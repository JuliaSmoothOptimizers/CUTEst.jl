function compare_cons(nlp1, cx1, nlp2, cx2, rtol)
  @test isapprox(cx1 - nlp1.meta.ucon, cx2 - nlp2.meta.ucon, rtol = rtol)
  @test isapprox(cx1 - nlp1.meta.lcon, cx2 - nlp2.meta.lcon, rtol = rtol)
end

function test_nlpinterface(nlp::CUTEstModel{T}, comp_nlp::AbstractNLPModel{T}) where T
  x0 = nlp.meta.x0
  f(x) = obj(comp_nlp, x)
  g(x) = grad(comp_nlp, x)
  H(x; obj_weight = one(T)) = hess(comp_nlp, x, obj_weight = obj_weight)
  c(x) = cons(comp_nlp, x)
  J(x) = jac(comp_nlp, x)
  W(x, y; obj_weight = one(T)) = hess(comp_nlp, x, y, obj_weight = obj_weight)

  v = ones(T, nlp.meta.nvar)
  u = ones(T, nlp.meta.ncon)

  rtol = eps(T) |> sqrt

  @testset "Julia interface" begin
    fx = obj(nlp, x0)
    @test isapprox(fx, f(x0), rtol = rtol)

    (fx, gx) = objgrad(nlp, x0)
    @test isapprox(fx, f(x0), rtol = rtol)
    @test isapprox(gx, g(x0), rtol = rtol)

    gx = grad(nlp, x0)
    @test isapprox(gx, g(x0), rtol = rtol)

    fill!(gx, zero(T))
    grad!(nlp, x0, gx)
    @test isapprox(gx, g(x0), rtol = rtol)

    if nlp.meta.ncon > 0
      (fx, cx) = objcons(nlp, x0)
      @test isapprox(fx, f(x0), rtol = rtol)
      compare_cons(nlp, cx, comp_nlp, c(x0), rtol)

      (cx, jrow, jcol, jval) = cons_coord(nlp, x0)
      Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
      compare_cons(nlp, cx, comp_nlp, c(x0), rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      x = Vector{Float64}(undef, 2 * nlp.meta.nvar)
      x[1:2:end] .= x0
      (cx, jrow, jcol, jval) = cons_coord(nlp, @view x[1:2:end])
      Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
      compare_cons(nlp, cx, comp_nlp, c(x0), rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      (cx, Jx) = consjac(nlp, x0)
      compare_cons(nlp, cx, comp_nlp, c(x0), rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      cx = cons(nlp, x0) # This is here to improve coverage
      compare_cons(nlp, cx, comp_nlp, c(x0), rtol)

      fill!(cx, zero(T))
      cons!(nlp, x0, cx)
      compare_cons(nlp, cx, comp_nlp, c(x0), rtol)

      jval = jac_coord(nlp, x0)
      Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
      @test isapprox(Jx, J(x0), rtol = rtol)

      Jx = jac(nlp, x0)
      @test isapprox(Jx, J(x0), rtol = rtol)

      Jv = jprod(nlp, x0, v)
      @test isapprox(Jv, J(x0) * v, rtol = rtol)

      Jtu = jtprod(nlp, x0, u)
      @test isapprox(Jtu, J(x0)' * u, rtol = rtol)
    else
      (fx, cx) = objcons(nlp, x0)
      @test isapprox(fx, f(x0), rtol = rtol)
      @test length(cx) == 0
    end

    v = rand(T, nlp.meta.nvar)
    obj_weights = [zero(T), one(T)]
    for obj_weight in obj_weights
      Hx = hess(nlp, x0, obj_weight = obj_weight)
      @test isapprox(Hx, H(x0, obj_weight = obj_weight), rtol = rtol)
      hval = hess_coord(nlp, x0, obj_weight = obj_weight)
      @test isapprox(
        sparse(nlp.hrows, nlp.hcols, hval, nlp.meta.nvar, nlp.meta.nvar),
        tril(H(x0, obj_weight = obj_weight)),
        rtol = rtol,
      )
      if nlp.meta.ncon > 0
        Wx = hess(nlp, x0, ones(T, nlp.meta.ncon), obj_weight = obj_weight)
        @test isapprox(Wx, W(x0, ones(T, nlp.meta.ncon), obj_weight = obj_weight), rtol = rtol)
        hval = hess_coord(nlp, x0, ones(T, nlp.meta.ncon), obj_weight = obj_weight)
        @test isapprox(
          sparse(nlp.hrows, nlp.hcols, hval, nlp.meta.nvar, nlp.meta.nvar),
          tril(W(x0, ones(T, nlp.meta.ncon), obj_weight = obj_weight)),
          rtol = rtol,
        )
      end

      hv = hprod(nlp, x0, v, obj_weight = obj_weight)
      @test isapprox(hv, H(x0, obj_weight = obj_weight) * v, rtol = rtol)

      fill!(hv, zero(T))
      hprod!(nlp, x0, v, hv, obj_weight = obj_weight)
      @test isapprox(hv, H(x0, obj_weight = obj_weight) * v, rtol = rtol)

      if nlp.meta.ncon > 0
        hv = hprod(nlp, x0, ones(T, nlp.meta.ncon), v, obj_weight = obj_weight)
        @test isapprox(hv, W(x0, ones(T, nlp.meta.ncon), obj_weight = obj_weight) * v, rtol = rtol)

        fill!(hv, zero(T))
        hprod!(nlp, x0, ones(T, nlp.meta.ncon), v, hv, obj_weight = obj_weight)
        @test isapprox(hv, W(x0, ones(T, nlp.meta.ncon), obj_weight = obj_weight) * v, rtol = rtol)
      end
    end

    if nlp.meta.ncon > 0
      @assert nlp.counters.neval_obj == 3
      @assert nlp.counters.neval_grad == 3
      @assert nlp.counters.neval_cons == 6
      @assert nlp.counters.neval_jac == 5
      @assert nlp.counters.neval_jprod == 1
      @assert nlp.counters.neval_jtprod == 1
      @assert nlp.counters.neval_hess == 4 * length(obj_weights)
      @assert nlp.counters.neval_hprod == 4 * length(obj_weights)
    else
      @assert nlp.counters.neval_obj == 3
      @assert nlp.counters.neval_grad == 3
      @assert nlp.counters.neval_cons == 0
      @assert nlp.counters.neval_jac == 0
      @assert nlp.counters.neval_jprod == 0
      @assert nlp.counters.neval_jtprod == 0
      @assert nlp.counters.neval_hess == 2 * length(obj_weights)
      @assert nlp.counters.neval_hprod == 2 * length(obj_weights)
    end

    print("Julia interface stress test... ")
    for i = 1:10000
      fx = obj(nlp, x0)
      (fx, gx) = objgrad(nlp, x0)
      gx = grad(nlp, x0)
      grad!(nlp, x0, gx)
      Hx = hess(nlp, x0)
      v = rand(T, nlp.meta.nvar)
      hv = hprod(nlp, x0, v)
      hprod!(nlp, x0, v, hv)
      if nlp.meta.ncon > 0
        (fx, cx) = objcons(nlp, x0)
        (cx, jrow, jcol, jval) = cons_coord(nlp, x0)
        Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
        (cx, Jx) = consjac(nlp, x0)
        cx = cons(nlp, x0)
        cons!(nlp, x0, cx)
        jval = jac_coord(nlp, x0)
        Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
        Jx = jac(nlp, x0)
        jv = jprod(nlp, x0, v)
        jtu = jtprod(nlp, x0, u)
        Wx = hess(nlp, x0, ones(T, nlp.meta.ncon))
        hv = hprod(nlp, x0, ones(T, nlp.meta.ncon), v)
        hprod!(nlp, x0, ones(T, nlp.meta.ncon), v, hv)
      end
    end
    println("Passed")
  end
end
