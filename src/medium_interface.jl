function jl_usetup(input, out, io_buffer, n; libname = fixedlibname)
  status = [int32(0)]
  x = Array(Float64, n)
  x_l = Array(Float64, n)
  x_u = Array(Float64, n)
  @eval CUTEst.usetup($(status), $([int32(input)]), $([int32(out)]), $([int32(io_buffer)]),
    $([int32(n)]), $(x), $(x_l), $(x_u), $(libname))
  return status[1], x, x_l, x_u
end

function jl_csetup(input, out, io_buffer, n, m; libname = fixedlibname)
  status = [int32(0)]
  x = Array(Float64, n)
  x_l = Array(Float64, n)
  x_u = Array(Float64, n)
  y = Array(Float64, m)
  c_l = Array(Float64, m)
  c_u = Array(Float64, m)
  @eval CUTEst.csetup($(status), $([int32(input)]), $([int32(out)]), $([int32(io_buffer)]),
    $([int32(n)]), $([int32(m)]), $(x), $(x_l), $(x_u), $(y), $(c_l),
    $(c_u), $(libname))
  return status[1], x, x_l, x_u, y, c_l, c_u
end

function jl_udimen(input; libname = fixedlibname)
  status = [int32(0)]
  n = [int32(0)]
  @eval CUTEst.udimen($(status), $([int32(input)]), $(n), $(libname))
  return status[1], n[1]
end

function jl_udimsh(libname = fixedlibname)
  status = [int32(0)]
  nnzh = [int32(0)]
  @eval CUTEst.udimsh($(status), $(nnzh), $(libname))
  return status[1], nnzh[1]
end

function jl_udimse(libname = fixedlibname)
  status = [int32(0)]
  ne = [int32(0)]
  he_val_ne = [int32(0)]
  he_row_ne = [int32(0)]
  @eval CUTEst.udimse($(status), $(ne), $(he_val_ne), $(he_row_ne), $(libname))
  return status[1], ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_uvartype(n; libname = fixedlibname)
  status = [int32(0)]
  x_type = Array(Int32, n)
  @eval CUTEst.uvartype($(status), $([int32(n)]), $(x_type), $(libname))
  return status[1], x_type
end

function jl_unames(n; libname = fixedlibname)
  status = [int32(0)]
  pname = [uint8(0)]
  vname = Array(Uint8, n)
  @eval CUTEst.unames($(status), $([int32(n)]), $(pname), $(vname), $(libname))
  return status[1], pname[1], vname
end

function jl_ureport(libname = fixedlibname)
  status = [int32(0)]
  calls = Array(Float64, 4)
  time = Array(Float64, 2)
  @eval CUTEst.ureport($(status), $(calls), $(time), $(libname))
  return status[1], calls, time
end

function jl_cdimen(input; libname = fixedlibname)
  status = [int32(0)]
  n = [int32(0)]
  m = [int32(0)]
  @eval CUTEst.cdimen($(status), $([int32(input)]), $(n), $(m), $(libname))
  return status[1], n[1], m[1]
end

function jl_cdimsj(libname = fixedlibname)
  status = [int32(0)]
  nnzj = [int32(0)]
  @eval CUTEst.cdimsj($(status), $(nnzj), $(libname))
  return status[1], nnzj[1]
end

function jl_cdimsh(libname = fixedlibname)
  status = [int32(0)]
  nnzh = [int32(0)]
  @eval CUTEst.cdimsh($(status), $(nnzh), $(libname))
  return status[1], nnzh[1]
end

function jl_cdimse(libname = fixedlibname)
  status = [int32(0)]
  ne = [int32(0)]
  he_val_ne = [int32(0)]
  he_row_ne = [int32(0)]
  @eval CUTEst.cdimse($(status), $(ne), $(he_val_ne), $(he_row_ne), $(libname))
  return status[1], ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_cstats(libname = fixedlibname)
  status = [int32(0)]
  nonlinear_variables_objective = [int32(0)]
  nonlinear_variables_constraints = [int32(0)]
  @eval CUTEst.cstats($(status), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(libname))
  return status[1], nonlinear_variables_objective[1], nonlinear_variables_constraints[1]
end

function jl_cvartype(n; libname = fixedlibname)
  status = [int32(0)]
  x_type = Array(Int32, n)
  @eval CUTEst.cvartype($(status), $([int32(n)]), $(x_type), $(libname))
  return status[1], x_type
