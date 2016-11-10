__precompile__(false)  # due to optional dependencies

# Using CUTEst from Julia.

module CUTEst

importall NLPModels
using Compat
import Compat.String
import Base.Libdl.dlsym

export CUTEstModel, sifdecoder

type CUTEstModel <: AbstractNLPModel
  lib     :: Ptr{Void}
  meta    :: NLPModelMeta;

  counters :: Counters
end

const outsdif = "OUTSDIF.d";
const automat = "AUTOMAT.d";
const funit   = convert(Int32, 42);
@static is_apple() ? (const linker = "gfortran") : (const linker = "ld")
@static is_apple() ? (const sh_flags = ["-dynamiclib", "-undefined", "dynamic_lookup"]) : (const sh_flags = ["-shared"]);

type CUTEstException <: Exception
  info :: Int32
  msg  :: String

  function CUTEstException(info :: Int32)
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

function __init__()
  deps = joinpath(dirname(@__FILE__), "../deps")
  cutestenv = joinpath(deps, "cutestenv.jl")
  ispath(cutestenv) && include(cutestenv)
  global sifdecoderbin = joinpath(ENV["SIFDECODE"], "bin/sifdecoder")

  global libpath = joinpath(ENV["CUTEST"], "objects", ENV["MYARCH"],
      "double/libcutest_double.$(Libdl.dlext)")

  push!(Libdl.DL_LOAD_PATH, ".")
end

CUTEstException(info :: Integer) = CUTEstException(convert(Int32, info));

macro cutest_error()  # Handle nonzero exit codes.
  :(io_err[1] > 0 && throw(CUTEstException(io_err[1])))
end

include("core_interface.jl")
include("specialized_interface.jl")
include("julia_interface.jl")
if Pkg.installed("MathProgBase") != nothing
  include("mpb_interface.jl")
end
include("classification.jl")

"""Decode problem and build shared library.

Optional arguments are passed directly to the SIF decoder.
Example:
    `sifdecoder("DIXMAANJ", "-param", "M=30")`.
"""
function sifdecoder(name :: String, args...; verbose :: Bool=false)
  # TODO: Accept options to pass to sifdecoder.
  pname, sif = splitext(name);
  libname = "lib$pname";

  # work around bogus "ERROR: failed process"
  # should be more elegant after https://github.com/JuliaLang/julia/pull/12807
  outlog = tempname()
  errlog = tempname()
  run(pipeline(ignorestatus(`$sifdecoderbin $args $name`), stdout=outlog, stderr=errlog))
  print(readstring(errlog))
  verbose && println(readstring(outlog))

  run(`gfortran -c -fPIC ELFUN.f EXTER.f GROUP.f RANGE.f`);
  run(`$linker $sh_flags -o $libname.$(Libdl.dlext) ELFUN.o EXTER.o GROUP.o RANGE.o $libpath`);
  run(`rm ELFUN.f EXTER.f GROUP.f RANGE.f ELFUN.o EXTER.o GROUP.o RANGE.o`);
  cutest_lib = Libdl.dlopen(libname,
      Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
end

# Initialize problem.
function CUTEstModel(name :: String, args...; decode :: Bool=true, verbose ::Bool=false)
  if !decode
    (isfile(outsdif) && isfile(automat)) || error("CUTEst: no decoded problem found")
    libname = "lib$name"
    isfile("$libname.$(Libdl.dlext)") || error("CUTEst: lib not found; decode problem first")
    cutest_lib = Libdl.dlopen(libname,
        Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
  else
    cutest_lib = sifdecoder(name, args..., verbose=verbose)
  end
  io_err = Cint[0];
  ccall(dlsym(cutest_lib, :fortran_open_), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err);
  @cutest_error

  # Obtain problem size.
  nvar = Cint[0];
  ncon = Cint[0];

  cdimen(cutest_lib, io_err, [funit], nvar, ncon)
  @cutest_error
  nvar = nvar[1];
  ncon = ncon[1];

  x  = Array(Float64, nvar)
  bl = Array(Float64, nvar)
  bu = Array(Float64, nvar)
  v  = Array(Float64, ncon)
  cl = Array(Float64, ncon)
  cu = Array(Float64, ncon)
  equatn = Array(Int32, ncon)
  linear = Array(Int32, ncon)

  if ncon > 0
    # Equality constraints first, linear constraints first, nonlinear variables first.
    csetup(cutest_lib, io_err, [funit], Cint[0], Cint[6], [nvar], [ncon], x, bl, bu, v, cl, cu,
      equatn, linear, Cint[1], Cint[1], Cint[1])
  else
    usetup(cutest_lib, io_err, [funit], Cint[0], Cint[6], [nvar], x, bl, bu)
  end
  @cutest_error

  for lim in Any[bl, bu, cl, cu]
    I = find(abs(lim) .>= 1e20)
    lim[I] = Inf * lim[I]
  end

  lin = find(linear);
  nln = setdiff(1:ncon, lin);
  nlin = sum(linear);
  nnln = ncon - nlin;

  nnzh = Cint[0];
  nnzj = Cint[0];

  if ncon > 0
    cdimsh(cutest_lib, io_err, nnzh)
    cdimsj(cutest_lib, io_err, nnzj)
    nnzj[1] -= nvar;  # nnzj also counts the nonzeros in the objective gradient.
  else
    udimsh(cutest_lib, io_err, nnzh)
  end
  @cutest_error

  nnzh = nnzh[1];
  nnzj = nnzj[1];

  ccall(dlsym(cutest_lib, :fortran_close_), Void,
      (Ptr{Int32}, Ptr{Int32}), &funit, io_err);
  @cutest_error

  meta = NLPModelMeta(nvar, x0=x, lvar=bl, uvar=bu,
                      ncon=ncon, y0=v, lcon=cl, ucon=cu,
                      nnzj=nnzj, nnzh=nnzh,
                      lin=lin, nln=nln,
                      nlin=nlin, nnln=nnln,
                      name=splitext(name)[1]);

  nlp = CUTEstModel(cutest_lib, meta, Counters())

  finalizer(nlp, cutest_finalize)

  return nlp
end


function cutest_finalize(nlp :: CUTEstModel)
  nlp.lib == C_NULL && return  # prevent double-finalization
  io_err = Cint[0];
  if nlp.meta.ncon > 0
    cterminate(nlp.lib, io_err)
  else
    uterminate(nlp.lib, io_err)
  end
  @cutest_error
  Libdl.dlclose(nlp.lib)
  nlp.lib = C_NULL
  return;
end


# Displaying CUTEstModel instances.

import Base.show, Base.print
function show(io :: IO, nlp :: CUTEstModel)
  show(io, nlp.meta);
end

function print(io :: IO, nlp :: CUTEstModel)
  print(io, nlp.meta);
end

end  # module CUTEst.
