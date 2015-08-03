println("\nTesting the core interface\n")
st = Cint[0]
nvar = Cint[nlp.meta.nvar]
ncon = Cint[nlp.meta.ncon]
fx = [0.0]
lx = [0.0]
ci = [0.0]
cx = Array(Cdouble, ncon[1])
gx = Array(Cdouble, nvar[1])
gci = Array(Cdouble, nvar[1])
glx = Array(Cdouble, nvar[1])
gval = Array(Cdouble, nvar[1])
gvar = Array(Cint, nvar[1])
lj = Cint[nlp.meta.nnzj+nlp.meta.nvar]
lh = Cint[nlp.meta.nnzh]
nnzg = Cint[0]
nnzj = Cint[0]
nnzh = Cint[0]
True = Cint[true]
False = Cint[false]
Jx = Array(Cdouble, ncon[1],nvar[1])
Jtx = Array(Cdouble, nvar[1],ncon[1])
Jval = Array(Cdouble, nlp.meta.nnzj+nlp.meta.nvar)
Jvar = Array(Cint, nlp.meta.nnzj+nlp.meta.nvar)
Jfun = Array(Cint, nlp.meta.nnzj+nlp.meta.nvar)
Hx = Array(Cdouble, nvar[1], nvar[1])
Wx = Array(Cdouble, nvar[1], nvar[1])
Cx = Array(Cdouble, nvar[1], nvar[1])
Hval = Array(Cdouble, nlp.meta.nnzh)
Hrow = Array(Cint, nlp.meta.nnzh)
Hcol = Array(Cint, nlp.meta.nnzh)

