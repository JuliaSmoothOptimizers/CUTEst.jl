#See JuliaSmoothOptimizers/NLPModels.jl/issues/113
__precompile__()

# Using CUTEst from Julia.

module CUTEst

using CUTEst_jll
import SIFDecode_jll
using Pkg.Artifacts
using Libdl

using NLPModels
import Libdl.dlsym

global cutest_lib_path = ""
global cutest_lib = C_NULL
include("libcutest.jl")

# Only one problem can be interfaced at any given time.
global cutest_instances = 0

export CUTEstModel, sifdecoder, set_mastsif

mutable struct CUTEstModel <: AbstractNLPModel{Float64, Vector{Float64}}
  meta::NLPModelMeta{Float64, Vector{Float64}}
  counters::Counters
  hrows::Vector{Int32}
  hcols::Vector{Int32}

  jac_structure_reliable::Bool
  jrows::Vector{Int32}
  jcols::Vector{Int32}

  lin_structure_reliable::Bool
  blin::Vector{Float64}
  clinrows::Vector{Int32}
  clincols::Vector{Int32}
  clinvals::Vector{Float64}

  work::Vector{Float64}
  Jval::Vector{Cdouble}
  Jvar::Vector{Cint}
end

const funit = convert(Int32, 42)
@static Sys.isapple() ? (const linker = "gfortran") : (const linker = "ld")
@static Sys.isapple() ? (const sh_flags = ["-dynamiclib", "-undefined", "dynamic_lookup"]) :
        (const sh_flags = ["-shared"])

struct CUTEstException <: Exception
  info::Int32
  msg::String

  function CUTEstException(info::Int32)
    if info == 1
      msg = "memory allocation error"
    elseif info == 2
      msg = "array bound error"
    elseif info == 3
      msg = "evaluation error"
    else
      msg = "unknown error"
    end
    return new(info, msg)
  end
end

const cutest_problems_path = joinpath(dirname(@__FILE__), "..", "deps", "files")
isdir(cutest_problems_path) || mkpath(cutest_problems_path)

function __init__()
  if success(`bash -c "type gfortran"`)
    @static Sys.isapple() ? (global libgfortran = []) :
            (global libgfortran = [strip(read(`gfortran --print-file libgfortran.so`, String))])
  else
    @error "gfortran is not installed. Please install it and try again."
    return
  end

  # set default MASTSIF location if the user hasn't set it already
  if !("MASTSIF" ∈ keys(ENV))
    ENV["MASTSIF"] = joinpath(artifact"sifcollection", "optrove-sif-99c5b38e7d03")
  else
    @info "call set_mastsif() to use the full SIF collection"
  end
  @info "using problem repository" ENV["MASTSIF"]

  global libpath = joinpath(CUTEst_jll.artifact_dir, "lib")
  push!(Libdl.DL_LOAD_PATH, cutest_problems_path)
end

CUTEstException(info::Integer) = CUTEstException(convert(Int32, info))

macro cutest_error()  # Handle nonzero exit codes.
  esc(:(io_err[1] > 0 && throw(CUTEstException(io_err[1]))))
end

# to allow view inputs with stride one
StrideOneVector{T} =
  Union{Vector{T}, SubArray{T, 1, Vector{T}, Tuple{UnitRange{U}}, true} where {U <: Integer}}

include("core_interface.jl")
include("julia_interface.jl")
include("classification.jl")

"""
    set_mastsif()

Set the MASTSIF environment variable to point to the main SIF collection.
"""
function set_mastsif()
  ENV["MASTSIF"] = joinpath(artifact"sifcollection", "optrove-sif-99c5b38e7d03")
  @info "using full SIF collection located at" ENV["MASTSIF"]
  nothing
end

function delete_temp_files(suffix::String)
  for f in (
    "ELFUN",
    "ELFUNF",
    "ELFUND",
    "RANGE",
    "GROUP",
    "GROUPF",
    "GROUPD",
    "SETTYP",
    "EXTER",
    "EXTERA",
  )
    for ext in ("f", "o")
      fname = "$f$suffix.$ext"
      isfile(fname) && rm(fname, force = true)
    end
  end
  isfile("OUTSDIF.d") && rm("OUTSDIF.d", force = true)
  nothing
end

