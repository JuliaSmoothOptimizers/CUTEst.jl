println("\nTesting the Specialized interface\n")


v = ones(nlp.meta.nvar)
fx, cx = jl_cfn(nlp.meta.nvar, nlp.meta.ncon, x0, nlp.libname)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

cx = zeros(nlp.meta.ncon)
fx = jl_cfn!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, nlp.libname)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

fx, cx = jl_cfn(nlp, x0)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

cx = zeros(nlp.meta.ncon)
fx = jl_cfn!(nlp, x0, cx)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

fx, gx = jl_cofg(nlp.meta.nvar, x0, true, nlp.libname)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

gx = zeros(nlp.meta.nvar)
fx = jl_cofg!(nlp.meta.nvar, x0, gx, true, nlp.libname)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

fx, gx = jl_cofg(nlp, x0, true)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

gx = zeros(nlp.meta.nvar)
fx = jl_cofg!(nlp, x0, gx, true)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

cx, Jx = jl_ccfg(nlp.meta.nvar, nlp.meta.ncon, x0, false, nlp.meta.ncon, nlp.meta.nvar, true, nlp.libname)
@test_approx_eq_eps cx c(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
cx = zeros(nlp.meta.ncon)
jl_ccfg!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, true, nlp.libname)
@test_approx_eq_eps cx c(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

cx, Jx = jl_ccfg(nlp, x0, false, nlp.meta.ncon, nlp.meta.nvar, true)
@test_approx_eq_eps cx c(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
cx = zeros(nlp.meta.ncon)
jl_ccfg!(nlp, x0, cx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, true)
@test_approx_eq_eps cx c(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

gx, Jx = jl_cgr(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.libname)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
gx = zeros(nlp.meta.nvar)
jl_cgr!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.libname)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

gx, Jx = jl_cgr(nlp, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
gx = zeros(nlp.meta.nvar)
jl_cgr!(nlp, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

cx, nnzj, Jx, j_var, j_fun = jl_ccfsg(nlp.meta.nvar, nlp.meta.ncon, x0, nlp.meta.nnzj+nlp.meta.nvar, true, nlp.libname)
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
nnzj = jl_ccfsg!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, nlp.meta.nnzj+nlp.meta.nvar, Jx, j_var, j_fun, true, nlp.libname)
@test_approx_eq_eps cx c(x0) 1e-8
j_val = copy(Jx)
Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
for k = 1:nnzj
  Jx[j_fun[k],j_var[k]] = j_val[k]
end
@test_approx_eq_eps Jx J(x0) 1e-8

cx, nnzj, Jx, j_var, j_fun = jl_ccfsg(nlp, x0, true)
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
nnzj = jl_ccfsg!(nlp, x0, cx, Jx, j_var, j_fun, true)
@test_approx_eq_eps cx c(x0) 1e-8
j_val = copy(Jx)
Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
for k = 1:nnzj
  Jx[j_fun[k],j_var[k]] = j_val[k]
end
@test_approx_eq_eps Jx J(x0) 1e-8

for j = 1:nlp.meta.ncon
  ci, gci = jl_ccifg(nlp.meta.nvar, j, x0, true, nlp.libname)
  @test_approx_eq_eps ci c(x0)[j] 1e-8
  @test_approx_eq_eps gci J(x0)[j,:] 1e-8
end

for j = 1:nlp.meta.ncon
  ci = jl_ccifg!(nlp.meta.nvar, j, x0, gci, true, nlp.libname)
  @test_approx_eq_eps ci c(x0)[j] 1e-8
end

for j = 1:nlp.meta.ncon
  ci, gci = jl_ccifg(nlp, j, x0, true)
  @test_approx_eq_eps ci c(x0)[j] 1e-8
  @test_approx_eq_eps gci J(x0)[j,:] 1e-8
end

for j = 1:nlp.meta.ncon
  ci = jl_ccifg!(nlp, j, x0, gci, true)
  @test_approx_eq_eps ci c(x0)[j] 1e-8
end

for j = 1:nlp.meta.ncon
  ci, nnzgci, gci_val, gci_var = jl_ccifsg(nlp.meta.nvar, j, x0, nlp.meta.nvar, true, nlp.libname)
  @test_approx_eq_eps ci c(x0)[j] 1e-8
  @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
end

for j = 1:nlp.meta.ncon
  gci_var = zeros(Int, nlp.meta.nvar)
  gci_val = zeros(nlp.meta.nvar)
  ci, nnzgci = jl_ccifsg!(nlp.meta.nvar, j, x0, nlp.meta.nvar, gci_val, gci_var, true, nlp.libname)
  @test_approx_eq_eps ci c(x0)[j] 1e-8
  @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
end

for j = 1:nlp.meta.ncon
  ci, nnzgci, gci_val, gci_var = jl_ccifsg(nlp, j, x0, nlp.meta.nvar, true)
  @test_approx_eq_eps ci c(x0)[j] 1e-8
  @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
end

for j = 1:nlp.meta.ncon
  gci_var = zeros(Int, nlp.meta.nvar)
  gci_val = zeros(nlp.meta.nvar)
  ci, nnzgci = jl_ccifsg!(nlp, j, x0, nlp.meta.nvar, gci_val, gci_var, true)
  @test_approx_eq_eps ci c(x0)[j] 1e-8
  @test_approx_eq_eps gci_val J(x0)[j,gci_var] 1e-8
end

gx, Jx, Wx = jl_cgrdh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.meta.nvar, nlp.libname)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8
@test_approx_eq_eps Wx W(x0,y0) 1e-8

Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
gx = zeros(nlp.meta.nvar)
jl_cgrdh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.meta.nvar, Wx, nlp.libname)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8
@test_approx_eq_eps Wx W(x0,y0) 1e-8

gx, Jx, Wx = jl_cgrdh(nlp, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.meta.nvar)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8
@test_approx_eq_eps Wx W(x0,y0) 1e-8

Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)
gx = zeros(nlp.meta.nvar)
jl_cgrdh!(nlp, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.meta.nvar, Wx)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8
@test_approx_eq_eps Wx W(x0,y0) 1e-8

