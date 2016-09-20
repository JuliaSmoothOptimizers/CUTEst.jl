using Documenter, CUTEst, NLPModels

makedocs(
  modules = [CUTEst]
)

deploydocs(deps = Deps.pip("pygments", "mkdocs", "mkdocs-material", "python-markdown-math"),
  repo = "github.com/JuliaSmoothOptimizers/CUTEst.jl.git",
  julia = "release",
  latest = "develop"
)
