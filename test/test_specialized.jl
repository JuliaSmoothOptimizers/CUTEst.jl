function test_specinterface(nlp::CUTEstModel, comp_nlp::AbstractNLPModel)
  x0 = nlp.meta.x0
  y0 = π*[(-1.0)^i for i = 1:nlp.meta.ncon]
  f(x) = obj(comp_nlp, x)
  g(x) = grad(comp_nlp, x)
  H(x; obj_weight=1.0) = tril(hess(comp_nlp, x, obj_weight=obj_weight),-1) + hess(comp_nlp, x, obj_weight=obj_weight)'

  c(x) = cons(comp_nlp, x)
  J(x) = jac(comp_nlp, x)
  W(x, y; obj_weight=1.0) = tril(hess(comp_nlp, x, y=y, obj_weight=obj_weight),-1) + hess(comp_nlp, x, y=y, obj_weight=obj_weight)'
  rtol = 1e-8

  v = ones(nlp.meta.nvar)
  @testset "Specialized interface" begin
    if nlp.meta.ncon > 0
      fx, cx = cfn(nlp.meta.nvar, nlp.meta.ncon, x0)
      @test isapprox(fx, f(x0), rtol=rtol)
      @test isapprox(cx, c(x0), rtol=rtol)

      fx = cifn(nlp.meta.nvar, 0, x0)
      @test isapprox(fx, f(x0), rtol=rtol)
      cx = c(x0)
      for i = 1:nlp.meta.ncon
        cxi = cifn(nlp.meta.nvar, i, x0)
        @test isapprox(cxi, cx[i], rtol=rtol)
      end

      cx = zeros(nlp.meta.ncon)
      fx = cfn!(nlp.meta.nvar, nlp.meta.ncon, x0, cx)
      @test isapprox(fx, f(x0), rtol=rtol)
      @test isapprox(cx, c(x0), rtol=rtol)

      fx, gx = cofg(nlp.meta.nvar, x0, true)
      @test isapprox(fx, f(x0), rtol=rtol)
      @test isapprox(gx, g(x0), rtol=rtol)

      gx = zeros(nlp.meta.nvar)
      fx = cofg!(nlp.meta.nvar, x0, gx, true)
      @test isapprox(fx, f(x0), rtol=rtol)
      @test isapprox(gx, g(x0), rtol=rtol)

      fx, nnzg, g_val, g_var = cofsg(nlp.meta.nvar, x0, nlp.meta.nvar, true)
      @test isapprox(fx, f(x0), rtol=rtol)
      @test isapprox(g_val[1:nnzg], g(x0)[g_var[1:nnzg]], rtol=rtol)

      g_var = zeros(Cint, nlp.meta.nvar)
      g_val = zeros(nlp.meta.nvar)
      fx, nnzg = cofsg!(nlp.meta.nvar, x0, nlp.meta.nvar, g_val, g_var, true)
      @test isapprox(fx, f(x0), rtol=rtol)
      @test isapprox(g_val[1:nnzg], g(x0)[g_var[1:nnzg]], rtol=rtol)

      cx, Jx = ccfg(nlp.meta.nvar, nlp.meta.ncon, x0, false, nlp.meta.ncon, nlp.meta.nvar, true)
      @test isapprox(cx, c(x0), rtol=rtol)
      @test isapprox(Jx, J(x0), rtol=rtol)

      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      cx = zeros(nlp.meta.ncon)
      ccfg!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, true)
      @test isapprox(cx, c(x0), rtol=rtol)
      @test isapprox(Jx, J(x0), rtol=rtol)

      fx, gx = clfg(nlp.meta.nvar, nlp.meta.ncon, x0, y0, true)
      @test isapprox(fx, f(x0)+dot(y0,c(x0)), rtol=rtol)
      @test isapprox(gx, g(x0)+J(x0)'*y0, rtol=rtol)

      fx = clfg!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, gx, true)
      @test isapprox(fx, f(x0)+dot(y0,c(x0)), rtol=rtol)
      @test isapprox(gx, g(x0)+J(x0)'*y0, rtol=rtol)

      gx, Jx = cgr(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar)
      @test isapprox(gx, g(x0), rtol=rtol)
      @test isapprox(Jx, J(x0), rtol=rtol)

      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      gx = zeros(nlp.meta.nvar)
      cgr!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx)
      @test isapprox(gx, g(x0), rtol=rtol)
      @test isapprox(Jx, J(x0), rtol=rtol)

      nnzj, Jx, j_var, j_fun = csgr(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar)
      j_val = copy(Jx)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      for k = 1:nnzj
        j_fun[k] == 0 && continue
        Jx[j_fun[k],j_var[k]] = j_val[k]
      end
      @test isapprox(Jx, J(x0), rtol=rtol)

      j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
      nnzj = csgr!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun)
      j_val = copy(Jx)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      for k = 1:nnzj
        j_fun[k] == 0 && continue
        Jx[j_fun[k],j_var[k]] = j_val[k]
      end
      @test isapprox(Jx, J(x0), rtol=rtol)

      cx, nnzj, Jx, j_var, j_fun = ccfsg(nlp.meta.nvar, nlp.meta.ncon, x0, nlp.meta.nnzj+nlp.meta.nvar, true)
      @test isapprox(cx, c(x0), rtol=rtol)
      j_val = copy(Jx)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      for k = 1:nnzj
        Jx[j_fun[k],j_var[k]] = j_val[k]
      end
      @test isapprox(Jx, J(x0), rtol=rtol)

      j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
      cx = zeros(nlp.meta.ncon)
      nnzj = ccfsg!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, true)
      @test isapprox(cx, c(x0), rtol=rtol)
      j_val = copy(Jx)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      for k = 1:nnzj
        Jx[j_fun[k],j_var[k]] = j_val[k]
      end
      @test isapprox(Jx, J(x0), rtol=rtol)

      for j = 1:nlp.meta.ncon
        ci, gci = ccifg(nlp.meta.nvar, j, x0, true)
        @test isapprox(ci, c(x0)[j], rtol=rtol)
        @test isapprox(gci, J(x0)[j,:][:], rtol=rtol)
      end

      for j = 1:nlp.meta.ncon
        gci = zeros(nlp.meta.nvar)
        ci = ccifg!(nlp.meta.nvar, j, x0, gci, true)
        @test isapprox(ci, c(x0)[j], rtol=rtol)
        @test isapprox(gci, J(x0)[j,:][:], rtol=rtol)
      end

      for j = 1:nlp.meta.ncon
        ci, nnzgci, gci_val, gci_var = ccifsg(nlp.meta.nvar, j, x0, nlp.meta.nvar, true)
        @test isapprox(ci, c(x0)[j], rtol=rtol)
        @test isapprox(gci_val, J(x0)[j,gci_var][:], rtol=rtol)
      end

      for j = 1:nlp.meta.ncon
        gci_var = zeros(Cint, nlp.meta.nvar)
        gci_val = zeros(nlp.meta.nvar)
        ci, nnzgci = ccifsg!(nlp.meta.nvar, j, x0, nlp.meta.nvar, gci_val, gci_var, true)
        @test isapprox(ci, c(x0)[j], rtol=rtol)
        @test isapprox(gci_val, J(x0)[j,gci_var][:], rtol=rtol)
      end

      gx, Jx, Wx = cgrdh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.meta.nvar)
      @test isapprox(gx, g(x0), rtol=rtol)
      @test isapprox(Jx, J(x0), rtol=rtol)
      @test isapprox(Wx, W(x0,y0), rtol=rtol)

      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      gx = zeros(nlp.meta.nvar)
      cgrdh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.meta.nvar, Wx)
      @test isapprox(gx, g(x0), rtol=rtol)
      @test isapprox(Jx, J(x0), rtol=rtol)
      @test isapprox(Wx, W(x0,y0), rtol=rtol)

      Wx = cdh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nvar)
      @test isapprox(Wx, W(x0,y0), rtol=rtol)

      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      cdh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nvar, Wx)
      @test isapprox(Wx, W(x0,y0), rtol=rtol)

      nnzh, Wx, h_row, h_col = csh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh)
      w_val = copy(Wx)
      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      for k = 1:nnzh
        Wx[h_row[k],h_col[k]] = w_val[k]
        Wx[h_col[k],h_row[k]] = w_val[k]
      end
      @test isapprox(Wx, W(x0,y0), rtol=rtol)

      h_col = zeros(Cint, nlp.meta.nnzh)
      h_row = zeros(Cint, nlp.meta.nnzh)
      Wx = zeros(nlp.meta.nnzh)
      nnzh = csh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, Wx, h_row, h_col)
      w_val = copy(Wx)
      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      for k = 1:nnzh
        Wx[h_row[k],h_col[k]] = w_val[k]
        Wx[h_col[k],h_row[k]] = w_val[k]
      end
      @test isapprox(Wx, W(x0,y0), rtol=rtol)

      nnzh, Wx, h_row, h_col = cshc(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh)
      w_val = copy(Wx)
      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      for k = 1:nnzh
        Wx[h_row[k],h_col[k]] = w_val[k]
        Wx[h_col[k],h_row[k]] = w_val[k]
      end
      @test isapprox(Wx, W(x0,y0)-H(x0), rtol=rtol)

      h_col = zeros(Cint, nlp.meta.nnzh)
      h_row = zeros(Cint, nlp.meta.nnzh)
      Wx = zeros(nlp.meta.nnzh)
      nnzh = cshc!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, Wx, h_row, h_col)
      w_val = copy(Wx)
      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      for k = 1:nnzh
        Wx[h_row[k],h_col[k]] = w_val[k]
        Wx[h_col[k],h_row[k]] = w_val[k]
      end
      @test isapprox(Wx, W(x0,y0)-H(x0), rtol=rtol)

      for j = 1:nlp.meta.ncon
        h = cidh(nlp.meta.nvar, x0, j, nlp.meta.nvar)
        @test isapprox(h, (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0)), rtol=rtol)
      end

      for j = 1:nlp.meta.ncon
        h = zeros(nlp.meta.nvar, nlp.meta.nvar)
        cidh!(nlp.meta.nvar, x0, j, nlp.meta.nvar, h)
        @test isapprox(h, (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0)), rtol=rtol)
      end

      for j = 1:nlp.meta.ncon
        nnzh, Wx, h_row, h_col = cish(nlp.meta.nvar, x0, j, nlp.meta.nnzh)
        w_val = copy(Wx)
        Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
        for k = 1:nnzh
          Wx[h_row[k],h_col[k]] = w_val[k]
          Wx[h_col[k],h_row[k]] = w_val[k]
        end
        @test isapprox(Wx, W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0), rtol=rtol)
      end

      for j = 1:nlp.meta.ncon
        h_col = zeros(Cint, nlp.meta.nnzh)
        h_row = zeros(Cint, nlp.meta.nnzh)
        Wx = zeros(nlp.meta.nnzh)
        nnzh = cish!(nlp.meta.nvar, x0, j, nlp.meta.nnzh, Wx, h_row, h_col)
        w_val = copy(Wx)
        Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
        for k = 1:nnzh
          Wx[h_row[k],h_col[k]] = w_val[k]
          Wx[h_col[k],h_row[k]] = w_val[k]
        end
        @test isapprox(Wx, W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0), rtol=rtol)
      end

      nnzj, Jx, j_var, j_fun, nnzh, Wx, h_row, h_col = csgrsh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, nlp.meta.nnzh)
      j_val = copy(Jx)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      for k = 1:nnzj
        j_fun[k] == 0 && continue
        Jx[j_fun[k],j_var[k]] = j_val[k]
      end
      @test isapprox(Jx, J(x0), rtol=rtol)
      w_val = copy(Wx)
      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      for k = 1:nnzh
        h_row[k] == 0 && continue
        Wx[h_row[k],h_col[k]] = w_val[k]
        Wx[h_col[k],h_row[k]] = w_val[k]
      end
      @test isapprox(Wx, W(x0,y0), rtol=rtol)

      h_col = zeros(Cint, nlp.meta.nnzh)
      h_row = zeros(Cint, nlp.meta.nnzh)
      Wx = zeros(nlp.meta.nnzh)
      j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
      nnzj, nnzh = csgrsh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, nlp.meta.nnzh, Wx, h_row, h_col)
      j_val = copy(Jx)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      for k = 1:nnzj
        j_fun[k] == 0 && continue
        Jx[j_fun[k],j_var[k]] = j_val[k]
      end
      @test isapprox(Jx, J(x0), rtol=rtol)
      w_val = copy(Wx)
      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      for k = 1:nnzh
        h_row[k] == 0 && continue
        Wx[h_row[k],h_col[k]] = w_val[k]
        Wx[h_col[k],h_row[k]] = w_val[k]
      end
      @test isapprox(Wx, W(x0,y0), rtol=rtol)

      result = chprod(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar))
      @test isapprox(result, W(x0,y0)*v, rtol=rtol)

      result = zeros(W(x0,y0)*v)
      chprod!(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), result)

      result = chcprod(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar))
      @test isapprox(result, (W(x0,y0)-H(x0))*v, rtol=rtol)

      result = zeros((W(x0,y0)-H(x0))*v)
      chcprod!(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), result)

      result = cjprod(nlp.meta.nvar, nlp.meta.ncon, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, nlp.meta.ncon)
      @test isapprox(result, J(x0)*v, rtol=rtol)

      result = zeros(J(x0)*v)
      cjprod!(nlp.meta.nvar, nlp.meta.ncon, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, result, nlp.meta.ncon)

      nnzj = cdimsj()
      Jx = jac(comp_nlp, x0)
      @test nnzj == sum(Jx .!= 0) + nlp.meta.nvar

      nnzh = cdimsh()
      Wx = hess(comp_nlp, x0, y=y0)
      @test nnzh == sum(Wx .!= 0)

      _, _, eq, lin = cstats()
      @test eq == length(nlp.meta.jfix)
      @test lin == nlp.meta.nlin

      t = cvartype(nlp.meta.nvar)
      @test all(t .== 0)

      cvartype!(nlp.meta.nvar, t)
      @test all(t .== 0)

      Cx = hess(comp_nlp, x0, y=y0, obj_weight=0.0)
      Cx2 = cdhc(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nvar)
      @test isapprox(tril(Cx2), Cx, rtol=rtol)

      cdhc!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nvar, Cx2)
      @test isapprox(tril(Cx2), Cx, rtol=rtol)

      _, cols, rows = cshp(nlp.meta.nvar, Int(nnzh))
      V = [Wx[rows[i],cols[i]] for i = 1:length(rows)]
      @test isapprox(sparse(rows, cols, V, nlp.meta.nvar, nlp.meta.nvar), sparse(Wx), rtol=rtol)

      cshp!(nlp.meta.nvar, Int(nnzh), cols, rows)
      V = [Wx[rows[i],cols[i]] for i = 1:length(rows)]
      @test isapprox(sparse(rows, cols, V, nlp.meta.nvar, nlp.meta.nvar), sparse(Wx), rtol=rtol)

      nnzr, Ir, r = cshprod(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, 1, Cint[1], [1.0])
      if nnzr < length(r)
        Ir = Ir[1:nnzr]
        r = r[1:nnzr]
      end
      @test isapprox(r, Wx[Ir,1], rtol=rtol)

      nnzr = cshprod!(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, 1, Cint[1], [1.0], Ir, r)
      @test isapprox(r, Wx[Ir,1], rtol=rtol)

      nnzr, Ir, r = cshcprod(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, 1, Cint[1], [1.0])
      if nnzr < length(r)
        Ir = Ir[1:nnzr]
        r = r[1:nnzr]
      end
      @test isapprox(r, Cx[Ir,1], rtol=rtol)

      nnzr = cshcprod!(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, 1, Cint[1], [1.0], Ir, r)
      @test isapprox(r, Cx[Ir,1], rtol=rtol)

      # Finite element
      ne, vlen, rlen = cdimse()

      Ex = zeros(nlp.meta.nvar, nlp.meta.nvar)
      _, rp, vp, rows, vals = ceh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, Int(ne+1), Int(rlen), Int(vlen), true)
      for e = 1:ne
        row = rows[rp[e]:rp[e+1]-1]
        val = vals[vp[e]:vp[e+1]-1]
        len = length(row)
        k = 1
        for j = 1:len
          for i = j:len
            ii, jj = row[i], row[j]
            Ex[ii,jj] += val[k]
            k += 1
          end
        end
      end
      @test isapprox(Ex, Wx, rtol=rtol)

      Ex = zeros(nlp.meta.nvar, nlp.meta.nvar)
      ceh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, Int(ne+1), rp, vp, Int(rlen), rows, Int(vlen), vals, true)
      for e = 1:ne
        row = rows[rp[e]:rp[e+1]-1]
        val = vals[vp[e]:vp[e+1]-1]
        len = length(row)
        k = 1
        for j = 1:len
          for i = j:len
            ii, jj = row[i], row[j]
            Ex[ii,jj] += val[k]
            k += 1
          end
        end
      end
      @test isapprox(Ex, Wx, rtol=rtol)

      nnzj, Jx, j_var, j_fun = csgr(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar)

      Ex = zeros(nlp.meta.nvar, nlp.meta.nvar)
      nnzj, j_val, j_var, j_fun, _, rp, vp, rows, vals = csgreh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nvar+nlp.meta.nnzj, Int(ne+1), Int(rlen), Int(vlen), true)
      gx = zeros(nlp.meta.nvar)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      for k = 1:nnzj
        if j_fun[k] == 0
          gx[j_var[k]] = j_val[k]
        else
          Jx[j_fun[k],j_var[k]] = j_val[k]
        end
      end
      @test isapprox(gx, g(x0), rtol=rtol)
      @test isapprox(Jx, J(x0), rtol=rtol)
      for e = 1:ne
        row = rows[rp[e]:rp[e+1]-1]
        val = vals[vp[e]:vp[e+1]-1]
        len = length(row)
        k = 1
        for j = 1:len
          for i = j:len
            ii, jj = row[i], row[j]
            Ex[ii,jj] += val[k]
            k += 1
          end
        end
      end
      @test isapprox(Ex, Wx, rtol=rtol)

      Ex = zeros(nlp.meta.nvar, nlp.meta.nvar)
      nnzj, ne = csgreh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nvar+nlp.meta.nnzj, j_val, j_var, j_fun, Int(ne+1), rp, vp, Int(rlen), rows, Int(vlen), vals, true)
      gx = zeros(nlp.meta.nvar)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      for k = 1:nnzj
        if j_fun[k] == 0
          gx[j_var[k]] = j_val[k]
        else
          Jx[j_fun[k],j_var[k]] = j_val[k]
        end
      end
      @test isapprox(gx, g(x0), rtol=rtol)
      @test isapprox(Jx, J(x0), rtol=rtol)
      for e = 1:ne
        row = rows[rp[e]:rp[e+1]-1]
        val = vals[vp[e]:vp[e+1]-1]
        len = length(row)
        k = 1
        for j = 1:len
          for i = j:len
            ii, jj = row[i], row[j]
            Ex[ii,jj] += val[k]
            k += 1
          end
        end
      end
      @test isapprox(Ex, Wx, rtol=rtol)
    else
      fx = ufn(nlp.meta.nvar, x0)
      @test isapprox(fx, f(x0), rtol=rtol)

      gx = ugr(nlp.meta.nvar, x0)
      @test isapprox(gx, g(x0), rtol=rtol)

      gx = zeros(nlp.meta.nvar)
      ugr!(nlp.meta.nvar, x0, gx)
      @test isapprox(gx, g(x0), rtol=rtol)

      fx, gx = uofg(nlp.meta.nvar, x0, true)
      @test isapprox(fx, f(x0), rtol=rtol)
      @test isapprox(gx, g(x0), rtol=rtol)

      gx = zeros(nlp.meta.nvar)
      fx = uofg!(nlp.meta.nvar, x0, gx, true)
      @test isapprox(fx, f(x0), rtol=rtol)
      @test isapprox(gx, g(x0), rtol=rtol)

      h = udh(nlp.meta.nvar, x0, nlp.meta.nvar)
      @test isapprox(h, H(x0), rtol=rtol)

      udh!(nlp.meta.nvar, x0, nlp.meta.nvar, h)
      @test isapprox(h, H(x0), rtol=rtol)

      nnzh, Wx, h_row, h_col = ush(nlp.meta.nvar, x0, nlp.meta.nnzh)
      w_val = copy(Wx)
      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      for k = 1:nnzh
        Wx[h_row[k],h_col[k]] = w_val[k]
        Wx[h_col[k],h_row[k]] = w_val[k]
      end
      @test isapprox(Wx, H(x0), rtol=rtol)

      h_col = zeros(Cint, nlp.meta.nnzh)
      h_row = zeros(Cint, nlp.meta.nnzh)
      Wx = zeros(nlp.meta.nnzh)
      nnzh = ush!(nlp.meta.nvar, x0, nlp.meta.nnzh, Wx, h_row, h_col)
      w_val = copy(Wx)
      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      for k = 1:nnzh
        Wx[h_row[k],h_col[k]] = w_val[k]
        Wx[h_col[k],h_row[k]] = w_val[k]
      end
      @test isapprox(Wx, H(x0), rtol=rtol)

      result = uhprod(nlp.meta.nvar, false, x0, ones(nlp.meta.nvar))
      @test isapprox(result, H(x0)*v, rtol=rtol)

      result = zeros(H(x0)*v)
      uhprod!(nlp.meta.nvar, false, x0, ones(nlp.meta.nvar), result)

      nnzh = udimsh()
      Hx = hess(comp_nlp, x0)
      @test nnzh == sum(Hx .!= 0)

      t = uvartype(nlp.meta.nvar)
      @test all(t .== 0)

      uvartype!(nlp.meta.nvar, t)
      @test all(t .== 0)

      _, cols, rows = ushp(nlp.meta.nvar, Int(nnzh))
      V = [Wx[rows[i],cols[i]] for i = 1:length(rows)]
      @test isapprox(sparse(rows, cols, V, nlp.meta.nvar, nlp.meta.nvar), sparse(Hx), rtol=rtol)

      ushp!(nlp.meta.nvar, Int(nnzh), cols, rows)
      V = [Wx[rows[i],cols[i]] for i = 1:length(rows)]
      @test isapprox(sparse(rows, cols, V, nlp.meta.nvar, nlp.meta.nvar), sparse(Hx), rtol=rtol)

      gx, Wx = ugrdh(nlp.meta.nvar, x0, nlp.meta.nvar)
      @test isapprox(gx, g(x0), rtol=rtol)
      @test isapprox(Wx, H(x0), rtol=rtol)

      ugrdh!(nlp.meta.nvar, x0, gx, nlp.meta.nvar, Wx)
      @test isapprox(gx, g(x0), rtol=rtol)
      @test isapprox(Wx, H(x0), rtol=rtol)

      gx, _, V, cols, rows = ugrsh(nlp.meta.nvar, x0, Int(nnzh))
      @test isapprox(gx, g(x0), rtol=rtol)
      @test isapprox(sparse(rows, cols, V, nlp.meta.nvar, nlp.meta.nvar), sparse(Hx), rtol=rtol)

      ugrsh!(nlp.meta.nvar, x0, gx, Int(nnzh), V, cols, rows)
      @test isapprox(gx, g(x0), rtol=rtol)
      @test isapprox(sparse(rows, cols, V, nlp.meta.nvar, nlp.meta.nvar), Hx, rtol=rtol)

      nnzr, Ir, r = ushprod(nlp.meta.nvar, false, x0, 1, Cint[1], [1.0])
      @test isapprox(r, Hx[Ir,1], rtol=rtol)

      nnzr = ushprod!(nlp.meta.nvar, false, x0, 1, Cint[1], [1.0], Ir, r)
      @test isapprox(r, Hx[Ir,1], rtol=rtol)

      B, _ = ubandh(nlp.meta.nvar, x0, 0, 0)
      @test isapprox(B[:], diag(Hx), rtol=rtol)

      _ = ubandh!(nlp.meta.nvar, x0, 0, B, 0)
      @test isapprox(B[:], diag(Hx), rtol=rtol)

      # Finite element
      ne, vlen, rlen = udimse()

      Ex = zeros(nlp.meta.nvar, nlp.meta.nvar)
      _, rp, vp, rows, vals = ueh(nlp.meta.nvar, x0, Int(ne+1), Int(rlen), Int(vlen), true)
      for e = 1:ne
        row = rows[rp[e]:rp[e+1]-1]
        val = vals[vp[e]:vp[e+1]-1]
        len = length(row)
        k = 1
        for j = 1:len
          for i = j:len
            ii, jj = row[i], row[j]
            Ex[ii,jj] += val[k]
            k += 1
          end
        end
      end
      @test isapprox(Ex, Hx, rtol=rtol)

      Ex = zeros(nlp.meta.nvar, nlp.meta.nvar)
      ueh!(nlp.meta.nvar, x0, Int(ne+1), rp, vp, Int(rlen), rows, Int(vlen), vals, true)
      for e = 1:ne
        row = rows[rp[e]:rp[e+1]-1]
        val = vals[vp[e]:vp[e+1]-1]
        len = length(row)
        k = 1
        for j = 1:len
          for i = j:len
            ii, jj = row[i], row[j]
            Ex[ii,jj] += val[k]
            k += 1
          end
        end
      end
      @test isapprox(Ex, Hx, rtol=rtol)

      Ex = zeros(nlp.meta.nvar, nlp.meta.nvar)
      gx, _, rp, vp, rows, vals = ugreh(nlp.meta.nvar, x0, Int(ne+1), Int(rlen), Int(vlen), true)
      for e = 1:ne
        row = rows[rp[e]:rp[e+1]-1]
        val = vals[vp[e]:vp[e+1]-1]
        len = length(row)
        k = 1
        for j = 1:len
          for i = j:len
            ii, jj = row[i], row[j]
            Ex[ii,jj] += val[k]
            k += 1
          end
        end
      end
      @test isapprox(Ex, Hx, rtol=rtol)
      @test isapprox(gx, g(x0), rtol=rtol)

      Ex = zeros(nlp.meta.nvar, nlp.meta.nvar)
      ugreh!(nlp.meta.nvar, x0, gx, Int(ne+1), rp, vp, Int(rlen), rows, Int(vlen), vals, true)
      for e = 1:ne
        row = rows[rp[e]:rp[e+1]-1]
        val = vals[vp[e]:vp[e+1]-1]
        len = length(row)
        k = 1
        for j = 1:len
          for i = j:len
            ii, jj = row[i], row[j]
            Ex[ii,jj] += val[k]
            k += 1
          end
        end
      end
      @test isapprox(Ex, Hx, rtol=rtol)
      @test isapprox(gx, g(x0), rtol=rtol)
    end

  end

  print("Specialized interface stress test... ")
  for i = 1:10000
    if nlp.meta.ncon > 0
      fx, cx = cfn(nlp.meta.nvar, nlp.meta.ncon, x0)
      cx = zeros(nlp.meta.ncon)
      fx = cfn!(nlp.meta.nvar, nlp.meta.ncon, x0, cx)
      fx, gx = cofg(nlp.meta.nvar, x0, true)
      gx = zeros(nlp.meta.nvar)
      fx = cofg!(nlp.meta.nvar, x0, gx, true)
      fx, nnzg, g_val, g_var = cofsg(nlp.meta.nvar, x0, nlp.meta.nvar, true)
      g_var = zeros(Cint, nlp.meta.nvar)
      g_val = zeros(nlp.meta.nvar)
      fx, nnzg = cofsg!(nlp.meta.nvar, x0, nlp.meta.nvar, g_val, g_var, true)
      cx, Jx = ccfg(nlp.meta.nvar, nlp.meta.ncon, x0, false, nlp.meta.ncon, nlp.meta.nvar, true)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      cx = zeros(nlp.meta.ncon)
      ccfg!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, true)
      fx, gx = clfg(nlp.meta.nvar, nlp.meta.ncon, x0, y0, true)
      fx = clfg!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, gx, true)
      gx, Jx = cgr(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      gx = zeros(nlp.meta.nvar)
      cgr!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx)
      nnzj, Jx, j_var, j_fun = csgr(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar)
      j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      nnzj = csgr!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun)
      cx, nnzj, Jx, j_var, j_fun = ccfsg(nlp.meta.nvar, nlp.meta.ncon, x0, nlp.meta.nnzj+nlp.meta.nvar, true)
      j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      cx = zeros(nlp.meta.ncon)
      nnzj = ccfsg!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, true)
      for j = 1:nlp.meta.ncon
        ci, gci = ccifg(nlp.meta.nvar, j, x0, true)
      end
      gci = zeros(nlp.meta.nvar)
      for j = 1:nlp.meta.ncon
        ci = ccifg!(nlp.meta.nvar, j, x0, gci, true)
      end
      for j = 1:nlp.meta.ncon
        ci, nnzgci, gci_val, gci_var = ccifsg(nlp.meta.nvar, j, x0, nlp.meta.nvar, true)
      end
      gci_var = zeros(Cint, nlp.meta.nvar)
      gci_val = zeros(nlp.meta.nvar)
      for j = 1:nlp.meta.ncon
        ci, nnzgci = ccifsg!(nlp.meta.nvar, j, x0, nlp.meta.nvar, gci_val, gci_var, true)
      end
      gx, Jx, Wx = cgrdh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.meta.nvar)
      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
      gx = zeros(nlp.meta.nvar)
      cgrdh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.meta.nvar, Wx)
      Wx = cdh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nvar)
      Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
      cdh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nvar, Wx)
      nnzh, Wx, h_row, h_col = csh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh)
      h_col = zeros(Cint, nlp.meta.nnzh)
      h_row = zeros(Cint, nlp.meta.nnzh)
      nnzh = csh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, Wx, h_row, h_col)
      nnzh, Wx, h_row, h_col = cshc(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh)
      h_col = zeros(Cint, nlp.meta.nnzh)
      h_row = zeros(Cint, nlp.meta.nnzh)
      nnzh = cshc!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, Wx, h_row, h_col)
      for j = 1:nlp.meta.ncon
        h = cidh(nlp.meta.nvar, x0, j, nlp.meta.nvar)
      end
      h = zeros(nlp.meta.nvar, nlp.meta.nvar)
      for j = 1:nlp.meta.ncon
        cidh!(nlp.meta.nvar, x0, j, nlp.meta.nvar, h)
      end
      for j = 1:nlp.meta.ncon
        nnzh, Wx, h_row, h_col = cish(nlp.meta.nvar, x0, j, nlp.meta.nnzh)
      end
      h_col = zeros(Cint, nlp.meta.nnzh)
      h_row = zeros(Cint, nlp.meta.nnzh)
      for j = 1:nlp.meta.ncon
        nnzh = cish!(nlp.meta.nvar, x0, j, nlp.meta.nnzh, Wx, h_row, h_col)
      end
      nnzj, Jx, j_var, j_fun, nnzh, Wx, h_row, h_col = csgrsh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, nlp.meta.nnzh)
      h_col = zeros(Cint, nlp.meta.nnzh)
      h_row = zeros(Cint, nlp.meta.nnzh)
      j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
      nnzj, nnzh = csgrsh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, nlp.meta.nnzh, Wx, h_row, h_col)
      result = chprod(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar))
      result = zeros(W(x0,y0)*v)
      chprod!(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), result)
      result = chcprod(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar))
      result = zeros((W(x0,y0)-H(x0))*v)
      chcprod!(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), result)
      result = cjprod(nlp.meta.nvar, nlp.meta.ncon, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, nlp.meta.ncon)
      result = zeros(J(x0)*v)
      cjprod!(nlp.meta.nvar, nlp.meta.ncon, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, result, nlp.meta.ncon)
    else
      fx = ufn(nlp.meta.nvar, x0)
      gx = ugr(nlp.meta.nvar, x0)
      gx = zeros(nlp.meta.nvar)
      ugr!(nlp.meta.nvar, x0, gx)
      fx, gx = uofg(nlp.meta.nvar, x0, true)
      gx = zeros(nlp.meta.nvar)
      fx = uofg!(nlp.meta.nvar, x0, gx, true)
      h = udh(nlp.meta.nvar, x0, nlp.meta.nvar)
      udh!(nlp.meta.nvar, x0, nlp.meta.nvar, h)
      nnzh, Wx, h_row, h_col = ush(nlp.meta.nvar, x0, nlp.meta.nnzh)
      h_col = zeros(Cint, nlp.meta.nnzh)
      h_row = zeros(Cint, nlp.meta.nnzh)
      nnzh = ush!(nlp.meta.nvar, x0, nlp.meta.nnzh, Wx, h_row, h_col)
      result = uhprod(nlp.meta.nvar, false, x0, ones(nlp.meta.nvar))
      result = zeros(H(x0)*v)
      uhprod!(nlp.meta.nvar, false, x0, ones(nlp.meta.nvar), result)
    end
  end
  println("passed")

end

