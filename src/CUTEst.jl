# Using CUTEst from Julia.

module CUTEst

push!(LOAD_PATH, Pkg.dir("MathProgBase","src","NLP"))
using NLP  # Defines NLPModelMeta.
using Compat

export CUTEstModel, sifdecoder, cutest_finalize

# Only one problem can be interfaced at any given time.
cutest_instances = 0;

type CUTEstModel
  meta    :: NLPModelMeta;
  cutest_lib :: Ptr{Void}
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

# Taken from
# http://docs.julialang.org/en/release-0.4/manual/calling-c-and-fortran-code/#indirect-calls
macro dlsym(func, lib)
  z, zlocal = gensym(string(func)), gensym()
  eval(current_module(), :(global $z = C_NULL))
  z = esc(z)
  quote
    let $zlocal::Ptr{Void} = $z::Ptr{Void}
      if $zlocal == C_NULL
        $zlocal = Libdl.dlsym($(esc(lib))::Ptr{Void}, $(esc(func)))
        global $z = $zlocal
      end
      $zlocal
    end
  end
end

include("core_interface.jl")
include("specialized_interface.jl")
include("julia_interface.jl")
include("documentation.jl")

# Decode problem and build shared library.
function sifdecoder(name :: ASCIIString)
  # TODO: Accept options to pass to sifdecoder.
  pname, sif = splitext(name);
  libname = "lib$pname";
  run(`sifdecoder $name`);
  run(`gfortran -c -fPIC ELFUN.f EXTER.f GROUP.f RANGE.f`);
  run(`$linker $sh_flags -o $libname.$soname ELFUN.o EXTER.o GROUP.o RANGE.o -L$cutest_dir/objects/$cutest_arch/double -lcutest_double`);
  run(`rm ELFUN.f EXTER.f GROUP.f RANGE.f ELFUN.o EXTER.o GROUP.o RANGE.o`);
  push!(Libdl.DL_LOAD_PATH,".")
  cutest_lib = Libdl.dlopen(libname)
  return cutest_lib
end

# Initialize problem.
function CUTEstModel(name :: ASCIIString; decode :: Bool=true)
  global cutest_instances
  cutest_instances > 0 && error("CUTEst: call cutest_finalize on current model first")
  if !decode
    (isfile(outsdif) & isfile(automat)) || error("CUTEst: no decoded problem found")
    libname = "lib$name"
    isfile("$libname.$soname") || error("CUTEst: lib not found; decode problem first")
    cutest_lib = Libdl.dlopen(libname)
  else
    cutest_lib = sifdecoder(name)
  end
  io_err = Cint[0];

  ccall(@dlsym(:fortran_open_, cutest_lib), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err);
  @cutest_error

  # Obtain problem size.
  nvar = Cint[0];
  ncon = Cint[0];

  cdimen(io_err, [funit], nvar, ncon, cutest_lib)
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
    csetup(io_err, [funit], Cint[5], Cint[6], [nvar], [ncon], x, bl, bu, v, cl, cu,
      equatn, linear, Cint[1], Cint[1], Cint[1], cutest_lib)
  else
    usetup(io_err, [funit], Cint[5], Cint[6], [nvar], x, bl, bu, cutest_lib)
  end
  @cutest_error

  lin = find(linear);
  nln = setdiff(1:ncon, lin);
  nlin = sum(linear);
  nnln = ncon - nlin;

  nnzh = Cint[0];
  nnzj = Cint[0];

  if ncon > 0
    cdimsh(io_err, nnzh, cutest_lib)
    cdimsj(io_err, nnzj, cutest_lib)
    nnzj[1] -= nvar;  # nnzj also counts the nonzeros in the objective gradient.
  else
    udimsh(io_err, nnzh, cutest_lib)
  end
  @cutest_error

  nnzh = nnzh[1];
  nnzj = nnzj[1];

  ccall(@dlsym(:fortran_close_, cutest_lib), Void,
      (Ptr{Int32}, Ptr{Int32}), &funit, io_err);
  @cutest_error

  meta = NLPModelMeta(nvar, x0=x, lvar=bl, uvar=bu,
                      ncon=ncon, y0=v, lcon=cl, ucon=cu,
                      nnzj=nnzj, nnzh=nnzh,
                      lin=lin, nln=nln,
                      nlin=nlin, nnln=nnln,
                      name=splitext(name)[1]);

  nlp = CUTEstModel(meta, cutest_lib);

  finalizer(nlp, cutest_finalize);
  cutest_instances += 1;
  return nlp
end


function cutest_finalize(nlp :: CUTEstModel)
  global cutest_instances
  cutest_instances == 0 && return;
  io_err = Cint[0];
  if nlp.meta.ncon > 0
    cterminate(io_err, nlp.cutest_lib)
  else
    uterminate(io_err, nlp.cutest_lib)
  end
  @cutest_error
  cutest_instances -= 1;
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

