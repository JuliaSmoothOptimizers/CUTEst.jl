export usetup, csetup, udimen, udimsh, udimse, uvartype, unames,
    ureport, cdimen, cdimsj, cdimsh, cdimse, cstats, cvartype, cnames,
    creport, connames, pname, probname, varnames, ufn, ugr, uofg, ubandh,
    udh, ush, ueh, ugrdh, ugrsh, ugreh, uhprod, cfn, cofg, cofsg, ccfg,
    clfg, cgr, csgr, ccfsg, ccifg, ccifsg, cgrdh, cdh, csh, cshc, ceh,
    cidh, cish, csgrsh, csgreh, chprod, chcprod, cjprod, uterminate,
    cterminate
export usetup!, csetup!, udimen!, udimsh!, udimse!, uvartype!,
    unames!, ureport!, cdimen!, cdimsj!, cdimsh!, cdimse!, cstats!,
    cvartype!, cnames!, creport!, connames!, pname!, probname!, varnames!,
    ufn!, ugr!, uofg!, ubandh!, udh!, ush!, ueh!, ugrdh!, ugrsh!, ugreh!,
    uhprod!, cfn!, cofg!, cofsg!, ccfg!, clfg!, cgr!, csgr!, ccfsg!,
    ccifg!, ccifsg!, cgrdh!, cdh!, csh!, cshc!, ceh!, cidh!, cish!,
    csgrsh!, csgreh!, chprod!, chcprod!, cjprod!, uterminate!, cterminate!

function usetup(input::Int, out::Int, io_buffer::Int, n::Int, cutest_lib)
  io_err = Cint[0]
  x = Array(Cdouble, n)
  x_l = Array(Cdouble, n)
  x_u = Array(Cdouble, n)
  usetup(io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n], x,
    x_l, x_u, cutest_lib)
  @cutest_error
  return x, x_l, x_u
end

function usetup!(input::Int, out::Int, io_buffer::Int, n::Int, x::Array{Float64, 1},
    x_l::Array{Float64, 1}, x_u::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  usetup(io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n], x,
    x_l, x_u, cutest_lib)
  @cutest_error
  return
end

function csetup(input::Int, out::Int, io_buffer::Int, n::Int, m::Int, e_order::Int,
    l_order::Int, v_order::Int, cutest_lib)
  io_err = Cint[0]
  x = Array(Cdouble, n)
  x_l = Array(Cdouble, n)
  x_u = Array(Cdouble, n)
  y = Array(Cdouble, m)
  c_l = Array(Cdouble, m)
  c_u = Array(Cdouble, m)
  equatn = Array(Cint, m)
  linear = Array(Cint, m)
  csetup(io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n],
    Cint[m], x, x_l, x_u, y, c_l, c_u, equatn, linear, Cint[e_order],
    Cint[l_order], Cint[v_order], cutest_lib)
  @cutest_error
  return x, x_l, x_u, y, c_l, c_u, equatn, linear
end

function csetup!(input::Int, out::Int, io_buffer::Int, n::Int, m::Int,
    x::Array{Float64, 1}, x_l::Array{Float64, 1}, x_u::Array{Float64, 1},
    y::Array{Float64, 1}, c_l::Array{Float64, 1}, c_u::Array{Float64, 1},
    equatn::Array{Bool, 1}, linear::Array{Bool, 1}, e_order::Int,
    l_order::Int, v_order::Int, cutest_lib)
  io_err = Cint[0]
  csetup(io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n],
    Cint[m], x, x_l, x_u, y, c_l, c_u, equatn, linear, Cint[e_order],
    Cint[l_order], Cint[v_order], cutest_lib)
  @cutest_error
  return
end

function udimen(input::Int, cutest_lib)
  io_err = Cint[0]
  n = Cint[0]
  udimen(io_err, Cint[input], n, cutest_lib)
  @cutest_error
  return n[1]
end

