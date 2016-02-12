println("\nTesting the Julia interface\n")
fx = obj(x0);
@test_approx_eq_eps fx f(x0) 1e-8

(fx, gx) = objgrad(x0, true);
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

gx = grad(x0)
@test_approx_eq_eps gx g(x0) 1e-8

fill!(gx, 0.0)
grad!(x0, gx)
@test_approx_eq_eps gx g(x0) 1e-8

println("f(x0) = ", fx)
println("∇f(x0) = ", gx)
if nlp.ncon > 0
  (fx, cx) = objcons(x0)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  (cx, jrow, jcol, jval) = cons_coord(x0, true)
  Jx = sparse(jrow, jcol, jval, nlp.ncon, nlp.nvar)
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  (cx, Jx) = cons(x0, true);
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  cx = cons(x0, false)
  @test_approx_eq_eps cx c(x0) 1e-8

  cx = cons(x0) # This is here to improve coverage
  @test_approx_eq_eps cx c(x0) 1e-8

  fill!(cx, 0.0)
  cons!(x0, cx)
  @test_approx_eq_eps cx c(x0) 1e-8

  (jrow, jcol, jval) = jac_coord(x0)
  Jx = sparse(jrow, jcol, jval, nlp.ncon, nlp.nvar)
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = jac(x0)
  @test_approx_eq_eps Jx J(x0) 1e-8

  println("c(x0) = ", cx);
  println("J(x0) = "); println(full(Jx));
end

Hx = hess(x0);
@test_approx_eq_eps Hx H(x0) 1e-8
println("H(x0) = "); println(full(Hx));
if nlp.ncon > 0
  Wx = hess(x0, ones(nlp.ncon));
  @test_approx_eq_eps Wx W(x0, ones(nlp.ncon)) 1e-8
  println("H(x0,ones) = "); println(full(Wx));
end

v = rand(nlp.nvar);
hv = hprod(x0, v);
println("H(x0) * v = ", hv);
@test_approx_eq_eps hv Hx*v 1e-8

fill!(hv, 0.0)
hprod!(x0, v, hv)
@test_approx_eq_eps hv Hx*v 1e-8

if nlp.ncon > 0
  hv = hprod(x0, ones(nlp.ncon), v);
  println("H(x0,ones) * v = ", hv);
  @test_approx_eq_eps hv Wx*v 1e-8

  fill!(hv, 0.0)
  hprod!(x0, ones(nlp.ncon), v, hv);
  @test_approx_eq_eps hv Wx*v 1e-8
end

print("Julia interface stress test... ")
for i = 1:100000
  fx = obj(x0);
  (fx, gx) = objgrad(x0, true);
  gx = grad(x0)
  grad!(x0, gx)
  Hx = hess(x0);
  v = rand(nlp.nvar);
  hv = hprod(x0, v);
  hprod!(x0, v, hv)
  if nlp.ncon > 0
    (fx, cx) = objcons(x0)
    (cx, jrow, jcol, jval) = cons_coord(x0, true)
    Jx = sparse(jrow, jcol, jval, nlp.ncon, nlp.nvar)
    (cx, Jx) = cons(x0, true);
    cx = cons(x0, false)
    cx = cons(x0)
    cons!(x0, cx)
    (jrow, jcol, jval) = jac_coord(x0)
    Jx = sparse(jrow, jcol, jval, nlp.ncon, nlp.nvar)
    Jx = jac(x0)
    Wx = hess(x0, ones(nlp.ncon));
    hv = hprod(x0, ones(nlp.ncon), v);
    hprod!(x0, ones(nlp.ncon), v, hv);
  end
end
println("Passed")