"""Decode problem and build shared library.

Optional arguments are passed directly to the SIF decoder.
Example:
    `sifdecoder("DIXMAANJ", "-param", "M=30")`.
"""
function sifdecoder(
  name::AbstractString,
  args...;
  verbose::Bool = false,
  outsdif::String = "OUTSDIF_$(basename(name)).d",
  precision::Symbol = :double,
)
  if precision == :single
    prec = "-sp"
    suffix = "_s"
  elseif precision == :double
    prec = "-dp"
    suffix = ""
  elseif precision == :quadruple
    prec = "-qp"
    suffix = "_q"
  else
    error("The $precision precision is not supported.")
  end

  if length(name) < 4 || name[(end - 3):end] != ".SIF"
    name = "$name.SIF"
  end
  if isfile(name)
    path_sifname = abspath(name)
  else
    path_sifname = joinpath(ENV["MASTSIF"], name)
    if !isfile(path_sifname)
      error("$name not found")
    end
  end

  pname, sif = basename(name) |> splitext
  libname = "lib$pname"

  outlog = tempname()
  errlog = tempname()
  cd(cutest_problems_path) do
    delete_temp_files(suffix)
    run(
      pipeline(
        Cmd(
          `$(SIFDecode_jll.sifdecoder_standalone()) $(args) $(prec) $(path_sifname)`,
          ignorestatus = true,
        ),
        stdout = outlog,
        stderr = errlog,
      ),
    )
    read(errlog, String) |> println
    if verbose
      read(outlog, String) |> println
    end

    if isfile("ELFUN$suffix.f")
      run(`gfortran -c -fPIC ELFUN$suffix.f`)
      object_files = ["ELFUN$suffix.o"]
      for file in
          ("GROUP", "RANGE", "ELFUNF", "ELFUND", "GROUPF", "GROUPD", "SETTYP", "EXTER", "EXTERA")
        if isfile("$file$suffix.f")
          run(`gfortran -c -fPIC $file$suffix.f`)
          push!(object_files, "$file$suffix.o")
        end
      end
      if Sys.isapple()
        run(
          `$linker $sh_flags -o $libname.$(Libdl.dlext) $(object_files) -Wl,-rpath $libpath $(joinpath(libpath, "libcutest_double.$(Libdl.dlext)")) $libgfortran`,
        )
      else
        run(
          `$linker $sh_flags -o $libname.$(Libdl.dlext) $(object_files) -rpath=$libpath -L$libpath -lcutest_double $libgfortran`,
        )
      end
      run(`mv OUTSDIF.d $outsdif`)
      delete_temp_files(suffix)
      global cutest_lib = Libdl.dlopen(libname, Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
      global cutest_lib_path = joinpath(cutest_problems_path, "$libname.$(Libdl.dlext)")
    end
  end
  rm(outlog)
  rm(errlog)
  nothing
end

"""
    nlp = CUTEstModel(name, args...; kwargs...)

Creates a CUTEst model following the NLPModels API.
This model needs to be finalized before a new one is created (e.g., calling `finalize(nlp)`).

## Optional arguments

Any extra arguments will be passed to `sifdecoder`.
You can, for instance, change parameters of the model:

```jldoctest
using CUTEst

nlp = CUTEstModel("CHAIN", "-param", "NH=50")
println(nlp.meta.nnzh)
finalize(nlp)
nlp = CUTEstModel("CHAIN", "-param", "NH=100")
println(nlp.meta.nnzh)
finalize(nlp)

# output

153
303
```

## Keyword arguments

- `decode::Bool = true`: Whether to call sifdecoder.
- `verbose::Bool = false`: Passed to sifdecoder.
- `efirst`::Bool = true`: Equalities first?
- `lfirst`::Bool = true`: Linear (or affine) constraints first?
- `lvfirst::Bool = true`: Nonlinear variables should appear first?
"""
function CUTEstModel(
  name::AbstractString,
  args...;
  decode::Bool = true,
  verbose::Bool = false,
  efirst::Bool = true,
  lfirst::Bool = true,
  lvfirst::Bool = true,
)
  sifname = (length(name) < 4 || name[(end - 3):end] != ".SIF") ? "$name.SIF" : name
  if isfile(sifname)
    # This file is local so make sure the full path is maintained for sifdecoder
    path_sifname = joinpath(pwd(), sifname)
  else
    path_sifname = joinpath(ENV["MASTSIF"], sifname)
    if !isfile(path_sifname)
      error("$name not found")
    end
  end

  pname, sif = basename(name) |> splitext
  outsdif = "OUTSDIF_$pname.d"
  global cutest_instances
  cutest_instances > 0 && error("CUTEst: call finalize on current model first")
  io_err = Cint[0]
  global cutest_lib
  cd(cutest_problems_path) do
    if !decode
      isfile(outsdif) || error("CUTEst: no decoded problem found")
      libname = "lib$pname"
      isfile("$libname.$(Libdl.dlext)") || error("CUTEst: lib not found; decode problem first")
      cutest_lib = Libdl.dlopen(libname, Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
    else
      sifdecoder(path_sifname, args..., verbose = verbose, outsdif = outsdif)
    end
    ccall(
      dlsym(cutest_lib, :fortran_open_),
      Nothing,
      (Ref{Int32}, Ptr{UInt8}, Ptr{Int32}),
      [funit],
      outsdif,
      io_err,
    )
    @cutest_error
  end

  # Obtain problem size.
  nvar = Cint[0]
  ncon = Cint[0]

  cdimen(io_err, [funit], nvar, ncon)
  @cutest_error
  nvar = nvar[1]
  ncon = ncon[1]

  x = Vector{Float64}(undef, nvar)
  bl = Vector{Float64}(undef, nvar)
  bu = Vector{Float64}(undef, nvar)
  v = Vector{Float64}(undef, ncon)
  cl = Vector{Float64}(undef, ncon)
  cu = Vector{Float64}(undef, ncon)
  equatn = Vector{Int32}(undef, ncon)
  linear = Vector{Int32}(undef, ncon)

  if ncon > 0
    e_order = efirst ? Cint[1] : Cint[0]
    l_order = lfirst ? Cint[1] : Cint[0]
    v_order = lvfirst ? Cint[1] : Cint[0]
    # Equality constraints first, linear constraints first, nonlinear variables first.
    csetup(
      io_err,
      [funit],
      Cint[0],
      Cint[6],
      [nvar],
      [ncon],
      x,
      bl,
      bu,
      v,
      cl,
      cu,
      equatn,
      linear,
      e_order,
      l_order,
      v_order,
    )
  else
    usetup(io_err, [funit], Cint[0], Cint[6], [nvar], x, bl, bu)
  end
  @cutest_error

  for lim in Any[bl, bu, cl, cu]
    I = findall(abs.(lim) .>= 1e20)
    lim[I] = Inf * lim[I]
  end

  lin = findall(linear .!= 0)
  nlin = length(lin)

  nnzh = Cint[0]
  nnzj = Cint[0]

  if ncon > 0
    cdimsh(io_err, nnzh)
    cdimsj(io_err, nnzj)
    nnzj[1] -= nvar  # nnzj also counts the nonzeros in the objective gradient.
  else
    udimsh(io_err, nnzh)
  end
  @cutest_error

  nnzh = Int(nnzh[1])
  nnzj = Int(nnzj[1])

  ccall(dlsym(cutest_lib, :fortran_close_), Nothing, (Ref{Int32}, Ptr{Int32}), funit, io_err)
  @cutest_error

  ncon = Int(ncon)
  nvar = Int(nvar)

  lin_nnzj = min(nvar * nlin, nnzj)
  nln_nnzj = min(nvar * (ncon - nlin), nnzj)

  meta = NLPModelMeta(
    nvar,
    x0 = x,
    lvar = bl,
    uvar = bu,
    ncon = ncon,
    y0 = v,
    lcon = cl,
    ucon = cu,
    nnzj = nnzj,
    nnzh = nnzh,
    lin = lin,
    lin_nnzj = lin_nnzj,
    nln_nnzj = nln_nnzj,
    name = splitext(name)[1],
  )

  hrows = Vector{Int32}(undef, nnzh)
  hcols = Vector{Int32}(undef, nnzh)

  jac_structure_reliable = false
  jrows = Vector{Int32}(undef, nnzj)
  jcols = Vector{Int32}(undef, nnzj)
  work = Vector{Int32}(undef, ncon)

  lin_structure_reliable = false
  blin = Vector{Float64}(undef, nlin)
  clinrows = Vector{Int32}(undef, lin_nnzj)
  clincols = Vector{Int32}(undef, lin_nnzj)
  clinvals = Vector{Float64}(undef, lin_nnzj)

  Jval = Array{Cdouble}(undef, nvar)
  Jvar = Array{Cint}(undef, nvar)

  nlp = CUTEstModel(
    meta,
    Counters(),
    hrows,
    hcols,
    jac_structure_reliable,
    jrows,
    jcols,
    lin_structure_reliable,
    blin,
    clinrows,
    clincols,
    clinvals,
    work,
    Jval,
    Jvar,
  )

  cutest_instances += 1
  finalizer(cutest_finalize, nlp)

  return nlp
end

function cutest_finalize(nlp::CUTEstModel)
  global cutest_instances
  cutest_instances == 0 && return
  global cutest_lib
  io_err = Cint[0]
  if nlp.meta.ncon > 0
    cterminate(io_err)
  else
    uterminate(io_err)
  end
  @cutest_error
  Libdl.dlclose(cutest_lib)
  cutest_instances -= 1
  cutest_lib = C_NULL
  return
end

# Displaying CUTEstModel instances.

import Base.show, Base.print
function show(io::IO, nlp::CUTEstModel)
  show(io, nlp.meta)
end

function print(io::IO, nlp::CUTEstModel)
  print(io, nlp.meta)
end

end  # module CUTEst.
