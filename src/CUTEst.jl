# Using CUTEst from Julia.

module CUTEst

using NLP  # Defines NLPModelMeta.

export CUTEstModel, sifdecoder

type CUTEstModel
  meta    :: NLPModelMeta;
  libname :: ASCIIString;
  initialized :: Bool;
end

global csetup_calls = 0

cint(n)     = convert(Cint, n)
cdouble(n)  = convert(Cdouble, n)

const fixedlibname = "libCUTEstJL"
const outsdif = "OUTSDIF.d";
const funit   = cint(42);
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

CUTEstException(info :: Integer) = CUTEstException(int32(info));

macro cutest_error()  # Handle nonzero exit codes.
  :(io_err[1] > 0 && throw(CUTEstException(io_err[1])))
end

include("raw_interface.jl")
include("medium_interface.jl")
include("julia_interface.jl")

# Decode problem and build shared library.
function sifdecoder(name :: ASCIIString; raw = false)
  # TODO: Accept options to pass to sifdecoder.
  pname, sif = splitext(name);
  libname = raw ? fixedlibname : "lib$pname"
  run(`sifdecoder $name`);
  run(`gfortran -c -fPIC ELFUN.f EXTER.f GROUP.f RANGE.f`);
  run(`ld $sh_flags -o $libname.$soname ELFUN.o EXTER.o GROUP.o RANGE.o -lcutest -lgfortran`);
  push!(DL_LOAD_PATH,".")
  return libname
end

# Initialize problem.
function CUTEstModel(name :: ASCIIString; raw :: Bool = false)
  @eval csetup_calls += 1;
  if csetup_calls > 1
    throw("CUTEst cannot be initialized a second time. See https://github.com/optimizers/CUTEst.jl/issues/4.")
  end
  libname = sifdecoder(name, raw=raw)
  io_err = Cint[0];

  @eval ccall((:fortran_open_, $(libname)), Void,
              (Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), &funit, outsdif, $(io_err));
  @cutest_error

  # Obtain problem size.
  nvar = Cint[0];
  ncon = Cint[0];

  @eval ccall((:cutest_cdimen_, $(libname)), Void,
               (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
                $(io_err),  &funit,     $(nvar),    $(ncon));
  @cutest_error
  nvar = nvar[1];
  ncon = ncon[1];

  x  = Array(Cdouble, nvar)
  bl = Array(Cdouble, nvar)
  bu = Array(Cdouble, nvar)
  v  = Array(Cdouble, ncon)
  cl = Array(Cdouble, ncon)
  cu = Array(Cdouble, ncon)
  equatn = Array(Cint, ncon)
  linear = Array(Cint, ncon)

  if ncon > 0
    # Equality constraints first, linear constraints first, nonlinear variables first.
    @eval ccall((:cutest_csetup_, $(libname)), Void,
      (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
      Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
      Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
      $(io_err), &funit, &5, &6, &$(nvar), &$(ncon), $(x), $(bl), $(bu), $(v),
      $(cl), $(cu), $(equatn), $(linear), &1, &1, &1);
  else
    @eval ccall((:cutest_usetup_, $(libname)), Void,
      (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
      Ptr{Cdouble}, Ptr{Cdouble}),
      $(io_err), &funit, &5, &6, &$(nvar), $(x), $(bl), $(bu));
  end
  @cutest_error

  lin = find(linear);
  nln = setdiff(1:ncon, lin);
  nlin = sum(linear);
  nnln = ncon - nlin;

  nnzh = Cint[0];
  nnzj = Cint[0];

  if ncon > 0
    @eval ccall((:cutest_cdimsh_, $(libname)), Void,
      (Ptr{Cint}, Ptr{Cint}), $(io_err), $(nnzh));
    @eval ccall((:cutest_cdimsj_, $(libname)), Void,
      (Ptr{Cint}, Ptr{Cint}), $(io_err), $(nnzj))
    nnzj[1] -= nvar;  # nnzj also counts the nonzeros in the objective gradient.
  else
    @eval ccall((:cutest_udimsh_, $(libname)), Void,
      (Ptr{Cint}, Ptr{Cint}), $(io_err), $(nnzh));
  end
  @cutest_error

  nnzh = nnzh[1];
  nnzj = nnzj[1];

  @eval ccall((:fortran_close_, $(libname)), Void,
              (Ptr{Cint}, Ptr{Cint}), &funit, $(io_err));
  @cutest_error

  meta = NLPModelMeta(nvar, x0=x, lvar=bl, uvar=bu,
                      ncon=ncon, y0=v, lcon=cl, ucon=cu,
                      nnzj=nnzj, nnzh=nnzh,
                      lin=lin, nln=nln,
                      nlin=nlin, nnln=nnln, nnet=0,
                      name=splitext(name)[1]);

  nlp = CUTEstModel(meta, libname, true);

  finalizer(nlp, terminate);
  return nlp
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

