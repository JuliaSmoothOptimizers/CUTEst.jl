function jl_usetup(input, out, io_buffer, n; libname = fixedlibname)
  io_err = [int32(0)]
  x = Array(Float64, n)
  x_l = Array(Float64, n)
  x_u = Array(Float64, n)
  @eval CUTEst.usetup($(io_err), $([int32(input)]), $([int32(out)]), $([int32(io_buffer)]),
    $([int32(n)]), $(x), $(x_l), $(x_u), $(libname))
  @cutest_error
  return x, x_l, x_u
end

function jl_csetup(input, out, io_buffer, n, m; libname = fixedlibname)
  io_err = [int32(0)]
  x = Array(Float64, n)
  x_l = Array(Float64, n)
  x_u = Array(Float64, n)
  y = Array(Float64, m)
  c_l = Array(Float64, m)
  c_u = Array(Float64, m)
  @eval CUTEst.csetup($(io_err), $([int32(input)]), $([int32(out)]), $([int32(io_buffer)]),
    $([int32(n)]), $([int32(m)]), $(x), $(x_l), $(x_u), $(y), $(c_l),
    $(c_u), $(libname))
  @cutest_error
  return x, x_l, x_u, y, c_l, c_u
end

function jl_udimen(input; libname = fixedlibname)
  io_err = [int32(0)]
  n = [int32(0)]
  @eval CUTEst.udimen($(io_err), $([int32(input)]), $(n), $(libname))
  @cutest_error
  return n[1]
end

function jl_udimsh(libname = fixedlibname)
  io_err = [int32(0)]
  nnzh = [int32(0)]
  @eval CUTEst.udimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_udimse(libname = fixedlibname)
  io_err = [int32(0)]
  ne = [int32(0)]
  he_val_ne = [int32(0)]
  he_row_ne = [int32(0)]
  @eval CUTEst.udimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne), $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_uvartype(n; libname = fixedlibname)
  io_err = [int32(0)]
  x_type = Array(Int32, n)
  @eval CUTEst.uvartype($(io_err), $([int32(n)]), $(x_type), $(libname))
  @cutest_error
  return x_type
end

function jl_unames(n; libname = fixedlibname)
  io_err = [int32(0)]
  pname = [uint8(0)]
  vname = Array(Uint8, n)
  @eval CUTEst.unames($(io_err), $([int32(n)]), $(pname), $(vname), $(libname))
  @cutest_error
  return pname[1], vname
end

function jl_ureport(libname = fixedlibname)
  io_err = [int32(0)]
  calls = Array(Float64, 4)
  time = Array(Float64, 2)
  @eval CUTEst.ureport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return calls, time
end

function jl_cdimen(input; libname = fixedlibname)
  io_err = [int32(0)]
  n = [int32(0)]
  m = [int32(0)]
  @eval CUTEst.cdimen($(io_err), $([int32(input)]), $(n), $(m), $(libname))
  @cutest_error
  return n[1], m[1]
end

function jl_cdimsj(libname = fixedlibname)
  io_err = [int32(0)]
  nnzj = [int32(0)]
  @eval CUTEst.cdimsj($(io_err), $(nnzj), $(libname))
  @cutest_error
  return nnzj[1]
end

function jl_cdimsh(libname = fixedlibname)
  io_err = [int32(0)]
  nnzh = [int32(0)]
  @eval CUTEst.cdimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_cdimse(libname = fixedlibname)
  io_err = [int32(0)]
  ne = [int32(0)]
  he_val_ne = [int32(0)]
  he_row_ne = [int32(0)]
  @eval CUTEst.cdimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne), $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_cstats(libname = fixedlibname)
  io_err = [int32(0)]
  nonlinear_variables_objective = [int32(0)]
  nonlinear_variables_constraints = [int32(0)]
  @eval CUTEst.cstats($(io_err), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(libname))
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1]
end