function udimsh(cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  udimsh(io_err, nnzh, cutest_lib)
  @cutest_error
  return nnzh[1]
end

function udimse(cutest_lib)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  udimse(io_err, ne, he_val_ne, he_row_ne, cutest_lib)
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function uvartype(n::Int, cutest_lib)
  io_err = Cint[0]
  x_type = Array(Cint, n)
  uvartype(io_err, Cint[n], x_type, cutest_lib)
  @cutest_error
  return x_type
end

function uvartype!(n::Int, x_type::Array{Int, 1}, cutest_lib)
  io_err = Cint[0]
  x_type_cp = Array(Cint, n)
  uvartype(io_err, Cint[n], x_type_cp, cutest_lib)
  @cutest_error
  for i = 1:n
    x_type[i] = x_type_cp[i]
  end
  return
end

function uvartype!(n::Int, x_type::Array{Cint, 1}, cutest_lib)
  io_err = Cint[0]
  uvartype(io_err, Cint[n], x_type, cutest_lib)
  @cutest_error
  return
end

function unames(n::Int, cutest_lib)
  io_err = Cint[0]
  pname = Cchar[0]
  vname = Array(Cchar, n)
  unames(io_err, Cint[n], pname, vname, cutest_lib)
  @cutest_error
  return pname[1], vname
end

function unames!(n::Int, vname::Array{UInt8, 1}, cutest_lib)
  io_err = Cint[0]
  pname = Cchar[0]
  unames(io_err, Cint[n], pname, vname, cutest_lib)
  @cutest_error
  return pname[1]
end

function ureport(cutest_lib)
  io_err = Cint[0]
  calls = Array(Cdouble, 4)
  time = Array(Cdouble, 2)
  ureport(io_err, calls, time, cutest_lib)
  @cutest_error
  return calls, time
end

function ureport!(calls::Array{Float64, 1}, time::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  ureport(io_err, calls, time, cutest_lib)
  @cutest_error
  return
end

function ureport(nlp::CUTEstModel)
  io_err = Cint[0]
  calls = Array(Cdouble, 4)
  time = Array(Cdouble, 2)
  ureport(io_err, calls, time, nlp.cutest_lib)
  @cutest_error
  return calls, time
end

function ureport!(nlp::CUTEstModel, calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  ureport(io_err, calls, time, nlp.cutest_lib)
  @cutest_error
  return
end

function cdimen(input::Int, cutest_lib)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  cdimen(io_err, Cint[input], n, m, cutest_lib)
  @cutest_error
  return n[1], m[1]
end

function cdimsj(cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  cdimsj(io_err, nnzj, cutest_lib)
  @cutest_error
  return nnzj[1]
end

function cdimsh(cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  cdimsh(io_err, nnzh, cutest_lib)
  @cutest_error
  return nnzh[1]
end

function cdimse(cutest_lib)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  cdimse(io_err, ne, he_val_ne, he_row_ne, cutest_lib)
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function cstats(cutest_lib)
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  cstats(io_err, nonlinear_variables_objective,
    nonlinear_variables_constraints, equality_constraints,
    linear_constraints, cutest_lib)
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function cstats(nlp::CUTEstModel)
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  cstats(io_err, nonlinear_variables_objective,
    nonlinear_variables_constraints, equality_constraints,
    linear_constraints, nlp.cutest_lib)
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function cvartype(n::Int, cutest_lib)
  io_err = Cint[0]
  x_type = Array(Cint, n)
  cvartype(io_err, Cint[n], x_type, cutest_lib)
  @cutest_error
  return x_type
end

function cvartype!(n::Int, x_type::Array{Int, 1}, cutest_lib)
  io_err = Cint[0]
  x_type_cp = Array(Cint, n)
  cvartype(io_err, Cint[n], x_type_cp, cutest_lib)
  @cutest_error
  for i = 1:n
    x_type[i] = x_type_cp[i]
  end
  return
end

function cvartype!(n::Int, x_type::Array{Cint, 1}, cutest_lib)
  io_err = Cint[0]
  cvartype(io_err, Cint[n], x_type, cutest_lib)
  @cutest_error
  return
end

function cnames(n::Int, m::Int, cutest_lib)
  io_err = Cint[0]
  pname = Cchar[0]
  vname = Array(Cchar, n)
  cname = Array(Cchar, m)
  cnames(io_err, Cint[n], Cint[m], pname, vname, cname, cutest_lib)
  @cutest_error
  return pname[1], vname, cname
end

function cnames!(n::Int, m::Int, vname::Array{UInt8, 1}, cname::Array{UInt8, 1},
    cutest_lib)
  io_err = Cint[0]
  pname = Cchar[0]
  cnames(io_err, Cint[n], Cint[m], pname, vname, cname, cutest_lib)
  @cutest_error
  return pname[1]
end

function cnames(nlp::CUTEstModel)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  pname = Cchar[0]
  vname = Array(Cchar, n)
  cname = Array(Cchar, m)
  cnames(io_err, Cint[n], Cint[m], pname, vname, cname,
    nlp.cutest_lib)
  @cutest_error
  return pname[1], vname, cname
end

function cnames!(nlp::CUTEstModel, vname::Array{UInt8, 1}, cname::Array{UInt8, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  pname = Cchar[0]
  cnames(io_err, Cint[n], Cint[m], pname, vname, cname,
    nlp.cutest_lib)
  @cutest_error
  return pname[1]
end

function creport(cutest_lib)
  io_err = Cint[0]
  calls = Array(Cdouble, 7)
  time = Array(Cdouble, 2)
  creport(io_err, calls, time, cutest_lib)
  @cutest_error
  return calls, time
end

function creport!(calls::Array{Float64, 1}, time::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  creport(io_err, calls, time, cutest_lib)
  @cutest_error
  return
end

function creport(nlp::CUTEstModel)
  io_err = Cint[0]
  calls = Array(Cdouble, 7)
  time = Array(Cdouble, 2)
  creport(io_err, calls, time, nlp.cutest_lib)
  @cutest_error
  return calls, time
end

function creport!(nlp::CUTEstModel, calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  creport(io_err, calls, time, nlp.cutest_lib)
  @cutest_error
  return
end

function connames(m::Int, cutest_lib)
  io_err = Cint[0]
  cname = Array(Cchar, m)
  connames(io_err, Cint[m], cname, cutest_lib)
  @cutest_error
  return cname
end

function connames!(m::Int, cname::Array{UInt8, 1}, cutest_lib)
  io_err = Cint[0]
  connames(io_err, Cint[m], cname, cutest_lib)
  @cutest_error
  return
end

function connames(nlp::CUTEstModel)
  io_err = Cint[0]
  m = nlp.meta.ncon
  cname = Array(Cchar, m)
  connames(io_err, Cint[m], cname, nlp.cutest_lib)
  @cutest_error
  return cname
end

function connames!(nlp::CUTEstModel, cname::Array{UInt8, 1})
  io_err = Cint[0]
  m = nlp.meta.ncon
  connames(io_err, Cint[m], cname, nlp.cutest_lib)
  @cutest_error
  return
end

function pname(input::Int, cutest_lib)
  io_err = Cint[0]
  pname = Cchar[0]
  pname(io_err, Cint[input], pname, cutest_lib)
  @cutest_error
  return pname[1]
end

function pname(nlp::CUTEstModel, input::Int)
  io_err = Cint[0]
  pname = Cchar[0]
  pname(io_err, Cint[input], pname, nlp.cutest_lib)
  @cutest_error
  return pname[1]
end

function probname(cutest_lib)
  io_err = Cint[0]
  pname = Cchar[0]
  probname(io_err, pname, cutest_lib)
  @cutest_error
  return pname[1]
end

function probname(nlp::CUTEstModel)
  io_err = Cint[0]
  pname = Cchar[0]
  probname(io_err, pname, nlp.cutest_lib)
  @cutest_error
  return pname[1]
end

function varnames(n::Int, cutest_lib)
  io_err = Cint[0]
  vname = Array(Cchar, n)
  varnames(io_err, Cint[n], vname, cutest_lib)
  @cutest_error
  return vname
end

function varnames!(n::Int, vname::Array{UInt8, 1}, cutest_lib)
  io_err = Cint[0]
  varnames(io_err, Cint[n], vname, cutest_lib)
  @cutest_error
  return
end

function ufn(n::Int, x::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  ufn(io_err, Cint[n], x, f, cutest_lib)
  @cutest_error
  return f[1]
end

function ufn(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  ufn(io_err, Cint[n], x, f, nlp.cutest_lib)
  @cutest_error
  return f[1]
end

function ugr(n::Int, x::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  ugr(io_err, Cint[n], x, g, cutest_lib)
  @cutest_error
  return g
end

function ugr!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  ugr(io_err, Cint[n], x, g, cutest_lib)
  @cutest_error
  return
end

function ugr(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  g = Array(Cdouble, n)
  ugr(io_err, Cint[n], x, g, nlp.cutest_lib)
  @cutest_error
  return g
end

function ugr!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  ugr(io_err, Cint[n], x, g, nlp.cutest_lib)
  @cutest_error
  return
end

function uofg(n::Int, x::Array{Float64, 1}, grad::Bool, cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  uofg(io_err, Cint[n], x, f, g, Cint[grad], cutest_lib)
  @cutest_error
  return f[1], g
end

function uofg!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool,
    cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  uofg(io_err, Cint[n], x, f, g, Cint[grad], cutest_lib)
  @cutest_error
  return f[1]
end

function uofg(nlp::CUTEstModel, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  g = Array(Cdouble, n)
  uofg(io_err, Cint[n], x, f, g, Cint[grad], nlp.cutest_lib)
  @cutest_error
  return f[1], g
end

function uofg!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  uofg(io_err, Cint[n], x, f, g, Cint[grad], nlp.cutest_lib)
  @cutest_error
  return f[1]
end

function ubandh(n::Int, x::Array{Float64, 1}, semibandwidth::Int, lbandh::Int,
    cutest_lib)
  io_err = Cint[0]
  h_band = Array(Cdouble, lbandh - 0 + 1, n)
  max_semibandwidth = Cint[0]
  ubandh(io_err, Cint[n], x, Cint[semibandwidth], h_band,
    Cint[lbandh], max_semibandwidth, cutest_lib)
  @cutest_error
  return h_band, max_semibandwidth[1]
end

function ubandh!(n::Int, x::Array{Float64, 1}, semibandwidth::Int,
    h_band::Array{Float64, 2}, lbandh::Int, cutest_lib)
  io_err = Cint[0]
  max_semibandwidth = Cint[0]
  ubandh(io_err, Cint[n], x, Cint[semibandwidth], h_band,
    Cint[lbandh], max_semibandwidth, cutest_lib)
  @cutest_error
  return max_semibandwidth[1]
end

function ubandh(nlp::CUTEstModel, x::Array{Float64, 1}, semibandwidth::Int,
    lbandh::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  h_band = Array(Cdouble, lbandh - 0 + 1, n)
  max_semibandwidth = Cint[0]
  ubandh(io_err, Cint[n], x, Cint[semibandwidth], h_band,
    Cint[lbandh], max_semibandwidth, nlp.cutest_lib)
  @cutest_error
  return h_band, max_semibandwidth[1]
end

function ubandh!(nlp::CUTEstModel, x::Array{Float64, 1}, semibandwidth::Int,
    h_band::Array{Float64, 2}, lbandh::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  max_semibandwidth = Cint[0]
  ubandh(io_err, Cint[n], x, Cint[semibandwidth], h_band,
    Cint[lbandh], max_semibandwidth, nlp.cutest_lib)
  @cutest_error
  return max_semibandwidth[1]
end

function udh(n::Int, x::Array{Float64, 1}, lh1::Int, cutest_lib)
  io_err = Cint[0]
  h = Array(Cdouble, lh1, n)
  udh(io_err, Cint[n], x, Cint[lh1], h, cutest_lib)
  @cutest_error
  return h
end

function udh!(n::Int, x::Array{Float64, 1}, lh1::Int, h::Array{Float64, 2},
    cutest_lib)
  io_err = Cint[0]
  udh(io_err, Cint[n], x, Cint[lh1], h, cutest_lib)
  @cutest_error
  return
end

function udh(nlp::CUTEstModel, x::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  h = Array(Cdouble, lh1, n)
  udh(io_err, Cint[n], x, Cint[lh1], h, nlp.cutest_lib)
  @cutest_error
  return h
end

function udh!(nlp::CUTEstModel, x::Array{Float64, 1}, lh1::Int, h::Array{Float64,
    2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  udh(io_err, Cint[n], x, Cint[lh1], h, nlp.cutest_lib)
  @cutest_error
  return
end

function ush(n::Int, x::Array{Float64, 1}, lh::Int, cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row, h_col,
    cutest_lib)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function ush!(n::Int, x::Array{Float64, 1}, lh::Int, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1}, cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row_cp, h_col_cp,
    cutest_lib)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function ush!(n::Int, x::Array{Float64, 1}, lh::Int, h_val::Array{Float64, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1}, cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row, h_col,
    cutest_lib)
  @cutest_error
  return nnzh[1]
end

function ush(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row, h_col,
    nlp.cutest_lib)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function ush!(nlp::CUTEstModel, x::Array{Float64, 1}, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row_cp, h_col_cp,
    nlp.cutest_lib)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function ush!(nlp::CUTEstModel, x::Array{Float64, 1}, h_val::Array{Float64, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row, h_col,
    nlp.cutest_lib)
  @cutest_error
  return nnzh[1]
end

function ueh(n::Int, x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int,
    lhe_val::Int, byrows::Bool, cutest_lib)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows],
    cutest_lib)
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ueh!(n::Int, x::Array{Float64, 1}, lhe_ptr::Int, he_row_ptr::Array{Int,
    1}, he_val_ptr::Array{Int, 1}, lhe_row::Int, he_row::Array{Int, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool, cutest_lib)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows], cutest_lib)
  @cutest_error
  for i = 1:lhe_ptr
    he_row_ptr[i] = he_row_ptr_cp[i]
  end
  for i = 1:lhe_ptr
    he_val_ptr[i] = he_val_ptr_cp[i]
  end
  for i = 1:lhe_row
    he_row[i] = he_row_cp[i]
  end
  return ne[1]
end

function ueh!(n::Int, x::Array{Float64, 1}, lhe_ptr::Int, he_row_ptr::Array{Cint,
    1}, he_val_ptr::Array{Cint, 1}, lhe_row::Int, he_row::Array{Cint, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool, cutest_lib)
  io_err = Cint[0]
  ne = Cint[0]
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows],
    cutest_lib)
  @cutest_error
  return ne[1]
end

function ueh(nlp::CUTEstModel, x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int,
    lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows],
    nlp.cutest_lib)
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ueh!(nlp::CUTEstModel, x::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1}, lhe_row::Int,
    he_row::Array{Int, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows], nlp.cutest_lib)
  @cutest_error
  for i = 1:lhe_ptr
    he_row_ptr[i] = he_row_ptr_cp[i]
  end
  for i = 1:lhe_ptr
    he_val_ptr[i] = he_val_ptr_cp[i]
  end
  for i = 1:lhe_row
    he_row[i] = he_row_cp[i]
  end
  return ne[1]
end

function ueh!(nlp::CUTEstModel, x::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1}, lhe_row::Int,
    he_row::Array{Cint, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ne = Cint[0]
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows],
    nlp.cutest_lib)
  @cutest_error
  return ne[1]
end

function ugrdh(n::Int, x::Array{Float64, 1}, lh1::Int, cutest_lib)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  h = Array(Cdouble, lh1, n)
  ugrdh(io_err, Cint[n], x, g, Cint[lh1], h, cutest_lib)
  @cutest_error
  return g, h
end

function ugrdh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lh1::Int,
    h::Array{Float64, 2}, cutest_lib)
  io_err = Cint[0]
  ugrdh(io_err, Cint[n], x, g, Cint[lh1], h, cutest_lib)
  @cutest_error
  return
end

function ugrdh(nlp::CUTEstModel, x::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  g = Array(Cdouble, n)
  h = Array(Cdouble, lh1, n)
  ugrdh(io_err, Cint[n], x, g, Cint[lh1], h, nlp.cutest_lib)
  @cutest_error
  return g, h
end

function ugrdh!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    lh1::Int, h::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  ugrdh(io_err, Cint[n], x, g, Cint[lh1], h, nlp.cutest_lib)
  @cutest_error
  return
end

function ugrsh(n::Int, x::Array{Float64, 1}, lh::Int, cutest_lib)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row, h_col,
    cutest_lib)
  @cutest_error
  return g, nnzh[1], h_val, h_row, h_col
end

function ugrsh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1},
    cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row_cp,
    h_col_cp, cutest_lib)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function ugrsh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1}, cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row, h_col,
    cutest_lib)
  @cutest_error
  return nnzh[1]
end

function ugrsh(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  g = Array(Cdouble, n)
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row, h_col,
    nlp.cutest_lib)
  @cutest_error
  return g, nnzh[1], h_val, h_row, h_col
end

function ugrsh!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row_cp,
    h_col_cp, nlp.cutest_lib)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function ugrsh!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row, h_col,
    nlp.cutest_lib)
  @cutest_error
  return nnzh[1]
end

function ugreh(n::Int, x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int,
    lhe_val::Int, byrows::Bool, cutest_lib)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows], cutest_lib)
  @cutest_error
  return g, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ugreh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1}, lhe_row::Int,
    he_row::Array{Int, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool, cutest_lib)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows], cutest_lib)
  @cutest_error
  for i = 1:lhe_ptr
    he_row_ptr[i] = he_row_ptr_cp[i]
  end
  for i = 1:lhe_ptr
    he_val_ptr[i] = he_val_ptr_cp[i]
  end
  for i = 1:lhe_row
    he_row[i] = he_row_cp[i]
  end
  return ne[1]
end

function ugreh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1}, lhe_row::Int,
    he_row::Array{Cint, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool, cutest_lib)
  io_err = Cint[0]
  ne = Cint[0]
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows], cutest_lib)
  @cutest_error
  return ne[1]
