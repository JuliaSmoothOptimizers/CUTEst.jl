# We don't use BinDeps because we couldn't make it work

using Compat

function validate_libcutest()
  env_cutest = get(ENV, "CUTEST", "")
  runcutest = env_cutest == "" ? "runcutest" : joinpath(env_cutest, "bin", "runcutest")
  myarch = get(ENV, "MYARCH", "")
  hs3 = env_cutest == "" ? "HS3.SIF" : joinpath(env_cutest, "sif", "HS3.SIF")
  tmpdir = mktempdir()
  cd(tmpdir)
  try
    outlog = tempname()
    errlog = tempname()
    run(pipeline(`$runcutest -p genc -D $hs3`, stdout=outlog, stderr=errlog))
    print(readstring(errlog))
    return true
  catch
    return false
  end
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
  @static if is_apple()
    using Homebrew
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
    end
  end

  @static if is_linux()
    lnxurl = "https://raw.githubusercontent.com/abelsiqueira/linux-cutest/master/install.sh"
    run(`wget $lnxurl -O install.sh`)
    run(`bash install.sh --install-deps`)

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
      end
    end
  end
end
