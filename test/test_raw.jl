println("\nTesting the raw interface\n")
st = [cint(0)]
nvar = [cint(nlp.meta.nvar)]
ncon = [cint(nlp.meta.ncon)]
x = nlp.meta.x0
f = [0.0]
c = zeros(ncon[1])
g = Array(Cdouble, nvar[1])
grad = [cint(true)]

CUTEst.cfn(st, nvar, ncon, x, f, c, nlp.libname)
CUTEst.cofg(st, nvar, x, f, g, grad, nlp.libname)
println("f(x0) = ", f[1])
println("c(x0) = ", c)
println("∇f(x0) = ", g)
