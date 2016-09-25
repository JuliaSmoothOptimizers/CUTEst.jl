function test_coreinterface(nlp::CUTEstModel, comp_nlp::AbstractNLPModel)
  x0 = nlp.meta.x0
  y0 = [(-1.0)^i for i = 1:nlp.meta.ncon]
  f(x) = obj(comp_nlp, x)
  g(x) = grad(comp_nlp, x)
  H(x; obj_weight=1.0) = tril(hess(comp_nlp, x, obj_weight=obj_weight),-1) +
                          hess(comp_nlp, x, obj_weight=obj_weight)'

  c(x) = cons(comp_nlp, x)
  J(x) = jac(comp_nlp, x)
  W(x, y; obj_weight=1.0) = tril(hess(comp_nlp, x, y=y, obj_weight=obj_weight),-1) +
                            hess(comp_nlp, x, y=y, obj_weight=obj_weight)'
  rtol = 1e-8


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

  facts("Core interface") do
    if (ncon[1] > 0)
      cfn(st, nvar, ncon, x0, fx, cx)
      @fact fx[1] --> roughly(f(x0), rtol=rtol)
      @fact cx --> roughly(c(x0), rtol=rtol)

      cofg(st, nvar, x0, fx, gx, True)
      @fact fx[1] --> roughly(f(x0), rtol=rtol)
      @fact gx --> roughly(g(x0), rtol=rtol)

      cofsg(st, nvar, x0, fx, nnzg, nvar, gval, gvar, True)
      @fact fx[1] --> roughly(f(x0), rtol=rtol)
      gx = zeros(nvar[1])
      for i = 1:nnzg[1]
        gx[gvar[i]] = gval[i]
      end
      @fact gx --> roughly(g(x0), rtol=rtol)

      ccfg(st, nvar, ncon, x0, cx, True, nvar, ncon, Jtx, True)
      @fact Jtx --> roughly(J(x0)', rtol=rtol)
      ccfg(st, nvar, ncon, x0, cx, False, ncon, nvar, Jx, True)
      @fact Jx --> roughly(J(x0), rtol=rtol)

      clfg(st, nvar, ncon, x0, y0, lx, glx, True)
      @fact lx[1] --> roughly(f(x0)+dot(y0,cx), rtol=rtol)
      @fact glx --> roughly(g(x0)+J(x0)'*y0, rtol=rtol)

      cgr(st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx)
      @fact gx --> roughly(g(x0), rtol=rtol)
      @fact Jtx --> roughly(J(x0)', rtol=rtol)
      cgr(st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx)
      @fact gx --> roughly(g(x0), rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)
      cgr(st, nvar, ncon, x0, y0, True, glx, True, nvar, ncon, Jtx)
      @fact glx --> roughly(g(x0)+J(x0)'*y0, rtol=rtol)
      @fact Jtx --> roughly(J(x0)', rtol=rtol)
      cgr(st, nvar, ncon, x0, y0, True, glx, False, ncon, nvar, Jx)
      @fact glx --> roughly(g(x0)+J(x0)'*y0, rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)

      csgr(st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun)
      glx = zeros(nvar[1])
      Jx = zeros(nvar[1], ncon[1])
      for k = 1:nnzj[1]
        if Jfun[k] == 0
          glx[Jvar[k]] = Jval[k]
        else
          Jtx[Jvar[k],Jfun[k]] = Jval[k]
        end
      end
      @fact glx --> roughly(g(x0)+J(x0)'*y0, rtol=rtol)
      @fact Jtx --> roughly(J(x0)', rtol=rtol)
      csgr(st, nvar, ncon, x0, y0, False, nnzj, lj, Jval, Jvar, Jfun)
      gx = zeros(nvar[1])
      Jx = zeros(ncon[1], nvar[1])
      for k = 1:nnzj[1]
        if Jfun[k] == 0
          gx[Jvar[k]] = Jval[k]
        else
          Jx[Jfun[k],Jvar[k]] = Jval[k]
        end
      end
      @fact gx --> roughly(g(x0), rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)

      ccfsg(st, nvar, ncon, x0, cx, nnzj, lj, Jval, Jvar, Jfun, True)
      Jx = zeros(ncon[1], nvar[1])
      for k = 1:nnzj[1]
        Jx[Jfun[k],Jvar[k]] = Jval[k]
      end
      @fact cx --> roughly(c(x0), rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)

      for j = 1:ncon[1]
        ccifg(st, nvar, Cint[j], x0, ci, gci, True)
        cx[j] = ci[1]
        Jx[j,:] = gci'
      end
      @fact cx --> roughly(c(x0), rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)

      Jx = zeros(ncon[1], nvar[1])
      for j = 1:ncon[1]
        ccifsg(st, nvar, Cint[j], x0, ci, nnzj, lj, Jval, Jvar, True)
        cx[j] = ci[1]
        for k = 1:nnzj[1]
          Jx[j,Jvar[k]] = Jval[k]
        end
      end
      @fact cx --> roughly(c(x0), rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)

      cgrdh(st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx, nvar,
            Wx)
      @fact gx --> roughly(g(x0), rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)
      @fact Wx --> roughly(W(x0,y0), rtol=rtol)
      cgrdh(st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx, nvar,
            Wx)
      @fact gx --> roughly(g(x0), rtol=rtol)
      @fact Jtx --> roughly(J(x0)', rtol=rtol)
      @fact Wx --> roughly(W(x0,y0), rtol=rtol)
      cgrdh(st, nvar, ncon, x0, y0, True, gx, False, ncon, nvar, Jx, nvar,
            Wx)
      @fact gx --> roughly(g(x0)+J(x0)'*y0, rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)
      @fact Wx --> roughly(W(x0,y0), rtol=rtol)
      cgrdh(st, nvar, ncon, x0, y0, True, gx, True, nvar, ncon, Jtx, nvar,
            Wx)
      @fact gx --> roughly(g(x0)+J(x0)'*y0, rtol=rtol)
      @fact Jtx --> roughly(J(x0)', rtol=rtol)
      @fact Wx --> roughly(W(x0,y0), rtol=rtol)

      cdh(st, nvar, ncon, x0, y0, nvar, Wx)
      @fact Wx --> roughly(W(x0,y0), rtol=rtol)

      csh(st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol)
      Wx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]; j = Hcol[k];
        Wx[i,j] = Hval[k]
        i != j && (Wx[j,i] = Hval[k])
      end
      @fact Wx --> roughly(W(x0,y0), rtol=rtol)

      cshc(st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol)
      Cx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]; j = Hcol[k];
        Cx[i,j] = Hval[k]
        i != j && (Cx[j,i] = Hval[k])
      end
      @fact Cx --> roughly((W(x0,y0)-H(x0)), rtol=rtol)

      cidh(st, nvar, x0, Cint[0], nvar, Hx)
      @fact Hx --> roughly(H(x0), rtol=rtol)
      y1 = zeros(ncon[1])
      for k = 1:ncon[1]
        cidh(st, nvar, x0, Cint[k], nvar, Cx)
        y1[k] = 1.0
        @fact Cx --> roughly((W(x0,y1)-H(x0)), rtol=rtol)
        y1[k] = 0.0
      end

      cish(st, nvar, x0, Cint[0], nnzh, lh, Hval, Hrow, Hcol)
      Hx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]; j = Hcol[k];
        Hx[i,j] = Hval[k]
        i != j && (Hx[j,i] = Hval[k])
      end
      @fact Hx --> roughly(H(x0), rtol=rtol)
      y1 = zeros(ncon[1])
      for k = 1:ncon[1]
        cish(st, nvar, x0, Cint[k], nnzh, lh, Hval, Hrow, Hcol)
        Cx = zeros(nvar[1], nvar[1])
        for k2 = 1:nnzh[1]
          i = Hrow[k2]; j = Hcol[k2];
          Cx[i,j] = Hval[k2]
          i != j && (Cx[j,i] = Hval[k2])
        end
        y1[k] = 1.0
        @fact Cx --> roughly((W(x0,y1)-H(x0)), rtol=rtol)
        y1[k] = 0.0
      end

      csgrsh(st, nvar, ncon, x0, y0, False, nnzj, lj, Jval, Jvar, Jfun, nnzh,
             lh, Hval, Hrow, Hcol)
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
      @fact gx --> roughly(g(x0), rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)
      @fact Wx --> roughly(W(x0,y0), rtol=rtol)
      csgrsh(st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun, nnzh,
             lh, Hval, Hrow, Hcol)
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
      @fact glx --> roughly(g(x0)+J(x0)'*y0, rtol=rtol)
      @fact Jx --> roughly(J(x0), rtol=rtol)
      @fact Wx --> roughly(W(x0,y0), rtol=rtol)

      v = ones(nvar[1])
      Hv = Array(Cdouble, nvar[1])
      chprod(st, nvar, ncon, False, x0, y0, v, Hv)
      @fact Hv --> roughly(W(x0,y0)*v, rtol=rtol)

      Hv = Array(Cdouble, nvar[1])
      chcprod(st, nvar, ncon, False, x0, y0, v, Hv)
      @fact Hv --> roughly((W(x0,y0)-H(x0))*v, rtol=rtol)

      v = ones(nvar[1])
      Jv = Array(Cdouble, ncon[1])
      cjprod(st, nvar, ncon, False, False, x0, v, nvar, Jv, ncon)
      @fact Jv --> roughly(J(x0)*v, rtol=rtol)
      v = ones(ncon[1])
      Jtv = Array(Cdouble, nvar[1])
      cjprod(st, nvar, ncon, False, True, x0, v, ncon, Jtv, nvar)
      @fact Jtv --> roughly(J(x0)'*v, rtol=rtol)
    else
      ufn(st, nvar, x0, fx)
      @fact fx[1] --> roughly(f(x0), rtol=rtol)

      ugr(st, nvar, x0, gx)
      @fact gx --> roughly(g(x0), rtol=rtol)

      udh(st, nvar, x0, nvar, Hx)
      @fact Hx --> roughly(H(x0), rtol=rtol)

      ush(st, nvar, x0, nnzh, lh, Hval, Hrow, Hcol)
      Hx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]; j = Hcol[k];
        Hx[i,j] = Hval[k]
        i != j && (Hx[j,i] = Hval[k])
      end
      @fact Hx --> roughly(H(x0), rtol=rtol)

      ugrdh(st, nvar, x0, gx, nvar, Hx)
      @fact gx --> roughly(g(x0), rtol=rtol)
      @fact Hx --> roughly(H(x0), rtol=rtol)

      ugrsh(st, nvar, x0, gx, nnzh, lh, Hval, Hrow, Hcol)
      @fact gx --> roughly(g(x0), rtol=rtol)
      Hx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]; j = Hcol[k];
        Hx[i,j] = Hval[k]
        i != j && (Hx[j,i] = Hval[k])
      end
      @fact Hx --> roughly(H(x0), rtol=rtol)

      v = ones(nvar[1])
      Hv = Array(Cdouble, nvar[1])
      uhprod(st, nvar, False, x0, v, Hv)
      @fact Hv --> roughly(H(x0)*v, rtol=rtol)

      uofg(st, nvar, x0, fx, gx, True)
      @fact fx[1] --> roughly(f(x0), rtol=rtol)
      @fact gx --> roughly(g(x0), rtol=rtol)
    end

    print("Core interface stress test... ")
    for i = 1:10000
      if (ncon[1] > 0)
        cfn(st, nvar, ncon, x0, fx, cx)
        cofg(st, nvar, x0, fx, gx, True)
        cofsg(st, nvar, x0, fx, nnzg, nvar, gval, gvar, True)
        ccfg(st, nvar, ncon, x0, cx, True, nvar, ncon, Jtx, True)
        ccfg(st, nvar, ncon, x0, cx, False, ncon, nvar, Jx, True)
        clfg(st, nvar, ncon, x0, y0, lx, glx, True)
        cgr(st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx)
        cgr(st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx)
        cgr(st, nvar, ncon, x0, y0, True, glx, True, nvar, ncon, Jtx)
        cgr(st, nvar, ncon, x0, y0, True, glx, False, ncon, nvar, Jx)
        csgr(st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun)
        csgr(st, nvar, ncon, x0, y0, False, nnzj, lj, Jval, Jvar, Jfun)
        ccfsg(st, nvar, ncon, x0, cx, nnzj, lj, Jval, Jvar, Jfun, True)
        for j = 1:ncon[1]
          ccifg(st, nvar, Cint[j], x0, ci, gci, True)
        end
        for j = 1:ncon[1]
          ccifsg(st, nvar, Cint[j], x0, ci, nnzj, lj, Jval, Jvar, True)
        end
        cgrdh(st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx, nvar,
              Wx)
        cgrdh(st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx, nvar,
              Wx)
        cgrdh(st, nvar, ncon, x0, y0, True, gx, False, ncon, nvar, Jx, nvar,
              Wx)
        cgrdh(st, nvar, ncon, x0, y0, True, gx, True, nvar, ncon, Jtx, nvar,
              Wx)
        cdh(st, nvar, ncon, x0, y0, nvar, Wx)
        csh(st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol)
        cshc(st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol)
        cidh(st, nvar, x0, Cint[0], nvar, Hx)
        for k = 1:ncon[1]
          cidh(st, nvar, x0, Cint[k], nvar, Cx)
        end
        cish(st, nvar, x0, Cint[0], nnzh, lh, Hval, Hrow, Hcol)
        for k = 1:ncon[1]
          cish(st, nvar, x0, Cint[k], nnzh, lh, Hval, Hrow, Hcol)
        end
        csgrsh(st, nvar, ncon, x0, y0, False, nnzj, lj, Jval, Jvar, Jfun, nnzh,
               lh, Hval, Hrow, Hcol)
        csgrsh(st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun, nnzh,
               lh, Hval, Hrow, Hcol)
        chprod(st, nvar, ncon, False, x0, y0, v, Hv)
        chcprod(st, nvar, ncon, False, x0, y0, v, Hv)
        cjprod(st, nvar, ncon, False, False, x0, v, nvar, Jv, ncon)
        cjprod(st, nvar, ncon, False, True, x0, v, ncon, Jtv, nvar)
      else
        ufn(st, nvar, x0, fx)
        ugr(st, nvar, x0, gx)
        udh(st, nvar, x0, nvar, Hx)
        ush(st, nvar, x0, nnzh, lh, Hval, Hrow, Hcol)
        ugrdh(st, nvar, x0, gx, nvar, Hx)
        ugrsh(st, nvar, x0, gx, nnzh, lh, Hval, Hrow, Hcol)
        uhprod(st, nvar, False, x0, v, Hv)
        uofg(st, nvar, x0, fx, gx, True)
      end
    end
    println("passed")
  end
end
