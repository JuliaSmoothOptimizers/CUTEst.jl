# Using CUTEst from Julia.

module CUTEst

using NLP  # Defines NLPModelMeta.

export CUTEstModel, sifdecoder,
       objcons, objgrad, obj, cons_coord, cons, hess_coord, hess

type CUTEstModel
  meta    :: NLPModelMeta;
  libname :: ASCIIString;
end

const outsdif = "OUTSDIF.d";
const funit   = int32(42);
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

CUTEstException(info :: Int) = CUTEstException(int32(info));

macro cutest_error()  # Handle nonzero exit codes.
  :(io_err[1] > 0 && throw(CUTEstException(io_err[1])))
end

# Decode problem and build shared library.
function sifdecoder(name :: ASCIIString)
  # TODO: Accept options to pass to sifdecoder.
  pname, sif = splitext(name);
  libname = "lib$pname";
  run(`sifdecoder $name`);
  run(`gfortran -c -fPIC ELFUN.f EXTER.f GROUP.f RANGE.f`);
  run(`gfortran $sh_flags -o $libname.$soname -lcutest ELFUN.o EXTER.o GROUP.o RANGE.o`);
  return libname
end

# Initialize problem.
function CUTEstModel(name :: ASCIIString)
  libname = sifdecoder(name);
  io_err = Cint[0];

  @eval ccall((:fortran_open_, $(libname)), Void,
              (Ptr{Int32}, Ptr{Uint8}, Ptr{Int32}), &funit, outsdif, $(io_err));
  @cutest_error

  # Obtain problem size.
  nvar = Cint[0];
  ncon = Cint[0];

  @eval ccall((:cutest_cdimen_, $(libname)), Void,
               (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
                $(io_err),  &funit,     $(nvar),    $(ncon));
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
    @eval ccall((:cutest_csetup_, $(libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
                 $(io_err),  &funit,     &5,         &6,         &$(nvar),   &$(ncon),   $(x),         $(bl),        $(bu),        $(v),         $(cl),        $(cu),        $(equatn),  $(linear),  &1,         &1,         &1);
  else
    @eval ccall((:cutest_usetup_, $(libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 $(io_err),  &funit,     &5,         &6,         &$(nvar),   $(x),         $(bl),        $(bu));
  end
  @cutest_error

  lin = find(linear);
  nln = setdiff(1:ncon, lin);
  nlin = sum(linear);
  nnln = ncon - nlin;

  nnzh = Cint[0];
  nnzj = Cint[0];

  if ncon > 0
    @eval ccall((:cutest_cdimsh_, $(libname)), Void, (Ptr{Int32}, Ptr{Int32}), $(io_err), $(nnzh));
    @eval ccall((:cutest_cdimsj_, $(libname)), Void, (Ptr{Int32}, Ptr{Int32}), $(io_err), $(nnzj))
    nnzj[1] -= nvar;  # nnzj also counts the nonzeros in the objective gradient.
  else
    @eval ccall((:cutest_udimsh_, $(libname)), Void, (Ptr{Int32}, Ptr{Int32}), $(io_err), $(nnzh));
  end
  @cutest_error

  nnzh = nnzh[1];
  nnzj = nnzj[1];

  @eval ccall((:fortran_close_, $(libname)), Void,
              (Ptr{Int32}, Ptr{Int32}), &funit, $(io_err));
  @cutest_error

  meta = NLPModelMeta(nvar, x0=x, lvar=bl, uvar=bu,
                      ncon=ncon, y0=v, lcon=cl, ucon=cu,
                      nnzj=nnzj, nnzh=nnzh,
                      lin=lin, nln=nln,
                      nlin=nlin, nnln=nnln, nnet=0,
                      name=splitext(name)[1]);

  nlp = CUTEstModel(meta, libname);

  finalizer(nlp, cutest_finalize);
  return nlp
end


function cutest_finalize(nlp :: CUTEstModel)
  io_err = Cint[0];
  terminate = nlp.meta.ncon > 0 ? "cutest_cterminate_" : "cutest_uterminate_";
  @eval ccall(($(terminate), $(nlp.libname)), Void, (Ptr{Int32},), $(io_err));
  @cutest_error
end


# Displaying CUTEstModel instances.

import Base.show, Base.print
function show(io :: IO, nlp :: CUTEstModel)
  show(io, nlp.meta);
end

function print(io :: IO, nlp :: CUTEstModel)
  print(io, nlp.meta);
end


function objcons(nlp :: CUTEstModel, x :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  io_err = Cint[0];
  f = Cdouble[0];
  c = Array(Float64, ncon);
  if ncon > 0
    @eval ccall((:cutest_cfn_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 $(io_err),  $(nvar),    $(ncon),    $(x),         $(f),         $(c));
  else
    @eval ccall((:cutest_ufn_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}),
                 $(io_err),  $(nvar),    $(x),         $(f));
  end
  @cutest_error

  return ncon > 0 ? (f[1], c) : f[1];
end


function objgrad(nlp :: CUTEstModel, x :: Array{Float64,1}, grad :: Bool)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  f = Cdouble[0];
  io_err = Cint[0];
  if grad
    g = Array(Float64, nvar);
    get_grad = 1;
  else
    g = Array(Float64, 0);
    get_grad = 0;
  end
  cutest_fcn = ncon > 0 ? "cutest_cofg_" : "cutest_uofg_";  # How do you do this with symbols?
  @eval ccall(($(cutest_fcn), $(nlp.libname)), Void,
            (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
             $(io_err),  &$(nvar),   $(x),         $(f),         $(g),         &$(get_grad));
  @cutest_error

  return (f, g);
end

obj(nlp :: CUTEstModel, x :: Array{Float64,1}) = objgrad(nlp, x, false);


function cons_coord(nlp :: CUTEstModel, x :: Array{Float64,1}, grad :: Bool)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzj = nlp.meta.nnzj;
  io_err = Cint[0];
  c = Array(Float64, ncon);
  jsize = grad ? nlp.meta.nnzj : 0;
  get_j = grad ? 1 : 0;
  jval = Array(Float64, jsize);
  jrow = Array(Int32, jsize);
  jcol = Array(Int32, jsize);

  @eval ccall((:cutest_ccfsg_, $(nlp.libname)), Void,
              (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
               $(io_err),  &$(nvar),   &$(ncon),   $(x),         $(c),         &$(nnzj),   &$(jsize),  $(jval),      $(jcol),    $(jrow),    &$(get_j));
  @cutest_error

  return grad ? (c, jrow, jcol, jval) : c;
end

function cons(nlp :: CUTEstModel, x :: Array{Float64,1}, grad :: Bool)
  if grad
    (c, jrow, jcol, jval) = cons_coord(nlp, x, grad);
    return (c, sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar))
  else
    return cons_coord(nlp, x, grad);
  end
end

cons(nlp :: CUTEstModel, x :: Array{Float64,1}) = cons_coord(nlp, x, false);


function hess_coord(nlp :: CUTEstModel, x :: Array{Float64,1};
                    y :: Array{Float64,1}=nlp.meta.y0)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzh = nlp.meta.nnzh;
  io_err = Cint[0];
  hval = Array(Float64, nnzh);
  hrow = Array(Int32, nnzh);
  hcol = Array(Int32, nnzh);
  this_nnzh = Cint[0];
  if ncon > 0
    @eval ccall((:cutest_csh_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 $(io_err),  &$(nvar),   &$(ncon),   $(x),         $(y),         $(this_nnzh),   &$(nnzh),   $(hval),      $(hrow),    $(hcol));
  else
    @eval ccall((:cutest_ush_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 $(io_err),  &$(nvar),   $(x),         $(this_nnzh),   &$(nnzh),   $(hval),      $(hrow),    $(hcol));
  end
  @cutest_error

  return (hrow, hcol, hval);
end

function hess(nlp :: CUTEstModel, x :: Array{Float64,1};
              y :: Array{Float64,1}=nlp.meta.y0)
  (hrow, hcol, hval) = hess_coord(nlp, x, y=y);
  return sparse(hrow, hcol, hval, nlp.meta.nvar, nlp.meta.nvar);
end

end  # module CUTEst.

