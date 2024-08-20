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
    ENV["MASTSIF"] = joinpath(artifact"sifcollection", "optrove-sif-c71425cc7f54")
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

_name_outsdif(name::AbstractString, precision::Symbol) = "OUTSDIF_$(basename(name))_$(precision).d"

"""Decode a SIF problem.

Optional arguments are passed directly to the SIF decoder.
Example:
    `sifdecoder("DIXMAANJ", "-param", "M=30")`.
"""
function sifdecoder(
  name::AbstractString,
  args...;
  verbose::Bool = false,
  precision::Symbol = :double,
  outsdif::String = _name_outsdif(name, precision),
  libsif_folder::String = cutest_problems_path,
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

  outlog = tempname()
  errlog = tempname()
  cd(libsif_folder) do
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
    isfile("OUTSDIF.d") && run(`mv OUTSDIF.d $outsdif`)
  end
  rm(outlog)
  rm(errlog)
  nothing
end

"""
Build a shared library from a decoded SIF problem.

Example:
    `build_libsif("DIXMAANJ")`.
"""
function build_libsif(
  name::AbstractString;
  precision::Symbol = :double,
  libsif_folder::String = cutest_problems_path,
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

  pname, sif = basename(name) |> splitext
  libsif = "lib$(pname)_$(precision)"

  cd(libsif_folder) do
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
          `$linker $sh_flags -o $libsif.$(Libdl.dlext) $(object_files) -Wl,-rpath $libpath $(joinpath(libpath, "libcutest_double.$(Libdl.dlext)")) $libgfortran`,
        )
      elseif Sys.iswindows()
        libcutest_double = joinpath(libpath, "libcutest_double.a")
        run(
          `gfortran -shared -o $libsif.$(Libdl.dlext) $(object_files) -Wl,--whole-archive $(libcutest_double) -Wl,--no-whole-archive`,
        )
      elseif Sys.iswindows()
        mingw = Int == Int64 ? "mingw64" : "mingw32"
        gfortran = joinpath(artifact"mingw-w64", mingw, "bin", "gfortran.exe")
        libcutest_double = joinpath(libpath, "libcutest_double.a")
        run(
          `$gfortran -shared -o $libname.$(Libdl.dlext) $(object_files) -Wl,--whole-archive $(libcutest_double) -Wl,--no-whole-archive`,
        )
      else
        run(
          `$linker $sh_flags -o $libsif.$(Libdl.dlext) $(object_files) -rpath=$libpath -L$libpath -lcutest_double $libgfortran`,
        )
      end
      delete_temp_files(suffix)
      global cutest_lib_double =
        Libdl.dlopen(libsif, Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
    end
  end
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
