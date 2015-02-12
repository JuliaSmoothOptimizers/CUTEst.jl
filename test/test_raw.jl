using CUTEst

# Work in a temporary directory.
curdir = pwd();
tmpdir = mktempdir();
cd(tmpdir);

problem = "HS35.SIF";
nlp = CUTEstModel(problem, raw=true);

st = [int32(0)]
nvar = [int32(nlp.meta.nvar)]
ncon = [int32(nlp.meta.ncon)]
x = nlp.meta.x0
f = [0.0]
c = zeros(ncon[1])
g = Array(Float64, nvar[1])
grad = [int32(true)]

CUTEst.cfn(st, nvar, ncon, x, f, c)
CUTEst.cofg(st, nvar, x, f, g, grad)
println("f(x0) = ", f[1])
println("c(x0) = ", c)
println("∇f(x0) = ", g)

terminate(nlp)

cd(curdir);
