println("\nTesting the Julia interface\n")
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
end

Hx = hess(nlp, x0);
println("Hx=", full(Hx)); println("H(x0)=", H(x0));
@test_approx_eq_eps Hx tril(H(x0)) 1e-8
println("H(x0) = "); println(full(Hx));
if nlp.meta.ncon > 0
  Wx = hess(nlp, x0, ones(nlp.meta.ncon));
  @test_approx_eq_eps Wx tril(W(x0, ones(nlp.meta.ncon))) 1e-8
  println("H(x0,ones) = "); println(full(Wx));
end

v = rand(nlp.meta.nvar);
hv = hprod(nlp, x0, v);
println("H(x0) * v = ", hv);
@test_approx_eq_eps hv H(x0)*v 1e-8

fill!(hv, 0.0)
hprod!(nlp, x0, v, hv)
@test_approx_eq_eps hv H(x0)*v 1e-8

if nlp.meta.ncon > 0
  hv = hprod(nlp, x0, ones(nlp.meta.ncon), v);
  println("H(x0,ones) * v = ", hv);
  @test_approx_eq_eps hv W(x0, ones(nlp.meta.ncon))*v 1e-8

  fill!(hv, 0.0)
  hprod!(nlp, x0, ones(nlp.meta.ncon), v, hv);
  @test_approx_eq_eps hv W(x0, ones(nlp.meta.ncon))*v 1e-8
end

print("Julia interface stress test... ")
for i = 1:100000
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
    Wx = hess(nlp, x0, ones(nlp.meta.ncon));
    hv = hprod(nlp, x0, ones(nlp.meta.ncon), v);
    hprod!(nlp, x0, ones(nlp.meta.ncon), v, hv);
  end
end
println("Passed")
