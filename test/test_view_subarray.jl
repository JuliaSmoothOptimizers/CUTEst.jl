include(joinpath(nlpmodels_path, "test_view_subarray.jl"))

function test_view_subarray()
  @testset "Test view subarray" begin
    cnlp = CUTEstModel("HS47")
    scnlp = SlackModel(cnlp)

    for nlp in [cnlp, scnlp]
      test_view_subarray_nlp(nlp)
    end

    finalize(cnlp)
  end
end

test_view_subarray()
