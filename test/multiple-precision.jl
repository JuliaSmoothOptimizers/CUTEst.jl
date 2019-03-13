function multiple_precision()
  @testset "Test multiple precision models" begin
    for T = [Float32, Float64], p = ["ROSENBR", "HS35", "ALLINITA"]
      nlp = CUTEstModel(p)
      x = convert.(T, nlp.meta.x0)
      println("x = $x")
      fx = obj(nlp, x)
      println("fx = $fx")
      @test typeof(obj(nlp, x)) == T
      @test eltype(grad(nlp, x)) == T
      @test eltype(hess(nlp, x)) == T
      @test eltype(hess(nlp, x, y=ones(T, 2))) == T
      @test eltype(hess(nlp, x, obj_weight=one(T), y=ones(T, 2))) == T
      @test eltype(cons(nlp, x)) == T
      @test eltype(jac(nlp, x)) == T
      finalize(nlp)
    end
  end
end

multiple_precision()