function jl_cvartype(n; libname = fixedlibname)
  io_err = [int32(0)]
  x_type = Array(Int32, n)
  @eval CUTEst.cvartype($(io_err), $([int32(n)]), $(x_type), $(libname))
  @cutest_error
  return x_type
end

function jl_cnames(n, m; libname = fixedlibname)
  io_err = [int32(0)]
  pname = [uint8(0)]
  vname = Array(Uint8, n)
  cname = Array(Uint8, m)
  @eval CUTEst.cnames($(io_err), $([int32(n)]), $([int32(m)]), $(pname), $(vname), $(cname), $(libname))
  @cutest_error
  return pname[1], vname, cname
end

function jl_creport(libname = fixedlibname)
  io_err = [int32(0)]
  calls = Array(Float64, 7)
  time = Array(Float64, 2)
  @eval CUTEst.creport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return calls, time
end

function jl_connames(m; libname = fixedlibname)
  io_err = [int32(0)]
  cname = Array(Uint8, m)
  @eval CUTEst.connames($(io_err), $([int32(m)]), $(cname), $(libname))
  @cutest_error
  return cname
end

function jl_pname(input; libname = fixedlibname)
  io_err = [int32(0)]
  pname = [uint8(0)]
  @eval CUTEst.pname($(io_err), $([int32(input)]), $(pname), $(libname))
  @cutest_error
  return pname[1]
end

function jl_probname(libname = fixedlibname)
  io_err = [int32(0)]
  pname = [uint8(0)]
  @eval CUTEst.probname($(io_err), $(pname), $(libname))
  @cutest_error
  return pname[1]
end

function jl_varnames(n; libname = fixedlibname)
  io_err = [int32(0)]
  vname = Array(Uint8, n)
  @eval CUTEst.varnames($(io_err), $([int32(n)]), $(vname), $(libname))
  @cutest_error
  return vname
end

function jl_ufn(n, x; libname = fixedlibname)
  io_err = [int32(0)]
  f = [float64(0)]
  @eval CUTEst.ufn($(io_err), $([int32(n)]), $(x), $(f), $(libname))
  @cutest_error
  return f[1]
end

function jl_ugr(n, x; libname = fixedlibname)
  io_err = [int32(0)]
  g = Array(Float64, n)
  @eval CUTEst.ugr($(io_err), $([int32(n)]), $(x), $(g), $(libname))
  @cutest_error
  return g
end

function jl_uofg(n, x, grad; libname = fixedlibname)
  io_err = [int32(0)]
  f = [float64(0)]
  g = Array(Float64, n)
  @eval CUTEst.uofg($(io_err), $([int32(n)]), $(x), $(f), $(g), $([int32(grad)]), $(libname))
  @cutest_error
  return f[1], g
end

function jl_ubandh(n, x, semibandwidth, lbandh; libname = fixedlibname)
  io_err = [int32(0)]
  h_band = Array(Float64, lbandh - 0 + 1, n)
  max_semibandwidth = [int32(0)]
  @eval CUTEst.ubandh($(io_err), $([int32(n)]), $(x), $([int32(semibandwidth)]), $(h_band),
    $([int32(lbandh)]), $(max_semibandwidth), $(libname))
  @cutest_error
  return h_band, max_semibandwidth[1]
end

function jl_udh(n, x, lh1; libname = fixedlibname)
  io_err = [int32(0)]
  h = Array(Float64, lh1, n)
  @eval CUTEst.udh($(io_err), $([int32(n)]), $(x), $([int32(lh1)]), $(h), $(libname))
  @cutest_error
  return h
end

