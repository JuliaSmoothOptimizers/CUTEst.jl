using Documenter, CUTEst, NLPModels

makedocs(
  modules = [CUTEst],
  doctest = false,
  linkcheck = true,
  format = Documenter.HTML(
    assets = ["assets/style.css"],
    ansicolor = true,
    prettyurls = get(ENV, "CI", nothing) == "true",
    size_threshold_ignore = ["core.md", "reference.md"],
  ),
  sitename = "CUTEst.jl",
  pages = [
    "Home" => "index.md",
    "Tutorial" => "tutorial.md",
    "CUTEstModel" => "model.md",
    "SIF decoder" => "sifdecoder.md",
    "Core" => "core.md",
    "Reference" => "reference.md",
  ],
)

deploydocs(
  repo = "github.com/JuliaSmoothOptimizers/CUTEst.jl.git",
  devbranch = "main",
  push_preview = true,
)
