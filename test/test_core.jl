function test_coreinterface(
  nlp::CUTEstModel{T},
  comp_nlp::AbstractNLPModel{T};
  test_view = false,
) where {T}
  x0 = nlp.meta.x0
  y0 = [(-one(T))^i for i = 1:(nlp.meta.ncon)]
  f(x) = obj(comp_nlp, x)
  g(x) = grad(comp_nlp, x)
  H(x; obj_weight = one(T)) = hess(comp_nlp, x, obj_weight = obj_weight)

  c(x) = cons(comp_nlp, x)
  J(x) = jac(comp_nlp, x)
  W(x, y; obj_weight = one(T)) = hess(comp_nlp, x, y, obj_weight = obj_weight)

  rtol = eps(T) |> sqrt
  rtol = max(rtol, T(1e-8))

  if !test_view
    st = Cint[0]
    nvar = Cint[nlp.meta.nvar]
    ncon = Cint[nlp.meta.ncon]
    fx = [zero(T)]
    lx = [zero(T)]
    ci = [zero(T)]
    cx = Vector{T}(undef, ncon[1])
    gx = Vector{T}(undef, nvar[1])
    gci = Vector{T}(undef, nvar[1])
    glx = Vector{T}(undef, nvar[1])
    gval = Vector{T}(undef, nvar[1])
    gvar = Vector{Cint}(undef, nvar[1])
    lj = Cint[nlp.meta.nnzj + nlp.meta.nvar]
    lh = Cint[nlp.meta.nnzh]
    nnzg = Cint[0]
    nnzj = Cint[0]
    nnzh = Cint[0]
    True = Bool[true]
    False = Bool[false]
    Jx = Matrix{T}(undef, ncon[1], nvar[1])
    Jtx = Matrix{T}(undef, nvar[1], ncon[1])
    Jval = Vector{T}(undef, nlp.meta.nnzj + nlp.meta.nvar)
    Jvar = Vector{Cint}(undef, nlp.meta.nnzj + nlp.meta.nvar)
    Jfun = Vector{Cint}(undef, nlp.meta.nnzj + nlp.meta.nvar)
    Hx = Matrix{T}(undef, nvar[1], nvar[1])
    Wx = Matrix{T}(undef, nvar[1], nvar[1])
    Cx = Matrix{T}(undef, nvar[1], nvar[1])
    Hval = Vector{T}(undef, nlp.meta.nnzh)
    Hrow = Vector{Cint}(undef, nlp.meta.nnzh)
    Hcol = Vector{Cint}(undef, nlp.meta.nnzh)
  else
    st = view(Cint[0; 0], 1:1)
    nvar = view(Cint[nlp.meta.nvar], 1:1)
    ncon = view(Cint[nlp.meta.ncon], 1:1)
    fx = view([zero(T)], 1:1)
    lx = view([zero(T)], 1:1)
    ci = view([zero(T)], 1:1)
    cx = @view(Vector{T}(undef, ncon[1] + 1)[2:end])
    gx = @view(Vector{T}(undef, nvar[1] + 1)[2:end])
    gci = @view(Vector{T}(undef, nvar[1] + 1)[2:end])
    glx = @view(Vector{T}(undef, nvar[1] + 1)[2:end])
    gval = @view(Vector{T}(undef, nvar[1] + 1)[2:end])
    gvar = @view(Vector{Cint}(undef, nvar[1] + 1)[2:end])
    lj = view(Cint[nlp.meta.nnzj + nlp.meta.nvar], 1:1)
    lh = view(Cint[nlp.meta.nnzh], 1:1)
    nnzg = view(Cint[0], 1:1)
    nnzj = view(Cint[0], 1:1)
    nnzh = view(Cint[0], 1:1)
    True = view(Bool[true], 1:1)
    False = view(Bool[false], 1:1)
    Jx = Matrix{T}(undef, ncon[1], nvar[1])
    Jtx = Matrix{T}(undef, nvar[1], ncon[1])
    Jval = @view(Vector{T}(undef, nlp.meta.nnzj + nlp.meta.nvar + 1)[2:end])
    Jvar = @view(Vector{Cint}(undef, nlp.meta.nnzj + nlp.meta.nvar + 1)[2:end])
    Jfun = @view(Vector{Cint}(undef, nlp.meta.nnzj + nlp.meta.nvar + 1)[2:end])
    Hx = Matrix{T}(undef, nvar[1], nvar[1])
    Wx = Matrix{T}(undef, nvar[1], nvar[1])
    Cx = Matrix{T}(undef, nvar[1], nvar[1])
    Hval = @view(Vector{T}(undef, nlp.meta.nnzh + 1)[2:end])
    Hrow = @view(Vector{Cint}(undef, nlp.meta.nnzh + 1)[2:end])
    Hcol = @view(Vector{Cint}(undef, nlp.meta.nnzh + 1)[2:end])
  end

  @testset "Core interface" begin
    if (ncon[1] > 0)
      CUTEst.cfn(T, nlp.libsif, st, nvar, ncon, x0, fx, cx)
      @test isapprox(fx[1], f(x0), rtol = rtol)
      compare_cons(nlp, cx, comp_nlp, c(x0), rtol)

      CUTEst.cifn(T, nlp.libsif, st, nvar, Cint[0], x0, fx)
      @test isapprox(fx[1], f(x0), rtol = rtol)
      for i = 1:ncon[1]
        CUTEst.cifn(T, nlp.libsif, st, nvar, Cint[i], x0, cx)
        #@test isapprox(cx[1], c(x0)[i], rtol = rtol)
        @test isapprox(cx[1] - nlp.meta.ucon[i], c(x0)[i] - comp_nlp.meta.ucon[i], rtol = rtol)
        @test isapprox(cx[1] - nlp.meta.lcon[i], c(x0)[i] - comp_nlp.meta.lcon[i], rtol = rtol)
      end

      CUTEst.cofg(T, nlp.libsif, st, nvar, x0, fx, gx, True)
      @test isapprox(fx[1], f(x0), rtol = rtol)
      @test isapprox(gx, g(x0), rtol = rtol)

      CUTEst.cofsg(T, nlp.libsif, st, nvar, x0, fx, nnzg, nvar, gval, gvar, True)
      @test isapprox(fx[1], f(x0), rtol = rtol)
      gx = zeros(T, nvar[1])
      for i = 1:nnzg[1]
        gx[gvar[i]] = gval[i]
      end
      @test isapprox(gx, g(x0), rtol = rtol)

      CUTEst.ccfg(T, nlp.libsif, st, nvar, ncon, x0, cx, True, nvar, ncon, Jtx, True)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      CUTEst.ccfg(T, nlp.libsif, st, nvar, ncon, x0, cx, False, ncon, nvar, Jx, True)
      @test isapprox(Jx, J(x0), rtol = rtol)

      CUTEst.clfg(T, nlp.libsif, st, nvar, ncon, x0, y0, lx, glx, True)
      @test isapprox(lx[1], f(x0) + dot(y0, cx), rtol = rtol)
      @test isapprox(glx, g(x0) + J(x0)' * y0, rtol = rtol)

      CUTEst.cgr(T, nlp.libsif, st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx)
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      CUTEst.cgr(T, nlp.libsif, st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx)
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)
      CUTEst.cgr(T, nlp.libsif, st, nvar, ncon, x0, y0, True, glx, True, nvar, ncon, Jtx)
      @test isapprox(glx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      CUTEst.cgr(T, nlp.libsif, st, nvar, ncon, x0, y0, True, glx, False, ncon, nvar, Jx)
      @test isapprox(glx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      CUTEst.cigr(T, nlp.libsif, st, nvar, Cint[0], x0, gval)
      @test isapprox(gval, g(x0), rtol = rtol)
      for i = 1:ncon[1]
        CUTEst.cigr(T, nlp.libsif, st, nvar, Cint[i], x0, gval)
        @test isapprox(gval, J(x0)[i, :], rtol = rtol)
      end

      CUTEst.cisgr(T, nlp.libsif, st, nvar, Cint[0], x0, nnzg, nvar, gval, gvar)
      I = 1:nnzg[1]
      @test isapprox(gval[I], g(x0)[gvar[I]], rtol = rtol)
      for i = 1:ncon[1]
        CUTEst.cisgr(T, nlp.libsif, st, nvar, Cint[i], x0, nnzg, nvar, gval, gvar)
        @test isapprox(gval, J(x0)[i, gvar[1:nnzg[1]]], rtol = rtol)
      end

      CUTEst.csgr(T, nlp.libsif, st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun)
      glx = zeros(T, nvar[1])
      Jx = zeros(T, nvar[1], ncon[1])
      for k = 1:nnzj[1]
        if Jfun[k] == 0
          glx[Jvar[k]] = Jval[k]
        else
          Jtx[Jvar[k], Jfun[k]] = Jval[k]
        end
      end
      @test isapprox(glx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      CUTEst.csgr(T, nlp.libsif, st, nvar, ncon, x0, y0, False, nnzj, lj, Jval, Jvar, Jfun)
      gx = zeros(T, nvar[1])
      Jx = zeros(T, ncon[1], nvar[1])
      for k = 1:nnzj[1]
        if Jfun[k] == 0
          gx[Jvar[k]] = Jval[k]
        else
          Jx[Jfun[k], Jvar[k]] = Jval[k]
        end
      end
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      CUTEst.ccfsg(T, nlp.libsif, st, nvar, ncon, x0, cx, nnzj, lj, Jval, Jvar, Jfun, True)
      Jx = zeros(T, ncon[1], nvar[1])
      for k = 1:nnzj[1]
        Jx[Jfun[k], Jvar[k]] = Jval[k]
      end
      compare_cons(nlp, cx, comp_nlp, c(x0), rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      for j = 1:ncon[1]
        CUTEst.ccifg(T, nlp.libsif, st, nvar, Cint[j], x0, ci, gci, True)
        cx[j] = ci[1]
        Jx[j, :] = gci'
      end
      compare_cons(nlp, cx, comp_nlp, c(x0), rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      Jx = zeros(T, ncon[1], nvar[1])
      for j = 1:ncon[1]
        CUTEst.ccifsg(T, nlp.libsif, st, nvar, Cint[j], x0, ci, nnzj, lj, Jval, Jvar, True)
        cx[j] = ci[1]
        for k = 1:nnzj[1]
          Jx[j, Jvar[k]] = Jval[k]
        end
      end
      compare_cons(nlp, cx, comp_nlp, c(x0), rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)

      CUTEst.cgrdh(
        T,
        nlp.libsif,
        st,
        nvar,
        ncon,
        x0,
        y0,
        False,
        gx,
        False,
        ncon,
        nvar,
        Jx,
        nvar,
        Wx,
      )
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)
      CUTEst.cgrdh(
        T,
        nlp.libsif,
        st,
        nvar,
        ncon,
        x0,
        y0,
        False,
        gx,
        True,
        nvar,
        ncon,
        Jtx,
        nvar,
        Wx,
      )
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)
      CUTEst.cgrdh(T, nlp.libsif, st, nvar, ncon, x0, y0, True, gx, False, ncon, nvar, Jx, nvar, Wx)
      @test isapprox(gx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)
      CUTEst.cgrdh(T, nlp.libsif, st, nvar, ncon, x0, y0, True, gx, True, nvar, ncon, Jtx, nvar, Wx)
      @test isapprox(gx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jtx, J(x0)', rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)

      CUTEst.cdh(T, nlp.libsif, st, nvar, ncon, x0, y0, nvar, Wx)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)

      CUTEst.csh(T, nlp.libsif, st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol)
      Wx = zeros(T, nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Wx[i, j] = Hval[k]
        i != j && (Wx[j, i] = Hval[k])
      end
      @test isapprox(Wx, W(x0, y0), rtol = rtol)

      CUTEst.cshc(T, nlp.libsif, st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol)
      Cx = zeros(T, nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Cx[i, j] = Hval[k]
        i != j && (Cx[j, i] = Hval[k])
      end
      @test isapprox(Cx, (W(x0, y0) - H(x0)), rtol = rtol)

      CUTEst.cidh(T, nlp.libsif, st, nvar, x0, Cint[0], nvar, Hx)
      @test isapprox(Hx, H(x0), rtol = rtol)
      y1 = zeros(T, ncon[1])
      for k = 1:ncon[1]
        CUTEst.cidh(T, nlp.libsif, st, nvar, x0, Cint[k], nvar, Cx)
        y1[k] = one(T)
        @test isapprox(Cx, (W(x0, y1) - H(x0)), rtol = rtol)
        y1[k] = zero(T)
      end

      CUTEst.cish(T, nlp.libsif, st, nvar, x0, Cint[0], nnzh, lh, Hval, Hrow, Hcol)
      Hx = zeros(T, nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Hx[i, j] = Hval[k]
        i != j && (Hx[j, i] = Hval[k])
      end
      @test isapprox(Hx, H(x0), rtol = rtol)
      y1 = zeros(T, ncon[1])
      for k = 1:ncon[1]
        CUTEst.cish(T, nlp.libsif, st, nvar, x0, Cint[k], nnzh, lh, Hval, Hrow, Hcol)
        Cx = zeros(T, nvar[1], nvar[1])
        for k2 = 1:nnzh[1]
          i = Hrow[k2]
          j = Hcol[k2]
          Cx[i, j] = Hval[k2]
          i != j && (Cx[j, i] = Hval[k2])
        end
        y1[k] = one(T)
        @test isapprox(Cx, (W(x0, y1) - H(x0)), rtol = rtol)
        y1[k] = zero(T)
      end

      CUTEst.csgrsh(
        T,
        nlp.libsif,
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
      gx = zeros(T, nvar[1])
      Jx = zeros(T, ncon[1], nvar[1])
      for k = 1:nnzj[1]
        if Jfun[k] == 0
          gx[Jvar[k]] = Jval[k]
        else
          Jx[Jfun[k], Jvar[k]] = Jval[k]
        end
      end
      Wx = zeros(T, nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Wx[i, j] = Hval[k]
        i != j && (Wx[j, i] = Hval[k])
      end
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)
      CUTEst.csgrsh(
        T,
        nlp.libsif,
        st,
        nvar,
        ncon,
        x0,
        y0,
        True,
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
      glx = zeros(T, nvar[1])
      Jx = zeros(T, ncon[1], nvar[1])
      for k = 1:nnzj[1]
        if Jfun[k] == 0
          glx[Jvar[k]] = Jval[k]
        else
          Jx[Jfun[k], Jvar[k]] = Jval[k]
        end
      end
      Wx = zeros(T, nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Wx[i, j] = Hval[k]
        i != j && (Wx[j, i] = Hval[k])
      end
      @test isapprox(glx, g(x0) + J(x0)' * y0, rtol = rtol)
      @test isapprox(Jx, J(x0), rtol = rtol)
      @test isapprox(Wx, W(x0, y0), rtol = rtol)

      v = ones(T, nvar[1])
      Hv = Vector{T}(undef, nvar[1])
      CUTEst.chprod(T, nlp.libsif, st, nvar, ncon, False, x0, y0, v, Hv)
      @test isapprox(Hv, W(x0, y0) * v, rtol = rtol)

      Hv = Vector{T}(undef, nvar[1])
      CUTEst.chcprod(T, nlp.libsif, st, nvar, ncon, False, x0, y0, v, Hv)
      @test isapprox(Hv, (W(x0, y0) - H(x0)) * v, rtol = rtol)

      v = ones(T, nvar[1])
      Jv = Vector{T}(undef, ncon[1])
      CUTEst.cjprod(T, nlp.libsif, st, nvar, ncon, False, False, x0, v, nvar, Jv, ncon)
      @test isapprox(Jv, J(x0) * v, rtol = rtol)
      v = ones(T, ncon[1])
      Jtv = Vector{T}(undef, nvar[1])
      CUTEst.cjprod(T, nlp.libsif, st, nvar, ncon, False, True, x0, v, ncon, Jtv, nvar)
      @test isapprox(Jtv, J(x0)' * v, rtol = rtol)
    else
      CUTEst.ufn(T, nlp.libsif, st, nvar, x0, fx)
      @test isapprox(fx[1], f(x0), rtol = rtol)

      CUTEst.ugr(T, nlp.libsif, st, nvar, x0, gx)
      @test isapprox(gx, g(x0), rtol = rtol)

      CUTEst.udh(T, nlp.libsif, st, nvar, x0, nvar, Hx)
      @test isapprox(Hx, H(x0), rtol = rtol)

      CUTEst.ush(T, nlp.libsif, st, nvar, x0, nnzh, lh, Hval, Hrow, Hcol)
      Hx = zeros(T, nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Hx[i, j] = Hval[k]
        i != j && (Hx[j, i] = Hval[k])
      end
      @test isapprox(Hx, H(x0), rtol = rtol)

      CUTEst.ugrdh(T, nlp.libsif, st, nvar, x0, gx, nvar, Hx)
      @test isapprox(gx, g(x0), rtol = rtol)
      @test isapprox(Hx, H(x0), rtol = rtol)

      CUTEst.ugrsh(T, nlp.libsif, st, nvar, x0, gx, nnzh, lh, Hval, Hrow, Hcol)
      @test isapprox(gx, g(x0), rtol = rtol)
      Hx = zeros(T, nvar[1], nvar[1])
      for k = 1:nnzh[1]
        i = Hrow[k]
        j = Hcol[k]
        Hx[i, j] = Hval[k]
        i != j && (Hx[j, i] = Hval[k])
      end
      @test isapprox(Hx, H(x0), rtol = rtol)

      v = ones(T, nvar[1])
      Hv = Vector{T}(undef, nvar[1])
      CUTEst.uhprod(T, nlp.libsif, st, nvar, False, x0, v, Hv)
      @test isapprox(Hv, H(x0) * v, rtol = rtol)

      CUTEst.uofg(T, nlp.libsif, st, nvar, x0, fx, gx, True)
      @test isapprox(fx[1], f(x0), rtol = rtol)
      @test isapprox(gx, g(x0), rtol = rtol)
    end

    print("Core interface stress test... ")
    for i = 1:10000
      if (ncon[1] > 0)
        CUTEst.cfn(T, nlp.libsif, st, nvar, ncon, x0, fx, cx)
        CUTEst.cofg(T, nlp.libsif, st, nvar, x0, fx, gx, True)
        CUTEst.cofsg(T, nlp.libsif, st, nvar, x0, fx, nnzg, nvar, gval, gvar, True)
        CUTEst.ccfg(T, nlp.libsif, st, nvar, ncon, x0, cx, True, nvar, ncon, Jtx, True)
        CUTEst.ccfg(T, nlp.libsif, st, nvar, ncon, x0, cx, False, ncon, nvar, Jx, True)
        CUTEst.clfg(T, nlp.libsif, st, nvar, ncon, x0, y0, lx, glx, True)
        CUTEst.cgr(T, nlp.libsif, st, nvar, ncon, x0, y0, False, gx, True, nvar, ncon, Jtx)
        CUTEst.cgr(T, nlp.libsif, st, nvar, ncon, x0, y0, False, gx, False, ncon, nvar, Jx)
        CUTEst.cgr(T, nlp.libsif, st, nvar, ncon, x0, y0, True, glx, True, nvar, ncon, Jtx)
        CUTEst.cgr(T, nlp.libsif, st, nvar, ncon, x0, y0, True, glx, False, ncon, nvar, Jx)
        CUTEst.csgr(T, nlp.libsif, st, nvar, ncon, x0, y0, True, nnzj, lj, Jval, Jvar, Jfun)
        CUTEst.csgr(T, nlp.libsif, st, nvar, ncon, x0, y0, False, nnzj, lj, Jval, Jvar, Jfun)
        CUTEst.ccfsg(T, nlp.libsif, st, nvar, ncon, x0, cx, nnzj, lj, Jval, Jvar, Jfun, True)
        for j = 1:ncon[1]
          CUTEst.ccifg(T, nlp.libsif, st, nvar, Cint[j], x0, ci, gci, True)
        end
        for j = 1:ncon[1]
          CUTEst.ccifsg(T, nlp.libsif, st, nvar, Cint[j], x0, ci, nnzj, lj, Jval, Jvar, True)
        end
        CUTEst.cgrdh(
          T,
          nlp.libsif,
          st,
          nvar,
          ncon,
          x0,
          y0,
          False,
          gx,
          False,
          ncon,
          nvar,
          Jx,
          nvar,
          Wx,
        )
        CUTEst.cgrdh(
          T,
          nlp.libsif,
          st,
          nvar,
          ncon,
          x0,
          y0,
          False,
          gx,
          True,
          nvar,
          ncon,
          Jtx,
          nvar,
          Wx,
        )
        CUTEst.cgrdh(
          T,
          nlp.libsif,
          st,
          nvar,
          ncon,
          x0,
          y0,
          True,
          gx,
          False,
          ncon,
          nvar,
          Jx,
          nvar,
          Wx,
        )
        CUTEst.cgrdh(
          T,
          nlp.libsif,
          st,
          nvar,
          ncon,
          x0,
          y0,
          True,
          gx,
          True,
          nvar,
          ncon,
          Jtx,
          nvar,
          Wx,
        )
        CUTEst.cdh(T, nlp.libsif, st, nvar, ncon, x0, y0, nvar, Wx)
        CUTEst.csh(T, nlp.libsif, st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol)
        CUTEst.cshc(T, nlp.libsif, st, nvar, ncon, x0, y0, nnzh, lh, Hval, Hrow, Hcol)
        CUTEst.cidh(T, nlp.libsif, st, nvar, x0, Cint[0], nvar, Hx)
        for k = 1:ncon[1]
          CUTEst.cidh(T, nlp.libsif, st, nvar, x0, Cint[k], nvar, Cx)
        end
        CUTEst.cish(T, nlp.libsif, st, nvar, x0, Cint[0], nnzh, lh, Hval, Hrow, Hcol)
        for k = 1:ncon[1]
          CUTEst.cish(T, nlp.libsif, st, nvar, x0, Cint[k], nnzh, lh, Hval, Hrow, Hcol)
        end
        CUTEst.csgrsh(
          T,
          nlp.libsif,
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
        CUTEst.csgrsh(
          T,
          nlp.libsif,
          st,
          nvar,
          ncon,
          x0,
          y0,
          True,
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
        CUTEst.chprod(T, nlp.libsif, st, nvar, ncon, False, x0, y0, v, Hv)
        CUTEst.chcprod(T, nlp.libsif, st, nvar, ncon, False, x0, y0, v, Hv)
        CUTEst.cjprod(T, nlp.libsif, st, nvar, ncon, False, False, x0, v, nvar, Jv, ncon)
        CUTEst.cjprod(T, nlp.libsif, st, nvar, ncon, False, True, x0, v, ncon, Jtv, nvar)
      else
        CUTEst.ufn(T, nlp.libsif, st, nvar, x0, fx)
        CUTEst.ugr(T, nlp.libsif, st, nvar, x0, gx)
        CUTEst.udh(T, nlp.libsif, st, nvar, x0, nvar, Hx)
        CUTEst.ush(T, nlp.libsif, st, nvar, x0, nnzh, lh, Hval, Hrow, Hcol)
        CUTEst.ugrdh(T, nlp.libsif, st, nvar, x0, gx, nvar, Hx)
        CUTEst.ugrsh(T, nlp.libsif, st, nvar, x0, gx, nnzh, lh, Hval, Hrow, Hcol)
        CUTEst.uhprod(T, nlp.libsif, st, nvar, False, x0, v, Hv)
        CUTEst.uofg(T, nlp.libsif, st, nvar, x0, fx, gx, True)
      end
    end
    println("passed")
  end
end
