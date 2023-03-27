using Documenter, CUTEst, NLPModels

makedocs(
  modules = [CUTEst],
  doctest = true,
  linkcheck = true,
  strict = true,
  format = Documenter.HTML(
    assets = ["assets/style.css"],
    ansicolor = true,
    prettyurls = get(ENV, "CI", nothing) == "true",
  ),
  sitename = "CUTEst.jl",
  pages = [
    "Home" => "index.md",
    "Tutorial" => "tutorial.md",
    "Core" => "core.md",
    "Reference" => "reference.md",
  ],
)

deploydocs(
  repo = "github.com/JuliaSmoothOptimizers/CUTEst.jl.git",
  devbranch = "main",
  push_preview = true,
)
