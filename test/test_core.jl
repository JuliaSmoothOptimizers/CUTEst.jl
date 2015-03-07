println("\nTesting the core interface\n")
st = Cint[0]
nvar = Cint[nlp.meta.nvar]
ncon = Cint[nlp.meta.ncon]
fx = [0.0]
lx = [0.0]
cx = Array(Cdouble, ncon[1])
gx = Array(Cdouble, nvar[1])
glx = Array(Cdouble, nvar[1])
gval = Array(Cdouble, nvar[1])
gvar = Array(Cint, nvar[1])
nnzg = Cint[0]
grad = Cint[true]
Jx = Array(Cdouble, ncon[1],nvar[1])
Jtx = Array(Cdouble, nvar[1],ncon[1])

if (ncon[1] > 0)
  CUTEst.cfn(st, nvar, ncon, x0, fx, cx, nlp.libname)
  @test_approx_eq_eps fx[1] f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  CUTEst.cofg(st, nvar, x0, fx, gx, grad, nlp.libname)
  @test_approx_eq_eps fx[1] f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  CUTEst.cofsg(st, nvar, x0, fx, nnzg, nvar, gval, gvar, grad, nlp.libname)
  @test_approx_eq_eps fx[1] f(x0) 1e-8
  gx = zeros(nvar[1])
  for i = 1:nnzg[1]
    gx[gvar[i]] = gval[i]
  end
  @test_approx_eq_eps gx g(x0) 1e-8

  CUTEst.ccfg(st, nvar, ncon, x0, cx, Cint[true], nvar, ncon, Jtx, grad, nlp.libname)
  @test_approx_eq_eps Jtx J(x0)' 1e-8
  CUTEst.ccfg(st, nvar, ncon, x0, cx, Cint[false], ncon, nvar, Jx, grad, nlp.libname)
  @test_approx_eq_eps Jx J(x0) 1e-8

  CUTEst.clfg(st, nvar, ncon, x0, y0, lx, glx, grad, nlp.libname)
  @test_approx_eq_eps lx f(x0)+dot(y0,cx) 1e-8
  @test_approx_eq_eps glx g(x0)+J(x0)'*y0 1e-8
else
  CUTEst.ufn(st, nvar, x0, fx, nlp.libname)
  @test_approx_eq_eps fx[1] f(x0) 1e-8

  CUTEst.uofg(st, nvar, x0, fx, gx, grad, nlp.libname)
  @test_approx_eq_eps fx[1] f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8
end

println("f(x0) = ", fx[1])
println("∇f(x0) = ", gx)
if (ncon[1] > 0)
  println("c(x0) = ", cx)
  println("J(x0) = "); println(Jx)
end
