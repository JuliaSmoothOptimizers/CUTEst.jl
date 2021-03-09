function test_memory_of_coord()
  @testset "Memory of coordinate inplace functions" begin
    for p in ["BROWNDEN", "HS5", "HS6", "HS10", "HS11", "HS14"]
      @info "Testing $p"
      nlp = CUTEstModel(p)
      coord_memory_nlp(nlp)
      finalize(nlp)
    end
  end
end

test_memory_of_coord()