end

function ugreh(nlp::CUTEstModel, x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int,
    lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  g = Array(Cdouble, n)
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows], nlp.cutest_lib)
  @cutest_error
  return g, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ugreh!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    lhe_ptr::Int, he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1},
    lhe_row::Int, he_row::Array{Int, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows], nlp.cutest_lib)
  @cutest_error
  for i = 1:lhe_ptr
    he_row_ptr[i] = he_row_ptr_cp[i]
  end
  for i = 1:lhe_ptr
    he_val_ptr[i] = he_val_ptr_cp[i]
  end
  for i = 1:lhe_row
    he_row[i] = he_row_cp[i]
  end
  return ne[1]
end

function ugreh!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    lhe_ptr::Int, he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1},
    lhe_row::Int, he_row::Array{Cint, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ne = Cint[0]
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows], nlp.cutest_lib)
  @cutest_error
  return ne[1]
end

function uhprod(n::Int, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1},
    cutest_lib)
  io_err = Cint[0]
  result = Array(Cdouble, n)
  uhprod(io_err, Cint[n], Cint[goth], x, vector, result, cutest_lib)
  @cutest_error
  return result
end

function uhprod!(n::Int, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1},
    result::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  uhprod(io_err, Cint[n], Cint[goth], x, vector, result, cutest_lib)
  @cutest_error
  return
