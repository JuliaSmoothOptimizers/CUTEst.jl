include(joinpath(path, "consistency.jl"))

problems = [:brownden, :hs5, :hs6, :hs10, :hs11, :hs14]
for problem in problems
  problem_s = string(problem)

  problem_f = eval(problem)
  nlp_mpb = MathProgNLPModel(problem_f())
  nlp_cutest = CUTEstModel(uppercase(problem_s))
  nlps = [nlp_cutest, nlp_mpb]

  @printf("Checking problem %-15s%12s\t", problem_s, "")
  consistent_nlps(nlps)

  cutest_finalize(nlp_cutest)
end
