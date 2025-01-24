function multiple_precision()
  @testset "Test multiple precision models" begin
    for T in (Float32, Float64, Float128)
      (T == Float128) && (Sys.ARCH == :aarch64) && Sys.islinux() && continue
      for p in ["ROSENBR", "HS35", "ALLINITA"]
        nlp = CUTEstModel{T}(p)
        x = T.(nlp.meta.x0)
        fx = obj(nlp, x)
        gx = grad(nlp, x)
        Hx = hess(nlp, x)
        cx = cons(nlp, x)
        Jx = jac(nlp, x)
        @test typeof(fx) == T
        @test eltype(gx) == T
        @test eltype(Hx) == T
        @test eltype(cx) == T
        @test eltype(Jx) == T
        finalize(nlp)
      end
    end
  end
end

multiple_precision()