end

function uhprod(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  result = Array(Cdouble, n)
  uhprod(io_err, Cint[n], Cint[goth], x, vector, result,
    nlp.cutest_lib)
  @cutest_error
  return result
end

function uhprod!(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  uhprod(io_err, Cint[n], Cint[goth], x, vector, result,
    nlp.cutest_lib)
  @cutest_error
  return
end

function cfn(n::Int, m::Int, x::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  c = Array(Cdouble, m)
  cfn(io_err, Cint[n], Cint[m], x, f, c, cutest_lib)
  @cutest_error
  return f[1], c
end

function cfn!(n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1},
    cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  cfn(io_err, Cint[n], Cint[m], x, f, c, cutest_lib)
  @cutest_error
  return f[1]
end

function cfn(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  c = Array(Cdouble, m)
  cfn(io_err, Cint[n], Cint[m], x, f, c, nlp.cutest_lib)
  @cutest_error
  return f[1], c
end

function cfn!(nlp::CUTEstModel, x::Array{Float64, 1}, c::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  cfn(io_err, Cint[n], Cint[m], x, f, c, nlp.cutest_lib)
  @cutest_error
  return f[1]
end

function cofg(n::Int, x::Array{Float64, 1}, grad::Bool, cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  cofg(io_err, Cint[n], x, f, g, Cint[grad], cutest_lib)
  @cutest_error
  return f[1], g
end

function cofg!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool,
    cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  cofg(io_err, Cint[n], x, f, g, Cint[grad], cutest_lib)
  @cutest_error
  return f[1]
end

function cofg(nlp::CUTEstModel, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  g = Array(Cdouble, n)
  cofg(io_err, Cint[n], x, f, g, Cint[grad], nlp.cutest_lib)
  @cutest_error
  return f[1], g
end

function cofg!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  cofg(io_err, Cint[n], x, f, g, Cint[grad], nlp.cutest_lib)
  @cutest_error
  return f[1]
end

function cofsg(n::Int, x::Array{Float64, 1}, lg::Int, grad::Bool, cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  g_val = Array(Cdouble, lg)
  g_var = Array(Cint, lg)
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var,
    Cint[grad], cutest_lib)
  @cutest_error
  return f[1], nnzg[1], g_val, g_var
end

function cofsg!(n::Int, x::Array{Float64, 1}, lg::Int, g_val::Array{Float64, 1},
    g_var::Array{Int, 1}, grad::Bool, cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  g_var_cp = Array(Cint, lg)
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var_cp,
    Cint[grad], cutest_lib)
  @cutest_error
  for i = 1:lg
    g_var[i] = g_var_cp[i]
  end
  return f[1], nnzg[1]
end

function cofsg!(n::Int, x::Array{Float64, 1}, lg::Int, g_val::Array{Float64, 1},
    g_var::Array{Cint, 1}, grad::Bool, cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var,
    Cint[grad], cutest_lib)
  @cutest_error
  return f[1], nnzg[1]
end

function cofsg(nlp::CUTEstModel, x::Array{Float64, 1}, lg::Int, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  nnzg = Cint[0]
  g_val = Array(Cdouble, lg)
  g_var = Array(Cint, lg)
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var,
    Cint[grad], nlp.cutest_lib)
  @cutest_error
  return f[1], nnzg[1], g_val, g_var
end

function cofsg!(nlp::CUTEstModel, x::Array{Float64, 1}, lg::Int,
    g_val::Array{Float64, 1}, g_var::Array{Int, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  nnzg = Cint[0]
  g_var_cp = Array(Cint, lg)
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var_cp,
    Cint[grad], nlp.cutest_lib)
  @cutest_error
  for i = 1:lg
    g_var[i] = g_var_cp[i]
  end
  return f[1], nnzg[1]
end

function cofsg!(nlp::CUTEstModel, x::Array{Float64, 1}, lg::Int,
    g_val::Array{Float64, 1}, g_var::Array{Cint, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  nnzg = Cint[0]
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var,
    Cint[grad], nlp.cutest_lib)
  @cutest_error
  return f[1], nnzg[1]
end

function ccfg(n::Int, m::Int, x::Array{Float64, 1}, jtrans::Bool, lcjac1::Int,
    lcjac2::Int, grad::Bool, cutest_lib)
  io_err = Cint[0]
  c = Array(Cdouble, m)
  cjac = Array(Cdouble, lcjac1, lcjac2)
  ccfg(io_err, Cint[n], Cint[m], x, c, Cint[jtrans], Cint[lcjac1],
    Cint[lcjac2], cjac, Cint[grad], cutest_lib)
  @cutest_error
  return c, cjac
end

function ccfg!(n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1},
    jtrans::Bool, lcjac1::Int, lcjac2::Int, cjac::Array{Float64, 2},
    grad::Bool, cutest_lib)
  io_err = Cint[0]
  ccfg(io_err, Cint[n], Cint[m], x, c, Cint[jtrans], Cint[lcjac1],
    Cint[lcjac2], cjac, Cint[grad], cutest_lib)
  @cutest_error
  return
end

function ccfg(nlp::CUTEstModel, x::Array{Float64, 1}, jtrans::Bool, lcjac1::Int,
    lcjac2::Int, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  c = Array(Cdouble, m)
  cjac = Array(Cdouble, lcjac1, lcjac2)
  ccfg(io_err, Cint[n], Cint[m], x, c, Cint[jtrans], Cint[lcjac1],
    Cint[lcjac2], cjac, Cint[grad], nlp.cutest_lib)
  @cutest_error
  return c, cjac
end

function ccfg!(nlp::CUTEstModel, x::Array{Float64, 1}, c::Array{Float64, 1},
    jtrans::Bool, lcjac1::Int, lcjac2::Int, cjac::Array{Float64, 2},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  ccfg(io_err, Cint[n], Cint[m], x, c, Cint[jtrans], Cint[lcjac1],
    Cint[lcjac2], cjac, Cint[grad], nlp.cutest_lib)
  @cutest_error
  return
end

function clfg(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grad::Bool, cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  clfg(io_err, Cint[n], Cint[m], x, y, f, g, Cint[grad], cutest_lib)
  @cutest_error
  return f[1], g
end

function clfg!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    g::Array{Float64, 1}, grad::Bool, cutest_lib)
  io_err = Cint[0]
  f = Cdouble[0]
  clfg(io_err, Cint[n], Cint[m], x, y, f, g, Cint[grad], cutest_lib)
  @cutest_error
  return f[1]
end

function clfg(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  g = Array(Cdouble, n)
  clfg(io_err, Cint[n], Cint[m], x, y, f, g, Cint[grad],
    nlp.cutest_lib)
  @cutest_error
  return f[1], g
end

function clfg!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  clfg(io_err, Cint[n], Cint[m], x, y, f, g, Cint[grad],
    nlp.cutest_lib)
  @cutest_error
  return f[1]
end

function cgr(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Int, lj2::Int, cutest_lib)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  cgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, cutest_lib)
  @cutest_error
  return g, j_val
end

function cgr!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2}, cutest_lib)
  io_err = Cint[0]
  cgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, cutest_lib)
  @cutest_error
  return
end

function cgr(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Int, lj2::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  cgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, nlp.cutest_lib)
  @cutest_error
  return g, j_val
end

function cgr!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  cgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, nlp.cutest_lib)
  @cutest_error
  return
end

function csgr(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, cutest_lib)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

function csgr!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1}, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp, cutest_lib)
  @cutest_error
  for i = 1:lj
    j_var[i] = j_var_cp[i]
  end
  for i = 1:lj
    j_fun[i] = j_fun_cp[i]
  end
  return nnzj[1]
end

function csgr!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Cint,
    1}, j_fun::Array{Cint, 1}, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, cutest_lib)
  @cutest_error
  return nnzj[1]
end

function csgr(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj + nlp.meta.nvar
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nlp.cutest_lib)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

function csgr!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj + nlp.meta.nvar
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp, nlp.cutest_lib)
  @cutest_error
  for i = 1:lj
    j_var[i] = j_var_cp[i]
  end
  for i = 1:lj
    j_fun[i] = j_fun_cp[i]
  end
  return nnzj[1]
end

function csgr!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, j_val::Array{Float64, 1}, j_var::Array{Cint, 1},
    j_fun::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj + nlp.meta.nvar
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nlp.cutest_lib)
  @cutest_error
  return nnzj[1]
