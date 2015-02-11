using CUTEst

# Work in a temporary directory.
curdir = pwd();
tmpdir = mktempdir();
cd(tmpdir);

# problem = "ROSENBR.SIF";
problem = "BYRDSPHR.SIF";
# sifdecoder(problem);
nlp = CUTEstModel(problem);

print(nlp);
println("f(x0), c(x0) = ", objcons(nlp, nlp.meta.x0));
println("f(x0), ∇f(x0) = ", objgrad(nlp, nlp.meta.x0, true));
if nlp.meta.ncon > 0
  (c, J) = cons(nlp, nlp.meta.x0, true);
  println("c(x0) = ", c);
  @printf("J(x0) = "); display(J); @printf("\n");
end
@printf("H(x0,y0) = "); display(hess(nlp, nlp.meta.x0)); @printf("\n");

# Return to initial directory.
cd(curdir);
