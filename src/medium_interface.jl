function jl_usetup(input::Integer, out::Integer, io_buffer::Integer, n::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  x = Array(Cdouble, n)
  x_l = Array(Cdouble, n)
  x_u = Array(Cdouble, n)
  @eval CUTEst.usetup($(io_err), $([cint(input)]), $([cint(out)]), $([cint(io_buffer)]),
    $([cint(n)]), $(x), $(x_l), $(x_u), $(libname))
  @cutest_error
  return x, x_l, x_u
end

function jl_csetup(input::Integer, out::Integer, io_buffer::Integer, n::Integer,
    m::Integer, e_order::Integer, l_order::Integer, v_order::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  x = Array(Cdouble, n)
  x_l = Array(Cdouble, n)
  x_u = Array(Cdouble, n)
  y = Array(Cdouble, m)
  c_l = Array(Cdouble, m)
  c_u = Array(Cdouble, m)
  equatn = Array(Cint, m)
  linear = Array(Cint, m)
  @eval CUTEst.csetup($(io_err), $([cint(input)]), $([cint(out)]), $([cint(io_buffer)]),
    $([cint(n)]), $([cint(m)]), $(x), $(x_l), $(x_u), $(y), $(c_l),
    $(c_u), $(equatn), $(linear), $([cint(e_order)]), $([cint(l_order)]),
    $([cint(v_order)]), $(libname))
  @cutest_error
  return x, x_l, x_u, y, c_l, c_u, equatn, linear
end

function jl_udimen(input::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  n = [cint(0)]
  @eval CUTEst.udimen($(io_err), $([cint(input)]), $(n), $(libname))
  @cutest_error
  return n[1]
end

function jl_udimsh(libname = fixedlibname)
  io_err = [cint(0)]
  nnzh = [cint(0)]
  @eval CUTEst.udimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_udimse(libname = fixedlibname)
  io_err = [cint(0)]
  ne = [cint(0)]
  he_val_ne = [cint(0)]
  he_row_ne = [cint(0)]
  @eval CUTEst.udimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne), $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_uvartype(n::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  x_type = Array(Cint, n)
  @eval CUTEst.uvartype($(io_err), $([cint(n)]), $(x_type), $(libname))
  @cutest_error
  return x_type
end

function jl_unames(n::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  pname = [cchar(0)]
  vname = Array(Cchar, n)
  @eval CUTEst.unames($(io_err), $([cint(n)]), $(pname), $(vname), $(libname))
  @cutest_error
  return pname[1], vname
end

function jl_ureport(libname = fixedlibname)
  io_err = [cint(0)]
  calls = Array(Cdouble, 4)
  time = Array(Cdouble, 2)
  @eval CUTEst.ureport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return calls, time
end

function jl_cdimen(input::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  n = [cint(0)]
  m = [cint(0)]
  @eval CUTEst.cdimen($(io_err), $([cint(input)]), $(n), $(m), $(libname))
  @cutest_error
  return n[1], m[1]
end

function jl_cdimsj(libname = fixedlibname)
  io_err = [cint(0)]
  nnzj = [cint(0)]
  @eval CUTEst.cdimsj($(io_err), $(nnzj), $(libname))
  @cutest_error
  return nnzj[1]
end

function jl_cdimsh(libname = fixedlibname)
  io_err = [cint(0)]
  nnzh = [cint(0)]
  @eval CUTEst.cdimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_cdimse(libname = fixedlibname)
  io_err = [cint(0)]
  ne = [cint(0)]
  he_val_ne = [cint(0)]
  he_row_ne = [cint(0)]
  @eval CUTEst.cdimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne), $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_cstats(libname = fixedlibname)
  io_err = [cint(0)]
  nonlinear_variables_objective = [cint(0)]
  nonlinear_variables_constraints = [cint(0)]
  equality_constraints = [cint(0)]
  linear_constraints = [cint(0)]
  @eval CUTEst.cstats($(io_err), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(equality_constraints),
    $(linear_constraints), $(libname))
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function jl_cvartype(n::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  x_type = Array(Cint, n)
  @eval CUTEst.cvartype($(io_err), $([cint(n)]), $(x_type), $(libname))
  @cutest_error
  return x_type
end

function jl_cnames(n::Integer, m::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  pname = [cchar(0)]
  vname = Array(Cchar, n)
  cname = Array(Cchar, m)
  @eval CUTEst.cnames($(io_err), $([cint(n)]), $([cint(m)]), $(pname), $(vname), $(cname), $(libname))
  @cutest_error
  return pname[1], vname, cname
end

function jl_creport(libname = fixedlibname)
  io_err = [cint(0)]
  calls = Array(Cdouble, 7)
  time = Array(Cdouble, 2)
  @eval CUTEst.creport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return calls, time
end

function jl_connames(m::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  cname = Array(Cchar, m)
  @eval CUTEst.connames($(io_err), $([cint(m)]), $(cname), $(libname))
  @cutest_error
  return cname
end

function jl_pname(input::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  pname = [cchar(0)]
  @eval CUTEst.pname($(io_err), $([cint(input)]), $(pname), $(libname))
  @cutest_error
  return pname[1]
end

function jl_probname(libname = fixedlibname)
  io_err = [cint(0)]
  pname = [cchar(0)]
  @eval CUTEst.probname($(io_err), $(pname), $(libname))
  @cutest_error
  return pname[1]
end

function jl_varnames(n::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  vname = Array(Cchar, n)
  @eval CUTEst.varnames($(io_err), $([cint(n)]), $(vname), $(libname))
  @cutest_error
  return vname
end

function jl_ufn(n::Integer, x::Array{Float64, 1}, libname = fixedlibname)
  io_err = [cint(0)]
  f = [cdouble(0)]
  @eval CUTEst.ufn($(io_err), $([cint(n)]), $(x), $(f), $(libname))
  @cutest_error
  return f[1]
end

function jl_ugr(n::Integer, x::Array{Float64, 1}, libname = fixedlibname)
  io_err = [cint(0)]
  g = Array(Cdouble, n)
  @eval CUTEst.ugr($(io_err), $([cint(n)]), $(x), $(g), $(libname))
  @cutest_error
  return g
end

function jl_uofg(n::Integer, x::Array{Float64, 1}, grad::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  f = [cdouble(0)]
  g = Array(Cdouble, n)
  @eval CUTEst.uofg($(io_err), $([cint(n)]), $(x), $(f), $(g), $([cint(grad)]), $(libname))
  @cutest_error
  return f[1], g
end

function jl_ubandh(n::Integer, x::Array{Float64, 1}, semibandwidth::Integer,
    lbandh::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  h_band = Array(Cdouble, lbandh - 0 + 1, n)
  max_semibandwidth = [cint(0)]
  @eval CUTEst.ubandh($(io_err), $([cint(n)]), $(x), $([cint(semibandwidth)]), $(h_band),
    $([cint(lbandh)]), $(max_semibandwidth), $(libname))
  @cutest_error
  return h_band, max_semibandwidth[1]
end

function jl_udh(n::Integer, x::Array{Float64, 1}, lh1::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  h = Array(Cdouble, lh1, n)
  @eval CUTEst.udh($(io_err), $([cint(n)]), $(x), $([cint(lh1)]), $(h), $(libname))
  @cutest_error
  return h
end

function jl_ush(n::Integer, x::Array{Float64, 1}, lh::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  nnzh = [cint(0)]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.ush($(io_err), $([cint(n)]), $(x), $(nnzh), $([cint(lh)]), $(h_val),
    $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_ueh(n::Integer, x::Array{Float64, 1}, lhe_ptr::Integer, lhe_row::Integer,
    lhe_val::Integer, byrows::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  ne = [cint(0)]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval CUTEst.ueh($(io_err), $([cint(n)]), $(x), $(ne), $([cint(lhe_ptr)]),
    $(he_row_ptr), $(he_val_ptr), $([cint(lhe_row)]), $(he_row),
    $([cint(lhe_val)]), $(he_val), $([cint(byrows)]), $(libname))
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_ugrdh(n::Integer, x::Array{Float64, 1}, lh1::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  g = Array(Cdouble, n)
  h = Array(Cdouble, lh1, n)
  @eval CUTEst.ugrdh($(io_err), $([cint(n)]), $(x), $(g), $([cint(lh1)]), $(h), $(libname))
  @cutest_error
  return g, h
end

function jl_ugrsh(n::Integer, x::Array{Float64, 1}, lh::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  g = Array(Cdouble, n)
  nnzh = [cint(0)]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.ugrsh($(io_err), $([cint(n)]), $(x), $(g), $(nnzh), $([cint(lh)]), $(h_val),
    $(h_row), $(h_col), $(libname))
  @cutest_error
  return g, nnzh[1], h_val, h_row, h_col
end

function jl_ugreh(n::Integer, x::Array{Float64, 1}, lhe_ptr::Integer, lhe_row::Integer,
    lhe_val::Integer, byrows::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  g = Array(Cdouble, n)
  ne = [cint(0)]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval CUTEst.ugreh($(io_err), $([cint(n)]), $(x), $(g), $(ne), $([cint(lhe_ptr)]),
    $(he_row_ptr), $(he_val_ptr), $([cint(lhe_row)]), $(he_row),
    $([cint(lhe_val)]), $(he_val), $([cint(byrows)]), $(libname))
  @cutest_error
  return g, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_uhprod(n::Integer, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64,
    1}, libname = fixedlibname)
  io_err = [cint(0)]
  result = Array(Cdouble, n)
  @eval CUTEst.uhprod($(io_err), $([cint(n)]), $([cint(goth)]), $(x), $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function jl_cfn(n::Integer, m::Integer, x::Array{Float64, 1}, libname = fixedlibname)
  io_err = [cint(0)]
  f = [cdouble(0)]
  c = Array(Cdouble, m)
  @eval CUTEst.cfn($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(f), $(c), $(libname))
  @cutest_error
  return f[1], c
end

function jl_cofg(n::Integer, x::Array{Float64, 1}, grad::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  f = [cdouble(0)]
  g = Array(Cdouble, n)
  @eval CUTEst.cofg($(io_err), $([cint(n)]), $(x), $(f), $(g), $([cint(grad)]), $(libname))
  @cutest_error
  return f[1], g
end

function jl_cofsg(n::Integer, x::Array{Float64, 1}, lg::Integer, grad::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  f = [cdouble(0)]
  nnzg = [cint(0)]
  g_val = Array(Cdouble, lg)
  g_var = Array(Cint, lg)
  @eval CUTEst.cofsg($(io_err), $([cint(n)]), $(x), $(f), $(nnzg), $([cint(lg)]), $(g_val),
    $(g_var), $([cint(grad)]), $(libname))
  @cutest_error
  return f[1], nnzg[1], g_val, g_var
end

function jl_ccfg(n::Integer, m::Integer, x::Array{Float64, 1}, jtrans::Bool,
    lcjac1::Integer, lcjac2::Integer, grad::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  c = Array(Cdouble, m)
  cjac = Array(Cdouble, lcjac1, lcjac2)
  @eval CUTEst.ccfg($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(c), $([cint(jtrans)]),
    $([cint(lcjac1)]), $([cint(lcjac2)]), $(cjac), $([cint(grad)]), $(libname))
  @cutest_error
  return c, cjac
end

function jl_clfg(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grad::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  f = [cdouble(0)]
  g = Array(Cdouble, n)
  @eval CUTEst.clfg($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(y), $(f), $(g),
    $([cint(grad)]), $(libname))
  @cutest_error
  return f[1], g
end

function jl_cgr(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Integer, lj2::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  @eval CUTEst.cgr($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(y), $([cint(grlagf)]),
    $(g), $([cint(jtrans)]), $([cint(lj1)]), $([cint(lj2)]), $(j_val), $(libname))
  @cutest_error
  return g, j_val
end

function jl_csgr(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  nnzj = [cint(0)]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  @eval CUTEst.csgr($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(y), $([cint(grlagf)]),
    $(nnzj), $([cint(lj)]), $(j_val), $(j_var), $(j_fun), $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

function jl_ccfsg(n::Integer, m::Integer, x::Array{Float64, 1}, lj::Integer, grad::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  c = Array(Cdouble, m)
  nnzj = [cint(0)]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  @eval CUTEst.ccfsg($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(c), $(nnzj),
    $([cint(lj)]), $(j_val), $(j_var), $(j_fun), $([cint(grad)]), $(libname))
  @cutest_error
  return c, nnzj[1], j_val, j_var, j_fun
end

function jl_ccifg(n::Integer, icon::Integer, x::Array{Float64, 1}, grad::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  ci = [cdouble(0)]
  gci = Array(Cdouble, n)
  @eval CUTEst.ccifg($(io_err), $([cint(n)]), $([cint(icon)]), $(x), $(ci), $(gci),
    $([cint(grad)]), $(libname))
  @cutest_error
  return ci[1], gci
end

function jl_ccifsg(n::Integer, icon::Integer, x::Array{Float64, 1}, lgci::Integer,
    grad::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  ci = [cdouble(0)]
  nnzgci = [cint(0)]
  gci_val = Array(Cdouble, lgci)
  gci_var = Array(Cint, lgci)
  @eval CUTEst.ccifsg($(io_err), $([cint(n)]), $([cint(icon)]), $(x), $(ci), $(nnzgci),
    $([cint(lgci)]), $(gci_val), $(gci_var), $([cint(grad)]), $(libname))
  @cutest_error
  return ci[1], nnzgci[1], gci_val, gci_var
end

function jl_cgrdh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Integer, lj2::Integer, lh1::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  h_val = Array(Cdouble, lh1, n)
  @eval CUTEst.cgrdh($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(y), $([cint(grlagf)]),
    $(g), $([cint(jtrans)]), $([cint(lj1)]), $([cint(lj2)]), $(j_val),
    $([cint(lh1)]), $(h_val), $(libname))
  @cutest_error
  return g, j_val, h_val
end

function jl_cdh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh1::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  h_val = Array(Cdouble, lh1, n)
  @eval CUTEst.cdh($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(y), $([cint(lh1)]),
    $(h_val), $(libname))
  @cutest_error
  return h_val
end

function jl_csh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  nnzh = [cint(0)]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.csh($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(y), $(nnzh),
    $([cint(lh)]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_cshc(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  nnzh = [cint(0)]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.cshc($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(y), $(nnzh),
    $([cint(lh)]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_ceh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Integer, lhe_row::Integer, lhe_val::Integer, byrows::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  ne = [cint(0)]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval CUTEst.ceh($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(y), $(ne),
    $([cint(lhe_ptr)]), $(he_row_ptr), $(he_val_ptr), $([cint(lhe_row)]),
    $(he_row), $([cint(lhe_val)]), $(he_val), $([cint(byrows)]), $(libname))
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_cidh(n::Integer, x::Array{Float64, 1}, iprob::Integer, lh1::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  h = Array(Cdouble, lh1, n)
  @eval CUTEst.cidh($(io_err), $([cint(n)]), $(x), $([cint(iprob)]), $([cint(lh1)]), $(h), $(libname))
  @cutest_error
  return h
end

function jl_cish(n::Integer, x::Array{Float64, 1}, iprob::Integer, lh::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  nnzh = [cint(0)]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.cish($(io_err), $([cint(n)]), $(x), $([cint(iprob)]), $(nnzh),
    $([cint(lh)]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_csgrsh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Integer, lh::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  nnzj = [cint(0)]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  nnzh = [cint(0)]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.csgrsh($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(y), $([cint(grlagf)]),
    $(nnzj), $([cint(lj)]), $(j_val), $(j_var), $(j_fun), $(nnzh),
    $([cint(lh)]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, nnzh[1], h_val, h_row, h_col
end

function jl_csgreh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Integer, lhe_ptr::Integer, lhe_row::Integer,
    lhe_val::Integer, byrows::Bool, libname = fixedlibname)
  io_err = [cint(0)]
  nnzj = [cint(0)]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  ne = [cint(0)]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval CUTEst.csgreh($(io_err), $([cint(n)]), $([cint(m)]), $(x), $(y), $([cint(grlagf)]),
    $(nnzj), $([cint(lj)]), $(j_val), $(j_var), $(j_fun), $(ne),
    $([cint(lhe_ptr)]), $(he_row_ptr), $(he_val_ptr), $([cint(lhe_row)]),
    $(he_row), $([cint(lhe_val)]), $(he_val), $([cint(byrows)]), $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_chprod(n::Integer, m::Integer, goth::Bool, x::Array{Float64, 1},
    y::Array{Float64, 1}, vector::Array{Float64, 1}, libname = fixedlibname)
  io_err = [cint(0)]
  result = Array(Cdouble, n)
  @eval CUTEst.chprod($(io_err), $([cint(n)]), $([cint(m)]), $([cint(goth)]), $(x), $(y),
    $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function jl_chcprod(n::Integer, m::Integer, goth::Bool, x::Array{Float64, 1},
    y::Array{Float64, 1}, vector::Array{Float64, 1}, libname = fixedlibname)
  io_err = [cint(0)]
  result = Array(Cdouble, n)
  @eval CUTEst.chcprod($(io_err), $([cint(n)]), $([cint(m)]), $([cint(goth)]), $(x), $(y),
    $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function jl_cjprod(n::Integer, m::Integer, gotj::Bool, jtrans::Bool, x::Array{Float64,
    1}, vector::Array{Float64, 1}, lvector::Integer, lresult::Integer, libname = fixedlibname)
  io_err = [cint(0)]
  result = Array(Cdouble, lresult)
  @eval CUTEst.cjprod($(io_err), $([cint(n)]), $([cint(m)]), $([cint(gotj)]),
    $([cint(jtrans)]), $(x), $(vector), $([cint(lvector)]), $(result),
    $([cint(lresult)]), $(libname))
  @cutest_error
  return result
end

function jl_uterminate(libname = fixedlibname)
  io_err = [cint(0)]
  @eval CUTEst.uterminate($(io_err), $(libname))
  @cutest_error
end

function jl_cterminate(libname = fixedlibname)
  io_err = [cint(0)]
  @eval CUTEst.cterminate($(io_err), $(libname))
  @cutest_error
end