end

function ccfsg(n::Int, m::Int, x::Array{Float64, 1}, lj::Int, grad::Bool,
    cutest_lib)
  io_err = Cint[0]
  c = Array(Cdouble, m)
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val, j_var,
    j_fun, Cint[grad], cutest_lib)
  @cutest_error
  return c, nnzj[1], j_val, j_var, j_fun
end

function ccfsg!(n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1}, lj::Int,
    j_val::Array{Float64, 1}, j_var::Array{Int, 1}, j_fun::Array{Int, 1},
    grad::Bool, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val,
    j_var_cp, j_fun_cp, Cint[grad], cutest_lib)
  @cutest_error
  for i = 1:lj
    j_var[i] = j_var_cp[i]
  end
  for i = 1:lj
    j_fun[i] = j_fun_cp[i]
  end
  return nnzj[1]
end

function ccfsg!(n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1}, lj::Int,
    j_val::Array{Float64, 1}, j_var::Array{Cint, 1}, j_fun::Array{Cint,
    1}, grad::Bool, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val, j_var,
    j_fun, Cint[grad], cutest_lib)
  @cutest_error
  return nnzj[1]
end

function ccfsg(nlp::CUTEstModel, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  c = Array(Cdouble, m)
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val, j_var,
    j_fun, Cint[grad], nlp.cutest_lib)
  @cutest_error
  return c, nnzj[1], j_val, j_var, j_fun
