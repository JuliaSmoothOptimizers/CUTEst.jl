for problem in problems
  @testset "Problem $problem" begin
    nlp_cutest = CUTEstModel(problem)
    nlp_manual = eval(Symbol(problem))()
    nlps = [nlp_cutest, nlp_manual]

    consistent_nlps(nlps, linear_api = true, reimplemented = ["cons","jac", "jprod", "jtprod"])
    view_subarray_nlp(nlp_cutest)
    coord_memory_nlp(nlp_cutest, linear_api = true)

    finalize(nlp_cutest)
  end
end
