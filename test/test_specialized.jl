println("\nTesting the Specialized interface\n")

v = ones(nlp.meta.nvar)
if nlp.meta.ncon > 0
  fx, cx = cfn(nlp.meta.nvar, nlp.meta.ncon, x0, nlp.libname)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  cx = zeros(nlp.meta.ncon)
  fx = cfn!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, nlp.libname)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  fx, cx = cfn(nlp, x0)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  cx = zeros(nlp.meta.ncon)
  fx = cfn!(nlp, x0, cx)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  fx, gx = cofg(nlp.meta.nvar, x0, true, nlp.libname)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.meta.nvar)
  fx = cofg!(nlp.meta.nvar, x0, gx, true, nlp.libname)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  fx, gx = cofg(nlp, x0, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.meta.nvar)
  fx = cofg!(nlp, x0, gx, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  fx, nnzg, g_val, g_var = cofsg(nlp.meta.nvar, x0, nlp.meta.nvar, true, nlp.libname)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  g_var = zeros(Int, nlp.meta.nvar)
  g_val = zeros(nlp.meta.nvar)
  fx, nnzg = cofsg!(nlp.meta.nvar, x0, nlp.meta.nvar, g_val, g_var, true, nlp.libname)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  g_var = zeros(Cint, nlp.meta.nvar)
  g_val = zeros(nlp.meta.nvar)
  fx, nnzg = cofsg!(nlp.meta.nvar, x0, nlp.meta.nvar, g_val, g_var, true, nlp.libname)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  fx, nnzg, g_val, g_var = cofsg(nlp, x0, nlp.meta.nvar, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  g_var = zeros(Int, nlp.meta.nvar)
  g_val = zeros(nlp.meta.nvar)
  fx, nnzg = cofsg!(nlp, x0, nlp.meta.nvar, g_val, g_var, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  g_var = zeros(Cint, nlp.meta.nvar)
  g_val = zeros(nlp.meta.nvar)
  fx, nnzg = cofsg!(nlp, x0, nlp.meta.nvar, g_val, g_var, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  cx, Jx = ccfg(nlp.meta.nvar, nlp.meta.ncon, x0, false, nlp.meta.ncon, nlp.meta.nvar, true, nlp.libname)
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  cx = zeros(nlp.meta.ncon)
  ccfg!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, true, nlp.libname)
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  cx, Jx = ccfg(nlp, x0, false, nlp.meta.ncon, nlp.meta.nvar, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  cx = zeros(nlp.meta.ncon)
  ccfg!(nlp, x0, cx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  fx, gx = clfg(nlp.meta.nvar, nlp.meta.ncon, x0, y0, true, nlp.libname)
  @test_approx_eq_eps fx f(x0)+dot(y0,c(x0)) 1e-8
  @test_approx_eq_eps gx g(x0)+J(x0)'*y0 1e-8

  fx = clfg!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, gx, true, nlp.libname)
  @test_approx_eq_eps fx f(x0)+dot(y0,c(x0)) 1e-8
  @test_approx_eq_eps gx g(x0)+J(x0)'*y0 1e-8

  fx, gx = clfg(nlp, x0, y0, true)
  @test_approx_eq_eps fx f(x0)+dot(y0,c(x0)) 1e-8
  @test_approx_eq_eps gx g(x0)+J(x0)'*y0 1e-8

  fx = clfg!(nlp, x0, y0, gx, true)
  @test_approx_eq_eps fx f(x0)+dot(y0,c(x0)) 1e-8
  @test_approx_eq_eps gx g(x0)+J(x0)'*y0 1e-8

  gx, Jx = cgr(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.libname)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  gx = zeros(nlp.meta.nvar)
  cgr!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.libname)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  gx, Jx = cgr(nlp, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  gx = zeros(nlp.meta.nvar)
  cgr!(nlp, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  nnzj, Jx, j_var, j_fun = csgr(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, nlp.libname)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  nnzj = csgr!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, nlp.libname)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  nnzj = csgr!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, nlp.libname)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  nnzj, Jx, j_var, j_fun = csgr(nlp, x0, y0, false)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  nnzj = csgr!(nlp, x0, y0, false, Jx, j_var, j_fun)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  nnzj = csgr!(nlp, x0, y0, false, Jx, j_var, j_fun)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  cx, nnzj, Jx, j_var, j_fun = ccfsg(nlp.meta.nvar, nlp.meta.ncon, x0, nlp.meta.nnzj+nlp.meta.nvar, true, nlp.libname)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  cx = zeros(nlp.meta.ncon)
  nnzj = ccfsg!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, true, nlp.libname)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  cx = zeros(nlp.meta.ncon)
  nnzj = ccfsg!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, true, nlp.libname)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  cx, nnzj, Jx, j_var, j_fun = ccfsg(nlp, x0, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  cx = zeros(nlp.meta.ncon)
  nnzj = ccfsg!(nlp, x0, cx, Jx, j_var, j_fun, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  cx = zeros(nlp.meta.ncon)
  nnzj = ccfsg!(nlp, x0, cx, Jx, j_var, j_fun, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  for j = 1:nlp.meta.ncon
    ci, gci = ccifg(nlp.meta.nvar, j, x0, true, nlp.libname)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci J(x0)[j,:] 1e-8
  end

  for j = 1:nlp.meta.ncon
    ci = ccifg!(nlp.meta.nvar, j, x0, gci, true, nlp.libname)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
  end

  for j = 1:nlp.meta.ncon
    ci, gci = ccifg(nlp, j, x0, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci J(x0)[j,:] 1e-8
  end

  for j = 1:nlp.meta.ncon
    ci = ccifg!(nlp, j, x0, gci, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
  end

  for j = 1:nlp.meta.ncon
    ci, nnzgci, gci_val, gci_var = ccifsg(nlp.meta.nvar, j, x0, nlp.meta.nvar, true, nlp.libname)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  for j = 1:nlp.meta.ncon
    gci_var = zeros(Int, nlp.meta.nvar)
    gci_val = zeros(nlp.meta.nvar)
    ci, nnzgci = ccifsg!(nlp.meta.nvar, j, x0, nlp.meta.nvar, gci_val, gci_var, true, nlp.libname)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  for j = 1:nlp.meta.ncon
    gci_var = zeros(Cint, nlp.meta.nvar)
    gci_val = zeros(nlp.meta.nvar)
    ci, nnzgci = ccifsg!(nlp.meta.nvar, j, x0, nlp.meta.nvar, gci_val, gci_var, true, nlp.libname)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  for j = 1:nlp.meta.ncon
    ci, nnzgci, gci_val, gci_var = ccifsg(nlp, j, x0, nlp.meta.nvar, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  for j = 1:nlp.meta.ncon
    gci_var = zeros(Int, nlp.meta.nvar)
    gci_val = zeros(nlp.meta.nvar)
    ci, nnzgci = ccifsg!(nlp, j, x0, nlp.meta.nvar, gci_val, gci_var, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  for j = 1:nlp.meta.ncon
    gci_var = zeros(Cint, nlp.meta.nvar)
    gci_val = zeros(nlp.meta.nvar)
    ci, nnzgci = ccifsg!(nlp, j, x0, nlp.meta.nvar, gci_val, gci_var, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  gx, Jx, Wx = cgrdh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.meta.nvar, nlp.libname)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  gx = zeros(nlp.meta.nvar)
  cgrdh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.meta.nvar, Wx, nlp.libname)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  gx, Jx, Wx = cgrdh(nlp, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.meta.nvar)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  gx = zeros(nlp.meta.nvar)
  cgrdh!(nlp, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.meta.nvar, Wx)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = cdh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nvar, nlp.libname)
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  cdh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nvar, Wx, nlp.libname)
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = cdh(nlp, x0, y0, nlp.meta.nvar)
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  cdh!(nlp, x0, y0, nlp.meta.nvar, Wx)
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  nnzh, Wx, h_row, h_col = csh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, nlp.libname)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Int, nlp.meta.nnzh)
  h_row = zeros(Int, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = csh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Cint, nlp.meta.nnzh)
  h_row = zeros(Cint, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = csh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  nnzh, Wx, h_row, h_col = csh(nlp, x0, y0)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Int, nlp.meta.nnzh)
  h_row = zeros(Int, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = csh!(nlp, x0, y0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Cint, nlp.meta.nnzh)
  h_row = zeros(Cint, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = csh!(nlp, x0, y0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  nnzh, Wx, h_row, h_col = cshc(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, nlp.libname)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  h_col = zeros(Int, nlp.meta.nnzh)
  h_row = zeros(Int, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = cshc!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  h_col = zeros(Cint, nlp.meta.nnzh)
  h_row = zeros(Cint, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = cshc!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  nnzh, Wx, h_row, h_col = cshc(nlp, x0, y0)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  h_col = zeros(Int, nlp.meta.nnzh)
  h_row = zeros(Int, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = cshc!(nlp, x0, y0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  h_col = zeros(Cint, nlp.meta.nnzh)
  h_row = zeros(Cint, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = cshc!(nlp, x0, y0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  for j = 1:nlp.meta.ncon
    h = cidh(nlp.meta.nvar, x0, j, nlp.meta.nvar, nlp.libname)
    @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0)) 1e-8
  end

  for j = 1:nlp.meta.ncon
    h = zeros(nlp.meta.nvar, nlp.meta.nvar)
    cidh!(nlp.meta.nvar, x0, j, nlp.meta.nvar, h, nlp.libname)
    @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0)) 1e-8
  end

  for j = 1:nlp.meta.ncon
    h = cidh(nlp, x0, j, nlp.meta.nvar)
    @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0)) 1e-8
  end

  for j = 1:nlp.meta.ncon
    h = zeros(nlp.meta.nvar, nlp.meta.nvar)
    cidh!(nlp, x0, j, nlp.meta.nvar, h)
    @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0)) 1e-8
  end

  for j = 1:nlp.meta.ncon
    nnzh, Wx, h_row, h_col = cish(nlp.meta.nvar, x0, j, nlp.meta.nnzh, nlp.libname)
    w_val = copy(Wx)
    Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0) 1e-8
  end

  for j = 1:nlp.meta.ncon
    h_col = zeros(Int, nlp.meta.nnzh)
    h_row = zeros(Int, nlp.meta.nnzh)
    Wx = zeros(nlp.meta.nnzh)
    nnzh = cish!(nlp.meta.nvar, x0, j, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
    w_val = copy(Wx)
    Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0) 1e-8
  end

  for j = 1:nlp.meta.ncon
    h_col = zeros(Cint, nlp.meta.nnzh)
    h_row = zeros(Cint, nlp.meta.nnzh)
    Wx = zeros(nlp.meta.nnzh)
    nnzh = cish!(nlp.meta.nvar, x0, j, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
    w_val = copy(Wx)
    Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0) 1e-8
  end

  for j = 1:nlp.meta.ncon
    nnzh, Wx, h_row, h_col = cish(nlp, x0, j)
    w_val = copy(Wx)
    Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0) 1e-8
  end

  for j = 1:nlp.meta.ncon
    h_col = zeros(Int, nlp.meta.nnzh)
    h_row = zeros(Int, nlp.meta.nnzh)
    Wx = zeros(nlp.meta.nnzh)
    nnzh = cish!(nlp, x0, j, Wx, h_row, h_col)
    w_val = copy(Wx)
    Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0) 1e-8
  end

  for j = 1:nlp.meta.ncon
    h_col = zeros(Cint, nlp.meta.nnzh)
    h_row = zeros(Cint, nlp.meta.nnzh)
    Wx = zeros(nlp.meta.nnzh)
    nnzh = cish!(nlp, x0, j, Wx, h_row, h_col)
    w_val = copy(Wx)
    Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0) 1e-8
  end

  nnzj, Jx, j_var, j_fun, nnzh, Wx, h_row, h_col = csgrsh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, nlp.meta.nnzh, nlp.libname)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Int, nlp.meta.nnzh)
  h_row = zeros(Int, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  j_fun = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  nnzj, nnzh = csgrsh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Cint, nlp.meta.nnzh)
  h_row = zeros(Cint, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  nnzj, nnzh = csgrsh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  nnzj, Jx, j_var, j_fun, nnzh, Wx, h_row, h_col = csgrsh(nlp, x0, y0, false)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Int, nlp.meta.nnzh)
  h_row = zeros(Int, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  j_fun = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Int, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  nnzj, nnzh = csgrsh!(nlp, x0, y0, false, Jx, j_var, j_fun, Wx, h_row, h_col)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Cint, nlp.meta.nnzh)
  h_row = zeros(Cint, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  j_fun = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  j_var = zeros(Cint, nlp.meta.nnzj+nlp.meta.nvar)
  Jx = zeros(nlp.meta.nnzj+nlp.meta.nvar)
  nnzj, nnzh = csgrsh!(nlp, x0, y0, false, Jx, j_var, j_fun, Wx, h_row, h_col)
  j_val = copy(Jx)
  Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  result = chprod(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), nlp.libname)
  @test_approx_eq_eps result W(x0,y0)*v 1e-8

  result = zeros(W(x0,y0)*v)
  chprod!(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), result, nlp.libname)

  result = chprod(nlp, false, x0, y0, ones(nlp.meta.nvar))
  @test_approx_eq_eps result W(x0,y0)*v 1e-8

  result = zeros(W(x0,y0)*v)
  chprod!(nlp, false, x0, y0, ones(nlp.meta.nvar), result)

  result = chcprod(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), nlp.libname)
  @test_approx_eq_eps result (W(x0,y0)-H(x0))*v 1e-8

  result = zeros((W(x0,y0)-H(x0))*v)
  chcprod!(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), result, nlp.libname)

  result = chcprod(nlp, false, x0, y0, ones(nlp.meta.nvar))
  @test_approx_eq_eps result (W(x0,y0)-H(x0))*v 1e-8

  result = zeros((W(x0,y0)-H(x0))*v)
  chcprod!(nlp, false, x0, y0, ones(nlp.meta.nvar), result)

  result = cjprod(nlp.meta.nvar, nlp.meta.ncon, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, nlp.meta.ncon, nlp.libname)
  @test_approx_eq_eps result J(x0)*v 1e-8

  result = zeros(J(x0)*v)
  cjprod!(nlp.meta.nvar, nlp.meta.ncon, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, result, nlp.meta.ncon, nlp.libname)

  result = cjprod(nlp, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, nlp.meta.ncon)
  @test_approx_eq_eps result J(x0)*v 1e-8

  result = zeros(J(x0)*v)
  cjprod!(nlp, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, result, nlp.meta.ncon)

