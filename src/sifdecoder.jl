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
    ENV["MASTSIF"] = joinpath(artifact"sifcollection", "optrove-sif-9c590588ccca")
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
    error_str = read(errlog, String)
    if length(error_str) > 0
      println(error_str)
      error("Unable to compile a shared library for the problem $name.")
    end
    if verbose
      output_str = read(outlog, String)
      println(output_str)
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
    library = "cutest_single"
  elseif precision == :double
    prec = "-dp"
    suffix = ""
    library = "cutest_double"
  elseif precision == :quadruple
    prec = "-qp"
    suffix = "_q"
    library = "cutest_quadruple"
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
        libcutest = joinpath(libpath, "lib$library.$dlext")
        run(
          `gfortran -dynamiclib -o $libsif.$dlext $(object_files) -Wl,-rpath,$libpath $libcutest`,
        )
      elseif Sys.iswindows()
        @static if Sys.iswindows()
          mingw = Int == Int64 ? "mingw64" : "mingw32"
          gfortran = joinpath(artifact"mingw-w64", mingw, "bin", "gfortran.exe")
          libcutest = joinpath(libpath, "lib$library.a")
          run(
            `$gfortran -shared -o $libsif.$dlext $(object_files) -Wl,--whole-archive $libcutest -Wl,--no-whole-archive`,
          )
        end
      else
        libgfortran = strip(read(`gfortran --print-file libgfortran.so`, String))
        run(
          `ld -shared -o $libsif.$dlext $(object_files) -rpath=$libpath -L$libpath -l$library $libgfortran`,
        )
      end
      delete_temp_files(suffix)
      cutest_lib = Libdl.dlopen(libsif, Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
      if precision == :single
        global cutest_lib_single = cutest_lib
      elseif precision == :double
        global cutest_lib_double = cutest_lib
      else  # precision = :quadruple
        global cutest_lib_quadruple = cutest_lib
      end
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
