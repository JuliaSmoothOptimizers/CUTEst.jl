using CUTEst
using Base.Test

# Work in a temporary directory.
curdir = pwd();
tmpdir = mktempdir();
cd(tmpdir);

problem = "HS32"
nlp = CUTEstModel(problem);
x0 = nlp.meta.x0

print(nlp);

fx = obj(nlp, x0);
@test_approx_eq_eps fx f(x0) 1e-8

(fx, gx) = objgrad(nlp, x0, true);
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

println("f(x0) = ", fx)
println("∇f(x0) = ", gx)
if nlp.meta.ncon > 0
  (fx, cx) = objcons(nlp, x0)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  (cx, Jx) = cons(nlp, x0, true);
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  cx = cons(nlp, x0, false)
  @test_approx_eq_eps cx c(x0) 1e-8
  cx = cons(nlp, x0) # This is here to improve coverage
  @test_approx_eq_eps cx c(x0) 1e-8

  println("c(x0) = ", cx);
  println("J(x0) = "); println(full(Jx));
end

Hx = hess(nlp, x0);
@test_approx_eq_eps Hx H(x0) 1e-8
println("H(x0) = "); println(full(Hx));
if nlp.meta.ncon > 0
  Wx = hess(nlp, x0, ones(nlp.meta.ncon));
  @test_approx_eq_eps Wx W(x0, ones(nlp.meta.ncon)) 1e-8
  println("H(x0,ones) = "); println(full(Wx));
end
cutest_finalize(nlp);

# Return to initial directory.
cd(curdir);
