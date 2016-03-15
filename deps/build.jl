cd(dirname(@__FILE__))

@linux_only begin
  lnxurl = "https://raw.githubusercontent.com/abelsiqueira/linux-cutest/master/install.sh"
  run(`wget $lnxurl -O install.sh`)
  run(`bash install.sh`)

  open("cutestenv.jl", "w") do cenv
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

@osx_only begin
  try
    run(`brew doctor`)
  end
  run(`brew update`)
  run(`brew tap optimizers/cutest`)
  run(`brew install cutest`)
  run(`brew install mastsif`)

  open("cutestenv.jl", "w") do cenv
    for p in ["archdefs", "cutest", "sifdecode", "mastsif"]
      prefix = chomp(readall(`brew --prefix $p`))
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


