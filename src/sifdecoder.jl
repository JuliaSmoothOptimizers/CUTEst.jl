"""
    set_mastsif(set::String="sifcollection")

Set the environment variable `MASTSIF` to point to a set of SIF problems.
The supported sets are:
- `"sifcollection"`: the CUTEst NLP test set;
- `"maros-meszaros"`: the Maros-Meszaros QP test set;
- `"netlib-lp"`: the Netlib LP test set.
"""
function set_mastsif(set::String = "sifcollection")
  if set == "sifcollection"
    ENV["MASTSIF"] = joinpath(artifact"sifcollection", "optrove-sif-0b335a4b1a3c")
  elseif set == "maros-meszaros"
    ENV["MASTSIF"] = joinpath(artifact"maros-meszaros", "optrove-maros-meszaros-9adfb5707b1e")
  elseif set == "netlib-lp"
    ENV["MASTSIF"] = joinpath(artifact"netlib-lp", "optrove-netlib-lp-f83996fca937")
  else
    error("The set $set is not supported.")
  end
  return nothing
end

"""
    problems = list_sif_problems()

# Output
- `problems::Vector{String}`: A list of SIF problems (without the extension `.SIF`) available in the current set.

See [`set_mastsif`](@ref) for more details about how to change the set of SIF files.
"""
function list_sif_problems()
  problems = String[]
  files = readdir(ENV["MASTSIF"])
  for file in files
    name, ext = splitext(file)
    if ext == ".SIF"
      push!(problems, name)
    end
  end
  return problems
end

function _name_outsdif(name::String, precision::Symbol)
  sifname, extension = basename(name) |> splitext
  name = "OUTSDIF_$(sifname)_$(precision).d"
  return name
end

