function test_nlpinterface(nlp::CUTEstModel, comp_nlp::AbstractNLPModel)
  x0 = nlp.meta.x0
  f(x) = obj(comp_nlp, x)
  g(x) = grad(comp_nlp, x)
  H(x; obj_weight=1.0) = tril(hess(comp_nlp, x, obj_weight=obj_weight),-1) +
                          hess(comp_nlp, x, obj_weight=obj_weight)'
  c(x) = cons(comp_nlp, x)
  J(x) = jac(comp_nlp, x)
  W(x, y; obj_weight=1.0) = tril(hess(comp_nlp, x, y=y, obj_weight=obj_weight),-1) +
                            hess(comp_nlp, x, y=y, obj_weight=obj_weight)'

  if nlp.meta.ncon > 0
    v = ones(nlp.meta.nvar)
    u = ones(nlp.meta.ncon)
  end

  rtol = 1e-8

  facts("Julia interface") do
    fx = obj(nlp, x0);
    @fact fx --> roughly(f(x0), rtol=rtol)

    (fx, gx) = objgrad(nlp, x0, true);
    @fact fx --> roughly(f(x0), rtol=rtol)
    @fact gx --> roughly(g(x0), rtol=rtol)

    gx = grad(nlp, x0)
    @fact gx --> roughly(g(x0), rtol=rtol)

    fill!(gx, 0.0)
    grad!(nlp, x0, gx)
    @fact gx --> roughly(g(x0), rtol=rtol)

    if nlp.meta.ncon > 0
      (fx, cx) = objcons(nlp, x0)
      @fact fx --> roughly(f(x0), rtol=rtol)
      @fact cx --> roughly(c(x0), rtol=rtol)

      (cx, jrow, jcol, jval) = cons_coord(nlp, x0, true)
      Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
      @fact cx --> roughly(c(x0), rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)

      (cx, Jx) = cons(nlp, x0, true);
      @fact cx --> roughly(c(x0), rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)

      cx = cons(nlp, x0, false)
      @fact cx --> roughly(c(x0), rtol=rtol)

      cx = cons(nlp, x0) # This is here to improve coverage
      @fact cx --> roughly(c(x0), rtol=rtol)

      fill!(cx, 0.0)
      cons!(nlp, x0, cx)
      @fact cx --> roughly(c(x0), rtol=rtol)

      (jrow, jcol, jval) = jac_coord(nlp, x0)
      Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
      @fact Jx --> roughly(J(x0), rtol=rtol)

      Jx = jac(nlp, x0)
      @fact Jx --> roughly(J(x0), rtol=rtol)

      Jv = jprod(nlp, x0, v)
      @fact Jv --> roughly(J(x0)*v, rtol=rtol)

      Jtu = jtprod(nlp, x0, u)
      @fact Jtu --> roughly(J(x0)'*u, rtol=rtol)
    end

    v = rand(nlp.meta.nvar);
    obj_weights = [0.0, 1.0, 3.141592]
    for obj_weight in obj_weights
      Hx = hess(nlp, x0, obj_weight=obj_weight);
      @fact Hx --> roughly(tril(H(x0, obj_weight=obj_weight)), rtol=rtol)
      if nlp.meta.ncon > 0
        Wx = hess(nlp, x0, y=ones(nlp.meta.ncon), obj_weight=obj_weight);
        @fact Wx --> roughly(tril(W(x0, ones(nlp.meta.ncon),
                                    obj_weight=obj_weight)), rtol=rtol)
      end

      hv = hprod(nlp, x0, v, obj_weight=obj_weight);
      @fact hv --> roughly(H(x0, obj_weight=obj_weight)*v, rtol=rtol)

      fill!(hv, 0.0)
      hprod!(nlp, x0, v, hv, obj_weight=obj_weight)
      @fact hv --> roughly(H(x0, obj_weight=obj_weight)*v, rtol=rtol)

      if nlp.meta.ncon > 0
        hv = hprod(nlp, x0, v, y=ones(nlp.meta.ncon), obj_weight=obj_weight);
        @fact hv --> roughly(W(x0, ones(nlp.meta.ncon),
                               obj_weight=obj_weight)*v, rtol=rtol)

        fill!(hv, 0.0)
        hprod!(nlp, x0, v, hv, y=ones(nlp.meta.ncon), obj_weight=obj_weight);
        @fact hv --> roughly(W(x0, ones(nlp.meta.ncon),
                               obj_weight=obj_weight)*v, rtol=rtol)
      end
    end

    if nlp.meta.ncon > 0
      @assert nlp.counters.neval_obj == 3
      @assert nlp.counters.neval_grad == 3
      @assert nlp.counters.neval_cons == 6
      @assert nlp.counters.neval_jac == 4
      @assert nlp.counters.neval_jprod == 1
      @assert nlp.counters.neval_jtprod == 1
      @assert nlp.counters.neval_hess == 2 * length(obj_weights)
      @assert nlp.counters.neval_hprod == 4 * length(obj_weights)
    else
      @assert nlp.counters.neval_obj == 2
      @assert nlp.counters.neval_grad == 3
      @assert nlp.counters.neval_cons == 0
      @assert nlp.counters.neval_jac == 0
      @assert nlp.counters.neval_jprod == 0
      @assert nlp.counters.neval_jtprod == 0
      @assert nlp.counters.neval_hess == 1 * length(obj_weights)
      @assert nlp.counters.neval_hprod == 2 * length(obj_weights)
    end

    print("Julia interface stress test... ")
    for i = 1:10000
      fx = obj(nlp, x0);
      (fx, gx) = objgrad(nlp, x0, true);
      gx = grad(nlp, x0)
      grad!(nlp, x0, gx)
      Hx = hess(nlp, x0);
      v = rand(nlp.meta.nvar);
      hv = hprod(nlp, x0, v);
      hprod!(nlp, x0, v, hv)
      if nlp.meta.ncon > 0
        (fx, cx) = objcons(nlp, x0)
        (cx, jrow, jcol, jval) = cons_coord(nlp, x0, true)
        Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
        (cx, Jx) = cons(nlp, x0, true);
        cx = cons(nlp, x0, false)
        cx = cons(nlp, x0)
        cons!(nlp, x0, cx)
        (jrow, jcol, jval) = jac_coord(nlp, x0)
        Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
        Jx = jac(nlp, x0)
        jv = jprod(nlp, x0, v)
        jtu = jtprod(nlp, x0, u)
        Wx = hess(nlp, x0, y=ones(nlp.meta.ncon));
        hv = hprod(nlp, x0, v, y=ones(nlp.meta.ncon));
        hprod!(nlp, x0, v, hv, y=ones(nlp.meta.ncon));
      end
    end
    println("Passed")
  end
end
