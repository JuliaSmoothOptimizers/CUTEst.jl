for problem in problems
  @testset "Problem $problem" begin
    nlp_cutest = CUTEstModel(problem)
    nlp_manual = eval(Symbol(problem))()
    nlps = [nlp_cutest, nlp_manual]

    consistent_nlps(nlps)
    view_subarray_nlp(nlp_cutest)
    coord_memory_nlp(nlp_cutest)

    finalize(nlp_cutest)
  end
end
