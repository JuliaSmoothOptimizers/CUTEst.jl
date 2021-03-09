using Test, CUTEst, NLPModelsCore, NLPModelsTestUtils, LinearAlgebra, SparseArrays, Random, Printf

set_mastsif()
@test ispath(ENV["MASTSIF"])
@test isfile(joinpath(ENV["MASTSIF"], "CYCLOOCT.SIF"))

# :hs10 removed from the tests because of
# https://github.com/JuliaSmoothOptimizers/CUTEst.jl/issues/113
problems = [:BROWNDEN, :HS5, :HS6, :HS10, :HS11, :HS14]

include("test_core.jl")
include("test_julia.jl")
include("coverage.jl")

for problem in problems
  problem_s = string(problem)
  nlp = CUTEstModel(problem_s)
  nlpman = eval(problem)()

  test_nlpinterface(nlp, nlpman)
  test_coreinterface(nlp, nlpman)
  coverage_increase(nlp)

  println("Finalizing")
  finalize(nlp)
end

include("consistency.jl")
# include("test_select.jl") # Tests are removed because any update to MASTSIF breaks it

problems = CUTEst.select(max_var=2, max_con=2)
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
include("test_view_subarray.jl")
include("test_memory_of_coord.jl")
