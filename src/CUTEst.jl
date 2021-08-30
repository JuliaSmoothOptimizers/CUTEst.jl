#See JuliaSmoothOptimizers/NLPModels.jl/issues/113
__precompile__()

# Using CUTEst from Julia.

module CUTEst

using CUTEst_jll
using Pkg.Artifacts
using Libdl

using NLPModels
import Libdl.dlsym

# Only one problem can be interfaced at any given time.
global cutest_instances = 0

export CUTEstModel, sifdecoder, set_mastsif

mutable struct CUTEstModel <: AbstractNLPModel{Float64, Vector{Float64}}
  meta::NLPModelMeta{Float64, Vector{Float64}}
  counters::Counters
  hrows::Vector{Int32}
  hcols::Vector{Int32}
  jrows::Vector{Int32}
  jcols::Vector{Int32}
  work::Vector{Float64}  
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

const cutest_problems_path = joinpath(dirname(@__FILE__), "../deps", "files")
isdir(cutest_problems_path) || mkpath(cutest_problems_path)
global cutest_lib = C_NULL

function __init__()
  if success(`bash -c "type gfortran"`)
    @static Sys.isapple() ? (global libgfortran = []) :
            (global libgfortran = [strip(read(`gfortran --print-file libgfortran.so`, String))])
  else
    @error "gfortran is not installed. Please install it and try again."
    return
  end

  ENV["ARCHDEFS"] = joinpath(CUTEst_jll.artifact_dir, "libexec", "ARCHDefs-2.0.4x")
  ENV["SIFDECODE"] = joinpath(CUTEst_jll.artifact_dir, "libexec", "SIFDecode-2.0.3")
  ENV["CUTEST"] = joinpath(CUTEst_jll.artifact_dir, "libexec", "CUTEst-2.0.3")

  # set default MASTSIF location if the user hasn't set it already
  if !("MASTSIF" ∈ keys(ENV))
    ENV["MASTSIF"] = joinpath(artifact"sifcollection", "optrove-sif-99c5b38e7d03")
  else
    @info "call set_mastsif() to use the full SIF collection"
  end
  @info "using problem repository" ENV["MASTSIF"]

  # Set MYARCH
  if Sys.isapple()
    if Sys.WORD_SIZE == 64
      ENV["MYARCH"] = "mac64.osx.gfo"
    else
      ENV["MYARCH"] = "mac.osx.gfo"
    end
  elseif Sys.iswindows()
    if Sys.WORD_SIZE == 64
      ENV["MYARCH"] = "pc64.mgw.gfo"
    else
      ENV["MYARCH"] = "pc.mgw.gfo"
    end
  else
    ENV["MYARCH"] = "pc64.lnx.gfo"
    # if Sys.WORD_SIZE == 64
    #   ENV["MYARCH"] = "pc64.lnx.gfo"
    # else
    #   ENV["MYARCH"] = "pc.lnx.gfo"
    # end
  end
  global libpath = joinpath(ENV["CUTEST"], "objects", ENV["MYARCH"], "double")
  push!(Libdl.DL_LOAD_PATH, cutest_problems_path)
end

CUTEstException(info::Integer) = CUTEstException(convert(Int32, info))

macro cutest_error()  # Handle nonzero exit codes.
  esc(:(io_err[1] > 0 && throw(CUTEstException(io_err[1]))))
end

# to allow view inputs with stride one
StrideOneVector{T} = Union{
  Vector{T},
  SubArray{T, 1, Vector{T}, Tuple{UnitRange{U}}, true} where {U <: Integer}
}

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

