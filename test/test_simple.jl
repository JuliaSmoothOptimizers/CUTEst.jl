println("\nTesting the julia interface\n")

println("f(x0), c(x0) = ", objcons(nlp, nlp.meta.x0));
println("f(x0), ∇f(x0) = ", objgrad(nlp, nlp.meta.x0, true));
if nlp.meta.ncon > 0
  (c, J) = cons(nlp, nlp.meta.x0, true);
  println("c(x0) = ", c);
  println("J(x0) = \n", full(J));
end
println("H(x0,y0) = \n", full(hess(nlp, nlp.meta.x0)));