Wx = jl_cdh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nvar, nlp.libname)
@test_approx_eq_eps Wx W(x0,y0) 1e-8

Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
jl_cdh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nvar, Wx, nlp.libname)
@test_approx_eq_eps Wx W(x0,y0) 1e-8

Wx = jl_cdh(nlp, x0, y0, nlp.meta.nvar)
@test_approx_eq_eps Wx W(x0,y0) 1e-8

Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
jl_cdh!(nlp, x0, y0, nlp.meta.nvar, Wx)
@test_approx_eq_eps Wx W(x0,y0) 1e-8

nnzh, Wx, h_row, h_col = jl_csh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, nlp.libname)
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
nnzh = jl_csh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
w_val = copy(Wx)
Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
for k = 1:nnzh
  Wx[h_row[k],h_col[k]] = w_val[k]
  Wx[h_col[k],h_row[k]] = w_val[k]
end
@test_approx_eq_eps Wx W(x0,y0) 1e-8

nnzh, Wx, h_row, h_col = jl_csh(nlp, x0, y0)
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
nnzh = jl_csh!(nlp, x0, y0, Wx, h_row, h_col)
w_val = copy(Wx)
Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
for k = 1:nnzh
  Wx[h_row[k],h_col[k]] = w_val[k]
  Wx[h_col[k],h_row[k]] = w_val[k]
end
@test_approx_eq_eps Wx W(x0,y0) 1e-8

nnzh, Wx, h_row, h_col = jl_cshc(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, nlp.libname)
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
nnzh = jl_cshc!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
w_val = copy(Wx)
Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
for k = 1:nnzh
  Wx[h_row[k],h_col[k]] = w_val[k]
  Wx[h_col[k],h_row[k]] = w_val[k]
end
@test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

nnzh, Wx, h_row, h_col = jl_cshc(nlp, x0, y0)
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
nnzh = jl_cshc!(nlp, x0, y0, Wx, h_row, h_col)
w_val = copy(Wx)
Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
for k = 1:nnzh
  Wx[h_row[k],h_col[k]] = w_val[k]
  Wx[h_col[k],h_row[k]] = w_val[k]