else
  fx = ufn(nlp.meta.nvar, x0, nlp.libname)
  @test_approx_eq_eps fx f(x0) 1e-8

  fx = ufn(nlp, x0)
  @test_approx_eq_eps fx f(x0) 1e-8

  gx = ugr(nlp.meta.nvar, x0, nlp.libname)
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.meta.nvar)
  ugr!(nlp.meta.nvar, x0, gx, nlp.libname)
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = ugr(nlp, x0)
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.meta.nvar)
  ugr!(nlp, x0, gx)
  @test_approx_eq_eps gx g(x0) 1e-8

  fx, gx = uofg(nlp.meta.nvar, x0, true, nlp.libname)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.meta.nvar)
  fx = uofg!(nlp.meta.nvar, x0, gx, true, nlp.libname)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  fx, gx = uofg(nlp, x0, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.meta.nvar)
  fx = uofg!(nlp, x0, gx, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  h = udh(nlp.meta.nvar, x0, nlp.meta.nvar, nlp.libname)
  @test_approx_eq_eps h H(x0) 1e-8

  udh!(nlp.meta.nvar, x0, nlp.meta.nvar, h, nlp.libname)
  @test_approx_eq_eps h H(x0) 1e-8

  h = udh(nlp, x0, nlp.meta.nvar)
  @test_approx_eq_eps h H(x0) 1e-8

  udh!(nlp, x0, nlp.meta.nvar, h)
  @test_approx_eq_eps h H(x0) 1e-8

  nnzh, Wx, h_row, h_col = ush(nlp.meta.nvar, x0, nlp.meta.nnzh, nlp.libname)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  h_col = zeros(Int, nlp.meta.nnzh)
  h_row = zeros(Int, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = ush!(nlp.meta.nvar, x0, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  h_col = zeros(Cint, nlp.meta.nnzh)
  h_row = zeros(Cint, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = ush!(nlp.meta.nvar, x0, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  nnzh, Wx, h_row, h_col = ush(nlp, x0)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  h_col = zeros(Int, nlp.meta.nnzh)
  h_row = zeros(Int, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = ush!(nlp, x0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  h_col = zeros(Cint, nlp.meta.nnzh)
  h_row = zeros(Cint, nlp.meta.nnzh)
  Wx = zeros(nlp.meta.nnzh)
  nnzh = ush!(nlp, x0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  result = uhprod(nlp.meta.nvar, false, x0, ones(nlp.meta.nvar), nlp.libname)
  @test_approx_eq_eps result H(x0)*v 1e-8

  result = zeros(H(x0)*v)
  uhprod!(nlp.meta.nvar, false, x0, ones(nlp.meta.nvar), result, nlp.libname)

  result = uhprod(nlp, false, x0, ones(nlp.meta.nvar))
  @test_approx_eq_eps result H(x0)*v 1e-8

  result = zeros(H(x0)*v)
  uhprod!(nlp, false, x0, ones(nlp.meta.nvar), result)

end
