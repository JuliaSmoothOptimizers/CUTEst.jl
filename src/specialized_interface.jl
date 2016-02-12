export usetup, csetup, udimen, udimsh, udimse, uvartype, unames,
    ureport, cdimen, cdimsj, cdimsh, cdimchp, cdimse, cstats, cvartype,
    cnames, creport, connames, pname, probname, varnames, ufn, ugr, uofg,
    udh, ushp, ush, ueh, ugrdh, ugrsh, ugreh, uhprod, ushprod, ubandh,
    cfn, cofg, cofsg, ccfg, clfg, cgr, csgr, ccfsg, ccifg, ccifsg, cgrdh,
    cdh, cdhc, cshp, csh, cshc, ceh, cidh, cish, csgrsh, csgreh, chprod,
    cshprod, chcprod, cshcprod, cjprod, csjprod, cchprods, uterminate,
    cterminate
export usetup!, csetup!, udimen!, udimsh!, udimse!, uvartype!,
    unames!, ureport!, cdimen!, cdimsj!, cdimsh!, cdimchp!, cdimse!,
    cstats!, cvartype!, cnames!, creport!, connames!, pname!, probname!,
    varnames!, ufn!, ugr!, uofg!, udh!, ushp!, ush!, ueh!, ugrdh!, ugrsh!,
    ugreh!, uhprod!, ushprod!, ubandh!, cfn!, cofg!, cofsg!, ccfg!, clfg!,
    cgr!, csgr!, ccfsg!, ccifg!, ccifsg!, cgrdh!, cdh!, cdhc!, cshp!,
    csh!, cshc!, ceh!, cidh!, cish!, csgrsh!, csgreh!, chprod!, cshprod!,
    chcprod!, cshcprod!, cjprod!, csjprod!, cchprods!, uterminate!,
    cterminate!

function usetup(input::Int, out::Int, io_buffer::Int, n::Int)
  io_err = Cint[0]
  x = Array(Cdouble, n)
  x_l = Array(Cdouble, n)
  x_u = Array(Cdouble, n)
  usetup(io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n], x,
    x_l, x_u)
  @cutest_error
  return x, x_l, x_u
end

function usetup!(input::Int, out::Int, io_buffer::Int, n::Int, x::Array{Float64, 1},
    x_l::Array{Float64, 1}, x_u::Array{Float64, 1})
  io_err = Cint[0]
  usetup(io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n], x,
    x_l, x_u)
  @cutest_error
  return
end

function csetup(input::Int, out::Int, io_buffer::Int, n::Int, m::Int, e_order::Int,
    l_order::Int, v_order::Int)
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
    Cint[l_order], Cint[v_order])
  @cutest_error
  return x, x_l, x_u, y, c_l, c_u, equatn, linear
end

function csetup!(input::Int, out::Int, io_buffer::Int, n::Int, m::Int,
    x::Array{Float64, 1}, x_l::Array{Float64, 1}, x_u::Array{Float64, 1},
    y::Array{Float64, 1}, c_l::Array{Float64, 1}, c_u::Array{Float64, 1},
    equatn::Array{Bool, 1}, linear::Array{Bool, 1}, e_order::Int,
    l_order::Int, v_order::Int)
  io_err = Cint[0]
  csetup(io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n],
    Cint[m], x, x_l, x_u, y, c_l, c_u, equatn, linear, Cint[e_order],
    Cint[l_order], Cint[v_order])
  @cutest_error
  return
end

function udimen(input::Int)
  io_err = Cint[0]
  n = Cint[0]
  udimen(io_err, Cint[input], n)
  @cutest_error
  return n[1]
end

function udimsh()  io_err = Cint[0]
  nnzh = Cint[0]
  udimsh(io_err, nnzh)
  @cutest_error
  return nnzh[1]
end

function udimse()  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  udimse(io_err, ne, he_val_ne, he_row_ne)
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function uvartype(n::Int)
  io_err = Cint[0]
  x_type = Array(Cint, n)
  uvartype(io_err, Cint[n], x_type)
  @cutest_error
  return x_type
end

function uvartype!(n::Int, x_type::Array{Int, 1})
  io_err = Cint[0]
  x_type_cp = Array(Cint, n)
  uvartype(io_err, Cint[n], x_type_cp)
  @cutest_error
  for i = 1:n
    x_type[i] = x_type_cp[i]
  end
  return
end

function uvartype!(n::Int, x_type::Array{Cint, 1})
  io_err = Cint[0]
  uvartype(io_err, Cint[n], x_type)
  @cutest_error
  return
end

function unames(n::Int)
  io_err = Cint[0]
  pname = Cchar[0]
  vname = Array(Cchar, n)
  unames(io_err, Cint[n], pname, vname)
  @cutest_error
  return pname[1], vname
end

function unames!(n::Int, vname::Array{UInt8, 1})
  io_err = Cint[0]
  pname = Cchar[0]
  unames(io_err, Cint[n], pname, vname)
  @cutest_error
  return pname[1]
end

function ureport()  io_err = Cint[0]
  calls = Array(Cdouble, 4)
  time = Array(Cdouble, 2)
  ureport(io_err, calls, time)
  @cutest_error
  return calls, time
end