end

function jl_cnames(n, m; libname = fixedlibname)
  status = [int32(0)]
  pname = [uint8(0)]
  vname = Array(Uint8, n)
  cname = Array(Uint8, m)
  @eval CUTEst.cnames($(status), $([int32(n)]), $([int32(m)]), $(pname), $(vname), $(cname), $(libname))
  return status[1], pname[1], vname, cname
end

function jl_creport(libname = fixedlibname)
  status = [int32(0)]
  calls = Array(Float64, 7)
  time = Array(Float64, 2)
  @eval CUTEst.creport($(status), $(calls), $(time), $(libname))
  return status[1], calls, time
end

function jl_connames(m; libname = fixedlibname)
  status = [int32(0)]
  cname = Array(Uint8, m)
  @eval CUTEst.connames($(status), $([int32(m)]), $(cname), $(libname))
  return status[1], cname
end

function jl_pname(input; libname = fixedlibname)
  status = [int32(0)]
  pname = [uint8(0)]
  @eval CUTEst.pname($(status), $([int32(input)]), $(pname), $(libname))
  return status[1], pname[1]
end

function jl_probname(libname = fixedlibname)
  status = [int32(0)]
  pname = [uint8(0)]
  @eval CUTEst.probname($(status), $(pname), $(libname))
  return status[1], pname[1]
end

function jl_varnames(n; libname = fixedlibname)
  status = [int32(0)]
  vname = Array(Uint8, n)
  @eval CUTEst.varnames($(status), $([int32(n)]), $(vname), $(libname))
  return status[1], vname
end

function jl_ufn(n, x; libname = fixedlibname)
  status = [int32(0)]
  f = [float64(0)]
  @eval CUTEst.ufn($(status), $([int32(n)]), $(x), $(f), $(libname))
  return status[1], f[1]
end

function jl_ugr(n, x; libname = fixedlibname)
  status = [int32(0)]
  g = Array(Float64, n)
  @eval CUTEst.ugr($(status), $([int32(n)]), $(x), $(g), $(libname))
  return status[1], g
end

function jl_uofg(n, x, grad; libname = fixedlibname)
  status = [int32(0)]
  f = [float64(0)]
  g = Array(Float64, n)
  @eval CUTEst.uofg($(status), $([int32(n)]), $(x), $(f), $(g), $([int32(grad)]), $(libname))
  return status[1], f[1], g
end

function jl_ubandh(n, x, semibandwidth, lbandh; libname = fixedlibname)
  status = [int32(0)]
  h_band = Array(Float64, lbandh - 0 + 1, n)
  max_semibandwidth = [int32(0)]
  @eval CUTEst.ubandh($(status), $([int32(n)]), $(x), $([int32(semibandwidth)]), $(h_band),
    $([int32(lbandh)]), $(max_semibandwidth), $(libname))
  return status[1], h_band, max_semibandwidth[1]
end

function jl_udh(n, x, lh1; libname = fixedlibname)
  status = [int32(0)]
  h = Array(Float64, lh1, n)
  @eval CUTEst.udh($(status), $([int32(n)]), $(x), $([int32(lh1)]), $(h), $(libname))
  return status[1], h
end

function jl_ush(n, x, lh; libname = fixedlibname)
  status = [int32(0)]
  nnzh = [int32(0)]
  h_val = Array(Float64, lh)
  h_row = Array(Int32, lh)
  h_col = Array(Int32, lh)
  @eval CUTEst.ush($(status), $([int32(n)]), $(x), $(nnzh), $([int32(lh)]), $(h_val),
    $(h_row), $(h_col), $(libname))
  return status[1], nnzh[1], h_val, h_row, h_col
end

function jl_ueh(n, x, lhe_ptr; libname = fixedlibname)
  status = [int32(0)]
  ne = [int32(0)]
  he_row_ptr = Array(Int32, lhe_ptr)
  he_val_ptr = Array(Int32, lhe_ptr)
  @eval CUTEst.ueh($(status), $([int32(n)]), $(x), $(ne), $([int32(lhe_ptr)]),
    $(he_row_ptr), $(he_val_ptr), $(libname))
  return status[1], ne[1], he_row_ptr, he_val_ptr
end