end
@test_approx_eq_eps Wx W(x0,y0)-H(x0) 1e-8

for j = 1:nlp.meta.ncon
  h = jl_cidh(nlp.meta.nvar, x0, j, nlp.meta.nvar, nlp.libname)
  @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0)) 1e-8
end

for j = 1:nlp.meta.ncon
  h = zeros(nlp.meta.nvar, nlp.meta.nvar)
  jl_cidh!(nlp.meta.nvar, x0, j, nlp.meta.nvar, h, nlp.libname)
  @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0)) 1e-8
end

for j = 1:nlp.meta.ncon
  h = jl_cidh(nlp, x0, j, nlp.meta.nvar)
  @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0)) 1e-8
end

for j = 1:nlp.meta.ncon
  h = zeros(nlp.meta.nvar, nlp.meta.nvar)
  jl_cidh!(nlp, x0, j, nlp.meta.nvar, h)
  @test_approx_eq_eps h (W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0)) 1e-8
end

for j = 1:nlp.meta.ncon
  nnzh, Wx, h_row, h_col = jl_cish(nlp.meta.nvar, x0, j, nlp.meta.nnzh, nlp.libname)
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
  nnzh = jl_cish!(nlp.meta.nvar, x0, j, nlp.meta.nnzh, Wx, h_row, h_col, nlp.libname)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0) 1e-8
end

for j = 1:nlp.meta.ncon
  nnzh, Wx, h_row, h_col = jl_cish(nlp, x0, j)
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
  nnzh = jl_cish!(nlp, x0, j, Wx, h_row, h_col)
  w_val = copy(Wx)
  Wx = zeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:nnzh
    Wx[h_row[k],h_col[k]] = w_val[k]
    Wx[h_col[k],h_row[k]] = w_val[k]
  end
  @test_approx_eq_eps Wx W(x0,[i == j ? 1.0 : 0.0 for i = 1:nlp.meta.ncon])-H(x0) 1e-8
end

result = jl_chprod(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), nlp.libname)
@test_approx_eq_eps result W(x0,y0)*v 1e-8

result = zeros(W(x0,y0)*v)
jl_chprod!(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), result, nlp.libname)

result = jl_chprod(nlp, false, x0, y0, ones(nlp.meta.nvar))
@test_approx_eq_eps result W(x0,y0)*v 1e-8

result = zeros(W(x0,y0)*v)
jl_chprod!(nlp, false, x0, y0, ones(nlp.meta.nvar), result)

result = jl_chcprod(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), nlp.libname)
@test_approx_eq_eps result (W(x0,y0)-H(x0))*v 1e-8

result = zeros((W(x0,y0)-H(x0))*v)
jl_chcprod!(nlp.meta.nvar, nlp.meta.ncon, false, x0, y0, ones(nlp.meta.nvar), result, nlp.libname)

result = jl_chcprod(nlp, false, x0, y0, ones(nlp.meta.nvar))
@test_approx_eq_eps result (W(x0,y0)-H(x0))*v 1e-8

result = zeros((W(x0,y0)-H(x0))*v)
jl_chcprod!(nlp, false, x0, y0, ones(nlp.meta.nvar), result)

result = jl_cjprod(nlp.meta.nvar, nlp.meta.ncon, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, nlp.meta.ncon, nlp.libname)
@test_approx_eq_eps result J(x0)*v 1e-8

result = zeros(J(x0)*v)
jl_cjprod!(nlp.meta.nvar, nlp.meta.ncon, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, result, nlp.meta.ncon, nlp.libname)

result = jl_cjprod(nlp, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, nlp.meta.ncon)
@test_approx_eq_eps result J(x0)*v 1e-8

result = zeros(J(x0)*v)
jl_cjprod!(nlp, false, false, x0, ones(nlp.meta.nvar), nlp.meta.nvar, result, nlp.meta.ncon)

