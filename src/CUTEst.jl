#See JuliaSmoothOptimizers/NLPModels.jl/issues/113
__precompile__()

# Using CUTEst from Julia.

module CUTEst

using Libdl

using NLPModels
import Libdl.dlsym

# Only one problem can be interfaced at any given time.
global cutest_instances = 0

export CUTEstModel, sifdecoder

mutable struct CUTEstModel <: AbstractNLPModel
  meta    :: NLPModelMeta;

  counters :: Counters
end

const funit   = convert(Int32, 42);
@static Sys.isapple() ? (const linker = "gfortran") : (const linker = "ld")
@static Sys.isapple() ? (const sh_flags = ["-dynamiclib", "-undefined", "dynamic_lookup"]) : (const sh_flags = ["-shared"]);
@static Sys.isapple() ? (const libgfortran = []) : (const libgfortran = [strip(read(`gfortran --print-file libgfortran.so`, String))])

struct CUTEstException <: Exception
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
  global cutest_lib = C_NULL
  deps = joinpath(dirname(@__FILE__), "../deps")
  cutestenv = joinpath(deps, "cutestenv.jl")
  if ispath(cutestenv)
    include(cutestenv)
  else
    ENV["cutest-problems"] = joinpath(deps, "files")
  end
  isdir(ENV["cutest-problems"]) || mkdir(ENV["cutest-problems"])
  global sifdecoderbin = joinpath(ENV["SIFDECODE"], "bin/sifdecoder")

  global libpath = joinpath(ENV["CUTEST"], "objects", ENV["MYARCH"],
      "double/libcutest_double.$(Libdl.dlext)")

  push!(Libdl.DL_LOAD_PATH, ENV["cutest-problems"])
end

CUTEstException(info :: Integer) = CUTEstException(convert(Int32, info));

macro cutest_error()  # Handle nonzero exit codes.
  esc(:(io_err[1] > 0 && throw(CUTEstException(io_err[1]))))
end

include("core_interface.jl")
include("julia_interface.jl")
include("classification.jl")

"""Decode problem and build shared library.

Optional arguments are passed directly to the SIF decoder.
Example:
    `sifdecoder("DIXMAANJ", "-param", "M=30")`.
"""
function sifdecoder(name :: String, args...; verbose :: Bool=false,
                    outsdif :: String="OUTSDIF_$name.d",
                    automat :: String="AUTOMAT_$name.d")
  # TODO: Accept options to pass to sifdecoder.
  pname, sif = splitext(name);
  libname = "lib$pname";

  # work around bogus "ERROR: failed process"
  # should be more elegant after https://github.com/JuliaLang/julia/pull/12807
  outlog = tempname()
  errlog = tempname()
  cd(ENV["cutest-problems"]) do
    run(pipeline(ignorestatus(`$sifdecoderbin $args $name`), stdout=outlog, stderr=errlog))
    print(read(errlog, String))
    verbose && println(read(outlog, String))

    run(`gfortran -c -fPIC ELFUN.f EXTER.f GROUP.f RANGE.f`);
    run(`$linker $sh_flags -o $libname.$(Libdl.dlext) ELFUN.o EXTER.o GROUP.o RANGE.o $libpath $libgfortran`);
    run(`mv OUTSDIF.d $outsdif`)
    run(`mv AUTOMAT.d $automat`)
    run(`rm ELFUN.f EXTER.f GROUP.f RANGE.f ELFUN.o EXTER.o GROUP.o RANGE.o`);
    global cutest_lib = Libdl.dlopen(libname,
      Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
  end
end

# Initialize problem.
function CUTEstModel(name :: String, args...; decode :: Bool=true, verbose ::Bool=false)
  outsdif = "OUTSDIF_$name.d";
  automat = "AUTOMAT_$name.d";
  global cutest_instances
  cutest_instances > 0 && error("CUTEst: call finalize on current model first")
  io_err = Cint[0];
  global cutest_lib
  cd(ENV["cutest-problems"]) do
    if !decode
      (isfile(outsdif) && isfile(automat)) || error("CUTEst: no decoded problem found")
      libname = "lib$name"
      isfile("$libname.$(Libdl.dlext)") || error("CUTEst: lib not found; decode problem first")
      cutest_lib = Libdl.dlopen(libname,
        Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
    else
      sifdecoder(name, args..., verbose=verbose, outsdif=outsdif, automat=automat)
    end
    ccall(dlsym(cutest_lib, :fortran_open_), Nothing,
          (Ref{Int32}, Ptr{UInt8}, Ptr{Int32}), funit, outsdif, io_err);
    @cutest_error
  end

  # Obtain problem size.
  nvar = Cint[0];
  ncon = Cint[0];

  cdimen(io_err, [funit], nvar, ncon)
  @cutest_error
  nvar = nvar[1];
  ncon = ncon[1];

  x  = Array{Float64}(undef, nvar)
  bl = Array{Float64}(undef, nvar)
  bu = Array{Float64}(undef, nvar)
  v  = Array{Float64}(undef, ncon)
  cl = Array{Float64}(undef, ncon)
  cu = Array{Float64}(undef, ncon)
  equatn = Array{Int32}(undef, ncon)
  linear = Array{Int32}(undef, ncon)

  if ncon > 0
    # Equality constraints first, linear constraints first, nonlinear variables first.
    csetup(io_err, [funit], Cint[0], Cint[6], [nvar], [ncon], x, bl, bu, v, cl, cu,
      equatn, linear, Cint[1], Cint[1], Cint[1])
  else
    usetup(io_err, [funit], Cint[0], Cint[6], [nvar], x, bl, bu)
  end
  @cutest_error

  for lim in Any[bl, bu, cl, cu]
    I = findall(abs.(lim) .>= 1e20)
    lim[I] = Inf * lim[I]
  end

  lin = findall(linear .!= 0);
  nln = setdiff(1:ncon, lin);
  nlin = sum(linear);
  nnln = ncon - nlin;

  nnzh = Cint[0];
  nnzj = Cint[0];

  if ncon > 0
    cdimsh(io_err, nnzh)
    cdimsj(io_err, nnzj)
    nnzj[1] -= nvar;  # nnzj also counts the nonzeros in the objective gradient.
  else
    udimsh(io_err, nnzh)
  end
  @cutest_error

  nnzh = Int(nnzh[1])
  nnzj = Int(nnzj[1])

  ccall(dlsym(cutest_lib, :fortran_close_), Nothing,
      (Ref{Int32}, Ptr{Int32}), funit, io_err);
  @cutest_error

  meta = NLPModelMeta(Int(nvar), x0=x, lvar=bl, uvar=bu,
                      ncon=Int(ncon), y0=v, lcon=cl, ucon=cu,
                      nnzj=nnzj, nnzh=nnzh,
                      lin=lin, nln=nln,
                      nlin=nlin, nnln=nnln,
                      name=splitext(name)[1]);

  nlp = CUTEstModel(meta, Counters())

  cutest_instances += 1;
  finalizer(cutest_finalize, nlp)

  return nlp
end


function cutest_finalize(nlp :: CUTEstModel)
  global cutest_instances
  cutest_instances == 0 && return;
  global cutest_lib
  io_err = Cint[0];
  if nlp.meta.ncon > 0
    cterminate(io_err)
  else
    uterminate(io_err)
  end
  @cutest_error
  Libdl.dlclose(cutest_lib)
  cutest_instances -= 1;
  cutest_lib = C_NULL
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
