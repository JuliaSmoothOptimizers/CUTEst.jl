function test_view_subarray()
  @testset "Test view subarray" begin
    cnlp = CUTEstModel("HS47")

    view_subarray_nlp(cnlp)

    finalize(cnlp)
  end
end

test_view_subarray()
