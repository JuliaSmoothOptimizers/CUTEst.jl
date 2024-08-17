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
  if !haskey(ENV, "MASTSIF")
    set_mastsif()
  else
    @info "call set_mastsif() to use the full SIF collection"
  end
  @info "using problem repository" ENV["MASTSIF"]

  global libpath = joinpath(CUTEst_jll.artifact_dir, "lib")
  push!(Libdl.DL_LOAD_PATH, cutest_problems_path)
end

CUTEstException(info::Integer) = CUTEstException(convert(Int32, info))

function cutest_error(status::Cint)  # Handle nonzero exit codes.
  (status > 0) && throw(CUTEstException(status))
end

# to allow view inputs with stride one
StrideOneVector{T} =
  Union{Ref{T}, Vector{T}, SubArray{T, 1, Vector{T}, Tuple{UnitRange{U}}, true} where {U <: Integer}}

include("sifdecoder.jl")
include("core_interface.jl")
include("julia_interface.jl")
include("classification.jl")

"""
    set_mastsif(set::String="sifcollection")

Set the MASTSIF environment variable to point to a set of SIF problems.
The supported sets are:
- "sifcollection": the CUTEst NLP test set;
- "maros-meszaros": the Maros-Meszaros QP test set;
- "netlib-lp": the Netlib LP test set.

"""
function set_mastsif(set::String = "sifcollection")
  if set == "sifcollection"
    ENV["MASTSIF"] = joinpath(artifact"sifcollection", "optrove-sif-229e00b81891")
  elseif set == "maros-meszaros"
    ENV["MASTSIF"] = joinpath(artifact"maros-meszaros", "optrove-maros-meszaros-9adfb5707b1e")
  elseif set == "netlib-lp"
    ENV["MASTSIF"] = joinpath(artifact"netlib-lp", "optrove-netlib-lp-f83996fca937")
  else
    error("The set $set is not supported.")
  end
  @info "using full SIF collection located at" ENV["MASTSIF"]
  return nothing
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
  global cutest_lib
  cd(cutest_problems_path) do
    if !decode
      isfile(outsdif) || error("CUTEst: no decoded problem found")
      libname = "lib$pname"
      isfile("$libname.$(Libdl.dlext)") || error("CUTEst: lib not found; decode problem first")
      cutest_lib = Libdl.dlopen(libname, Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
    else
      sifdecoder(path_sifname, args..., verbose = verbose, outsdif = outsdif, precision = :double)
      build_libsif(path_sifname, precision = :double)
    end
    status = Ref{Cint}(0)
    fortran_open_(Ref{Cint}(funit), outsdif, status)
    cutest_error(status[])
  end

  # Obtain problem size.
  status = Ref{Cint}(0)
  nvar = Ref{Cint}(0)
  ncon = Ref{Cint}(0)

  cdimen(status, Ref{Cint}(funit), nvar, ncon)
  cutest_error(status[])

  x = Vector{Float64}(undef, nvar[])
  bl = Vector{Float64}(undef, nvar[])
  bu = Vector{Float64}(undef, nvar[])
  v = Vector{Float64}(undef, ncon[])
  cl = Vector{Float64}(undef, ncon[])
  cu = Vector{Float64}(undef, ncon[])
  equatn = Vector{Int32}(undef, ncon[])
  linear = Vector{Int32}(undef, ncon[])

  if ncon[] > 0
    e_order = efirst ? Ref{Cint}(1) : Ref{Cint}(0)
    l_order = lfirst ? Ref{Cint}(1) : Ref{Cint}(0)
    v_order = lvfirst ? Ref{Cint}(1) : Ref{Cint}(0)
    # Equality constraints first, linear constraints first, nonlinear variables first.
    csetup(
      status,
      Ref{Cint}(funit),
      Ref{Cint}(0),
      Ref{Cint}(6),
      nvar,
      ncon,
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
    usetup(status, Ref{Cint}(funit), Ref{Cint}(0), Ref{Cint}(6), nvar, x, bl, bu)
  end
  cutest_error(status[])

  for lim in Any[bl, bu, cl, cu]
    I = findall(abs.(lim) .>= 1e20)
    lim[I] = Inf * lim[I]
  end

  lin = findall(linear .!= 0)
  nlin = length(lin)

  nnzh = Ref{Cint}(0)
  nnzj = Ref{Cint}(0)

  if ncon[] > 0
    cdimsh(status, nnzh)
    cdimsj(status, nnzj)
    nnzj[] -= nvar[]  # nnzj also counts the nonzeros in the objective gradient.
  else
    udimsh(status, nnzh)
  end
  cutest_error(status[])

  # Remove references
  nvar = nvar[] |> Int
  ncon = ncon[] |> Int
  nnzj = nnzj[] |> Int
  nnzh = nnzh[] |> Int

  fortran_close_(Ref{Cint}(funit), status)
  cutest_error(status[])

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

  Jval = Vector{Cdouble}(undef, nvar)
  Jvar = Vector{Cint}(undef, nvar)

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
  status = Ref{Cint}(0)
  if nlp.meta.ncon > 0
    cterminate(status)
  else
    uterminate(status)
  end
  cutest_error(status[])
  Libdl.dlclose(cutest_lib)
  cutest_instances -= 1
  cutest_lib = C_NULL
  cutest_lib_path = ""
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
