using CUTEst

# Work in a temporary directory.
curdir = pwd();
tmpdir = mktempdir();
cd(tmpdir);

problem = "HS35.SIF";
nlp = CUTEstModel(problem, raw=true);

nvar = int32(nlp.meta.nvar)
ncon = int32(nlp.meta.ncon)
x = nlp.meta.x0

(st, f, c) = CUTEst.jl_cfn(nvar, ncon, x)
(st, f, g) = CUTEst.jl_cofg(nvar, x, true)

println("f(x0) = ", f)
println("c(x0) = ", c)
println("∇f(x0) = ", g)

terminate(nlp)

cd(curdir);
