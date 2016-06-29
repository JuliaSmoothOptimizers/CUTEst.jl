println("\nTesting the Julia interface\n")

if nlp.meta.ncon > 0
  v = ones(nlp.meta.nvar)
  u = ones(nlp.meta.ncon)
end

fx = obj(nlp, x0);
@test_approx_eq_eps fx f(x0) 1e-8

(fx, gx) = objgrad(nlp, x0, true);
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

gx = grad(nlp, x0)
@test_approx_eq_eps gx g(x0) 1e-8

fill!(gx, 0.0)
grad!(nlp, x0, gx)
@test_approx_eq_eps gx g(x0) 1e-8

println("f(x0) = ", fx)
println("∇f(x0) = ", gx)
if nlp.meta.ncon > 0
  (fx, cx) = objcons(nlp, x0)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  (cx, jrow, jcol, jval) = cons_coord(nlp, x0, true)
  Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  (cx, Jx) = cons(nlp, x0, true);
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  cx = cons(nlp, x0, false)
  @test_approx_eq_eps cx c(x0) 1e-8

  cx = cons(nlp, x0) # This is here to improve coverage
  @test_approx_eq_eps cx c(x0) 1e-8

  fill!(cx, 0.0)
  cons!(nlp, x0, cx)
  @test_approx_eq_eps cx c(x0) 1e-8

  (jrow, jcol, jval) = jac_coord(nlp, x0)
  Jx = sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = jac(nlp, x0)
  @test_approx_eq_eps Jx J(x0) 1e-8

  println("c(x0) = ", cx);
  println("J(x0) = "); println(full(Jx));

  Jv = jprod(nlp, x0, v)
  @test_approx_eq_eps Jv J(x0)*v 1e-8

  println("J(x0)*e = ", Jv)

  Jtu = jtprod(nlp, x0, u)
  @test_approx_eq_eps Jtu J(x0)'*u 1e-8

  println("J(x0)'*e = ", Jtu)
end

v = rand(nlp.meta.nvar);
obj_weights = [0.0, 1.0, 3.141592]
for obj_weight in obj_weights
  Hx = hess(nlp, x0, obj_weight=obj_weight);
  @test_approx_eq_eps Hx tril(H(x0, obj_weight=obj_weight)) 1e-7
  println("H(x0) = "); println(full(Hx));
  if nlp.meta.ncon > 0
    Wx = hess(nlp, x0, y=ones(nlp.meta.ncon), obj_weight=obj_weight);
    @test_approx_eq_eps Wx tril(W(x0, ones(nlp.meta.ncon), obj_weight=obj_weight)) 1e-7
    println("H(x0,ones,", obj_weight, ") = "); println(full(Wx));
  end

  hv = hprod(nlp, x0, v, obj_weight=obj_weight);
  println("H(x0,", obj_weight, ") * v = ", hv);
  @test_approx_eq_eps hv H(x0, obj_weight=obj_weight)*v 1e-7

  fill!(hv, 0.0)
  hprod!(nlp, x0, v, hv, obj_weight=obj_weight)
  println("obj_weight = ", obj_weight)
  @test_approx_eq_eps hv H(x0, obj_weight=obj_weight)*v 1e-7

  if nlp.meta.ncon > 0
    hv = hprod(nlp, x0, v, y=ones(nlp.meta.ncon), obj_weight=obj_weight);
    println("H(x0,ones,", obj_weight, ") * v = ", hv);
    @test_approx_eq_eps hv W(x0, ones(nlp.meta.ncon), obj_weight=obj_weight)*v 1e-7

    fill!(hv, 0.0)
    hprod!(nlp, x0, v, hv, y=ones(nlp.meta.ncon), obj_weight=obj_weight);
    @test_approx_eq_eps hv W(x0, ones(nlp.meta.ncon), obj_weight=obj_weight)*v 1e-7
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
