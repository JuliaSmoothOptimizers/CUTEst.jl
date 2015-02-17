println("\nTesting the julia interface\n")

if (nlp.meta.ncon > 0)
  (fx, cx) =  objcons(nlp, x0);
  @test_small(cx-c(x0))
else
  fx =  objcons(nlp, x0);
end
@test_small(fx-f(x0))
(fx, gx) =  objgrad(nlp, x0, true);
@test_small(fx-f(x0))
@test_small(gx-g(x0))
println("f(x0) = ", fx)
println("g(x0) = ", gx)
if nlp.meta.ncon > 0
  (cx, Jx) = cons(nlp, x0, true);
  @test_small(cx-c(x0))
  @test_small(Jx-J(x0))
  println("c(x0) = ", cx);
  println("J(x0) = \n", full(Jx));
end
Hx = hess(nlp, x0);
@test_small(Hx-H(x0))
println("H(x0,y0) = \n", full(Hx))
