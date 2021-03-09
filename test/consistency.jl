for problem in problems
  @testset "Checking problem $problem" begin
    problem_s = string(problem)

    nlp_man = eval(problem)()
    nlp_cutest = CUTEstModel(uppercase(problem_s))
    nlps = [nlp_cutest, nlp_man]

    consistent_nlps(nlps)

    finalize(nlp_cutest)
  end
end
