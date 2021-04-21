using Documenter, CUTEst, NLPModels

makedocs(
  modules = [CUTEst],
  doctest = true,
  linkcheck = true,
  strict = true,
  assets = ["assets/style.css"],
  format = Documenter.HTML(
              prettyurls = get(ENV, "CI", nothing) == "true"
            ),
  sitename = "CUTEst.jl",
  pages = Any["Home" => "index.md",
              "Tutorial" => "tutorial.md",
              "Core" => "core.md",
              "Reference" => "reference.md"]
)

deploydocs(deps = nothing, make = nothing,
  repo = "github.com/JuliaSmoothOptimizers/CUTEst.jl.git",
  target = "build",
  devbranch = "master"
)
