using Compat
using BinDeps

@BinDeps.setup

libgsl = library_dependency("libgsl", aliases=["libgsl-0"])

# package managers - currently with error on sudo
#   https://discourse.julialang.org/t/installing-dependencies-error-sudo-no-tty-present-and-no-askpass-program-specified/778
#provides(AptGet, Dict("libgsl0ldbl"=>libgsl, "libgsl0-dev" =>libgsl, "gsl-bin"=>libgsl))
#provides(Yum, "gsl-devel", libgsl)
#provides(Pacman, "gsl", libgsl)

if is_apple()
    using Homebrew
    provides(Homebrew.HB, "homebrew/versions/gsl1", libgsl, os = :Darwin)
end

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
    end
    return true
  end
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

if validate_libcutest()
  check_env()
  ispath(cutestenv) && rm(cutestenv)
else
  install = true
  if isfile(cutestenv)
    include(cutestenv)
    if validate_libcutest()
      println("Valid CUTEst installation detected, no files installed.\nTo force installation, delete $cutestenv and run Pkg.build(\"CUTEst\") again.")
      install = false
    end
  end
  if install
    # Install CUTEst
    @static if is_apple()
      Homebrew.add("optimizers/cutest/cutest")
      Homebrew.add("optimizers/cutest/mastsif")

      open(cutestenv, "w") do cenv
        for p in ["archdefs", "cutest", "sifdecode", "mastsif"]
          prefix = Homebrew.prefix(p)
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

    @static if is_linux()
      cd(here) do
        isdir("files") && rm("files", recursive=true)
        mkdir("files")
        cd("files") do
          lnxurl = "https://raw.githubusercontent.com/abelsiqueira/linux-cutest/v0.1.0/install.sh"
          run(`wget $lnxurl -O install.sh`)
          ENV["C_INCLUDE_PATH"] = joinpath(here, "usr", "include")
          run(`bash install.sh`)

          open(cutestenv, "w") do cenv
            open("cutest_env.bashrc") do f
              for p in ["PATH", "MANPATH", "LD_LIBRARY_PATH"]
                write(cenv, "$p = get(ENV, \"$p\", \"\")\n")
              end
              for line in readlines(f)
                var = split(split(line, "=")[1])[2]
                path = chomp(split(line, "=")[2])
                write(cenv, "ENV[\"$var\"] = \"$path\"\n")
              end
              println(cenv, "ENV[\"cutest-problems\"] = \"$(pwd())/problems\"")
            end
          end
        end
      end
    end
  end
end