function delete_temp_files()
  for f in ("ELFUN", "EXTER", "GROUP", "RANGE")
    for ext in ("f", "o")
      fname = "$f.$ext"
      isfile(fname) && rm(fname, force = true)
    end
  end
  for f in ("OUTSDIF.d", "AUTOMAT.d")
    isfile(f) && rm(f, force = true)
  end
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
  automat::String = "AUTOMAT_$(basename(name)).d",
)
  if length(name) < 4 || name[(end - 3):end] != ".SIF"
    name = "$name.SIF"
  end
  if !isfile(name) && !isfile(joinpath(ENV["MASTSIF"], name))
    error("$name not found")
  end

  pname, sif = splitext(basename(name))
  libname = "lib$pname"

  outlog = tempname()
  errlog = tempname()
  cd(cutest_problems_path) do
    delete_temp_files()
    # safeguard for macOS: see https://github.com/JuliaPackaging/Yggdrasil/pull/404#issuecomment-576958966
    if Sys.isapple()
      CUTEst_jll.sifdecoder() do decoder_exe
        run(
          pipeline(
            ignorestatus(
              `bash -c "export DYLD_FALLBACK_LIBRARY_PATH=$(ENV["DYLD_FALLBACK_LIBRARY_PATH"]); source $decoder_exe $(join(args, " ")) $name"`,
            ),
            stdout = outlog,
            stderr = errlog,
          ),
        )
      end
    else
      CUTEst_jll.sifdecoder() do decoder_exe
        run(
          pipeline(
            ignorestatus(Cmd([decoder_exe, args..., name])),
            stdout = outlog,
            stderr = errlog,
          ),
        )
      end
    end
    print(read(errlog, String))
    verbose && println(read(outlog, String))

    if isfile("ELFUN.f")
      run(`gfortran -c -fPIC ELFUN.f EXTER.f GROUP.f RANGE.f`)
      if Sys.isapple()
        run(
          `$linker $sh_flags -o $libname.$(Libdl.dlext) ELFUN.o EXTER.o GROUP.o RANGE.o -Wl,-rpath $libpath $(joinpath(libpath, "libcutest_double.$(Libdl.dlext)")) $libgfortran`,
        )
      else
        run(
          `$linker $sh_flags -o $libname.$(Libdl.dlext) ELFUN.o EXTER.o GROUP.o RANGE.o -rpath=$libpath -L$libpath -lcutest_double $libgfortran`,
        )
      end
      run(`mv OUTSDIF.d $outsdif`)
      run(`mv AUTOMAT.d $automat`)
      delete_temp_files()
      global cutest_lib =
        Libdl.dlopen(libname, Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
    end
  end
  rm(outlog)
  rm(errlog)
  nothing
end

# Initialize problem.
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
  name = splitext(basename(sifname))[1]
  if !isfile(sifname) && !isfile(joinpath(ENV["MASTSIF"], sifname))
    error("$name not found")
  elseif isfile(sifname) && !isfile(joinpath(ENV["MASTSIF"], sifname))
    # This file is local so make sure the full path is maintained for sifdecoder
    sifname = joinpath(pwd(), basename(sifname))
  end
  outsdif = "OUTSDIF_$name.d"
  automat = "AUTOMAT_$name.d"
  global cutest_instances
  cutest_instances > 0 && error("CUTEst: call finalize on current model first")
  io_err = Cint[0]
  global cutest_lib
  cd(cutest_problems_path) do
    if !decode
      (isfile(outsdif) && isfile(automat)) || error("CUTEst: no decoded problem found")
      libname = "lib$name"
      isfile("$libname.$(Libdl.dlext)") || error("CUTEst: lib not found; decode problem first")
      cutest_lib = Libdl.dlopen(libname, Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
    else
      sifdecoder(sifname, args..., verbose = verbose, outsdif = outsdif, automat = automat)
    end
    ccall(
      dlsym(cutest_lib, :fortran_open_),
      Nothing,
      (Ref{Int32}, Ptr{UInt8}, Ptr{Int32}),
      funit,
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
  nln = setdiff(1:ncon, lin)
  nlin = sum(linear)
  nnln = ncon - nlin

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

  meta = NLPModelMeta(
    Int(nvar),
    x0 = x,
    lvar = bl,
    uvar = bu,
    ncon = Int(ncon),
    y0 = v,
    lcon = cl,
    ucon = cu,
    nnzj = nnzj,
    nnzh = nnzh,
    lin = lin,
    nln = nln,
    nlin = nlin,
    nnln = nnln,
    name = splitext(name)[1],
  )

  hrows = Vector{Int32}(undef, nnzh)
  hcols = Vector{Int32}(undef, nnzh)
  jrows = Vector{Int32}(undef, nnzj)
  jcols = Vector{Int32}(undef, nnzj)
  work  = Vector{Int32}(undef, ncon)
  nlp = CUTEstModel(meta, Counters(), hrows, hcols, jrows, jcols, work)

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
