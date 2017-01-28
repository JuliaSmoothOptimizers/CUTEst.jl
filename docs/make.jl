using Documenter, CUTEst, NLPModels

makedocs(
  modules = [CUTEst, NLPModels],
  assets = ["assets/style.css"],
  format = :html,
  sitename = "CUTEst.jl",
  pages = Any["Home" => "index.md",
              "Tutorial" => "tutorial.md",
              "API" => "api.md",
              "Core" => "core.md",
              "Reference" => "reference.md"]
)

deploydocs(deps = nothing, make = nothing,
  repo = "github.com/JuliaSmoothOptimizers/CUTEst.jl.git",
  target = "build",
  julia = "0.5",
  latest = "master"
)
