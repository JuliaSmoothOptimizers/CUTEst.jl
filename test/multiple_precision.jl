function multiple_precision()
  @testset "Test multiple precision models" begin
    for (T, precision) in [(Float32, :single), (Float64, :double)]
      for p in ["ROSENBR", "HS35", "ALLINITA"]
        nlp = CUTEstModel(p, precision = precision)
        x = T.(nlp.meta.x0)
        fx = obj(nlp, x)
        @test typeof(obj(nlp, x)) == T
        @test eltype(grad(nlp, x)) == T
        @test eltype(hess(nlp, x)) == T
        @test eltype(cons(nlp, x)) == T
        @test eltype(jac(nlp, x)) == T
        finalize(nlp)
      end
    end
  end
end

multiple_precision()