"""
    sifdecoder(name::String, args...; verbose::Bool=false, precision::Symbol=:double,
               outsdif::String=_name_outsdif(name, precision), libsif_folder=libsif_path)

Decodes a SIF problem, converting it into a format suitable for further processing.

# Arguments
- `name::String`: The path or name of the SIF problem, with or without the extension `.SIF`.
- `args...`: Additional arguments passed directly to the SIF decoder. Relevant for problems with variable sizes.
- `verbose::Bool`: If `true`, enables verbose output during the decoding process. Defaults to `false`.
- `precision::Symbol`: The desired precision for the problem. Can be `:single`, `:double` (default), or `:quadruple`.
- `outsdif::String`: The name of the file `OUTSDIF.d` required for automatic differentiation. Defaults to `"OUTSDIF_sifname_precision.d"`, where `sifname` and `precision` are replaced with the problem name and chosen precision.
- `libsif_folder::String`: The directory where the generated files (`*.f` and `*.d`) will be stored. Defaults to `libsif_path`.

```julia
sifdecoder("HS1.SIF", precision=:single)
sifdecoder("DIXMAANJ", "-param", "M=30"; precision=:double, verbose=true)
sifdecoder("/home/alexis/CUTEst/BROWNDEN.SIF", precision=:quadruple)
```
"""
function sifdecoder(
  name::String,
  args...;
  verbose::Bool = false,
  precision::Symbol = :double,
  outsdif::String = _name_outsdif(name, precision),
  libsif_folder::String = libsif_path,
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
    isfile("OUTSDIF.d") && mv("OUTSDIF.d", outsdif, force = true)
  end
  rm(outlog)
  rm(errlog)
  return nothing
end

"""
    build_libsif(name::String; precision::Symbol=:double, libsif_folder::String=libsif_path)

Builds a shared library from a decoded SIF problem.

# Arguments
- `name::String`: The path or name of the SIF problem, with or without the extension `.SIF`.
- `precision::Symbol`: The desired precision of the problem. Can be `:single`, `:double` (default), or `:quadruple`.
- `libsif_folder::String`: The directory where the compiled library will be stored. Defaults to `libsif_path`.

!!! warning
    We expect that the SIF problem has been decoded in `libsif_folder` and contains the generated files (`*.f` and `*.d`).

```julia
build_libsif("HS1.SIF", precision=:single)
build_libsif("DIXMAANJ", precision=:double)
build_libsif("/home/alexis/CUTEst/BROWNDEN.SIF", precision=:quadruple)
```
"""
function build_libsif(
  name::AbstractString;
  precision::Symbol = :double,
  libsif_folder::String = libsif_path,
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
  libsif_name = "lib$(pname)_$(precision)"

  cd(libsif_folder) do
    if isfile("ELFUN$suffix.f")
      object_files = String[]
      for file in (
        "ELFUN",
        "GROUP",
        "RANGE",
        "ELFUNF",
        "ELFUND",
        "GROUPF",
        "GROUPD",
        "SETTYP",
        "EXTER",
        "EXTERA",
      )
        if isfile("$file$suffix.f")
          @static if Sys.iswindows()
            mingw = Int == Int64 ? "mingw64" : "mingw32"
            gfortran = joinpath(artifact"mingw-w64", mingw, "bin", "gfortran.exe")
            run(`$gfortran -O3 -c -fPIC $file$suffix.f`)
          else
            run(`gfortran -O3 -c -fPIC $file$suffix.f`)
          end
          push!(object_files, "$file$suffix.o")
        end
      end
      if Sys.isapple()
        if VERSION < v"1.10"
          libcutest = joinpath(libcutest_path, "lib$library.$dlext")
          run(
            `gfortran -dynamiclib -o $(libsif_name).$dlext $(object_files) -Wl,-rpath,$(libcutest_path) $libcutest`,
          )
        else
          libcutest = joinpath(libcutest_path, "lib$library.a")
          run(
            `gfortran -dynamiclib -o $(libsif_name).$dlext $(object_files) -Wl,-all_load $libcutest`,
          )
        end
      elseif Sys.iswindows()
        @static if Sys.iswindows()
          mingw = Int == Int64 ? "mingw64" : "mingw32"
          gfortran = joinpath(artifact"mingw-w64", mingw, "bin", "gfortran.exe")
          libcutest = joinpath(libcutest_path, "lib$library.a")
          run(
            `$gfortran -shared -o $(libsif_name).$dlext $(object_files) -Wl,--whole-archive $libcutest -Wl,--no-whole-archive`,
          )
        end
      else
        if VERSION < v"1.10"
          libgfortran = strip(read(`gfortran --print-file libgfortran.so`, String))
          run(
            `ld -shared -o $(libsif_name).$dlext $(object_files) -rpath=$(libcutest_path) -L$(libcutest_path) -l$library $libgfortran`,
          )
        else
          libcutest = joinpath(libcutest_path, "lib$library.a")
          run(
            `gfortran -shared -o $(libsif_name).$dlext $(object_files) -Wl,--whole-archive $libcutest -Wl,--no-whole-archive`,
          )
        end
      end
      delete_temp_files(suffix)
    end
  end
  return nothing
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

"""
    clear_libsif()

Removes all compiled libraries and data files associated with SIF problems.
"""
function clear_libsif()
  total_nbytes = 0
  for file in readdir(libsif_path, join = true, sort = false)
    total_nbytes += filesize(file)
    rm(file, force = true)
  end
  println(
    "All files generated by CUTEst.jl have been deleted for a total of $(total_nbytes |> format_bytes).",
  )
end

"""
    manage_libsif(; sort_by::Symbol=:name, rev::Bool=false)

Opens a prompt allowing the user to selectively remove compiled libraries for SIF problems.
Data files `OUTSDIF_*.d`, which store preprocessed information required for automatic differentiation within CUTEst, are also removed.

By default, the problems are sorted by name.
Alternatively, you can sort them by file size on disk by specifying `sort_by=:size`.
Use `rev=true` to reverse the sort order.
"""
function manage_libsif(; sort_by::Symbol = :name, rev::Bool = false)
  # Get all installed libsif / outsdif
  sif_problems = Set{String}()
  sif_precision = Dict{String, Vector{String}}()
  sif_sizes = Dict{String, Int}()
  files = readdir(libsif_path)
  for file in files
    for precision in ("single", "double", "quadruple")
      suffix = "_$precision.$dlext"
      if startswith(file, "lib") && endswith(file, suffix)
        sif_problem = file[4:(end - length(suffix))]
        push!(sif_problems, sif_problem)
        if !haskey(sif_precision, sif_problem)
          sif_precision[sif_problem] = String[]
          sif_sizes[sif_problem] = 0
        end
        push!(sif_precision[sif_problem], precision)
        libsif = joinpath(libsif_path, file)
        name_outsdif = _name_outsdif(sif_problem, precision |> Symbol)
        outsdif = joinpath(libsif_path, name_outsdif)
        sif_sizes[sif_problem] += filesize(libsif)
        sif_sizes[sif_problem] += filesize(outsdif)
      end
    end
  end

  if isempty(sif_problems)
    println("No problems to remove. All SIF libraries have already been cleared.")
  else
    # Compute the size in bytes associated to each problems
    sif_problems = collect(sif_problems)
    sif_sizes = [sif_sizes[sif_problem] for sif_problem in sif_problems]

    # Sort sif_problems and sif_sizes
    if sort_by === :name
      perm = sortperm(sif_problems; rev)
    elseif sort_by == :size
      perm = sortperm(sif_sizes; rev)
    else
      error("unsupported sort value: :$sort_by (allowed: :name, :size)")
    end

    sif_problems = sif_problems[perm]
    sif_sizes = sif_sizes[perm]

    # Build menu items
    menu_items = similar(sif_problems)
    for i in eachindex(sif_problems, sif_sizes)
      menu_items[i] = @sprintf("%-10s (%s)", sif_problems[i], sif_sizes[i] |> Base.format_bytes)
    end

    # Prompt user
    ts = @sprintf("%s", sum(sif_sizes) |> Base.format_bytes)
    manage_sif_menu = TerminalMenus.request(
      "Which problems should be removed (total size on disk: $ts)?",
      TerminalMenus.MultiSelectMenu(menu_items; pagesize = 10, charset = :ascii),
    )

    # Handle no selection
    if isempty(manage_sif_menu)
      println("Removed 0 problems.")
    else
      # Otherwise prompt for confirmation
      println("\nThe following problems have been marked for removal:\n")
      index_items = Int.(manage_sif_menu)
      for item in menu_items[sort(index_items)]
        println("  ", item)
      end
      print("\nAre you sure that these should be removed? [Y/n]: ")
      answer = strip(readline()) |> lowercase

      # If removal is confirmed, deleting the relevant files
      if isempty(answer) || answer == "yes" || answer == "y"
        for index_item in index_items
          sif_problem = sif_problems[index_item]
          for precision in sif_precision[sif_problem]
            suffix = "_$precision.$dlext"
            libsif = joinpath(libsif_path, "lib$(sif_problem)$(suffix)")
            rm(libsif, force = true)
            name_outsdif = _name_outsdif(sif_problem, precision |> Symbol)
            outsdif = joinpath(libsif_path, name_outsdif)
            rm(outsdif, force = true)
          end
        end
        println("Removed ", length(manage_sif_menu), " problems.")
      else
        println("Removed 0 problems.")
      end
    end
  end
end