function jl_ush(n, x, lh; libname = fixedlibname)
  io_err = [int32(0)]
  nnzh = [int32(0)]
  h_val = Array(Float64, lh)
  h_row = Array(Int32, lh)
  h_col = Array(Int32, lh)
  @eval CUTEst.ush($(io_err), $([int32(n)]), $(x), $(nnzh), $([int32(lh)]), $(h_val),
    $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_ueh(n, x, lhe_ptr; libname = fixedlibname)
  io_err = [int32(0)]
  ne = [int32(0)]
  he_row_ptr = Array(Int32, lhe_ptr)
  he_val_ptr = Array(Int32, lhe_ptr)
  @eval CUTEst.ueh($(io_err), $([int32(n)]), $(x), $(ne), $([int32(lhe_ptr)]),
    $(he_row_ptr), $(he_val_ptr), $(libname))
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr
end

function jl_ugrdh(n, x, lh1; libname = fixedlibname)
  io_err = [int32(0)]
  g = Array(Float64, n)
  h = Array(Float64, lh1, n)
  @eval CUTEst.ugrdh($(io_err), $([int32(n)]), $(x), $(g), $([int32(lh1)]), $(h), $(libname))
  @cutest_error
  return g, h
end

function jl_ugrsh(n, x, lh; libname = fixedlibname)
  io_err = [int32(0)]
  g = Array(Float64, n)
  nnzh = [int32(0)]
  h_val = Array(Float64, lh)
  h_row = Array(Int32, lh)
  h_col = Array(Int32, lh)
  @eval CUTEst.ugrsh($(io_err), $([int32(n)]), $(x), $(g), $(nnzh), $([int32(lh)]),
    $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return g, nnzh[1], h_val, h_row, h_col
end

function jl_ugreh(n, x, lhe_ptr, lhe_row; libname = fixedlibname)
  io_err = [int32(0)]
  g = Array(Float64, n)
  ne = [int32(0)]
  he_row_ptr = Array(Int32, lhe_ptr)
  he_val_ptr = Array(Int32, lhe_ptr)
  @eval CUTEst.ugreh($(io_err), $([int32(n)]), $(x), $(g), $(ne), $([int32(lhe_ptr)]),
    $(he_row_ptr), $(he_val_ptr), $([int32(lhe_row)]), $(libname))
  @cutest_error
  return g, ne[1], he_row_ptr, he_val_ptr
end

function jl_uhprod(n, goth, x, vector; libname = fixedlibname)
  io_err = [int32(0)]
  result = Array(Float64, n)
  @eval CUTEst.uhprod($(io_err), $([int32(n)]), $([int32(goth)]), $(x), $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function jl_cfn(n, m, x; libname = fixedlibname)
  io_err = [int32(0)]
  f = [float64(0)]
  c = Array(Float64, m)
  @eval CUTEst.cfn($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(f), $(c), $(libname))
  @cutest_error
  return f[1], c
end

function jl_cofg(n, x, grad; libname = fixedlibname)
  io_err = [int32(0)]
  f = [float64(0)]
  g = Array(Float64, n)
  @eval CUTEst.cofg($(io_err), $([int32(n)]), $(x), $(f), $(g), $([int32(grad)]), $(libname))
  @cutest_error
  return f[1], g
end

function jl_cofsg(n, x, lg, grad; libname = fixedlibname)
  io_err = [int32(0)]
  f = [float64(0)]
  nnzg = [int32(0)]
  g_val = Array(Float64, lg)
  g_var = Array(Int32, lg)
  @eval CUTEst.cofsg($(io_err), $([int32(n)]), $(x), $(f), $(nnzg), $([int32(lg)]),
    $(g_val), $(g_var), $([int32(grad)]), $(libname))
  @cutest_error
  return f[1], nnzg[1], g_val, g_var
end

function jl_ccfg(n, m, x, jtrans, lcjac1, lcjac2, grad; libname = fixedlibname)
  io_err = [int32(0)]
  c = Array(Float64, m)
  cjac = Array(Float64, lcjac1, lcjac2)
  @eval CUTEst.ccfg($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(c),
    $([int32(jtrans)]), $([int32(lcjac1)]), $([int32(lcjac2)]), $(cjac),
    $([int32(grad)]), $(libname))
  @cutest_error
  return c, cjac
end

function jl_clfg(n, m, x, y, grad; libname = fixedlibname)
  io_err = [int32(0)]
  f = [float64(0)]
  g = Array(Float64, n)
  @eval CUTEst.clfg($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(y), $(f), $(g),
    $([int32(grad)]), $(libname))
  @cutest_error
  return f[1], g
end

function jl_cgr(n, m, x, y, grlagf, jtrans, lj1, lj2; libname = fixedlibname)
  io_err = [int32(0)]
  g = Array(Float64, n)
  j_val = Array(Float64, lj1, lj2)
  @eval CUTEst.cgr($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(y),
    $([int32(grlagf)]), $(g), $([int32(jtrans)]), $([int32(lj1)]),
    $([int32(lj2)]), $(j_val), $(libname))
  @cutest_error
  return g, j_val
end

function jl_csgr(n, m, x, y, grlagf, lj; libname = fixedlibname)
  io_err = [int32(0)]
  nnzj = [int32(0)]
  j_val = Array(Float64, lj)
  j_var = Array(Int32, lj)
  j_fun = Array(Int32, lj)
  @eval CUTEst.csgr($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(y),
    $([int32(grlagf)]), $(nnzj), $([int32(lj)]), $(j_val), $(j_var),
    $(j_fun), $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

function jl_ccfsg(n, m, x, lj, grad; libname = fixedlibname)
  io_err = [int32(0)]
  c = Array(Float64, m)
  nnzj = [int32(0)]
  j_val = Array(Float64, lj)
  j_var = Array(Int32, lj)
  j_fun = Array(Int32, lj)
  @eval CUTEst.ccfsg($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(c), $(nnzj),
    $([int32(lj)]), $(j_val), $(j_var), $(j_fun), $([int32(grad)]), $(libname))
  @cutest_error
  return c, nnzj[1], j_val, j_var, j_fun
end

function jl_ccifg(n, icon, x, grad; libname = fixedlibname)
  io_err = [int32(0)]
  ci = [float64(0)]
  gci = Array(Float64, n)
  @eval CUTEst.ccifg($(io_err), $([int32(n)]), $([int32(icon)]), $(x), $(ci), $(gci),
    $([int32(grad)]), $(libname))
  @cutest_error
  return ci[1], gci
end

function jl_ccifsg(n, icon, x, lgci, grad; libname = fixedlibname)
  io_err = [int32(0)]
  ci = [float64(0)]
  nnzgci = [int32(0)]
  gci_val = Array(Float64, lgci)
  gci_var = Array(Int32, lgci)
  @eval CUTEst.ccifsg($(io_err), $([int32(n)]), $([int32(icon)]), $(x), $(ci), $(nnzgci),
    $([int32(lgci)]), $(gci_val), $(gci_var), $([int32(grad)]), $(libname))
  @cutest_error
  return ci[1], nnzgci[1], gci_val, gci_var
end

function jl_cgrdh(n, m, x, y, grlagf, jtrans, lj1, lj2, lh1; libname = fixedlibname)
  io_err = [int32(0)]
  g = Array(Float64, n)
  j_val = Array(Float64, lj1, lj2)
  h_val = Array(Float64, lh1, n)
  @eval CUTEst.cgrdh($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(y),
    $([int32(grlagf)]), $(g), $([int32(jtrans)]), $([int32(lj1)]),
    $([int32(lj2)]), $(j_val), $([int32(lh1)]), $(h_val), $(libname))
  @cutest_error
  return g, j_val, h_val
end

function jl_cdh(n, m, x, y, lh1; libname = fixedlibname)
  io_err = [int32(0)]
  h_val = Array(Float64, lh1, n)
  @eval CUTEst.cdh($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(y), $([int32(lh1)]),
    $(h_val), $(libname))
  @cutest_error
  return h_val
end

function jl_csh(n, m, x, y, lh; libname = fixedlibname)
  io_err = [int32(0)]
  nnzh = [int32(0)]
  h_val = Array(Float64, lh)
  h_row = Array(Int32, lh)
  h_col = Array(Int32, lh)
  @eval CUTEst.csh($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(y), $(nnzh),
    $([int32(lh)]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_cshc(n, m, x, y, lh; libname = fixedlibname)
  io_err = [int32(0)]
  nnzh = [int32(0)]
  h_val = Array(Float64, lh)
  h_row = Array(Int32, lh)
  h_col = Array(Int32, lh)
  @eval CUTEst.cshc($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(y), $(nnzh),
    $([int32(lh)]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_ceh(n, m, x, y, lhe_ptr; libname = fixedlibname)
  io_err = [int32(0)]
  ne = [int32(0)]
  he_row_ptr = Array(Int32, lhe_ptr)
  he_val_ptr = Array(Int32, lhe_ptr)
  @eval CUTEst.ceh($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(y), $(ne),
    $([int32(lhe_ptr)]), $(he_row_ptr), $(he_val_ptr), $(libname))
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr
end

function jl_cidh(n, x, iprob, lh1; libname = fixedlibname)
  io_err = [int32(0)]
  h = Array(Float64, lh1, n)
  @eval CUTEst.cidh($(io_err), $([int32(n)]), $(x), $([int32(iprob)]), $([int32(lh1)]),
    $(h), $(libname))
  @cutest_error
  return h
end

function jl_cish(n, x, iprob, lh; libname = fixedlibname)
  io_err = [int32(0)]
  nnzh = [int32(0)]
  h_val = Array(Float64, lh)
  h_row = Array(Int32, lh)
  h_col = Array(Int32, lh)
  @eval CUTEst.cish($(io_err), $([int32(n)]), $(x), $([int32(iprob)]), $(nnzh),
    $([int32(lh)]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_csgrsh(n, m, x, y, grlagf, lj; libname = fixedlibname)
  io_err = [int32(0)]
  nnzj = [int32(0)]
  j_val = Array(Float64, lj)
  j_var = Array(Int32, lj)
  j_fun = Array(Int32, lj)
  @eval CUTEst.csgrsh($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(y),
    $([int32(grlagf)]), $(nnzj), $([int32(lj)]), $(j_val), $(j_var),
    $(j_fun), $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

function jl_csgreh(n, m, x, y, grlagf, lj; libname = fixedlibname)
  io_err = [int32(0)]
  nnzj = [int32(0)]
  j_val = Array(Float64, lj)
  j_var = Array(Int32, lj)
  j_fun = Array(Int32, lj)
  ne = [int32(0)]
  @eval CUTEst.csgreh($(io_err), $([int32(n)]), $([int32(m)]), $(x), $(y),
    $([int32(grlagf)]), $(nnzj), $([int32(lj)]), $(j_val), $(j_var),
    $(j_fun), $(ne), $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, ne[1]
end

function jl_chprod(n, m, goth, x, y, vector; libname = fixedlibname)
  io_err = [int32(0)]
  result = Array(Float64, n)
  @eval CUTEst.chprod($(io_err), $([int32(n)]), $([int32(m)]), $([int32(goth)]), $(x), $(y),
    $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function jl_chcprod(n, m, goth, x, y, vector; libname = fixedlibname)
  io_err = [int32(0)]
  result = Array(Float64, n)
  @eval CUTEst.chcprod($(io_err), $([int32(n)]), $([int32(m)]), $([int32(goth)]), $(x), $(y),
    $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function jl_cjprod(n, m, gotj, jtrans, x, vector, lvector, lresult; libname = fixedlibname)
  io_err = [int32(0)]
  result = Array(Float64, lresult)
  @eval CUTEst.cjprod($(io_err), $([int32(n)]), $([int32(m)]), $([int32(gotj)]),
    $([int32(jtrans)]), $(x), $(vector), $([int32(lvector)]), $(result),
    $([int32(lresult)]), $(libname))
  @cutest_error
  return result
end

function jl_uterminate(libname = fixedlibname)
  io_err = [int32(0)]
  @eval CUTEst.uterminate($(io_err), $(libname))
  @cutest_error
end

function jl_cterminate(libname = fixedlibname)
  io_err = [int32(0)]
  @eval CUTEst.cterminate($(io_err), $(libname))
  @cutest_error
end