end

function ccfsg!(nlp::CUTEstModel, x::Array{Float64, 1}, c::Array{Float64, 1},
    j_val::Array{Float64, 1}, j_var::Array{Int, 1}, j_fun::Array{Int, 1},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val,
    j_var_cp, j_fun_cp, Cint[grad], nlp.cutest_lib)
  @cutest_error
  for i = 1:lj
    j_var[i] = j_var_cp[i]
  end
  for i = 1:lj
    j_fun[i] = j_fun_cp[i]
  end
  return nnzj[1]
end

function ccfsg!(nlp::CUTEstModel, x::Array{Float64, 1}, c::Array{Float64, 1},
    j_val::Array{Float64, 1}, j_var::Array{Cint, 1}, j_fun::Array{Cint,
    1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val, j_var,
    j_fun, Cint[grad], nlp.cutest_lib)
  @cutest_error
  return nnzj[1]
end

function ccifg(n::Int, icon::Int, x::Array{Float64, 1}, grad::Bool, cutest_lib)
  io_err = Cint[0]
  ci = Cdouble[0]
  gci = Array(Cdouble, n)
  ccifg(io_err, Cint[n], Cint[icon], x, ci, gci, Cint[grad],
    cutest_lib)
  @cutest_error
  return ci[1], gci
end

function ccifg!(n::Int, icon::Int, x::Array{Float64, 1}, gci::Array{Float64, 1},
    grad::Bool, cutest_lib)
  io_err = Cint[0]
  ci = Cdouble[0]
  ccifg(io_err, Cint[n], Cint[icon], x, ci, gci, Cint[grad],
    cutest_lib)
  @cutest_error
  return ci[1]
end

function ccifg(nlp::CUTEstModel, icon::Int, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  gci = Array(Cdouble, n)
  ccifg(io_err, Cint[n], Cint[icon], x, ci, gci, Cint[grad],
    nlp.cutest_lib)
  @cutest_error
  return ci[1], gci
end

function ccifg!(nlp::CUTEstModel, icon::Int, x::Array{Float64, 1},
    gci::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  ccifg(io_err, Cint[n], Cint[icon], x, ci, gci, Cint[grad],
    nlp.cutest_lib)
  @cutest_error
  return ci[1]
end

function ccifsg(n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int, grad::Bool,
    cutest_lib)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_val = Array(Cdouble, lgci)
  gci_var = Array(Cint, lgci)
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var, Cint[grad], cutest_lib)
  @cutest_error
  return ci[1], nnzgci[1], gci_val, gci_var
end

function ccifsg!(n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int,
    gci_val::Array{Float64, 1}, gci_var::Array{Int, 1}, grad::Bool,
    cutest_lib)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_var_cp = Array(Cint, lgci)
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var_cp, Cint[grad], cutest_lib)
  @cutest_error
  for i = 1:lgci
    gci_var[i] = gci_var_cp[i]
  end
  return ci[1], nnzgci[1]
end

function ccifsg!(n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int,
    gci_val::Array{Float64, 1}, gci_var::Array{Cint, 1}, grad::Bool,
    cutest_lib)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var, Cint[grad], cutest_lib)
  @cutest_error
  return ci[1], nnzgci[1]
end

function ccifsg(nlp::CUTEstModel, icon::Int, x::Array{Float64, 1}, lgci::Int,
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_val = Array(Cdouble, lgci)
  gci_var = Array(Cint, lgci)
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var, Cint[grad], nlp.cutest_lib)
  @cutest_error
  return ci[1], nnzgci[1], gci_val, gci_var
end

function ccifsg!(nlp::CUTEstModel, icon::Int, x::Array{Float64, 1}, lgci::Int,
    gci_val::Array{Float64, 1}, gci_var::Array{Int, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_var_cp = Array(Cint, lgci)
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var_cp, Cint[grad], nlp.cutest_lib)
  @cutest_error
  for i = 1:lgci
    gci_var[i] = gci_var_cp[i]
  end
  return ci[1], nnzgci[1]
end

function ccifsg!(nlp::CUTEstModel, icon::Int, x::Array{Float64, 1}, lgci::Int,
    gci_val::Array{Float64, 1}, gci_var::Array{Cint, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  nnzgci = Cint[0]
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var, Cint[grad], nlp.cutest_lib)
  @cutest_error
  return ci[1], nnzgci[1]
end

function cgrdh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Int, lj2::Int, lh1::Int, cutest_lib)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  h_val = Array(Cdouble, lh1, n)
  cgrdh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, Cint[lh1], h_val, cutest_lib)
  @cutest_error
  return g, j_val, h_val
end

