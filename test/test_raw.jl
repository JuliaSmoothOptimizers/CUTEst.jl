println("\nTesting the raw interface\n")
st = [cint(0)]
nvar = [cint(nlp.meta.nvar)]
ncon = [cint(nlp.meta.ncon)]
fx = [0.0]
cx = zeros(ncon[1])
gx = Array(Cdouble, nvar[1])
grad = [cint(true)]

CUTEst.cfn(st, nvar, ncon, x0, fx, cx, nlp.libname)
@test_small(fx-f(x0))
@test_small(cx-c(x0))
CUTEst.cofg(st, nvar, x0, fx, gx, grad, nlp.libname)
@test_small(fx-f(x0))
@test_small(gx-g(x0))
println("f(x0) = ", fx[1])
println("c(x0) = ", cx)
println("∇f(x0) = ", gx)
