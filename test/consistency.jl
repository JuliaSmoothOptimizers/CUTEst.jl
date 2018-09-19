include(joinpath(path, "consistency.jl"))

problems = [:brownden, :hs5, :hs6, :hs11, :hs14]
for problem in problems
  problem_s = string(problem)

  nlp_autodiff = eval(parse("$(problem)_autodiff"))()
  nlp_cutest = CUTEstModel(uppercase(problem_s))
  nlps = [nlp_cutest, nlp_autodiff]

  @printf("Checking problem %-15s%12s\t", problem_s, "")
  consistent_nlps(nlps)

  finalize(nlp_cutest)
end
