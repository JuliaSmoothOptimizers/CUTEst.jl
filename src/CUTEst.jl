# Using CUTEst from Julia.

module CUTEst

push!(LOAD_PATH, Pkg.dir("MathProgBase","src","NLP"))
using NLP  # Defines NLPModelMeta.
using Compat
import Base.Libdl.dlsym

# Only one problem can be interfaced at any given time.
global cutest_instances = 0

export CUTEstModel, sifdecoder, cutest_finalize

type CUTEstModel
  meta    :: NLPModelMeta;
end

const cutest_arch  = get(ENV, "MYARCH", "");
const cutest_dir   = get(ENV, "CUTEST", "");
const outsdif = "OUTSDIF.d";
const automat = "AUTOMAT.d";
const funit   = convert(Int32, 42);
@osx? (const linker = "gfortran") : (const linker = "ld")
@osx? (const sh_flags = ["-dynamiclib", "-undefined", "dynamic_lookup"]) : (const sh_flags = ["-shared"]);
@osx? (const soname = "dylib") : (const soname = "so");

type CUTEstException <: Exception
  info :: Int32
  msg  :: ASCIIString

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

CUTEstException(info :: Integer) = CUTEstException(convert(Int32, info));

macro cutest_error()  # Handle nonzero exit codes.
  :(io_err[1] > 0 && throw(CUTEstException(io_err[1])))
end

include("core_interface.jl")
include("specialized_interface.jl")
include("julia_interface.jl")
include("documentation.jl")

  # Decode problem and build shared library.
function sifdecoder(name :: ASCIIString; verbose = false)
  # TODO: Accept options to pass to sifdecoder.
  pname, sif = splitext(name);
  libname = "lib$pname";
  out = readall(`sifdecoder $name`)
  verbose && println(out)
  run(`gfortran -c -fPIC ELFUN.f EXTER.f GROUP.f RANGE.f`);
  run(`$linker $sh_flags -o $libname.$soname ELFUN.o EXTER.o GROUP.o RANGE.o -L$cutest_dir/objects/$cutest_arch/double -lcutest_double`);
  run(`rm ELFUN.f EXTER.f GROUP.f RANGE.f ELFUN.o EXTER.o GROUP.o RANGE.o`);
  push!(Libdl.DL_LOAD_PATH, ".")
  global cutest_lib = Libdl.dlopen(libname,
      Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
end

# Initialize problem.
function CUTEstModel(name :: ASCIIString; decode :: Bool=true, verbose = false)
  global cutest_instances
  cutest_instances > 0 && error("CUTEst: call cutest_finalize on current model first")
  global cutest_lib
  if !decode
    (isfile(outsdif) && isfile(automat)) || error("CUTEst: no decoded problem found")
    libname = "lib$name"
    isfile("$libname.$soname") || error("CUTEst: lib not found; decode problem first")
    cutest_lib = Libdl.dlopen(libname,
        Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
  else
    sifdecoder(name, verbose=verbose)
  end
  io_err = Cint[0];
  ccall(dlsym(cutest_lib, :fortran_open_), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err);
  @cutest_error

  # Obtain problem size.
  nvar = Cint[0];
  ncon = Cint[0];

  cdimen(io_err, [funit], nvar, ncon)
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
    csetup(io_err, [funit], Cint[0], Cint[6], [nvar], [ncon], x, bl, bu, v, cl, cu,
      equatn, linear, Cint[1], Cint[1], Cint[1])
  else
    usetup(io_err, [funit], Cint[0], Cint[6], [nvar], x, bl, bu)
  end
  @cutest_error

  lin = find(linear);
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

  nlp = CUTEstModel(meta)

  cutest_instances += 1;
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