if (ncon[1] > 0)
  cfn(st, nvar, ncon, x0, fx, cx, nlp.libname)
  @test_approx_eq_eps fx[1] f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  cofg(st, nvar, x0, fx, gx, True, nlp.libname)
  @test_approx_eq_eps fx[1] f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  cofsg(st, nvar, x0, fx, nnzg, nvar, gval, gvar, True, nlp.libname)
  @test_approx_eq_eps fx[1] f(x0) 1e-8
  gx = zeros(nvar[1])
  for i = 1:nnzg[1]
    gx[gvar[i]] = gval[i]
  end
  @test_approx_eq_eps gx g(x0) 1e-8

  ccfg(st, nvar, ncon, x0, cx, True, nvar, ncon, Jtx, True, nlp.libname)
  @test_approx_eq_eps Jtx J(x0)' 1e-8
  ccfg(st, nvar, ncon, x0, cx, False, ncon, nvar, Jx, True, nlp.libname)
  @test_approx_eq_eps Jx J(x0) 1e-8

  clfg(st, nvar, ncon, x0, y0, lx, glx, True, nlp.libname)
  @test_approx_eq_eps lx[1] f(x0)+dot(y0,cx) 1e-8
  @test_approx_eq_eps glx g(x0)+J(x0)'*y0 1e-8

  cgr(st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx,
      nlp.libname)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jtx J(x0)' 1e-8
  cgr(st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx,
      nlp.libname)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  cgr(st, nvar, ncon, x0, y0, True, glx, True, nvar, ncon, Jtx,
      nlp.libname)
  @test_approx_eq_eps glx g(x0)+J(x0)'*y0 1e-8
  @test_approx_eq_eps Jtx J(x0)' 1e-8
  cgr(st, nvar, ncon, x0, y0, True, glx, False, ncon, nvar, Jx,
      nlp.libname)
  @test_approx_eq_eps glx g(x0)+J(x0)'*y0 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  csgr(st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun,
      nlp.libname)
  glx = zeros(nvar[1])
  Jx = zeros(nvar[1], ncon[1])
  for k = 1:nnzj[1]
    if Jfun[k] == 0
      glx[Jvar[k]] = Jval[k]
    else
      Jtx[Jvar[k],Jfun[k]] = Jval[k]
    end
  end
  @test_approx_eq_eps glx g(x0)+J(x0)'*y0 1e-8
  @test_approx_eq_eps Jtx J(x0)' 1e-8
  csgr(st, nvar, ncon, x0, y0, False, nnzj, lj, Jval, Jvar, Jfun,
      nlp.libname)
  gx = zeros(nvar[1])
  Jx = zeros(ncon[1], nvar[1])
  for k = 1:nnzj[1]
    if Jfun[k] == 0
      gx[Jvar[k]] = Jval[k]
    else
      Jx[Jfun[k],Jvar[k]] = Jval[k]
    end
  end
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  ccfsg(st, nvar, ncon, x0, cx, nnzj, lj, Jval, Jvar, Jfun, True,
      nlp.libname)
  Jx = zeros(ncon[1], nvar[1])
  for k = 1:nnzj[1]
    Jx[Jfun[k],Jvar[k]] = Jval[k]
  end
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  for j = 1:ncon[1]
    ccifg(st, nvar, Cint[j], x0, ci, gci, True, nlp.libname)
    cx[j] = ci[1]
    Jx[j,:] = gci'
  end
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = zeros(ncon[1], nvar[1])
  for j = 1:ncon[1]
    ccifsg(st, nvar, Cint[j], x0, ci, nnzj, lj, Jval, Jvar, True,
        nlp.libname)
    cx[j] = ci[1]
    for k = 1:nnzj[1]
      Jx[j,Jvar[k]] = Jval[k]
    end
  end
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  cgrdh(st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx, nvar,
      Wx, nlp.libname)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8
  cgrdh(st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx, nvar,
      Wx, nlp.libname)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jtx J(x0)' 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8
  cgrdh(st, nvar, ncon, x0, y0, True, gx, False, ncon, nvar, Jx, nvar,
      Wx, nlp.libname)
  @test_approx_eq_eps gx g(x0)+J(x0)'*y0 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8
  cgrdh(st, nvar, ncon, x0, y0, True, gx, True, nvar, ncon, Jtx, nvar,
      Wx, nlp.libname)
  @test_approx_eq_eps gx g(x0)+J(x0)'*y0 1e-8
  @test_approx_eq_eps Jtx J(x0)' 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  cdh(st, nvar, ncon, x0, y0, nvar, Wx, nlp.libname)
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  csh(st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol, nlp.libname)
  Wx = zeros(nvar[1], nvar[1])
  for k = 1:nnzh[1]
    i = Hrow[k]; j = Hcol[k];
    Wx[i,j] = Hval[k]
    i != j && (Wx[j,i] = Hval[k])
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  cshc(st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol, nlp.libname)
  Cx = zeros(nvar[1], nvar[1])
  for k = 1:nnzh[1]
    i = Hrow[k]; j = Hcol[k];
    Cx[i,j] = Hval[k]
    i != j && (Cx[j,i] = Hval[k])
  end
  @test_approx_eq_eps Cx (W(x0,y0)-H(x0)) 1e-8

  cidh(st, nvar, x0, Cint[0], nvar, Hx, nlp.libname)
  @test_approx_eq_eps Hx H(x0) 1e-8
  y1 = zeros(ncon[1])
  for k = 1:ncon[1]
    cidh(st, nvar, x0, Cint[k], nvar, Cx, nlp.libname)
    y1[k] = 1.0
    @test_approx_eq_eps Cx (W(x0,y1)-H(x0)) 1e-8
    y1[k] = 0.0
  end

  cish(st, nvar, x0, Cint[0], nnzh, lh, Hval, Hrow, Hcol, nlp.libname)
  Hx = zeros(nvar[1], nvar[1])
  for k = 1:nnzh[1]
    i = Hrow[k]; j = Hcol[k];
    Hx[i,j] = Hval[k]
    i != j && (Hx[j,i] = Hval[k])
  end
  @test_approx_eq_eps Hx H(x0) 1e-8
  y1 = zeros(ncon[1])
  for k = 1:ncon[1]
    cish(st, nvar, x0, Cint[k], nnzh, lh, Hval, Hrow, Hcol, nlp.libname)
    Cx = zeros(nvar[1], nvar[1])
    for k2 = 1:nnzh[1]
      i = Hrow[k2]; j = Hcol[k2];
      Cx[i,j] = Hval[k2]
      i != j && (Cx[j,i] = Hval[k2])
    end
    y1[k] = 1.0
    @test_approx_eq_eps Cx (W(x0,y1)-H(x0)) 1e-8
    y1[k] = 0.0
  end

  csgrsh(st, nvar, ncon, x0, y0, False, nnzj, lj, Jval, Jvar, Jfun, nnzh,
      lh, Hval, Hrow, Hcol, nlp.libname)
  gx = zeros(nvar[1])
  Jx = zeros(ncon[1], nvar[1])
  for k = 1:nnzj[1]
    if Jfun[k] == 0
      gx[Jvar[k]] = Jval[k]
    else
      Jx[Jfun[k],Jvar[k]] = Jval[k]
    end
  end
  Wx = zeros(nvar[1], nvar[1])
  for k = 1:nnzh[1]
    i = Hrow[k]; j = Hcol[k];
    Wx[i,j] = Hval[k]
    i != j && (Wx[j,i] = Hval[k])
  end
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8
  csgrsh(st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun, nnzh,
      lh, Hval, Hrow, Hcol, nlp.libname)
  glx = zeros(nvar[1])
  Jx = zeros(ncon[1], nvar[1])
  for k = 1:nnzj[1]
    if Jfun[k] == 0
      glx[Jvar[k]] = Jval[k]
    else
      Jx[Jfun[k],Jvar[k]] = Jval[k]
    end
  end
  Wx = zeros(nvar[1], nvar[1])
  for k = 1:nnzh[1]
    i = Hrow[k]; j = Hcol[k];
    Wx[i,j] = Hval[k]
    i != j && (Wx[j,i] = Hval[k])
  end
  @test_approx_eq_eps glx g(x0)+J(x0)'*y0 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  v = ones(nvar[1])
  Hv = Array(Cdouble, nvar[1])
  chprod(st, nvar, ncon, False, x0, y0, v, Hv, nlp.libname)
  @test_approx_eq_eps Hv W(x0,y0)*v 1e-8

  Hv = Array(Cdouble, nvar[1])
  chcprod(st, nvar, ncon, False, x0, y0, v, Hv, nlp.libname)
  @test_approx_eq_eps Hv (W(x0,y0)-H(x0))*v 1e-8

  v = ones(nvar[1])
  Jv = Array(Cdouble, ncon[1])
  cjprod(st, nvar, ncon, False, False, x0, v, nvar, Jv, ncon,
      nlp.libname)
  @test_approx_eq_eps Jv J(x0)*v 1e-8
  v = ones(ncon[1])
  Jtv = Array(Cdouble, nvar[1])
  cjprod(st, nvar, ncon, False, True, x0, v, ncon, Jtv, nvar,
      nlp.libname)
  @test_approx_eq_eps Jtv J(x0)'*v 1e-8
else
  ufn(st, nvar, x0, fx, nlp.libname)
  @test_approx_eq_eps fx[1] f(x0) 1e-8

  uofg(st, nvar, x0, fx, gx, grad, nlp.libname)
  @test_approx_eq_eps fx[1] f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8
end

println("f(x0) = ", fx[1])
println("∇f(x0) = ", gx)
if (ncon[1] > 0)
  println("c(x0) = ", cx)
  println("J(x0) = "); println(Jx)
end
println("H(x0) = "); println(Hx)
println("H(x0,y0) = "); println(Wx)
