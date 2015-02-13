using CUTEst

cint(n) = convert(Cint, n)
# Work in a temporary directory.
curdir = pwd();
tmpdir = mktempdir();
cd(tmpdir);

problem = "HS53.SIF";
nlp = CUTEstModel(problem, raw=true);

nvar = nlp.meta.nvar
ncon = nlp.meta.ncon
x = nlp.meta.x0

(f, c) = CUTEst.jl_cfn(nvar, ncon, x)
(f, g) = CUTEst.jl_cofg(nvar, x, true)
(c, nnzj, Jval, Jvar, Jfun) = CUTEst.jl_ccfsg(nvar, ncon, x,
  nlp.meta.nnzj, true)

println("f(x0) = ", f)
println("c(x0) = ", c)
println("∇f(x0) = ", g)
println("Jval = ", Jval)
println("Jvar = ", Jvar)
println("Jfun = ", Jfun)

terminate(nlp)

cd(curdir);
