# Using CUTEst from Julia.

module CUTEst

push!(LOAD_PATH, Pkg.dir("MathProgBase","src","NLP"))
using NLP  # Defines NLPModelMeta.
using Compat
import Base.Libdl.dlsym

global nlp

# Only one problem can be interfaced at any given time.
export sifdecoder, cutest_finalize, loadProblem, nlp

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

function __init__()
  global nlp_is_loaded = false
  global cutest_lib = C_NULL
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
function sifdecoder(name :: ASCIIString)
  # TODO: Accept options to pass to sifdecoder.
  pname, sif = splitext(name);
  libname = "lib$pname";
  run(`sifdecoder $name`);
  run(`gfortran -c -fPIC ELFUN.f EXTER.f GROUP.f RANGE.f`);
  run(`$linker $sh_flags -o $libname.$soname ELFUN.o EXTER.o GROUP.o RANGE.o -L$cutest_dir/objects/$cutest_arch/double -lcutest_double`);
  run(`rm ELFUN.f EXTER.f GROUP.f RANGE.f ELFUN.o EXTER.o GROUP.o RANGE.o`);
  push!(Libdl.DL_LOAD_PATH, ".")
  global cutest_lib = Libdl.dlopen(libname,
      Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
end

# Initialize problem.
function loadProblem(name :: ASCIIString; decode :: Bool=true)
  global nlp_is_loaded, nlp
  if nlp_is_loaded
    cutest_finalize(nlp)
    nlp_is_loaded = false
  end
  global cutest_lib
  if !decode
    (isfile(outsdif) && isfile(automat)) || error("CUTEst: no decoded problem found")
    libname = "lib$name"
    isfile("$libname.$soname") || error("CUTEst: lib not found; decode problem first")
    cutest_lib = Libdl.dlopen(libname,
        Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
  else
    sifdecoder(name)
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

  nlp = NLPModelMeta(nvar, x0=x, lvar=bl, uvar=bu,
                      ncon=ncon, y0=v, lcon=cl, ucon=cu,
                      nnzj=nnzj, nnzh=nnzh,
                      lin=lin, nln=nln,
                      nlin=nlin, nnln=nnln,
                      name=splitext(name)[1]);

  nlp_is_loaded = true
end


function cutest_finalize()
  global nlp_is_loaded, nlp
  nlp_is_loaded || return
  global cutest_lib
  io_err = Cint[0];
  if nlp.ncon > 0
    cterminate(io_err)
  else
    uterminate(io_err)
  end
  @cutest_error
  Libdl.dlclose(cutest_lib)
  nlp_is_loaded = false
  cutest_lib = C_NULL
end


# Displaying instances.

function cutest_show()
  show(io, nlp)
end

function cutest_print()
  print(io, nlp)
end

end  # module CUTEst.