function jl_ugrdh(n, x, lh1; libname = fixedlibname)
  status = [int32(0)]
  g = Array(Float64, n)
  h = Array(Float64, lh1, n)
  @eval CUTEst.ugrdh($(status), $([int32(n)]), $(x), $(g), $([int32(lh1)]), $(h), $(libname))
  return status[1], g, h
end

function jl_ugrsh(n, x, lh; libname = fixedlibname)
  status = [int32(0)]
  g = Array(Float64, n)
  nnzh = [int32(0)]
  h_val = Array(Float64, lh)
  h_row = Array(Int32, lh)
  h_col = Array(Int32, lh)
  @eval CUTEst.ugrsh($(status), $([int32(n)]), $(x), $(g), $(nnzh), $([int32(lh)]),
    $(h_val), $(h_row), $(h_col), $(libname))
  return status[1], g, nnzh[1], h_val, h_row, h_col
end

function jl_ugreh(n, x, lhe_ptr, lhe_row; libname = fixedlibname)
  status = [int32(0)]
  g = Array(Float64, n)
  ne = [int32(0)]
  he_row_ptr = Array(Int32, lhe_ptr)
  he_val_ptr = Array(Int32, lhe_ptr)
  @eval CUTEst.ugreh($(status), $([int32(n)]), $(x), $(g), $(ne), $([int32(lhe_ptr)]),
    $(he_row_ptr), $(he_val_ptr), $([int32(lhe_row)]), $(libname))
  return status[1], g, ne[1], he_row_ptr, he_val_ptr
end

function jl_uhprod(n, goth, x, vector; libname = fixedlibname)
  status = [int32(0)]
  result = Array(Float64, n)
  @eval CUTEst.uhprod($(status), $([int32(n)]), $([int32(goth)]), $(x), $(vector), $(result), $(libname))
  return status[1], result
end

function jl_cfn(n, m, x; libname = fixedlibname)
  status = [int32(0)]
  f = [float64(0)]
  c = Array(Float64, m)
  @eval CUTEst.cfn($(status), $([int32(n)]), $([int32(m)]), $(x), $(f), $(c), $(libname))
  return status[1], f[1], c
end

function jl_cofg(n, x, grad; libname = fixedlibname)
  status = [int32(0)]
  f = [float64(0)]
  g = Array(Float64, n)
  @eval CUTEst.cofg($(status), $([int32(n)]), $(x), $(f), $(g), $([int32(grad)]), $(libname))
  return status[1], f[1], g
end

function jl_cofsg(n, x, lg, grad; libname = fixedlibname)
  status = [int32(0)]
  f = [float64(0)]
  nnzg = [int32(0)]
  g_val = Array(Float64, lg)
  g_var = Array(Int32, lg)
  @eval CUTEst.cofsg($(status), $([int32(n)]), $(x), $(f), $(nnzg), $([int32(lg)]),
    $(g_val), $(g_var), $([int32(grad)]), $(libname))
  return status[1], f[1], nnzg[1], g_val, g_var
end

function jl_ccfg(n, m, x, jtrans, lcjac1, lcjac2, grad; libname = fixedlibname)
  status = [int32(0)]
  c = Array(Float64, m)
  cjac = Array(Float64, lcjac1, lcjac2)
  @eval CUTEst.ccfg($(status), $([int32(n)]), $([int32(m)]), $(x), $(c),
    $([int32(jtrans)]), $([int32(lcjac1)]), $([int32(lcjac2)]), $(cjac),
    $([int32(grad)]), $(libname))
  return status[1], c, cjac
end

function jl_clfg(n, m, x, y, grad; libname = fixedlibname)
  status = [int32(0)]
  f = [float64(0)]
  g = Array(Float64, n)
  @eval CUTEst.clfg($(status), $([int32(n)]), $([int32(m)]), $(x), $(y), $(f), $(g),
    $([int32(grad)]), $(libname))
  return status[1], f[1], g
end

function jl_cgr(n, m, x, y, grlagf, jtrans, lj1, lj2; libname = fixedlibname)
  status = [int32(0)]
  g = Array(Float64, n)
  j_val = Array(Float64, lj1, lj2)
  @eval CUTEst.cgr($(status), $([int32(n)]), $([int32(m)]), $(x), $(y),
    $([int32(grlagf)]), $(g), $([int32(jtrans)]), $([int32(lj1)]),
    $([int32(lj2)]), $(j_val), $(libname))
  return status[1], g, j_val
