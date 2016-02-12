println("\nTesting the Specialized interface\n")

v = ones(nlp.nvar)
if nlp.ncon > 0
  fx, cx = cfn(nlp.nvar, nlp.ncon, x0)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  cx = zeros(nlp.ncon)
  fx = cfn!(nlp.nvar, nlp.ncon, x0, cx)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  fx, cx = cfn(x0)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  cx = zeros(nlp.ncon)
  fx = cfn!(x0, cx)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps cx c(x0) 1e-8

  fx, gx = cofg(nlp.nvar, x0, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.nvar)
  fx = cofg!(nlp.nvar, x0, gx, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  fx, gx = cofg(x0, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.nvar)
  fx = cofg!(x0, gx, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  fx, nnzg, g_val, g_var = cofsg(nlp.nvar, x0, nlp.nvar, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  g_var = zeros(Int, nlp.nvar)
  g_val = zeros(nlp.nvar)
  fx, nnzg = cofsg!(nlp.nvar, x0, nlp.nvar, g_val, g_var, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  g_var = zeros(Cint, nlp.nvar)
  g_val = zeros(nlp.nvar)
  fx, nnzg = cofsg!(nlp.nvar, x0, nlp.nvar, g_val, g_var, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  fx, nnzg, g_val, g_var = cofsg(x0, nlp.nvar, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  g_var = zeros(Int, nlp.nvar)
  g_val = zeros(nlp.nvar)
  fx, nnzg = cofsg!(x0, nlp.nvar, g_val, g_var, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  g_var = zeros(Cint, nlp.nvar)
  g_val = zeros(nlp.nvar)
  fx, nnzg = cofsg!(x0, nlp.nvar, g_val, g_var, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps g_val g(x0)[g_var] 1e-8

  cx, Jx = ccfg(nlp.nvar, nlp.ncon, x0, false, nlp.ncon, nlp.nvar, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = zeros(nlp.ncon, nlp.nvar)
  cx = zeros(nlp.ncon)
  ccfg!(nlp.nvar, nlp.ncon, x0, cx, false, nlp.ncon, nlp.nvar, Jx, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  cx, Jx = ccfg(x0, false, nlp.ncon, nlp.nvar, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = zeros(nlp.ncon, nlp.nvar)
  cx = zeros(nlp.ncon)
  ccfg!(x0, cx, false, nlp.ncon, nlp.nvar, Jx, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  fx, gx = clfg(nlp.nvar, nlp.ncon, x0, y0, true)
  @test_approx_eq_eps fx f(x0)+dot(y0,c(x0)) 1e-8
  @test_approx_eq_eps gx g(x0)+J(x0)'*y0 1e-8

  fx = clfg!(nlp.nvar, nlp.ncon, x0, y0, gx, true)
  @test_approx_eq_eps fx f(x0)+dot(y0,c(x0)) 1e-8
  @test_approx_eq_eps gx g(x0)+J(x0)'*y0 1e-8

  fx, gx = clfg(x0, y0, true)
  @test_approx_eq_eps fx f(x0)+dot(y0,c(x0)) 1e-8
  @test_approx_eq_eps gx g(x0)+J(x0)'*y0 1e-8

  fx = clfg!(x0, y0, gx, true)
  @test_approx_eq_eps fx f(x0)+dot(y0,c(x0)) 1e-8
  @test_approx_eq_eps gx g(x0)+J(x0)'*y0 1e-8

  gx, Jx = cgr(nlp.nvar, nlp.ncon, x0, y0, false, false, nlp.ncon, nlp.nvar)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = zeros(nlp.ncon, nlp.nvar)
  gx = zeros(nlp.nvar)
  cgr!(nlp.nvar, nlp.ncon, x0, y0, false, gx, false, nlp.ncon, nlp.nvar, Jx)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  gx, Jx = cgr(x0, y0, false, false, nlp.ncon, nlp.nvar)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  Jx = zeros(nlp.ncon, nlp.nvar)
  gx = zeros(nlp.nvar)
  cgr!(x0, y0, false, gx, false, nlp.ncon, nlp.nvar, Jx)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8

  nnzj, Jx, j_var, j_fun = csgr(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  nnzj = csgr!(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  nnzj = csgr!(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  nnzj, Jx, j_var, j_fun = csgr(x0, y0, false)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  nnzj = csgr!(x0, y0, false, Jx, j_var, j_fun)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  nnzj = csgr!(x0, y0, false, Jx, j_var, j_fun)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  cx, nnzj, Jx, j_var, j_fun = ccfsg(nlp.nvar, nlp.ncon, x0, nlp.nnzj+nlp.nvar, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  cx = zeros(nlp.ncon)
  nnzj = ccfsg!(nlp.nvar, nlp.ncon, x0, cx, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  cx = zeros(nlp.ncon)
  nnzj = ccfsg!(nlp.nvar, nlp.ncon, x0, cx, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  cx, nnzj, Jx, j_var, j_fun = ccfsg(x0, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  cx = zeros(nlp.ncon)
  nnzj = ccfsg!(x0, cx, Jx, j_var, j_fun, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  cx = zeros(nlp.ncon)
  nnzj = ccfsg!(x0, cx, Jx, j_var, j_fun, true)
  @test_approx_eq_eps cx c(x0) 1e-8
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8

  for j = 1:nlp.ncon
    ci, gci = ccifg(nlp.nvar, j, x0, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci J(x0)[j,:] 1e-8
  end

  for j = 1:nlp.ncon
    ci = ccifg!(nlp.nvar, j, x0, gci, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
  end

  for j = 1:nlp.ncon
    ci, gci = ccifg(j, x0, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci J(x0)[j,:] 1e-8
  end

  for j = 1:nlp.ncon
    ci = ccifg!(j, x0, gci, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
  end

  for j = 1:nlp.ncon
    ci, nnzgci, gci_val, gci_var = ccifsg(nlp.nvar, j, x0, nlp.nvar, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  for j = 1:nlp.ncon
    gci_var = zeros(Int, nlp.nvar)
    gci_val = zeros(nlp.nvar)
    ci, nnzgci = ccifsg!(nlp.nvar, j, x0, nlp.nvar, gci_val, gci_var, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  for j = 1:nlp.ncon
    gci_var = zeros(Cint, nlp.nvar)
    gci_val = zeros(nlp.nvar)
    ci, nnzgci = ccifsg!(nlp.nvar, j, x0, nlp.nvar, gci_val, gci_var, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  for j = 1:nlp.ncon
    ci, nnzgci, gci_val, gci_var = ccifsg(j, x0, nlp.nvar, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  for j = 1:nlp.ncon
    gci_var = zeros(Int, nlp.nvar)
    gci_val = zeros(nlp.nvar)
    ci, nnzgci = ccifsg!(j, x0, nlp.nvar, gci_val, gci_var, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  for j = 1:nlp.ncon
    gci_var = zeros(Cint, nlp.nvar)
    gci_val = zeros(nlp.nvar)
    ci, nnzgci = ccifsg!(j, x0, nlp.nvar, gci_val, gci_var, true)
    @test_approx_eq_eps ci c(x0)[j] 1e-8
    @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
  end

  gx, Jx, Wx = cgrdh(nlp.nvar, nlp.ncon, x0, y0, false, false, nlp.ncon, nlp.nvar, nlp.nvar)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = zeros(nlp.nvar, nlp.nvar)
  Jx = zeros(nlp.ncon, nlp.nvar)
  gx = zeros(nlp.nvar)
  cgrdh!(nlp.nvar, nlp.ncon, x0, y0, false, gx, false, nlp.ncon, nlp.nvar, Jx, nlp.nvar, Wx)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  gx, Jx, Wx = cgrdh(x0, y0, false, false, nlp.ncon, nlp.nvar, nlp.nvar)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = zeros(nlp.nvar, nlp.nvar)
  Jx = zeros(nlp.ncon, nlp.nvar)
  gx = zeros(nlp.nvar)
  cgrdh!(x0, y0, false, gx, false, nlp.ncon, nlp.nvar, Jx, nlp.nvar, Wx)
  @test_approx_eq_eps gx g(x0) 1e-8
  @test_approx_eq_eps Jx J(x0) 1e-8
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = cdh(nlp.nvar, nlp.ncon, x0, y0, nlp.nvar)
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = zeros(nlp.nvar, nlp.nvar)
  cdh!(nlp.nvar, nlp.ncon, x0, y0, nlp.nvar, Wx)
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = cdh(x0, y0, nlp.nvar)
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  Wx = zeros(nlp.nvar, nlp.nvar)
  cdh!(x0, y0, nlp.nvar, Wx)
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  nnzh, Wx, h_row, h_col = csh(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = csh!(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = csh!(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  nnzh, Wx, h_row, h_col = csh(x0, y0)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = csh!(x0, y0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = csh!(x0, y0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  nnzh, Wx, h_row, h_col = cshc(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = cshc!(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = cshc!(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  nnzh, Wx, h_row, h_col = cshc(x0, y0)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = cshc!(x0, y0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = cshc!(x0, y0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

  for j = 1:nlp.ncon
    h = cidh(nlp.nvar, x0, j, nlp.nvar)
    @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.ncon])-H(x0)) 1e-8
  end

  for j = 1:nlp.ncon
    h = zeros(nlp.nvar, nlp.nvar)
    cidh!(nlp.nvar, x0, j, nlp.nvar, h)
    @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.ncon])-H(x0)) 1e-8
  end

  for j = 1:nlp.ncon
    h = cidh(x0, j, nlp.nvar)
    @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.ncon])-H(x0)) 1e-8
  end

  for j = 1:nlp.ncon
    h = zeros(nlp.nvar, nlp.nvar)
    cidh!(x0, j, nlp.nvar, h)
    @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.ncon])-H(x0)) 1e-8
  end

  for j = 1:nlp.ncon
    nnzh, Wx, h_row, h_col = cish(nlp.nvar, x0, j, nlp.nnzh)
    w_val = copy(Wx)
    Wx = zeros(nlp.nvar, nlp.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.ncon])-H(x0) 1e-8
  end

  for j = 1:nlp.ncon
    h_col = zeros(Int, nlp.nnzh)
    h_row = zeros(Int, nlp.nnzh)
    Wx = zeros(nlp.nnzh)
    nnzh = cish!(nlp.nvar, x0, j, nlp.nnzh, Wx, h_row, h_col)
    w_val = copy(Wx)
    Wx = zeros(nlp.nvar, nlp.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.ncon])-H(x0) 1e-8
  end

  for j = 1:nlp.ncon
    h_col = zeros(Cint, nlp.nnzh)
    h_row = zeros(Cint, nlp.nnzh)
    Wx = zeros(nlp.nnzh)
    nnzh = cish!(nlp.nvar, x0, j, nlp.nnzh, Wx, h_row, h_col)
    w_val = copy(Wx)
    Wx = zeros(nlp.nvar, nlp.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.ncon])-H(x0) 1e-8
  end

  for j = 1:nlp.ncon
    nnzh, Wx, h_row, h_col = cish(x0, j)
    w_val = copy(Wx)
    Wx = zeros(nlp.nvar, nlp.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.ncon])-H(x0) 1e-8
  end

  for j = 1:nlp.ncon
    h_col = zeros(Int, nlp.nnzh)
    h_row = zeros(Int, nlp.nnzh)
    Wx = zeros(nlp.nnzh)
    nnzh = cish!(x0, j, Wx, h_row, h_col)
    w_val = copy(Wx)
    Wx = zeros(nlp.nvar, nlp.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.ncon])-H(x0) 1e-8
  end

  for j = 1:nlp.ncon
    h_col = zeros(Cint, nlp.nnzh)
    h_row = zeros(Cint, nlp.nnzh)
    Wx = zeros(nlp.nnzh)
    nnzh = cish!(x0, j, Wx, h_row, h_col)
    w_val = copy(Wx)
    Wx = zeros(nlp.nvar, nlp.nvar)
    for k = 1:nnzh
      Wx[h_row[k],h_col[k]] = w_val[k]
      Wx[h_col[k],h_row[k]] = w_val[k]
    end
    @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.ncon])-H(x0) 1e-8
  end

  nnzj, Jx, j_var, j_fun, nnzh, Wx, h_row, h_col = csgrsh(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar, nlp.nnzh)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  nnzj, nnzh = csgrsh!(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun, nlp.nnzh, Wx, h_row, h_col)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  nnzj, nnzh = csgrsh!(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun, nlp.nnzh, Wx, h_row, h_col)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  nnzj, Jx, j_var, j_fun, nnzh, Wx, h_row, h_col = csgrsh(x0, y0, false)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  nnzj, nnzh = csgrsh!(x0, y0, false, Jx, j_var, j_fun, Wx, h_row, h_col)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  Jx = zeros(nlp.nnzj+nlp.nvar)
  nnzj, nnzh = csgrsh!(x0, y0, false, Jx, j_var, j_fun, Wx, h_row, h_col)
  j_val = copy(Jx)
  Jx = zeros(nlp.ncon, nlp.nvar)
  for k = 1:nnzj
    j_fun[k] == 0 && continue
    Jx[j_fun[k],j_var[k]] = j_val[k]
  end
  @test_approx_eq_eps Jx J(x0) 1e-8
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    h_row[k] == 0 && continue
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,y0) 1e-8

  result = chprod(nlp.nvar, nlp.ncon, false, x0, y0, ones(nlp.nvar))
  @test_approx_eq_eps result W(x0,y0)*v 1e-8

  result = zeros(W(x0,y0)*v)
  chprod!(nlp.nvar, nlp.ncon, false, x0, y0, ones(nlp.nvar), result)

  result = chprod(false, x0, y0, ones(nlp.nvar))
  @test_approx_eq_eps result W(x0,y0)*v 1e-8

  result = zeros(W(x0,y0)*v)
  chprod!(false, x0, y0, ones(nlp.nvar), result)

  result = chcprod(nlp.nvar, nlp.ncon, false, x0, y0, ones(nlp.nvar))
  @test_approx_eq_eps result (W(x0,y0)-H(x0))*v 1e-8

  result = zeros((W(x0,y0)-H(x0))*v)
  chcprod!(nlp.nvar, nlp.ncon, false, x0, y0, ones(nlp.nvar), result)

  result = chcprod(false, x0, y0, ones(nlp.nvar))
  @test_approx_eq_eps result (W(x0,y0)-H(x0))*v 1e-8

  result = zeros((W(x0,y0)-H(x0))*v)
  chcprod!(false, x0, y0, ones(nlp.nvar), result)

  result = cjprod(nlp.nvar, nlp.ncon, false, false, x0, ones(nlp.nvar), nlp.nvar, nlp.ncon)
  @test_approx_eq_eps result J(x0)*v 1e-8

  result = zeros(J(x0)*v)
  cjprod!(nlp.nvar, nlp.ncon, false, false, x0, ones(nlp.nvar), nlp.nvar, result, nlp.ncon)

  result = cjprod(false, false, x0, ones(nlp.nvar), nlp.nvar, nlp.ncon)
  @test_approx_eq_eps result J(x0)*v 1e-8

  result = zeros(J(x0)*v)
  cjprod!(false, false, x0, ones(nlp.nvar), nlp.nvar, result, nlp.ncon)

else
  fx = ufn(nlp.nvar, x0)
  @test_approx_eq_eps fx f(x0) 1e-8

  fx = ufn(x0)
  @test_approx_eq_eps fx f(x0) 1e-8

  gx = ugr(nlp.nvar, x0)
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.nvar)
  ugr!(nlp.nvar, x0, gx)
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = ugr(x0)
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.nvar)
  ugr!(x0, gx)
  @test_approx_eq_eps gx g(x0) 1e-8

  fx, gx = uofg(nlp.nvar, x0, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.nvar)
  fx = uofg!(nlp.nvar, x0, gx, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  fx, gx = uofg(x0, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  gx = zeros(nlp.nvar)
  fx = uofg!(x0, gx, true)
  @test_approx_eq_eps fx f(x0) 1e-8
  @test_approx_eq_eps gx g(x0) 1e-8

  h = udh(nlp.nvar, x0, nlp.nvar)
  @test_approx_eq_eps h H(x0) 1e-8

  udh!(nlp.nvar, x0, nlp.nvar, h)
  @test_approx_eq_eps h H(x0) 1e-8

  h = udh(x0, nlp.nvar)
  @test_approx_eq_eps h H(x0) 1e-8

  udh!(x0, nlp.nvar, h)
  @test_approx_eq_eps h H(x0) 1e-8

  nnzh, Wx, h_row, h_col = ush(nlp.nvar, x0, nlp.nnzh)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = ush!(nlp.nvar, x0, nlp.nnzh, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = ush!(nlp.nvar, x0, nlp.nnzh, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  nnzh, Wx, h_row, h_col = ush(x0)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = ush!(x0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  Wx = zeros(nlp.nnzh)
  nnzh = ush!(x0, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.nvar, nlp.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx H(x0) 1e-8

  result = uhprod(nlp.nvar, false, x0, ones(nlp.nvar))
  @test_approx_eq_eps result H(x0)*v 1e-8

  result = zeros(H(x0)*v)
  uhprod!(nlp.nvar, false, x0, ones(nlp.nvar), result)

  result = uhprod(false, x0, ones(nlp.nvar))
  @test_approx_eq_eps result H(x0)*v 1e-8

  result = zeros(H(x0)*v)
  uhprod!(false, x0, ones(nlp.nvar), result)

end

print("Specialized interface stress test... ")
for i = 1:100000
  if nlp.ncon > 0
  fx, cx = cfn(nlp.nvar, nlp.ncon, x0)
  cx = zeros(nlp.ncon)
  fx = cfn!(nlp.nvar, nlp.ncon, x0, cx)
  fx, cx = cfn(x0)
  cx = zeros(nlp.ncon)
  fx = cfn!(x0, cx)
  fx, gx = cofg(nlp.nvar, x0, true)
  gx = zeros(nlp.nvar)
  fx = cofg!(nlp.nvar, x0, gx, true)
  fx, gx = cofg(x0, true)
  gx = zeros(nlp.nvar)
  fx = cofg!(x0, gx, true)
  fx, nnzg, g_val, g_var = cofsg(nlp.nvar, x0, nlp.nvar, true)
  g_var = zeros(Int, nlp.nvar)
  g_val = zeros(nlp.nvar)
  fx, nnzg = cofsg!(nlp.nvar, x0, nlp.nvar, g_val, g_var, true)
  g_var = zeros(Cint, nlp.nvar)
  g_val = zeros(nlp.nvar)
  fx, nnzg = cofsg!(nlp.nvar, x0, nlp.nvar, g_val, g_var, true)
  fx, nnzg, g_val, g_var = cofsg(x0, nlp.nvar, true)
  g_var = zeros(Int, nlp.nvar)
  g_val = zeros(nlp.nvar)
  fx, nnzg = cofsg!(x0, nlp.nvar, g_val, g_var, true)
  g_var = zeros(Cint, nlp.nvar)
  g_val = zeros(nlp.nvar)
  fx, nnzg = cofsg!(x0, nlp.nvar, g_val, g_var, true)
  cx, Jx = ccfg(nlp.nvar, nlp.ncon, x0, false, nlp.ncon, nlp.nvar, true)
  Jx = zeros(nlp.ncon, nlp.nvar)
  cx = zeros(nlp.ncon)
  ccfg!(nlp.nvar, nlp.ncon, x0, cx, false, nlp.ncon, nlp.nvar, Jx, true)
  cx, Jx = ccfg(x0, false, nlp.ncon, nlp.nvar, true)
  Jx = zeros(nlp.ncon, nlp.nvar)
  cx = zeros(nlp.ncon)
  ccfg!(x0, cx, false, nlp.ncon, nlp.nvar, Jx, true)
  fx, gx = clfg(nlp.nvar, nlp.ncon, x0, y0, true)
  fx = clfg!(nlp.nvar, nlp.ncon, x0, y0, gx, true)
  fx, gx = clfg(x0, y0, true)
  fx = clfg!(x0, y0, gx, true)
  gx, Jx = cgr(nlp.nvar, nlp.ncon, x0, y0, false, false, nlp.ncon, nlp.nvar)
  Jx = zeros(nlp.ncon, nlp.nvar)
  gx = zeros(nlp.nvar)
  cgr!(nlp.nvar, nlp.ncon, x0, y0, false, gx, false, nlp.ncon, nlp.nvar, Jx)
  gx, Jx = cgr(x0, y0, false, false, nlp.ncon, nlp.nvar)
  Jx = zeros(nlp.ncon, nlp.nvar)
  gx = zeros(nlp.nvar)
  cgr!(x0, y0, false, gx, false, nlp.ncon, nlp.nvar, Jx)
  nnzj, Jx, j_var, j_fun = csgr(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar)
  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  nnzj = csgr!(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun)
  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  nnzj = csgr!(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun)
  nnzj, Jx, j_var, j_fun = csgr(x0, y0, false)
  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  nnzj = csgr!(x0, y0, false, Jx, j_var, j_fun)
  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  nnzj = csgr!(x0, y0, false, Jx, j_var, j_fun)
  cx, nnzj, Jx, j_var, j_fun = ccfsg(nlp.nvar, nlp.ncon, x0, nlp.nnzj+nlp.nvar, true)
  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  cx = zeros(nlp.ncon)
  nnzj = ccfsg!(nlp.nvar, nlp.ncon, x0, cx, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun, true)
  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  cx = zeros(nlp.ncon)
  nnzj = ccfsg!(nlp.nvar, nlp.ncon, x0, cx, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun, true)
  cx, nnzj, Jx, j_var, j_fun = ccfsg(x0, true)
  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  cx = zeros(nlp.ncon)
  nnzj = ccfsg!(x0, cx, Jx, j_var, j_fun, true)
  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  cx = zeros(nlp.ncon)
  nnzj = ccfsg!(x0, cx, Jx, j_var, j_fun, true)
  for j = 1:nlp.ncon
    ci, gci = ccifg(nlp.nvar, j, x0, true)
  end
  for j = 1:nlp.ncon
    ci = ccifg!(nlp.nvar, j, x0, gci, true)
  end
  for j = 1:nlp.ncon
    ci, gci = ccifg(j, x0, true)
  end
  for j = 1:nlp.ncon
    ci = ccifg!(j, x0, gci, true)
  end
  for j = 1:nlp.ncon
    ci, nnzgci, gci_val, gci_var = ccifsg(nlp.nvar, j, x0, nlp.nvar, true)
  end
    gci_var = zeros(Int, nlp.nvar)
    gci_val = zeros(nlp.nvar)
  for j = 1:nlp.ncon
    ci, nnzgci = ccifsg!(nlp.nvar, j, x0, nlp.nvar, gci_val, gci_var, true)
  end
    gci_var = zeros(Cint, nlp.nvar)
    gci_val = zeros(nlp.nvar)
  for j = 1:nlp.ncon
    ci, nnzgci = ccifsg!(nlp.nvar, j, x0, nlp.nvar, gci_val, gci_var, true)
  end
  for j = 1:nlp.ncon
    ci, nnzgci, gci_val, gci_var = ccifsg(j, x0, nlp.nvar, true)
  end
    gci_var = zeros(Int, nlp.nvar)
    gci_val = zeros(nlp.nvar)
  for j = 1:nlp.ncon
    ci, nnzgci = ccifsg!(j, x0, nlp.nvar, gci_val, gci_var, true)
  end
    gci_var = zeros(Cint, nlp.nvar)
    gci_val = zeros(nlp.nvar)
  for j = 1:nlp.ncon
    ci, nnzgci = ccifsg!(j, x0, nlp.nvar, gci_val, gci_var, true)
  end
  gx, Jx, Wx = cgrdh(nlp.nvar, nlp.ncon, x0, y0, false, false, nlp.ncon, nlp.nvar, nlp.nvar)
  Wx = zeros(nlp.nvar, nlp.nvar)
  Jx = zeros(nlp.ncon, nlp.nvar)
  gx = zeros(nlp.nvar)
  cgrdh!(nlp.nvar, nlp.ncon, x0, y0, false, gx, false, nlp.ncon, nlp.nvar, Jx, nlp.nvar, Wx)
  gx, Jx, Wx = cgrdh(x0, y0, false, false, nlp.ncon, nlp.nvar, nlp.nvar)
  Wx = zeros(nlp.nvar, nlp.nvar)
  Jx = zeros(nlp.ncon, nlp.nvar)
  gx = zeros(nlp.nvar)
  cgrdh!(x0, y0, false, gx, false, nlp.ncon, nlp.nvar, Jx, nlp.nvar, Wx)
  Wx = cdh(nlp.nvar, nlp.ncon, x0, y0, nlp.nvar)
  Wx = zeros(nlp.nvar, nlp.nvar)
  cdh!(nlp.nvar, nlp.ncon, x0, y0, nlp.nvar, Wx)
  Wx = cdh(x0, y0, nlp.nvar)
  Wx = zeros(nlp.nvar, nlp.nvar)
  cdh!(x0, y0, nlp.nvar, Wx)
  nnzh, Wx, h_row, h_col = csh(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh)
  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  nnzh = csh!(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh, Wx, h_row, h_col)
  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  nnzh = csh!(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh, Wx, h_row, h_col)
  nnzh, Wx, h_row, h_col = csh(x0, y0)
  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  nnzh = csh!(x0, y0, Wx, h_row, h_col)
  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  nnzh = csh!(x0, y0, Wx, h_row, h_col)
  nnzh, Wx, h_row, h_col = cshc(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh)
  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  nnzh = cshc!(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh, Wx, h_row, h_col)
  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  nnzh = cshc!(nlp.nvar, nlp.ncon, x0, y0, nlp.nnzh, Wx, h_row, h_col)
  nnzh, Wx, h_row, h_col = cshc(x0, y0)
  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  nnzh = cshc!(x0, y0, Wx, h_row, h_col)
  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  nnzh = cshc!(x0, y0, Wx, h_row, h_col)
  for j = 1:nlp.ncon
    h = cidh(nlp.nvar, x0, j, nlp.nvar)
  end
    h = zeros(nlp.nvar, nlp.nvar)
  for j = 1:nlp.ncon
    cidh!(nlp.nvar, x0, j, nlp.nvar, h)
  end
  for j = 1:nlp.ncon
    h = cidh(x0, j, nlp.nvar)
  end
    h = zeros(nlp.nvar, nlp.nvar)
  for j = 1:nlp.ncon
    cidh!(x0, j, nlp.nvar, h)
  end
  for j = 1:nlp.ncon
    nnzh, Wx, h_row, h_col = cish(nlp.nvar, x0, j, nlp.nnzh)
  end
    h_col = zeros(Int, nlp.nnzh)
    h_row = zeros(Int, nlp.nnzh)
  for j = 1:nlp.ncon
    nnzh = cish!(nlp.nvar, x0, j, nlp.nnzh, Wx, h_row, h_col)
  end
    h_col = zeros(Cint, nlp.nnzh)
    h_row = zeros(Cint, nlp.nnzh)
  for j = 1:nlp.ncon
    nnzh = cish!(nlp.nvar, x0, j, nlp.nnzh, Wx, h_row, h_col)
  end
  for j = 1:nlp.ncon
    nnzh, Wx, h_row, h_col = cish(x0, j)
  end
    h_col = zeros(Int, nlp.nnzh)
    h_row = zeros(Int, nlp.nnzh)
  for j = 1:nlp.ncon
    nnzh = cish!(x0, j, Wx, h_row, h_col)
  end
    h_col = zeros(Cint, nlp.nnzh)
    h_row = zeros(Cint, nlp.nnzh)
  for j = 1:nlp.ncon
    nnzh = cish!(x0, j, Wx, h_row, h_col)
  end
  nnzj, Jx, j_var, j_fun, nnzh, Wx, h_row, h_col = csgrsh(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar, nlp.nnzh)
  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  nnzj, nnzh = csgrsh!(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun, nlp.nnzh, Wx, h_row, h_col)
  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  nnzj, nnzh = csgrsh!(nlp.nvar, nlp.ncon, x0, y0, false, nlp.nnzj+nlp.nvar, Jx, j_var, j_fun, nlp.nnzh, Wx, h_row, h_col)
  nnzj, Jx, j_var, j_fun, nnzh, Wx, h_row, h_col = csgrsh(x0, y0, false)
  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  j_fun = zeros(Int, nlp.nnzj+nlp.nvar)
  j_var = zeros(Int, nlp.nnzj+nlp.nvar)
  nnzj, nnzh = csgrsh!(x0, y0, false, Jx, j_var, j_fun, Wx, h_row, h_col)
  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  j_fun = zeros(Cint, nlp.nnzj+nlp.nvar)
  j_var = zeros(Cint, nlp.nnzj+nlp.nvar)
  nnzj, nnzh = csgrsh!(x0, y0, false, Jx, j_var, j_fun, Wx, h_row, h_col)
  result = chprod(nlp.nvar, nlp.ncon, false, x0, y0, ones(nlp.nvar))
  result = zeros(W(x0,y0)*v)
  chprod!(nlp.nvar, nlp.ncon, false, x0, y0, ones(nlp.nvar), result)
  result = chprod(false, x0, y0, ones(nlp.nvar))
  result = zeros(W(x0,y0)*v)
  chprod!(false, x0, y0, ones(nlp.nvar), result)
  result = chcprod(nlp.nvar, nlp.ncon, false, x0, y0, ones(nlp.nvar))
  result = zeros((W(x0,y0)-H(x0))*v)
  chcprod!(nlp.nvar, nlp.ncon, false, x0, y0, ones(nlp.nvar), result)
  result = chcprod(false, x0, y0, ones(nlp.nvar))
  result = zeros((W(x0,y0)-H(x0))*v)
  chcprod!(false, x0, y0, ones(nlp.nvar), result)
  result = cjprod(nlp.nvar, nlp.ncon, false, false, x0, ones(nlp.nvar), nlp.nvar, nlp.ncon)
  result = zeros(J(x0)*v)
  cjprod!(nlp.nvar, nlp.ncon, false, false, x0, ones(nlp.nvar), nlp.nvar, result, nlp.ncon)
  result = cjprod(false, false, x0, ones(nlp.nvar), nlp.nvar, nlp.ncon)
  result = zeros(J(x0)*v)
  cjprod!(false, false, x0, ones(nlp.nvar), nlp.nvar, result, nlp.ncon)
  else
  fx = ufn(nlp.nvar, x0)
  fx = ufn(x0)
  gx = ugr(nlp.nvar, x0)
  gx = zeros(nlp.nvar)
  ugr!(nlp.nvar, x0, gx)
  gx = ugr(x0)
  gx = zeros(nlp.nvar)
  ugr!(x0, gx)
  fx, gx = uofg(nlp.nvar, x0, true)
  gx = zeros(nlp.nvar)
  fx = uofg!(nlp.nvar, x0, gx, true)
  fx, gx = uofg(x0, true)
  gx = zeros(nlp.nvar)
  fx = uofg!(x0, gx, true)
  h = udh(nlp.nvar, x0, nlp.nvar)
  udh!(nlp.nvar, x0, nlp.nvar, h)
  h = udh(x0, nlp.nvar)
  udh!(x0, nlp.nvar, h)
  nnzh, Wx, h_row, h_col = ush(nlp.nvar, x0, nlp.nnzh)
  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  nnzh = ush!(nlp.nvar, x0, nlp.nnzh, Wx, h_row, h_col)
  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  nnzh = ush!(nlp.nvar, x0, nlp.nnzh, Wx, h_row, h_col)
  nnzh, Wx, h_row, h_col = ush(x0)
  h_col = zeros(Int, nlp.nnzh)
  h_row = zeros(Int, nlp.nnzh)
  nnzh = ush!(x0, Wx, h_row, h_col)
  h_col = zeros(Cint, nlp.nnzh)
  h_row = zeros(Cint, nlp.nnzh)
  nnzh = ush!(x0, Wx, h_row, h_col)
  result = uhprod(nlp.nvar, false, x0, ones(nlp.nvar))
  result = zeros(H(x0)*v)
  uhprod!(nlp.nvar, false, x0, ones(nlp.nvar), result)
  result = uhprod(false, x0, ones(nlp.nvar))
  result = zeros(H(x0)*v)
  uhprod!(false, x0, ones(nlp.nvar), result)
  end
end
println("passed")