function cgrdh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2}, lh1::Int, h_val::Array{Float64, 2},
    cutest_lib)
  io_err = Cint[0]
  cgrdh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, Cint[lh1], h_val, cutest_lib)
  @cutest_error
  return
end

function cgrdh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Int, lj2::Int, lh1::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  h_val = Array(Cdouble, lh1, n)
  cgrdh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, Cint[lh1], h_val, nlp.cutest_lib)
  @cutest_error
  return g, j_val, h_val
end

function cgrdh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2}, lh1::Int, h_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  cgrdh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, Cint[lh1], h_val, nlp.cutest_lib)
  @cutest_error
  return
end

function cdh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int,
    cutest_lib)
  io_err = Cint[0]
  h_val = Array(Cdouble, lh1, n)
  cdh(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val, cutest_lib)
  @cutest_error
  return h_val
end

function cdh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int,
    h_val::Array{Float64, 2}, cutest_lib)
  io_err = Cint[0]
  cdh(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val, cutest_lib)
  @cutest_error
  return
end

function cdh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh1::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  h_val = Array(Cdouble, lh1, n)
  cdh(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val,
    nlp.cutest_lib)
  @cutest_error
  return h_val
end

function cdh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh1::Int, h_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  cdh(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val,
    nlp.cutest_lib)
  @cutest_error
  return
end

function csh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col, cutest_lib)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function csh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1},
    cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row_cp,
    h_col_cp, cutest_lib)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function csh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1}, cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col, cutest_lib)
  @cutest_error
  return nnzh[1]
end

function csh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col, nlp.cutest_lib)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function csh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row_cp,
    h_col_cp, nlp.cutest_lib)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function csh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col, nlp.cutest_lib)
  @cutest_error
  return nnzh[1]
end

function cshc(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col, cutest_lib)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function cshc!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1},
    cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val,
    h_row_cp, h_col_cp, cutest_lib)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function cshc!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1}, cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col, cutest_lib)
  @cutest_error
  return nnzh[1]
end

function cshc(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col, nlp.cutest_lib)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function cshc!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val,
    h_row_cp, h_col_cp, nlp.cutest_lib)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function cshc!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col, nlp.cutest_lib)
  @cutest_error
  return nnzh[1]
end

function ceh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, lhe_row::Int, lhe_val::Int, byrows::Bool, cutest_lib)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows], cutest_lib)
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ceh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1},
    lhe_row::Int, he_row::Array{Int, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool, cutest_lib)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr],
    he_row_ptr_cp, he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val],
    he_val, Cint[byrows], cutest_lib)
  @cutest_error
  for i = 1:lhe_ptr
    he_row_ptr[i] = he_row_ptr_cp[i]
  end
  for i = 1:lhe_ptr
    he_val_ptr[i] = he_val_ptr_cp[i]
  end
  for i = 1:lhe_row
    he_row[i] = he_row_cp[i]
  end
  return ne[1]
end

function ceh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1},
    lhe_row::Int, he_row::Array{Cint, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool, cutest_lib)
  io_err = Cint[0]
  ne = Cint[0]
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows], cutest_lib)
  @cutest_error
  return ne[1]
end

function ceh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, lhe_row::Int, lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows], nlp.cutest_lib)
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ceh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1},
    lhe_row::Int, he_row::Array{Int, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr],
    he_row_ptr_cp, he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val],
    he_val, Cint[byrows], nlp.cutest_lib)
  @cutest_error
  for i = 1:lhe_ptr
    he_row_ptr[i] = he_row_ptr_cp[i]
  end
  for i = 1:lhe_ptr
    he_val_ptr[i] = he_val_ptr_cp[i]
  end
  for i = 1:lhe_row
    he_row[i] = he_row_cp[i]
  end
  return ne[1]
end

function ceh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1},
    lhe_row::Int, he_row::Array{Cint, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  ne = Cint[0]
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows], nlp.cutest_lib)
  @cutest_error
  return ne[1]
end

function cidh(n::Int, x::Array{Float64, 1}, iprob::Int, lh1::Int, cutest_lib)
  io_err = Cint[0]
  h = Array(Cdouble, lh1, n)
  cidh(io_err, Cint[n], x, Cint[iprob], Cint[lh1], h, cutest_lib)
  @cutest_error
  return h
end

function cidh!(n::Int, x::Array{Float64, 1}, iprob::Int, lh1::Int, h::Array{Float64,
    2}, cutest_lib)
  io_err = Cint[0]
  cidh(io_err, Cint[n], x, Cint[iprob], Cint[lh1], h, cutest_lib)
  @cutest_error
  return
end

function cidh(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Int, lh1::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  h = Array(Cdouble, lh1, n)
  cidh(io_err, Cint[n], x, Cint[iprob], Cint[lh1], h, nlp.cutest_lib)
  @cutest_error
  return h
end

function cidh!(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Int, lh1::Int,
    h::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  cidh(io_err, Cint[n], x, Cint[iprob], Cint[lh1], h, nlp.cutest_lib)
  @cutest_error
  return
end

function cish(n::Int, x::Array{Float64, 1}, iprob::Int, lh::Int, cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val, h_row,
    h_col, cutest_lib)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function cish!(n::Int, x::Array{Float64, 1}, iprob::Int, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1},
    cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val,
    h_row_cp, h_col_cp, cutest_lib)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function cish!(n::Int, x::Array{Float64, 1}, iprob::Int, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1}, cutest_lib)
  io_err = Cint[0]
  nnzh = Cint[0]
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val, h_row,
    h_col, cutest_lib)
  @cutest_error
  return nnzh[1]
end

function cish(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val, h_row,
    h_col, nlp.cutest_lib)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function cish!(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val,
    h_row_cp, h_col_cp, nlp.cutest_lib)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function cish!(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Int,
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val, h_row,
    h_col, nlp.cutest_lib)
  @cutest_error
  return nnzh[1]
end

function csgrsh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, lh::Int, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nnzh, Cint[lh], h_val, h_row, h_col, cutest_lib)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, nnzh[1], h_val, h_row, h_col
end

function csgrsh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1}, lh::Int, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1}, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp, nnzh, Cint[lh], h_val, h_row_cp, h_col_cp,
    cutest_lib)
  @cutest_error
  for i = 1:lj
    j_var[i] = j_var_cp[i]
  end
  for i = 1:lj
    j_fun[i] = j_fun_cp[i]
  end
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzj[1], nnzh[1]
end

