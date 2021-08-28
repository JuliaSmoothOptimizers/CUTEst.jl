function test_coreinterface(nlp::CUTEstModel, comp_nlp::AbstractNLPModel; test_view = false)
  x0 = nlp.meta.x0
  y0 = [(-1.0)^i for i = 1:(nlp.meta.ncon)]
  f(x) = obj(comp_nlp, x)
  g(x) = grad(comp_nlp, x)
  H(x; obj_weight = 1.0) = hess(comp_nlp, x, obj_weight = obj_weight)

  c(x) = cons(comp_nlp, x)
  J(x) = jac(comp_nlp, x)
  W(x, y; obj_weight = 1.0) = hess(comp_nlp, x, y, obj_weight = obj_weight)
  rtol = 1e-8

  if !test_view
    st = Cint[0]
    nvar = Cint[nlp.meta.nvar]
    ncon = Cint[nlp.meta.ncon]
    fx = [0.0]
    lx = [0.0]
    ci = [0.0]
    cx = Array{Cdouble}(undef, ncon[1])
    gx = Array{Cdouble}(undef, nvar[1])
    gci = Array{Cdouble}(undef, nvar[1])
    glx = Array{Cdouble}(undef, nvar[1])
    gval = Array{Cdouble}(undef, nvar[1])
    gvar = Array{Cint}(undef, nvar[1])
    lj = Cint[nlp.meta.nnzj + nlp.meta.nvar]
    lh = Cint[nlp.meta.nnzh]
    nnzg = Cint[0]
    nnzj = Cint[0]
    nnzh = Cint[0]
    True = Cint[true]
    False = Cint[false]
    Jx = Array{Cdouble}(undef, ncon[1], nvar[1])
    Jtx = Array{Cdouble}(undef, nvar[1], ncon[1])
    Jval = Array{Cdouble}(undef, nlp.meta.nnzj + nlp.meta.nvar)
    Jvar = Array{Cint}(undef, nlp.meta.nnzj + nlp.meta.nvar)
    Jfun = Array{Cint}(undef, nlp.meta.nnzj + nlp.meta.nvar)
    Hx = Array{Cdouble}(undef, nvar[1], nvar[1])
    Wx = Array{Cdouble}(undef, nvar[1], nvar[1])
    Cx = Array{Cdouble}(undef, nvar[1], nvar[1])
    Hval = Array{Cdouble}(undef, nlp.meta.nnzh)
    Hrow = Array{Cint}(undef, nlp.meta.nnzh)
    Hcol = Array{Cint}(undef, nlp.meta.nnzh)
  else
    st = view(Cint[0;0],1:1)
    nvar = view(Cint[nlp.meta.nvar],1:1)
    ncon = view(Cint[nlp.meta.ncon],1:1)
    fx = view([0.0],1:1)
    lx = view([0.0],1:1)
    ci = view([0.0],1:1)
    cx = @view(Array{Cdouble}(undef, ncon[1]+1)[2:end])
    gx = @view(Array{Cdouble}(undef, nvar[1]+1)[2:end])
    gci = @view(Array{Cdouble}(undef, nvar[1]+1)[2:end])
    glx = @view(Array{Cdouble}(undef, nvar[1]+1)[2:end])
    gval = @view(Array{Cdouble}(undef, nvar[1]+1)[2:end])
    gvar = @view(Array{Cint}(undef, nvar[1]+1)[2:end])
    lj = view(Cint[nlp.meta.nnzj + nlp.meta.nvar],1:1)
    lh = view(Cint[nlp.meta.nnzh],1:1)
    nnzg = view(Cint[0],1:1)
    nnzj = view(Cint[0],1:1)
    nnzh = view(Cint[0],1:1)
    True = view(Cint[true],1:1)
    False = view(Cint[false],1:1)
    Jx = Array{Cdouble}(undef, ncon[1], nvar[1])
    Jtx = Array{Cdouble}(undef, nvar[1], ncon[1])
    Jval = @view(Array{Cdouble}(undef, nlp.meta.nnzj + nlp.meta.nvar+1)[2:end])
    Jvar = @view(Array{Cint}(undef, nlp.meta.nnzj + nlp.meta.nvar+1)[2:end])
    Jfun = @view(Array{Cint}(undef, nlp.meta.nnzj + nlp.meta.nvar+1)[2:end])
    Hx = Array{Cdouble}(undef, nvar[1], nvar[1])
    Wx = Array{Cdouble}(undef, nvar[1], nvar[1])
    Cx = Array{Cdouble}(undef, nvar[1], nvar[1])
    Hval = @view(Array{Cdouble}(undef, nlp.meta.nnzh+1)[2:end])
    Hrow = @view(Array{Cint}(undef, nlp.meta.nnzh+1)[2:end])
    Hcol = @view(Array{Cint}(undef, nlp.meta.nnzh+1)[2:end])    
  end

  @testset "Core interface" begin
    if (ncon[1] > 0)
      cfn(st, nvar, ncon, x0, fx, cx)
      @test isapprox(fx[1], f(x0), rtol = rtol)
      @test isapprox(cx, c(x0), rtol = rtol)

      cifn(st, nvar, Cint[0], x0, fx)
      @test isapprox(fx[1], f(x0), rtol = rtol)
      for i = 1:ncon[1]
        cifn(st, nvar, Cint[i], x0, cx)
        @test isapprox(cx[1], c(x0)[i], rtol = rtol)
      end

      cofg(st, nvar, x0, fx, gx, True)
      @test isapprox(fx[1], f(x0), rtol = rtol)
      @test isapprox(gx, g(x0), rtol = rtol)

      cofsg(st, nvar, x0, fx, nnzg, nvar, gval, gvar, True)
      @test isapprox(fx[1], f(x0), rtol = rtol)
      gx = zeros(nvar[1])
      for i = 1:nnzg[1]
        gx[gvar[i]] = gval[i]
      end
      @test isapprox(gx, g(x0), rtol = rtol)

      ccfg(st, nvar, ncon, x0, cx, True, nvar, ncon, Jtx, True)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      ccfg(st, nvar, ncon, x0, cx, False, ncon, nvar, Jx, True)
      @test isapprox(Jx, J(x0), rtol = rtol)

      clfg(st, nvar, ncon, x0, y0, lx, glx, True)
      @test isapprox(lx[1], f(x0) + dot(y0, cx), rtol = rtol)
      @test isapprox(glx, g(x0) + J(x0)' * y0, rtol = rtol)

      cgr(st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx)
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      cgr(st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx)
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)
      cgr(st, nvar, ncon, x0, y0, True, glx, True, nvar, ncon, Jtx)
      @test isapprox(glx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      cgr(st, nvar, ncon, x0, y0, True, glx, False, ncon, nvar, Jx)
      @test isapprox(glx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      cigr(st, nvar, Cint[0], x0, gval)
      @test isapprox(gval, g(x0), rtol = rtol)
      for i = 1:ncon[1]
        cigr(st, nvar, Cint[i], x0, gval)
        @test isapprox(gval, J(x0)[i, :], rtol = rtol)
      end

      cisgr(st, nvar, Cint[0], x0, nnzg, nvar, gval, gvar)
      I = 1:nnzg[1]
      @test isapprox(gval[I], g(x0)[gvar[I]], rtol = rtol)
      for i = 1:ncon[1]
        cisgr(st, nvar, Cint[i], x0, nnzg, nvar, gval, gvar)
        @test isapprox(gval, J(x0)[i, gvar[1:nnzg[1]]], rtol = rtol)
      end

      csgr(st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun)
      glx = zeros(nvar[1])
      Jx = zeros(nvar[1], ncon[1])
      for k = 1:nnzj[1]
        if Jfun[k] == 0
          glx[Jvar[k]] = Jval[k]
        else
          Jtx[Jvar[k], Jfun[k]] = Jval[k]
        end
      end
      @test isapprox(glx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      csgr(st, nvar, ncon, x0, y0, False, nnzj, lj, Jval, Jvar, Jfun)
      gx = zeros(nvar[1])
      Jx = zeros(ncon[1], nvar[1])
      for k = 1:nnzj[1]
        if Jfun[k] == 0
          gx[Jvar[k]] = Jval[k]
        else
          Jx[Jfun[k], Jvar[k]] = Jval[k]
        end
      end
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      ccfsg(st, nvar, ncon, x0, cx, nnzj, lj, Jval, Jvar, Jfun, True)
      Jx = zeros(ncon[1], nvar[1])
      for k = 1:nnzj[1]
        Jx[Jfun[k], Jvar[k]] = Jval[k]
      end
      @test isapprox(cx, c(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      for j = 1:ncon[1]
        ccifg(st, nvar, Cint[j], x0, ci, gci, True)
        cx[j] = ci[1]
        Jx[j, :] = gci'
      end
      @test isapprox(cx, c(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      Jx = zeros(ncon[1], nvar[1])
      for j = 1:ncon[1]
        ccifsg(st, nvar, Cint[j], x0, ci, nnzj, lj, Jval, Jvar, True)
        cx[j] = ci[1]
        for k = 1:nnzj[1]
          Jx[j, Jvar[k]] = Jval[k]
        end
      end
      @test isapprox(cx, c(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      cgrdh(st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx, nvar, Wx)
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)
      cgrdh(st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx, nvar, Wx)
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)
      cgrdh(st, nvar, ncon, x0, y0, True, gx, False, ncon, nvar, Jx, nvar, Wx)
      @test isapprox(gx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)
      cgrdh(st, nvar, ncon, x0, y0, True, gx, True, nvar, ncon, Jtx, nvar, Wx)
      @test isapprox(gx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)

      cdh(st, nvar, ncon, x0, y0, nvar, Wx)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)

      csh(st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol)
      Wx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Wx[i, j] = Hval[k]
        i != j && (Wx[j, i] = Hval[k])
      end
      @test isapprox(Wx, W(x0, y0), rtol = rtol)

      cshc(st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol)
      Cx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Cx[i, j] = Hval[k]
        i != j && (Cx[j, i] = Hval[k])
      end
      @test isapprox(Cx, (W(x0, y0) - H(x0)), rtol = rtol)

      cidh(st, nvar, x0, Cint[0], nvar, Hx)
      @test isapprox(Hx, H(x0), rtol = rtol)
      y1 = zeros(ncon[1])
      for k = 1:ncon[1]
        cidh(st, nvar, x0, Cint[k], nvar, Cx)
        y1[k] = 1.0
        @test isapprox(Cx, (W(x0, y1) - H(x0)), rtol = rtol)
        y1[k] = 0.0
      end

      cish(st, nvar, x0, Cint[0], nnzh, lh, Hval, Hrow, Hcol)
      Hx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Hx[i, j] = Hval[k]
        i != j && (Hx[j, i] = Hval[k])
      end
      @test isapprox(Hx, H(x0), rtol = rtol)
      y1 = zeros(ncon[1])
      for k = 1:ncon[1]
        cish(st, nvar, x0, Cint[k], nnzh, lh, Hval, Hrow, Hcol)
        Cx = zeros(nvar[1], nvar[1])
        for k2 = 1:nnzh[1]
          i = Hrow[k2]
          j = Hcol[k2]
          Cx[i, j] = Hval[k2]
          i != j && (Cx[j, i] = Hval[k2])
        end
        y1[k] = 1.0
        @test isapprox(Cx, (W(x0, y1) - H(x0)), rtol = rtol)
        y1[k] = 0.0
      end

      csgrsh(st, nvar, ncon, x0, y0, False, nnzj, lj, Jval, Jvar, Jfun, nnzh, lh, Hval, Hrow, Hcol)
      gx = zeros(nvar[1])
      Jx = zeros(ncon[1], nvar[1])
      for k = 1:nnzj[1]
        if Jfun[k] == 0
          gx[Jvar[k]] = Jval[k]
        else
          Jx[Jfun[k], Jvar[k]] = Jval[k]
        end
      end
      Wx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Wx[i, j] = Hval[k]
        i != j && (Wx[j, i] = Hval[k])
      end
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)
      csgrsh(st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun, nnzh, lh, Hval, Hrow, Hcol)
      glx = zeros(nvar[1])
      Jx = zeros(ncon[1], nvar[1])
      for k = 1:nnzj[1]
        if Jfun[k] == 0
          glx[Jvar[k]] = Jval[k]
        else
          Jx[Jfun[k], Jvar[k]] = Jval[k]
        end
      end
      Wx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Wx[i, j] = Hval[k]
        i != j && (Wx[j, i] = Hval[k])
      end
      @test isapprox(glx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)

      v = ones(nvar[1])
      Hv = Array{Cdouble}(undef, nvar[1])
      chprod(st, nvar, ncon, False, x0, y0, v, Hv)
      @test isapprox(Hv, W(x0, y0) * v, rtol = rtol)

      Hv = Array{Cdouble}(undef, nvar[1])
      chcprod(st, nvar, ncon, False, x0, y0, v, Hv)
      @test isapprox(Hv, (W(x0, y0) - H(x0)) * v, rtol = rtol)

      v = ones(nvar[1])
      Jv = Array{Cdouble}(undef, ncon[1])
      cjprod(st, nvar, ncon, False, False, x0, v, nvar, Jv, ncon)
      @test isapprox(Jv, J(x0) * v, rtol = rtol)
      v = ones(ncon[1])
      Jtv = Array{Cdouble}(undef, nvar[1])
      cjprod(st, nvar, ncon, False, True, x0, v, ncon, Jtv, nvar)
      @test isapprox(Jtv, J(x0)' * v, rtol = rtol)
    else
      ufn(st, nvar, x0, fx)
      @test isapprox(fx[1], f(x0), rtol = rtol)

      ugr(st, nvar, x0, gx)
      @test isapprox(gx, g(x0), rtol = rtol)

      udh(st, nvar, x0, nvar, Hx)
      @test isapprox(Hx, H(x0), rtol = rtol)

      ush(st, nvar, x0, nnzh, lh, Hval, Hrow, Hcol)
      Hx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Hx[i, j] = Hval[k]
        i != j && (Hx[j, i] = Hval[k])
      end
      @test isapprox(Hx, H(x0), rtol = rtol)

      ugrdh(st, nvar, x0, gx, nvar, Hx)
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Hx, H(x0), rtol = rtol)

      ugrsh(st, nvar, x0, gx, nnzh, lh, Hval, Hrow, Hcol)
      @test isapprox(gx, g(x0), rtol = rtol)
      Hx = zeros(nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Hx[i, j] = Hval[k]
        i != j && (Hx[j, i] = Hval[k])
      end
      @test isapprox(Hx, H(x0), rtol = rtol)

      v = ones(nvar[1])
      Hv = Array{Cdouble}(undef, nvar[1])
      uhprod(st, nvar, False, x0, v, Hv)
      @test isapprox(Hv, H(x0) * v, rtol = rtol)

      uofg(st, nvar, x0, fx, gx, True)
      @test isapprox(fx[1], f(x0), rtol = rtol)
      @test isapprox(gx, g(x0), rtol = rtol)
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
        cgrdh(st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx, nvar, Wx)
        cgrdh(st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx, nvar, Wx)
        cgrdh(st, nvar, ncon, x0, y0, True, gx, False, ncon, nvar, Jx, nvar, Wx)
        cgrdh(st, nvar, ncon, x0, y0, True, gx, True, nvar, ncon, Jtx, nvar, Wx)
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
        csgrsh(
          st,
          nvar,
          ncon,
          x0,
          y0,
          False,
          nnzj,
          lj,
          Jval,
          Jvar,
          Jfun,
          nnzh,
          lh,
          Hval,
          Hrow,
          Hcol,
        )
        csgrsh(st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun, nnzh, lh, Hval, Hrow, Hcol)
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