end

function jl_csgr(n, m, x, y, grlagf, lj; libname = fixedlibname)
  status = [int32(0)]
  nnzj = [int32(0)]
  j_val = Array(Float64, lj)
  j_var = Array(Int32, lj)
  j_fun = Array(Int32, lj)
  @eval CUTEst.csgr($(status), $([int32(n)]), $([int32(m)]), $(x), $(y),
    $([int32(grlagf)]), $(nnzj), $([int32(lj)]), $(j_val), $(j_var),
    $(j_fun), $(libname))
  return status[1], nnzj[1], j_val, j_var, j_fun
end

function jl_ccfsg(n, m, x, lj, grad; libname = fixedlibname)
  status = [int32(0)]
  c = Array(Float64, m)
  nnzj = [int32(0)]
  j_val = Array(Float64, lj)
  j_var = Array(Int32, lj)
  j_fun = Array(Int32, lj)
  @eval CUTEst.ccfsg($(status), $([int32(n)]), $([int32(m)]), $(x), $(c), $(nnzj),
    $([int32(lj)]), $(j_val), $(j_var), $(j_fun), $([int32(grad)]), $(libname))
  return status[1], c, nnzj[1], j_val, j_var, j_fun
end

function jl_ccifg(n, icon, x, grad; libname = fixedlibname)
  status = [int32(0)]
  ci = [float64(0)]
  gci = Array(Float64, n)
  @eval CUTEst.ccifg($(status), $([int32(n)]), $([int32(icon)]), $(x), $(ci), $(gci),
    $([int32(grad)]), $(libname))
  return status[1], ci[1], gci
end

function jl_ccifsg(n, icon, x, lgci, grad; libname = fixedlibname)
  status = [int32(0)]
  ci = [float64(0)]
  nnzgci = [int32(0)]
  gci_val = Array(Float64, lgci)
  gci_var = Array(Int32, lgci)
  @eval CUTEst.ccifsg($(status), $([int32(n)]), $([int32(icon)]), $(x), $(ci), $(nnzgci),
    $([int32(lgci)]), $(gci_val), $(gci_var), $([int32(grad)]), $(libname))
  return status[1], ci[1], nnzgci[1], gci_val, gci_var
end

function jl_cgrdh(n, m, x, y, grlagf, jtrans, lj1, lj2, lh1; libname = fixedlibname)
  status = [int32(0)]
  g = Array(Float64, n)
  j_val = Array(Float64, lj1, lj2)
  h_val = Array(Float64, lh1, n)
  @eval CUTEst.cgrdh($(status), $([int32(n)]), $([int32(m)]), $(x), $(y),
    $([int32(grlagf)]), $(g), $([int32(jtrans)]), $([int32(lj1)]),
    $([int32(lj2)]), $(j_val), $([int32(lh1)]), $(h_val), $(libname))
  return status[1], g, j_val, h_val
end

function jl_cdh(n, m, x, y, lh1; libname = fixedlibname)
  status = [int32(0)]
  h_val = Array(Float64, lh1, n)
  @eval CUTEst.cdh($(status), $([int32(n)]), $([int32(m)]), $(x), $(y), $([int32(lh1)]),
    $(h_val), $(libname))
  return status[1], h_val
end

function jl_csh(n, m, x, y, lh; libname = fixedlibname)
  status = [int32(0)]
  nnzh = [int32(0)]
  h_val = Array(Float64, lh)
  h_row = Array(Int32, lh)
  h_col = Array(Int32, lh)
  @eval CUTEst.csh($(status), $([int32(n)]), $([int32(m)]), $(x), $(y), $(nnzh),
    $([int32(lh)]), $(h_val), $(h_row), $(h_col), $(libname))
  return status[1], nnzh[1], h_val, h_row, h_col
end

function jl_cshc(n, m, x, y, lh; libname = fixedlibname)
  status = [int32(0)]
  nnzh = [int32(0)]
  h_val = Array(Float64, lh)
  h_row = Array(Int32, lh)
  h_col = Array(Int32, lh)
  @eval CUTEst.cshc($(status), $([int32(n)]), $([int32(m)]), $(x), $(y), $(nnzh),
    $([int32(lh)]), $(h_val), $(h_row), $(h_col), $(libname))
  return status[1], nnzh[1], h_val, h_row, h_col
