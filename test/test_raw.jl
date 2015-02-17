println("\nTesting the raw interface\n")
st = [cint(0)]
nvar = [cint(nlp.meta.nvar)]
ncon = [cint(nlp.meta.ncon)]
fx = [0.0]
cx = zeros(ncon[1])
gx = Array(Cdouble, nvar[1])
grad = [cint(true)]

if (ncon[1] > 0)
  CUTEst.cfn(st, nvar, ncon, x0, fx, cx, nlp.libname)
  @test_small(cx-c(x0))
else
  CUTEst.ufn(st, nvar, x0, fx, nlp.libname)
end
println(fx)
@test_small(fx-f(x0))
if (ncon[1] > 0)
  CUTEst.cofg(st, nvar, x0, fx, gx, grad, nlp.libname)
else
  CUTEst.uofg(st, nvar, x0, fx, gx, grad, nlp.libname)
end
@test_small(fx-f(x0))
@test_small(gx-g(x0))

println("f(x0) = ", fx[1])
println("∇f(x0) = ", gx)
if (ncon[1] > 0)
  println("c(x0) = ", cx)
end