function ureport!(calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  ureport(io_err, calls, time)
  @cutest_error
  return
end

function ureport()
  io_err = Cint[0]
  calls = Array(Cdouble, 4)
  time = Array(Cdouble, 2)
  ureport(io_err, calls, time)
  @cutest_error
  return calls, time
end

function ureport!(calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  ureport(io_err, calls, time)
  @cutest_error
  return
end

function cdimen(input::Int)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  cdimen(io_err, Cint[input], n, m)
  @cutest_error
  return n[1], m[1]
end

function cdimsj()  io_err = Cint[0]
  nnzj = Cint[0]
  cdimsj(io_err, nnzj)
  @cutest_error
  return nnzj[1]
end

function cdimsh()  io_err = Cint[0]
  nnzh = Cint[0]
  cdimsh(io_err, nnzh)
  @cutest_error
  return nnzh[1]
end

function cdimchp()  io_err = Cint[0]
  nnzchp = Cint[0]
  cdimchp(io_err, nnzchp)
  @cutest_error
  return nnzchp[1]
end

function cdimchp()
  io_err = Cint[0]
  nnzchp = Cint[0]
  cdimchp(io_err, nnzchp)
  @cutest_error
  return nnzchp[1]
end

function cdimse()  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  cdimse(io_err, ne, he_val_ne, he_row_ne)
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function cstats()  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  cstats(io_err, nonlinear_variables_objective,
    nonlinear_variables_constraints, equality_constraints,
    linear_constraints)
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function cstats()
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  cstats(io_err, nonlinear_variables_objective,
    nonlinear_variables_constraints, equality_constraints,
    linear_constraints)
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function cvartype(n::Int)
  io_err = Cint[0]
  x_type = Array(Cint, n)
  cvartype(io_err, Cint[n], x_type)
  @cutest_error
  return x_type
end

function cvartype!(n::Int, x_type::Array{Int, 1})
  io_err = Cint[0]
  x_type_cp = Array(Cint, n)
  cvartype(io_err, Cint[n], x_type_cp)
  @cutest_error
  for i = 1:n
    x_type[i] = x_type_cp[i]
  end
  return
end

function cvartype!(n::Int, x_type::Array{Cint, 1})
  io_err = Cint[0]
  cvartype(io_err, Cint[n], x_type)
  @cutest_error
  return
end

function cnames(n::Int, m::Int)
  io_err = Cint[0]
  pname = Cchar[0]
  vname = Array(Cchar, n)
  cname = Array(Cchar, m)
  cnames(io_err, Cint[n], Cint[m], pname, vname, cname)
  @cutest_error
  return pname[1], vname, cname
end

function cnames!(n::Int, m::Int, vname::Array{UInt8, 1}, cname::Array{UInt8, 1})
  io_err = Cint[0]
  pname = Cchar[0]
  cnames(io_err, Cint[n], Cint[m], pname, vname, cname)
  @cutest_error
  return pname[1]
end

function cnames()
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  pname = Cchar[0]
  vname = Array(Cchar, n)
  cname = Array(Cchar, m)
  cnames(io_err, Cint[n], Cint[m], pname, vname, cname)
  @cutest_error
  return pname[1], vname, cname
end

function cnames!(vname::Array{UInt8, 1}, cname::Array{UInt8, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  pname = Cchar[0]
  cnames(io_err, Cint[n], Cint[m], pname, vname, cname)
  @cutest_error
  return pname[1]
end

function creport()  io_err = Cint[0]
  calls = Array(Cdouble, 7)
  time = Array(Cdouble, 2)
  creport(io_err, calls, time)
  @cutest_error
  return calls, time
end

function creport!(calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  creport(io_err, calls, time)
  @cutest_error
  return
end

function creport()
  io_err = Cint[0]
  calls = Array(Cdouble, 7)
  time = Array(Cdouble, 2)
  creport(io_err, calls, time)
  @cutest_error
  return calls, time
end

function creport!(calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  creport(io_err, calls, time)
  @cutest_error
  return
end

function connames(m::Int)
  io_err = Cint[0]
  cname = Array(Cchar, m)
  connames(io_err, Cint[m], cname)
  @cutest_error
  return cname
end

function connames!(m::Int, cname::Array{UInt8, 1})
  io_err = Cint[0]
  connames(io_err, Cint[m], cname)
  @cutest_error
  return
end

function connames()
  io_err = Cint[0]
  m = nlp.ncon
  cname = Array(Cchar, m)
  connames(io_err, Cint[m], cname)
  @cutest_error
  return cname
end

function connames!(cname::Array{UInt8, 1})
  io_err = Cint[0]
  m = nlp.ncon
  connames(io_err, Cint[m], cname)
  @cutest_error
  return
end

function pname(input::Int)
  io_err = Cint[0]
  pname = Cchar[0]
  pname(io_err, Cint[input], pname)
  @cutest_error
  return pname[1]
end

function pname(input::Int)
  io_err = Cint[0]
  pname = Cchar[0]
  pname(io_err, Cint[input], pname)
  @cutest_error
  return pname[1]
end

function probname()  io_err = Cint[0]
  pname = Cchar[0]
  probname(io_err, pname)
  @cutest_error
  return pname[1]
end

function probname()
  io_err = Cint[0]
  pname = Cchar[0]
  probname(io_err, pname)
  @cutest_error
  return pname[1]
end

function varnames(n::Int)
  io_err = Cint[0]
  vname = Array(Cchar, n)
  varnames(io_err, Cint[n], vname)
  @cutest_error
  return vname
end

function varnames!(n::Int, vname::Array{UInt8, 1})
  io_err = Cint[0]
  varnames(io_err, Cint[n], vname)
  @cutest_error
  return
end

function ufn(n::Int, x::Array{Float64, 1})
  io_err = Cint[0]
  f = Cdouble[0]
  ufn(io_err, Cint[n], x, f)
  @cutest_error
  return f[1]
end

function ufn(x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  f = Cdouble[0]
  ufn(io_err, Cint[n], x, f)
  @cutest_error
  return f[1]
end

function ugr(n::Int, x::Array{Float64, 1})
  io_err = Cint[0]
  g = Array(Cdouble, n)
  ugr(io_err, Cint[n], x, g)
  @cutest_error
  return g
end

function ugr!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1})
  io_err = Cint[0]
  ugr(io_err, Cint[n], x, g)
  @cutest_error
  return
end

function ugr(x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  g = Array(Cdouble, n)
  ugr(io_err, Cint[n], x, g)
  @cutest_error
  return g
end

function ugr!(x::Array{Float64, 1}, g::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  ugr(io_err, Cint[n], x, g)
  @cutest_error
  return
end

function uofg(n::Int, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  uofg(io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1], g
end

function uofg!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  uofg(io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1]
end

function uofg(x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  f = Cdouble[0]
  g = Array(Cdouble, n)
  uofg(io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1], g
end

function uofg!(x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  f = Cdouble[0]
  uofg(io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1]
end

function udh(n::Int, x::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  h = Array(Cdouble, lh1, n)
  udh(io_err, Cint[n], x, Cint[lh1], h)
  @cutest_error
  return h
end

function udh!(n::Int, x::Array{Float64, 1}, lh1::Int, h::Array{Float64, 2})
  io_err = Cint[0]
  udh(io_err, Cint[n], x, Cint[lh1], h)
  @cutest_error
  return
end

function udh(x::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  n = nlp.nvar
  h = Array(Cdouble, lh1, n)
  udh(io_err, Cint[n], x, Cint[lh1], h)
  @cutest_error
  return h
end

function udh!(x::Array{Float64, 1}, lh1::Int, h::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.nvar
  udh(io_err, Cint[n], x, Cint[lh1], h)
  @cutest_error
  return
end

function ushp(n::Int, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ushp(io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1], h_row, h_col
end

function ushp!(n::Int, lh::Int, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  ushp(io_err, Cint[n], nnzh, Cint[lh], h_row_cp, h_col_cp)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function ushp!(n::Int, lh::Int, h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  ushp(io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1]
end

function ushp()
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ushp(io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1], h_row, h_col
end

function ushp!(h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  ushp(io_err, Cint[n], nnzh, Cint[lh], h_row_cp, h_col_cp)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function ushp!(h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  ushp(io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1]
end

function ush(n::Int, x::Array{Float64, 1}, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function ush!(n::Int, x::Array{Float64, 1}, lh::Int, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row_cp, h_col_cp)
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
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzh[1]
end

function ush(x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function ush!(x::Array{Float64, 1}, h_val::Array{Float64, 1}, h_row::Array{Int, 1},
    h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row_cp, h_col_cp)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function ush!(x::Array{Float64, 1}, h_val::Array{Float64, 1}, h_row::Array{Cint,
    1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  ush(io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzh[1]
end

function ueh(n::Int, x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int,
    lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ueh!(n::Int, x::Array{Float64, 1}, lhe_ptr::Int, he_row_ptr::Array{Int,
    1}, he_val_ptr::Array{Int, 1}, lhe_row::Int, he_row::Array{Int, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows])
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
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return ne[1]
end

function ueh(x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int, lhe_val::Int,
    byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ueh!(x::Array{Float64, 1}, lhe_ptr::Int, he_row_ptr::Array{Int, 1},
    he_val_ptr::Array{Int, 1}, lhe_row::Int, he_row::Array{Int, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows])
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

function ueh!(x::Array{Float64, 1}, lhe_ptr::Int, he_row_ptr::Array{Cint, 1},
    he_val_ptr::Array{Cint, 1}, lhe_row::Int, he_row::Array{Cint, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  ne = Cint[0]
  ueh(io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return ne[1]
end

function ugrdh(n::Int, x::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  h = Array(Cdouble, lh1, n)
  ugrdh(io_err, Cint[n], x, g, Cint[lh1], h)
  @cutest_error
  return g, h
end

function ugrdh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lh1::Int,
    h::Array{Float64, 2})
  io_err = Cint[0]
  ugrdh(io_err, Cint[n], x, g, Cint[lh1], h)
  @cutest_error
  return
end

function ugrdh(x::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  n = nlp.nvar
  g = Array(Cdouble, n)
  h = Array(Cdouble, lh1, n)
  ugrdh(io_err, Cint[n], x, g, Cint[lh1], h)
  @cutest_error
  return g, h
end

function ugrdh!(x::Array{Float64, 1}, g::Array{Float64, 1}, lh1::Int,
    h::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.nvar
  ugrdh(io_err, Cint[n], x, g, Cint[lh1], h)
  @cutest_error
  return
end

function ugrsh(n::Int, x::Array{Float64, 1}, lh::Int)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return g, nnzh[1], h_val, h_row, h_col
end

function ugrsh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row_cp,
    h_col_cp)
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
    1})
  io_err = Cint[0]
  nnzh = Cint[0]
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzh[1]
end

function ugrsh(x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  g = Array(Cdouble, n)
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return g, nnzh[1], h_val, h_row, h_col
end

function ugrsh!(x::Array{Float64, 1}, g::Array{Float64, 1}, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row_cp,
    h_col_cp)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function ugrsh!(x::Array{Float64, 1}, g::Array{Float64, 1}, h_val::Array{Float64, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  ugrsh(io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzh[1]
end

function ugreh(n::Int, x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int,
    lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return g, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ugreh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1}, lhe_row::Int,
    he_row::Array{Int, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows])
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
    byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return ne[1]
end

function ugreh(x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int, lhe_val::Int,
    byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  g = Array(Cdouble, n)
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return g, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ugreh!(x::Array{Float64, 1}, g::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1}, lhe_row::Int,
    he_row::Array{Int, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows])
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

function ugreh!(x::Array{Float64, 1}, g::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1}, lhe_row::Int,
    he_row::Array{Cint, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  ne = Cint[0]
  ugreh(io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return ne[1]
end

function uhprod(n::Int, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  result = Array(Cdouble, n)
  uhprod(io_err, Cint[n], Cint[goth], x, vector, result)
  @cutest_error
  return result
end

function uhprod!(n::Int, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  uhprod(io_err, Cint[n], Cint[goth], x, vector, result)
  @cutest_error
  return
end

function uhprod(goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  result = Array(Cdouble, n)
  uhprod(io_err, Cint[n], Cint[goth], x, vector, result)
  @cutest_error
  return result
end

function uhprod!(goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  uhprod(io_err, Cint[n], Cint[goth], x, vector, result)
  @cutest_error
  return
end

function ushprod(n::Int, goth::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Int, 1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, n)
  ushprod(io_err, Cint[n], Cint[goth], x, Cint[nnz_vector],
    index_nz_vector, vector, nnz_result, index_nz_result, result)
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

function ushprod!(n::Int, goth::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Int, 1}, vector::Array{Float64, 1},
    index_nz_result::Array{Int, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result_cp = Array(Cint, n)
  ushprod(io_err, Cint[n], Cint[goth], x, Cint[nnz_vector],
    index_nz_vector, vector, nnz_result, index_nz_result_cp, result)
  @cutest_error
  for i = 1:n
    index_nz_result[i] = index_nz_result_cp[i]
  end
  return nnz_result[1]
end

function ushprod!(n::Int, goth::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Int, 1}, vector::Array{Float64, 1},
    index_nz_result::Array{Cint, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  ushprod(io_err, Cint[n], Cint[goth], x, Cint[nnz_vector],
    index_nz_vector, vector, nnz_result, index_nz_result, result)
  @cutest_error
  return nnz_result[1]
end

function ushprod(goth::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Int, 1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, n)
  ushprod(io_err, Cint[n], Cint[goth], x, Cint[nnz_vector],
    index_nz_vector, vector, nnz_result, index_nz_result, result)
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

function ushprod!(goth::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Int, 1}, vector::Array{Float64, 1},
    index_nz_result::Array{Int, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnz_result = Cint[0]
  index_nz_result_cp = Array(Cint, n)
  ushprod(io_err, Cint[n], Cint[goth], x, Cint[nnz_vector],
    index_nz_vector, vector, nnz_result, index_nz_result_cp, result)
  @cutest_error
  for i = 1:n
    index_nz_result[i] = index_nz_result_cp[i]
  end
  return nnz_result[1]
end

function ushprod!(goth::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Int, 1}, vector::Array{Float64, 1},
    index_nz_result::Array{Cint, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnz_result = Cint[0]
  ushprod(io_err, Cint[n], Cint[goth], x, Cint[nnz_vector],
    index_nz_vector, vector, nnz_result, index_nz_result, result)
  @cutest_error
  return nnz_result[1]
end

function ubandh(n::Int, x::Array{Float64, 1}, semibandwidth::Int, lbandh::Int)
  io_err = Cint[0]
  h_band = Array(Cdouble, lbandh - 0 + 1, n)
  max_semibandwidth = Cint[0]
  ubandh(io_err, Cint[n], x, Cint[semibandwidth], h_band,
    Cint[lbandh], max_semibandwidth)
  @cutest_error
  return h_band, max_semibandwidth[1]
end

function ubandh!(n::Int, x::Array{Float64, 1}, semibandwidth::Int,
    h_band::Array{Float64, 2}, lbandh::Int)
  io_err = Cint[0]
  max_semibandwidth = Cint[0]
  ubandh(io_err, Cint[n], x, Cint[semibandwidth], h_band,
    Cint[lbandh], max_semibandwidth)
  @cutest_error
  return max_semibandwidth[1]
end

function ubandh(x::Array{Float64, 1}, semibandwidth::Int, lbandh::Int)
  io_err = Cint[0]
  n = nlp.nvar
  h_band = Array(Cdouble, lbandh - 0 + 1, n)
  max_semibandwidth = Cint[0]
  ubandh(io_err, Cint[n], x, Cint[semibandwidth], h_band,
    Cint[lbandh], max_semibandwidth)
  @cutest_error
  return h_band, max_semibandwidth[1]
end

function ubandh!(x::Array{Float64, 1}, semibandwidth::Int, h_band::Array{Float64, 2},
    lbandh::Int)
  io_err = Cint[0]
  n = nlp.nvar
  max_semibandwidth = Cint[0]
  ubandh(io_err, Cint[n], x, Cint[semibandwidth], h_band,
    Cint[lbandh], max_semibandwidth)
  @cutest_error
  return max_semibandwidth[1]
end

function cfn(n::Int, m::Int, x::Array{Float64, 1})
  io_err = Cint[0]
  f = Cdouble[0]
  c = Array(Cdouble, m)
  cfn(io_err, Cint[n], Cint[m], x, f, c)
  @cutest_error
  return f[1], c
end

function cfn!(n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1})
  io_err = Cint[0]
  f = Cdouble[0]
  cfn(io_err, Cint[n], Cint[m], x, f, c)
  @cutest_error
  return f[1]
end

function cfn(x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  f = Cdouble[0]
  c = Array(Cdouble, m)
  cfn(io_err, Cint[n], Cint[m], x, f, c)
  @cutest_error
  return f[1], c
end

function cfn!(x::Array{Float64, 1}, c::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  f = Cdouble[0]
  cfn(io_err, Cint[n], Cint[m], x, f, c)
  @cutest_error
  return f[1]
end

function cofg(n::Int, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  cofg(io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1], g
end

function cofg!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  cofg(io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1]
end

function cofg(x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  f = Cdouble[0]
  g = Array(Cdouble, n)
  cofg(io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1], g
end

function cofg!(x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  f = Cdouble[0]
  cofg(io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1]
end

function cofsg(n::Int, x::Array{Float64, 1}, lg::Int, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  g_val = Array(Cdouble, lg)
  g_var = Array(Cint, lg)
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var,
    Cint[grad])
  @cutest_error
  return f[1], nnzg[1], g_val, g_var
end

function cofsg!(n::Int, x::Array{Float64, 1}, lg::Int, g_val::Array{Float64, 1},
    g_var::Array{Int, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  g_var_cp = Array(Cint, lg)
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var_cp,
    Cint[grad])
  @cutest_error
  for i = 1:lg
    g_var[i] = g_var_cp[i]
  end
  return f[1], nnzg[1]
end

function cofsg!(n::Int, x::Array{Float64, 1}, lg::Int, g_val::Array{Float64, 1},
    g_var::Array{Cint, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var,
    Cint[grad])
  @cutest_error
  return f[1], nnzg[1]
end

function cofsg(x::Array{Float64, 1}, lg::Int, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  f = Cdouble[0]
  nnzg = Cint[0]
  g_val = Array(Cdouble, lg)
  g_var = Array(Cint, lg)
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var,
    Cint[grad])
  @cutest_error
  return f[1], nnzg[1], g_val, g_var
end

function cofsg!(x::Array{Float64, 1}, lg::Int, g_val::Array{Float64, 1},
    g_var::Array{Int, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  f = Cdouble[0]
  nnzg = Cint[0]
  g_var_cp = Array(Cint, lg)
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var_cp,
    Cint[grad])
  @cutest_error
  for i = 1:lg
    g_var[i] = g_var_cp[i]
  end
  return f[1], nnzg[1]
end

function cofsg!(x::Array{Float64, 1}, lg::Int, g_val::Array{Float64, 1},
    g_var::Array{Cint, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  f = Cdouble[0]
  nnzg = Cint[0]
  cofsg(io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var,
    Cint[grad])
  @cutest_error
  return f[1], nnzg[1]
end

function ccfg(n::Int, m::Int, x::Array{Float64, 1}, jtrans::Bool, lcjac1::Int,
    lcjac2::Int, grad::Bool)
  io_err = Cint[0]
  c = Array(Cdouble, m)
  cjac = Array(Cdouble, lcjac1, lcjac2)
  ccfg(io_err, Cint[n], Cint[m], x, c, Cint[jtrans], Cint[lcjac1],
    Cint[lcjac2], cjac, Cint[grad])
  @cutest_error
  return c, cjac
end

function ccfg!(n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1},
    jtrans::Bool, lcjac1::Int, lcjac2::Int, cjac::Array{Float64, 2},
    grad::Bool)
  io_err = Cint[0]
  ccfg(io_err, Cint[n], Cint[m], x, c, Cint[jtrans], Cint[lcjac1],
    Cint[lcjac2], cjac, Cint[grad])
  @cutest_error
  return
end

function ccfg(x::Array{Float64, 1}, jtrans::Bool, lcjac1::Int, lcjac2::Int,
    grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  c = Array(Cdouble, m)
  cjac = Array(Cdouble, lcjac1, lcjac2)
  ccfg(io_err, Cint[n], Cint[m], x, c, Cint[jtrans], Cint[lcjac1],
    Cint[lcjac2], cjac, Cint[grad])
  @cutest_error
  return c, cjac
end

function ccfg!(x::Array{Float64, 1}, c::Array{Float64, 1}, jtrans::Bool,
    lcjac1::Int, lcjac2::Int, cjac::Array{Float64, 2}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  ccfg(io_err, Cint[n], Cint[m], x, c, Cint[jtrans], Cint[lcjac1],
    Cint[lcjac2], cjac, Cint[grad])
  @cutest_error
  return
end

function clfg(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  clfg(io_err, Cint[n], Cint[m], x, y, f, g, Cint[grad])
  @cutest_error
  return f[1], g
end

function clfg!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  clfg(io_err, Cint[n], Cint[m], x, y, f, g, Cint[grad])
  @cutest_error
  return f[1]
end

function clfg(x::Array{Float64, 1}, y::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  f = Cdouble[0]
  g = Array(Cdouble, n)
  clfg(io_err, Cint[n], Cint[m], x, y, f, g, Cint[grad])
  @cutest_error
  return f[1], g
end

function clfg!(x::Array{Float64, 1}, y::Array{Float64, 1}, g::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  f = Cdouble[0]
  clfg(io_err, Cint[n], Cint[m], x, y, f, g, Cint[grad])
  @cutest_error
  return f[1]
end

function cgr(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Int, lj2::Int)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  cgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val)
  @cutest_error
  return g, j_val
end

function cgr!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2})
  io_err = Cint[0]
  cgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val)
  @cutest_error
  return
end

function cgr(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    jtrans::Bool, lj1::Int, lj2::Int)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  cgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val)
  @cutest_error
  return g, j_val
end

function cgr!(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  cgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val)
  @cutest_error
  return
end

function csgr(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

function csgr!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1})
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp)
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
    1}, j_fun::Array{Cint, 1})
  io_err = Cint[0]
  nnzj = Cint[0]
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun)
  @cutest_error
  return nnzj[1]
end

function csgr(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj + nlp.nvar
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

function csgr!(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    j_val::Array{Float64, 1}, j_var::Array{Int, 1}, j_fun::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj + nlp.nvar
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp)
  @cutest_error
  for i = 1:lj
    j_var[i] = j_var_cp[i]
  end
  for i = 1:lj
    j_fun[i] = j_fun_cp[i]
  end
  return nnzj[1]
end

function csgr!(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    j_val::Array{Float64, 1}, j_var::Array{Cint, 1}, j_fun::Array{Cint,
    1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj + nlp.nvar
  csgr(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun)
  @cutest_error
  return nnzj[1]
end

function ccfsg(n::Int, m::Int, x::Array{Float64, 1}, lj::Int, grad::Bool)
  io_err = Cint[0]
  c = Array(Cdouble, m)
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val, j_var,
    j_fun, Cint[grad])
  @cutest_error
  return c, nnzj[1], j_val, j_var, j_fun
end

function ccfsg!(n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1}, lj::Int,
    j_val::Array{Float64, 1}, j_var::Array{Int, 1}, j_fun::Array{Int, 1},
    grad::Bool)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val,
    j_var_cp, j_fun_cp, Cint[grad])
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
    1}, grad::Bool)
  io_err = Cint[0]
  nnzj = Cint[0]
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val, j_var,
    j_fun, Cint[grad])
  @cutest_error
  return nnzj[1]
end

function ccfsg(x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  c = Array(Cdouble, m)
  nnzj = Cint[0]
  lj = nlp.nnzj
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val, j_var,
    j_fun, Cint[grad])
  @cutest_error
  return c, nnzj[1], j_val, j_var, j_fun
end

function ccfsg!(x::Array{Float64, 1}, c::Array{Float64, 1}, j_val::Array{Float64, 1},
    j_var::Array{Int, 1}, j_fun::Array{Int, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val,
    j_var_cp, j_fun_cp, Cint[grad])
  @cutest_error
  for i = 1:lj
    j_var[i] = j_var_cp[i]
  end
  for i = 1:lj
    j_fun[i] = j_fun_cp[i]
  end
  return nnzj[1]
end

function ccfsg!(x::Array{Float64, 1}, c::Array{Float64, 1}, j_val::Array{Float64, 1},
    j_var::Array{Cint, 1}, j_fun::Array{Cint, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj
  ccfsg(io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val, j_var,
    j_fun, Cint[grad])
  @cutest_error
  return nnzj[1]
end

function ccifg(n::Int, icon::Int, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  ci = Cdouble[0]
  gci = Array(Cdouble, n)
  ccifg(io_err, Cint[n], Cint[icon], x, ci, gci, Cint[grad])
  @cutest_error
  return ci[1], gci
end

function ccifg!(n::Int, icon::Int, x::Array{Float64, 1}, gci::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  ci = Cdouble[0]
  ccifg(io_err, Cint[n], Cint[icon], x, ci, gci, Cint[grad])
  @cutest_error
  return ci[1]
end

function ccifg(icon::Int, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  ci = Cdouble[0]
  gci = Array(Cdouble, n)
  ccifg(io_err, Cint[n], Cint[icon], x, ci, gci, Cint[grad])
  @cutest_error
  return ci[1], gci
end

function ccifg!(icon::Int, x::Array{Float64, 1}, gci::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  ci = Cdouble[0]
  ccifg(io_err, Cint[n], Cint[icon], x, ci, gci, Cint[grad])
  @cutest_error
  return ci[1]
end

function ccifsg(n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int, grad::Bool)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_val = Array(Cdouble, lgci)
  gci_var = Array(Cint, lgci)
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var, Cint[grad])
  @cutest_error
  return ci[1], nnzgci[1], gci_val, gci_var
end

function ccifsg!(n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int,
    gci_val::Array{Float64, 1}, gci_var::Array{Int, 1}, grad::Bool)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_var_cp = Array(Cint, lgci)
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var_cp, Cint[grad])
  @cutest_error
  for i = 1:lgci
    gci_var[i] = gci_var_cp[i]
  end
  return ci[1], nnzgci[1]
end

function ccifsg!(n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int,
    gci_val::Array{Float64, 1}, gci_var::Array{Cint, 1}, grad::Bool)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var, Cint[grad])
  @cutest_error
  return ci[1], nnzgci[1]
end

function ccifsg(icon::Int, x::Array{Float64, 1}, lgci::Int, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_val = Array(Cdouble, lgci)
  gci_var = Array(Cint, lgci)
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var, Cint[grad])
  @cutest_error
  return ci[1], nnzgci[1], gci_val, gci_var
end

function ccifsg!(icon::Int, x::Array{Float64, 1}, lgci::Int, gci_val::Array{Float64,
    1}, gci_var::Array{Int, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_var_cp = Array(Cint, lgci)
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var_cp, Cint[grad])
  @cutest_error
  for i = 1:lgci
    gci_var[i] = gci_var_cp[i]
  end
  return ci[1], nnzgci[1]
end

function ccifsg!(icon::Int, x::Array{Float64, 1}, lgci::Int, gci_val::Array{Float64,
    1}, gci_var::Array{Cint, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  ci = Cdouble[0]
  nnzgci = Cint[0]
  ccifsg(io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var, Cint[grad])
  @cutest_error
  return ci[1], nnzgci[1]
end

function cgrdh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Int, lj2::Int, lh1::Int)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  h_val = Array(Cdouble, lh1, n)
  cgrdh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, Cint[lh1], h_val)
  @cutest_error
  return g, j_val, h_val
end

function cgrdh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2}, lh1::Int, h_val::Array{Float64, 2})
  io_err = Cint[0]
  cgrdh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, Cint[lh1], h_val)
  @cutest_error
  return
end

function cgrdh(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    jtrans::Bool, lj1::Int, lj2::Int, lh1::Int)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  h_val = Array(Cdouble, lh1, n)
  cgrdh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, Cint[lh1], h_val)
  @cutest_error
  return g, j_val, h_val
end

function cgrdh!(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2}, lh1::Int, h_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  cgrdh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, Cint[lh1], h_val)
  @cutest_error
  return
end

function cdh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  h_val = Array(Cdouble, lh1, n)
  cdh(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return h_val
end

function cdh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int,
    h_val::Array{Float64, 2})
  io_err = Cint[0]
  cdh(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return
end

function cdh(x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  h_val = Array(Cdouble, lh1, n)
  cdh(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return h_val
end

function cdh!(x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int,
    h_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  cdh(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return
end

function cdhc(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  h_val = Array(Cdouble, lh1, n)
  cdhc(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return h_val
end

function cdhc!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int,
    h_val::Array{Float64, 2})
  io_err = Cint[0]
  cdhc(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return
end

function cdhc(x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  h_val = Array(Cdouble, lh1, n)
  cdhc(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return h_val
end

function cdhc!(x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int,
    h_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  cdhc(io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return
end

function cshp(n::Int, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cshp(io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1], h_row, h_col
end

function cshp!(n::Int, lh::Int, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  cshp(io_err, Cint[n], nnzh, Cint[lh], h_row_cp, h_col_cp)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function cshp!(n::Int, lh::Int, h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  cshp(io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1]
end

function cshp()
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cshp(io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1], h_row, h_col
end

function cshp!(h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  cshp(io_err, Cint[n], nnzh, Cint[lh], h_row_cp, h_col_cp)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function cshp!(h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  cshp(io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1]
end

function csh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function csh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row_cp,
    h_col_cp)
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
    1})
  io_err = Cint[0]
  nnzh = Cint[0]
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1]
end

function csh(x::Array{Float64, 1}, y::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function csh!(x::Array{Float64, 1}, y::Array{Float64, 1}, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row_cp,
    h_col_cp)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function csh!(x::Array{Float64, 1}, y::Array{Float64, 1}, h_val::Array{Float64, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzh = Cint[0]
  lh = nlp.nnzh
  csh(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1]
end

function cshc(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function cshc!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val,
    h_row_cp, h_col_cp)
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
    1})
  io_err = Cint[0]
  nnzh = Cint[0]
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1]
end

function cshc(x::Array{Float64, 1}, y::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function cshc!(x::Array{Float64, 1}, y::Array{Float64, 1}, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val,
    h_row_cp, h_col_cp)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function cshc!(x::Array{Float64, 1}, y::Array{Float64, 1}, h_val::Array{Float64, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzh = Cint[0]
  lh = nlp.nnzh
  cshc(io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1]
end

function ceh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, lhe_row::Int, lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ceh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1},
    lhe_row::Int, he_row::Array{Int, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr],
    he_row_ptr_cp, he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val],
    he_val, Cint[byrows])
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
    he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return ne[1]
end

function ceh(x::Array{Float64, 1}, y::Array{Float64, 1}, lhe_ptr::Int,
    lhe_row::Int, lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ceh!(x::Array{Float64, 1}, y::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1}, lhe_row::Int,
    he_row::Array{Int, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr],
    he_row_ptr_cp, he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val],
    he_val, Cint[byrows])
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

function ceh!(x::Array{Float64, 1}, y::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1}, lhe_row::Int,
    he_row::Array{Cint, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  ne = Cint[0]
  ceh(io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return ne[1]
end

function cidh(n::Int, x::Array{Float64, 1}, iprob::Int, lh1::Int)
  io_err = Cint[0]
  h = Array(Cdouble, lh1, n)
  cidh(io_err, Cint[n], x, Cint[iprob], Cint[lh1], h)
  @cutest_error
  return h
end

function cidh!(n::Int, x::Array{Float64, 1}, iprob::Int, lh1::Int, h::Array{Float64,
    2})
  io_err = Cint[0]
  cidh(io_err, Cint[n], x, Cint[iprob], Cint[lh1], h)
  @cutest_error
  return
end

function cidh(x::Array{Float64, 1}, iprob::Int, lh1::Int)
  io_err = Cint[0]
  n = nlp.nvar
  h = Array(Cdouble, lh1, n)
  cidh(io_err, Cint[n], x, Cint[iprob], Cint[lh1], h)
  @cutest_error
  return h
end

function cidh!(x::Array{Float64, 1}, iprob::Int, lh1::Int, h::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.nvar
  cidh(io_err, Cint[n], x, Cint[iprob], Cint[lh1], h)
  @cutest_error
  return
end

function cish(n::Int, x::Array{Float64, 1}, iprob::Int, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function cish!(n::Int, x::Array{Float64, 1}, iprob::Int, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val,
    h_row_cp, h_col_cp)
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
    1})
  io_err = Cint[0]
  nnzh = Cint[0]
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1]
end

function cish(x::Array{Float64, 1}, iprob::Int)
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function cish!(x::Array{Float64, 1}, iprob::Int, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val,
    h_row_cp, h_col_cp)
  @cutest_error
  for i = 1:lh
    h_row[i] = h_row_cp[i]
  end
  for i = 1:lh
    h_col[i] = h_col_cp[i]
  end
  return nnzh[1]
end

function cish!(x::Array{Float64, 1}, iprob::Int, h_val::Array{Float64, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  cish(io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1]
end

function csgrsh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, lh::Int)
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
    j_val, j_var, j_fun, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, nnzh[1], h_val, h_row, h_col
end

function csgrsh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1}, lh::Int, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp, nnzh, Cint[lh], h_val, h_row_cp, h_col_cp)
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
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  nnzj = Cint[0]
  nnzh = Cint[0]
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzj[1], nnzh[1]
end

function csgrsh(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj + nlp.nvar
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, nnzh[1], h_val, h_row, h_col
end

function csgrsh!(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    j_val::Array{Float64, 1}, j_var::Array{Int, 1}, j_fun::Array{Int, 1},
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj + nlp.nvar
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  nnzh = Cint[0]
  lh = nlp.nnzh
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp, nnzh, Cint[lh], h_val, h_row_cp, h_col_cp)
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

function csgrsh!(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    j_val::Array{Float64, 1}, j_var::Array{Cint, 1}, j_fun::Array{Cint,
    1}, h_val::Array{Float64, 1}, h_row::Array{Cint, 1},
    h_col::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj + nlp.nvar
  nnzh = Cint[0]
  lh = nlp.nnzh
  csgrsh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzj[1], nnzh[1]
end

function csgreh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, lhe_ptr::Int, lhe_row::Int, lhe_val::Int,
    byrows::Bool)
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
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function csgreh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1}, lhe_ptr::Int, he_row_ptr::Array{Int, 1},
    he_val_ptr::Array{Int, 1}, lhe_row::Int, he_row::Array{Int, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool)
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
    Cint[byrows])
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
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  nnzj = Cint[0]
  ne = Cint[0]
  csgreh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return nnzj[1], ne[1]
end

function csgreh(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    lhe_ptr::Int, lhe_row::Int, lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj
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
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function csgreh!(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    j_val::Array{Float64, 1}, j_var::Array{Int, 1}, j_fun::Array{Int, 1},
    lhe_ptr::Int, he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1},
    lhe_row::Int, he_row::Array{Int, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  csgreh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var_cp, j_fun_cp, ne, Cint[lhe_ptr], he_row_ptr_cp,
    he_val_ptr_cp, Cint[lhe_row], he_row_cp, Cint[lhe_val], he_val,
    Cint[byrows])
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

function csgreh!(x::Array{Float64, 1}, y::Array{Float64, 1}, grlagf::Bool,
    j_val::Array{Float64, 1}, j_var::Array{Cint, 1}, j_fun::Array{Cint,
    1}, lhe_ptr::Int, he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint,
    1}, lhe_row::Int, he_row::Array{Cint, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnzj = Cint[0]
  lj = nlp.nnzj
  ne = Cint[0]
  csgreh(io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return nnzj[1], ne[1]
end

function chprod(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  result = Array(Cdouble, n)
  chprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return result
end

function chprod!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  chprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return
end

function chprod(goth::Bool, x::Array{Float64, 1}, y::Array{Float64, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  result = Array(Cdouble, n)
  chprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return result
end

function chprod!(goth::Bool, x::Array{Float64, 1}, y::Array{Float64, 1},
    vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  chprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return
end

function cshprod(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, n)
  cshprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

function cshprod!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, index_nz_result::Array{Int, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result_cp = Array(Cint, n)
  cshprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result_cp, result)
  @cutest_error
  for i = 1:n
    index_nz_result[i] = index_nz_result_cp[i]
  end
  return nnz_result[1]
end

function cshprod!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, index_nz_result::Array{Cint, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  cshprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1]
end

function cshprod(goth::Bool, x::Array{Float64, 1}, y::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, n)
  cshprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

function cshprod!(goth::Bool, x::Array{Float64, 1}, y::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, index_nz_result::Array{Int, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnz_result = Cint[0]
  index_nz_result_cp = Array(Cint, n)
  cshprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result_cp, result)
  @cutest_error
  for i = 1:n
    index_nz_result[i] = index_nz_result_cp[i]
  end
  return nnz_result[1]
end

function cshprod!(goth::Bool, x::Array{Float64, 1}, y::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, index_nz_result::Array{Cint, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnz_result = Cint[0]
  cshprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1]
end

function chcprod(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  result = Array(Cdouble, n)
  chcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return result
end

function chcprod!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  chcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return
end

function chcprod(goth::Bool, x::Array{Float64, 1}, y::Array{Float64, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  result = Array(Cdouble, n)
  chcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return result
end

function chcprod!(goth::Bool, x::Array{Float64, 1}, y::Array{Float64, 1},
    vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  chcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return
end

function cshcprod(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, n)
  cshcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

function cshcprod!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, index_nz_result::Array{Int, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result_cp = Array(Cint, n)
  cshcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result_cp, result)
  @cutest_error
  for i = 1:n
    index_nz_result[i] = index_nz_result_cp[i]
  end
  return nnz_result[1]
end

function cshcprod!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, index_nz_result::Array{Cint, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  cshcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1]
end

function cshcprod(goth::Bool, x::Array{Float64, 1}, y::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, n)
  cshcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

function cshcprod!(goth::Bool, x::Array{Float64, 1}, y::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, index_nz_result::Array{Int, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnz_result = Cint[0]
  index_nz_result_cp = Array(Cint, n)
  cshcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result_cp, result)
  @cutest_error
  for i = 1:n
    index_nz_result[i] = index_nz_result_cp[i]
  end
  return nnz_result[1]
end

function cshcprod!(goth::Bool, x::Array{Float64, 1}, y::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, index_nz_result::Array{Cint, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnz_result = Cint[0]
  cshcprod(io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1]
end

function cjprod(n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, lresult::Int)
  io_err = Cint[0]
  result = Array(Cdouble, lresult)
  cjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    vector, Cint[lvector], result, Cint[lresult])
  @cutest_error
  return result
end

function cjprod!(n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, result::Array{Float64, 1},
    lresult::Int)
  io_err = Cint[0]
  cjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    vector, Cint[lvector], result, Cint[lresult])
  @cutest_error
  return
end

function cjprod(gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, lresult::Int)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  result = Array(Cdouble, lresult)
  cjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    vector, Cint[lvector], result, Cint[lresult])
  @cutest_error
  return result
end

function cjprod!(gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, result::Array{Float64, 1},
    lresult::Int)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  cjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    vector, Cint[lvector], result, Cint[lresult])
  @cutest_error
  return
end

function csjprod(n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, lvector::Int, lresult::Int)
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, lresult)
  csjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    Cint[nnz_vector], index_nz_vector, vector, Cint[lvector], nnz_result,
    index_nz_result, result, Cint[lresult])
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

function csjprod!(n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, lvector::Int, index_nz_result::Array{Int,
    1}, result::Array{Float64, 1}, lresult::Int)
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result_cp = Array(Cint, n)
  csjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    Cint[nnz_vector], index_nz_vector, vector, Cint[lvector], nnz_result,
    index_nz_result_cp, result, Cint[lresult])
  @cutest_error
  for i = 1:n
    index_nz_result[i] = index_nz_result_cp[i]
  end
  return nnz_result[1]
end

function csjprod!(n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Int, 1},
    vector::Array{Float64, 1}, lvector::Int, index_nz_result::Array{Cint,
    1}, result::Array{Float64, 1}, lresult::Int)
  io_err = Cint[0]
  nnz_result = Cint[0]
  csjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    Cint[nnz_vector], index_nz_vector, vector, Cint[lvector], nnz_result,
    index_nz_result, result, Cint[lresult])
  @cutest_error
  return nnz_result[1]
end

function csjprod(gotj::Bool, jtrans::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Int, 1}, vector::Array{Float64, 1},
    lvector::Int, lresult::Int)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, lresult)
  csjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    Cint[nnz_vector], index_nz_vector, vector, Cint[lvector], nnz_result,
    index_nz_result, result, Cint[lresult])
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

function csjprod!(gotj::Bool, jtrans::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Int, 1}, vector::Array{Float64, 1},
    lvector::Int, index_nz_result::Array{Int, 1}, result::Array{Float64,
    1}, lresult::Int)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnz_result = Cint[0]
  index_nz_result_cp = Array(Cint, n)
  csjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    Cint[nnz_vector], index_nz_vector, vector, Cint[lvector], nnz_result,
    index_nz_result_cp, result, Cint[lresult])
  @cutest_error
  for i = 1:n
    index_nz_result[i] = index_nz_result_cp[i]
  end
  return nnz_result[1]
end

function csjprod!(gotj::Bool, jtrans::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Int, 1}, vector::Array{Float64, 1},
    lvector::Int, index_nz_result::Array{Cint, 1}, result::Array{Float64,
    1}, lresult::Int)
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  nnz_result = Cint[0]
  csjprod(io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    Cint[nnz_vector], index_nz_vector, vector, Cint[lvector], nnz_result,
    index_nz_result, result, Cint[lresult])
  @cutest_error
  return nnz_result[1]
end

function cchprods(n::Int, m::Int, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lchp::Int, chp_ind::Array{Int, 1},
    chp_ptr::Array{Int, 1})
  io_err = Cint[0]
  chp_val = Array(Cdouble, lchp)
  cchprods(io_err, Cint[n], Cint[m], Cint[goth], x, vector,
    Cint[lchp], chp_val, chp_ind, chp_ptr)
  @cutest_error
  return chp_val
end

function cchprods!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lchp::Int, chp_val::Array{Float64, 1},
    chp_ind::Array{Int, 1}, chp_ptr::Array{Int, 1})
  io_err = Cint[0]
  cchprods(io_err, Cint[n], Cint[m], Cint[goth], x, vector,
    Cint[lchp], chp_val, chp_ind, chp_ptr)
  @cutest_error
  return
end

function cchprods!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lchp::Int, chp_val::Array{Float64, 1},
    chp_ind::Array{Int, 1}, chp_ptr::Array{Int, 1})
  io_err = Cint[0]
  cchprods(io_err, Cint[n], Cint[m], Cint[goth], x, vector,
    Cint[lchp], chp_val, chp_ind, chp_ptr)
  @cutest_error
  return
end

function cchprods(goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1},
    lchp::Int, chp_ind::Array{Int, 1}, chp_ptr::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  chp_val = Array(Cdouble, lchp)
  cchprods(io_err, Cint[n], Cint[m], Cint[goth], x, vector,
    Cint[lchp], chp_val, chp_ind, chp_ptr)
  @cutest_error
  return chp_val
end

function cchprods!(goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1},
    lchp::Int, chp_val::Array{Float64, 1}, chp_ind::Array{Int, 1},
    chp_ptr::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  cchprods(io_err, Cint[n], Cint[m], Cint[goth], x, vector,
    Cint[lchp], chp_val, chp_ind, chp_ptr)
  @cutest_error
  return
end

function cchprods!(goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1},
    lchp::Int, chp_val::Array{Float64, 1}, chp_ind::Array{Int, 1},
    chp_ptr::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.nvar
  m = nlp.ncon
  cchprods(io_err, Cint[n], Cint[m], Cint[goth], x, vector,
    Cint[lchp], chp_val, chp_ind, chp_ptr)
  @cutest_error
  return
end

function uterminate()  io_err = Cint[0]
  uterminate(io_err)
  @cutest_error
  return
end

function cterminate()  io_err = Cint[0]
  cterminate(io_err)
  @cutest_error
  return
end