end

function jl_ceh(n, m, x, y, lhe_ptr; libname = fixedlibname)
  status = [int32(0)]
  ne = [int32(0)]
  he_row_ptr = Array(Int32, lhe_ptr)
  he_val_ptr = Array(Int32, lhe_ptr)
  @eval CUTEst.ceh($(status), $([int32(n)]), $([int32(m)]), $(x), $(y), $(ne),
    $([int32(lhe_ptr)]), $(he_row_ptr), $(he_val_ptr), $(libname))
  return status[1], ne[1], he_row_ptr, he_val_ptr
end

function jl_cidh(n, x, iprob, lh1; libname = fixedlibname)
  status = [int32(0)]
  h = Array(Float64, lh1, n)
  @eval CUTEst.cidh($(status), $([int32(n)]), $(x), $([int32(iprob)]), $([int32(lh1)]),
    $(h), $(libname))
  return status[1], h
end

function jl_cish(n, x, iprob, lh; libname = fixedlibname)
  status = [int32(0)]
  nnzh = [int32(0)]
  h_val = Array(Float64, lh)
  h_row = Array(Int32, lh)
  h_col = Array(Int32, lh)
  @eval CUTEst.cish($(status), $([int32(n)]), $(x), $([int32(iprob)]), $(nnzh),
    $([int32(lh)]), $(h_val), $(h_row), $(h_col), $(libname))
  return status[1], nnzh[1], h_val, h_row, h_col
end

function jl_csgrsh(n, m, x, y, grlagf, lj; libname = fixedlibname)
  status = [int32(0)]
  nnzj = [int32(0)]
  j_val = Array(Float64, lj)
  j_var = Array(Int32, lj)
  j_fun = Array(Int32, lj)
  @eval CUTEst.csgrsh($(status), $([int32(n)]), $([int32(m)]), $(x), $(y),
    $([int32(grlagf)]), $(nnzj), $([int32(lj)]), $(j_val), $(j_var),
    $(j_fun), $(libname))
  return status[1], nnzj[1], j_val, j_var, j_fun
end

function jl_csgreh(n, m, x, y, grlagf, lj; libname = fixedlibname)
  status = [int32(0)]
  nnzj = [int32(0)]
  j_val = Array(Float64, lj)
  j_var = Array(Int32, lj)
  j_fun = Array(Int32, lj)
  ne = [int32(0)]
  @eval CUTEst.csgreh($(status), $([int32(n)]), $([int32(m)]), $(x), $(y),
    $([int32(grlagf)]), $(nnzj), $([int32(lj)]), $(j_val), $(j_var),
    $(j_fun), $(ne), $(libname))
  return status[1], nnzj[1], j_val, j_var, j_fun, ne[1]
end

function jl_chprod(n, m, goth, x, y, vector; libname = fixedlibname)
  status = [int32(0)]
  result = Array(Float64, n)
  @eval CUTEst.chprod($(status), $([int32(n)]), $([int32(m)]), $([int32(goth)]), $(x), $(y),
    $(vector), $(result), $(libname))
  return status[1], result
end

function jl_chcprod(n, m, goth, x, y, vector; libname = fixedlibname)
  status = [int32(0)]
  result = Array(Float64, n)
  @eval CUTEst.chcprod($(status), $([int32(n)]), $([int32(m)]), $([int32(goth)]), $(x), $(y),
    $(vector), $(result), $(libname))
  return status[1], result
end

function jl_cjprod(n, m, gotj, jtrans, x, vector, lvector, lresult; libname = fixedlibname)
  status = [int32(0)]
  result = Array(Float64, lresult)
  @eval CUTEst.cjprod($(status), $([int32(n)]), $([int32(m)]), $([int32(gotj)]),
    $([int32(jtrans)]), $(x), $(vector), $([int32(lvector)]), $(result),
    $([int32(lresult)]), $(libname))
  return status[1], result
end

function jl_uterminate(libname = fixedlibname)
  status = [int32(0)]
  @eval CUTEst.uterminate($(status), $(libname))
  return status[1]
end

function jl_cterminate(libname = fixedlibname)
  status = [int32(0)]
  @eval CUTEst.cterminate($(status), $(libname))
  return status[1]
end

