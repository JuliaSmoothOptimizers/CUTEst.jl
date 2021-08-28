#stdlib
using LinearAlgebra, SparseArrays, Random, Test
# jso
using CUTEst, NLPModels, NLPModelsTest

set_mastsif()
@test ispath(ENV["MASTSIF"])
@test isfile(joinpath(ENV["MASTSIF"], "CYCLOOCT.SIF"))

problems = ["BROWNDEN", "HS5", "HS6", "HS10", "HS11", "HS14"]

include("test_core.jl")
include("test_julia.jl")
include("coverage.jl")

for problem in problems
  println("Testing interfaces on problem $problem")
  nlp = CUTEstModel(problem)
  nlp_man = eval(Symbol(problem))()

  test_nlpinterface(nlp, nlp_man)
  test_coreinterface(nlp, nlp_man)
  test_coreinterface(nlp, nlp_man; test_view = true)
  coverage_increase(nlp)

  println("Finalizing")
  finalize(nlp)
end

include("nlpmodelstest.jl")
# include("test_select.jl") # Tests are removed because any update to MASTSIF breaks it

problems = CUTEst.select(max_var = 2, max_con = 2)
problems = randsubseq(problems, 0.1)

for p in problems
  nlp = CUTEstModel(p)
  x0 = nlp.meta.x0
  nvar, ncon = nlp.meta.nvar, nlp.meta.ncon

  println("$p: julia interface: f(x₀) = $(obj(nlp, x0))")

  io_err = Cint[0]
  fval = [0.0]
  if ncon > 0
    cx = zeros(ncon)
    cfn(io_err, Cint[nvar], Cint[ncon], x0, fval, cx)
  else
    ufn(io_err, Cint[nvar], x0, fval)
  end
  println("$p: core interface: f(x₀) = $(fval[1])")

  finalize(nlp)
end

# test arguments passed to decoder
nlp = CUTEstModel("DIXMAANJ", "-param", "M=5")
@assert nlp.meta.nvar == 15
finalize(nlp)

nlp = CUTEstModel("DIXMAANJ", "-param", "M=30")
@assert nlp.meta.nvar == 90
finalize(nlp)

@testset "Test decoding separately (issue #239)" begin
  problems = ["AKIVA", "ROSENBR", "ZANGWIL2"]
  # Decoding
  for p in problems
    finalize(CUTEstModel(p))
  end
  # No decode
  for p in problems
    nlp = CUTEstModel(p, decode = false)
    @test nlp.meta.nvar == 2
    finalize(nlp)
  end
end
