using BinDeps

@BinDeps.setup

libgsl = library_dependency("libgsl", aliases=["libgsl-0"])

if is_apple()
    using Homebrew
    provides(Homebrew.HB, "gsl@1", libgsl, os = :Darwin)
end
if is_linux()
    using Linuxbrew
    provides(Linuxbrew.LB, "gsl@1", libgsl, os = :Linux)
end
Brew = is_apple() ? Homebrew : Linuxbrew

# build from source
provides(Sources, URI("http://ftp.gnu.org/gnu/gsl/gsl-1.16.tar.gz"), libgsl)
provides(BuildProcess, Autotools(libtarget = "libgsl.la"), libgsl)

@BinDeps.install Dict(:libgsl => :libgsl)

## BinDeps end

function validate_libcutest()
  env_cutest = get(ENV, "CUTEST", "")
  runcutest = env_cutest == "" ? "runcutest" : joinpath(env_cutest, "bin", "runcutest")
  myarch = get(ENV, "MYARCH", "")
  hs3 = env_cutest == "" ? "HS3.SIF" : joinpath(env_cutest, "sif", "HS3.SIF")
  tmpdir = mktempdir()
  try
    cd(tmpdir) do
      outlog = tempname()
      errlog = tempname()
      run(pipeline(`$runcutest -p genc -D $hs3`, stdout=outlog, stderr=errlog))
      print(readstring(errlog))
      rm(outlog, force=true)
      rm(errlog, force=true)
    end
    return true
  end
  rm(tmpdir, force=true, recursive=true)
  false
end

function check_env()
  for var in (:ARCHDEFS, :SIFDECODE, :CUTEST, :MYARCH, :MASTSIF)
    get(ENV, "$var", "") == "" && error("CUTEst.jl: please set the $var environment variable")
  end
  nothing
end

here = dirname(@__FILE__)
cutestenv = joinpath(here, "cutestenv.jl")

# Check if there is an external CUTEst installation
if validate_libcutest()
  info("External CUTEst installation found")
  check_env()
  ispath(cutestenv) && rm(cutestenv)
else
  @static if is_apple()
    install = true
    if isfile(cutestenv)
      include(cutestenv)
      if validate_libcutest()
        info("Updating CUTEst")
        try
          Brew.brew(`upgrade cutest`)
          Brew.brew(`upgrade mastsif`)
        catch
          # brew upgrade returns an error if the latest version is already installed
          info("Ignore error message above; latest version already installed")
        end
        install = false
      end
    end
  end

  if install
    info("Installing CUTEst")
    Brew.add("optimizers/cutest/cutest")
    Brew.add("optimizers/cutest/mastsif")

    open(cutestenv, "w") do cenv
      for p in ["archdefs", "cutest", "sifdecode", "mastsif"]
        prefix = Brew.prefix(p)
        open("$prefix/$p.bashrc") do f
          for line in readlines(f)
            var = split(split(line, "=")[1])[2]
            path = chomp(split(line, "=")[2])
            write(cenv, "ENV[\"$var\"] = \"$path\"\n")
          end
        end
      end
      cd(here) do
        isdir("files") && rm("files", recursive=true)
        mkdir("files")
      end
      path = joinpath(here, "files", "problems")
      println(cenv, "ENV[\"cutest-problems\"] = \"$path\"")
    end
  end
end