function csgrsh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Cint,
    1}, j_fun::Array{Cint, 1}, lh::Int, h_val::Array{Float64, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1}, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  nnzh = Cint[0]
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nnzh, Cint[lh], h_val, h_row, h_col, cutest_lib)
  @cutest_error
  return nnzj[1], nnzh[1]
end

function csgrsh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj + nlp.meta.nvar
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nnzh, Cint[lh], h_val, h_row, h_col,
    nlp.cutest_lib)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, nnzh[1], h_val, h_row, h_col
end

function csgrsh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1}, h_val::Array{Float64, 1}, h_row::Array{Int, 1},
    h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj + nlp.meta.nvar
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp, nnzh, Cint[lh], h_val, h_row_cp, h_col_cp,
    nlp.cutest_lib)
  @cutest_error
  for i = 1:lj
    j_var[i] = j_var_cp[i]
  end
  for i = 1:lj
    j_fun[i] = j_fun_cp[i]
  end
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzj[1], nnzh[1]
end

function csgrsh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, j_val::Array{Float64, 1}, j_var::Array{Cint, 1},
    j_fun::Array{Cint, 1}, h_val::Array{Float64, 1}, h_row::Array{Cint,
    1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj + nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nnzh, Cint[lh], h_val, h_row, h_col,
    nlp.cutest_lib)
  @cutest_error
  return nnzj[1], nnzh[1]
end

function csgreh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, lhe_ptr::Int, lhe_row::Int, lhe_val::Int,
    byrows::Bool, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  csgreh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows],
    cutest_lib)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function csgreh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1}, lhe_ptr::Int, he_row_ptr::Array{Int, 1},
    he_val_ptr::Array{Int, 1}, lhe_row::Int, he_row::Array{Int, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  csgreh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows], cutest_lib)
  @cutest_error
  for i = 1:lj
    j_var[i] = j_var_cp[i]
  end
  for i = 1:lj
    j_fun[i] = j_fun_cp[i]
  end
  for i = 1:lhe_ptr
    he_row_ptr[i] = he_row_ptr_cp[i]
  end
  for i = 1:lhe_ptr
    he_val_ptr[i] = he_val_ptr_cp[i]
  end
  for i = 1:lhe_row
    he_row[i] = he_row_cp[i]
  end
  return nnzj[1], ne[1]
end

function csgreh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Cint,
    1}, j_fun::Array{Cint, 1}, lhe_ptr::Int, he_row_ptr::Array{Cint, 1},
    he_val_ptr::Array{Cint, 1}, lhe_row::Int, he_row::Array{Cint, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool, cutest_lib)
  io_err = Cint[0]
  nnzj = Cint[0]
  ne = Cint[0]
  csgreh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows],
    cutest_lib)
  @cutest_error
  return nnzj[1], ne[1]
end

function csgreh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lhe_ptr::Int, lhe_row::Int, lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  csgreh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows],
    nlp.cutest_lib)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function csgreh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1}, lhe_ptr::Int, he_row_ptr::Array{Int, 1},
    he_val_ptr::Array{Int, 1}, lhe_row::Int, he_row::Array{Int, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  csgreh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows], nlp.cutest_lib)
  @cutest_error
  for i = 1:lj
    j_var[i] = j_var_cp[i]
  end
  for i = 1:lj
    j_fun[i] = j_fun_cp[i]
  end
  for i = 1:lhe_ptr
    he_row_ptr[i] = he_row_ptr_cp[i]
  end
  for i = 1:lhe_ptr
    he_val_ptr[i] = he_val_ptr_cp[i]
  end
  for i = 1:lhe_row
    he_row[i] = he_row_cp[i]
  end
  return nnzj[1], ne[1]
end

function csgreh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, j_val::Array{Float64, 1}, j_var::Array{Cint, 1},
    j_fun::Array{Cint, 1}, lhe_ptr::Int, he_row_ptr::Array{Cint, 1},
    he_val_ptr::Array{Cint, 1}, lhe_row::Int, he_row::Array{Cint, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  ne = Cint[0]
  csgreh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows],
    nlp.cutest_lib)
  @cutest_error
  return nnzj[1], ne[1]
end

function chprod(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  result = Array(Cdouble, n)
  chprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result,
    cutest_lib)
  @cutest_error
  return result
end

function chprod!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  chprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result,
    cutest_lib)
  @cutest_error
  return
end

function chprod(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  result = Array(Cdouble, n)
  chprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result,
    nlp.cutest_lib)
  @cutest_error
  return result
end

function chprod!(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  chprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result,
    nlp.cutest_lib)
  @cutest_error
  return
end

function chcprod(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  result = Array(Cdouble, n)
  chcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result,
    cutest_lib)
  @cutest_error
  return result
end

function chcprod!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1}, cutest_lib)
  io_err = Cint[0]
  chcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result,
    cutest_lib)
  @cutest_error
  return
end

function chcprod(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  result = Array(Cdouble, n)
  chcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result,
    nlp.cutest_lib)
  @cutest_error
  return result
end

function chcprod!(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  chcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result,
    nlp.cutest_lib)
  @cutest_error
  return
end

function cjprod(n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, lresult::Int, cutest_lib)
  io_err = Cint[0]
  result = Array(Cdouble, lresult)
  cjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    vector, Cint[lvector], result, Cint[lresult], cutest_lib)
  @cutest_error
  return result
end

function cjprod!(n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, result::Array{Float64, 1},
    lresult::Int, cutest_lib)
  io_err = Cint[0]
  cjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    vector, Cint[lvector], result, Cint[lresult], cutest_lib)
  @cutest_error
  return
end

function cjprod(nlp::CUTEstModel, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, lresult::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  result = Array(Cdouble, lresult)
  cjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    vector, Cint[lvector], result, Cint[lresult], nlp.cutest_lib)
  @cutest_error
  return result
end

function cjprod!(nlp::CUTEstModel, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, result::Array{Float64, 1},
    lresult::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  cjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    vector, Cint[lvector], result, Cint[lresult], nlp.cutest_lib)
  @cutest_error
  return
end

function uterminate(cutest_lib)
  io_err = Cint[0]
  uterminate(io_err, cutest_lib)
  @cutest_error
  return
end

function cterminate(cutest_lib)
  io_err = Cint[0]
  cterminate(io_err, cutest_lib)
  @cutest_error
  return
end

