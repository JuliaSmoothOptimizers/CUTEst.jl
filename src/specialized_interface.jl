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

"""
    x, x_l, x_u = usetup(input, out, io_buffer, n)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
"""
function usetup(cutest_lib::Ptr{Void}, input::Int, out::Int, io_buffer::Int, n::Int)
  io_err = Cint[0]
  x = Array(Cdouble, n)
  x_l = Array(Cdouble, n)
  x_u = Array(Cdouble, n)
  usetup(cutest_lib, io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n], x,
    x_l, x_u)
  @cutest_error
  return x, x_l, x_u
end

"""
    usetup!(input, out, io_buffer, n, x, x_l, x_u)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
"""
function usetup!(cutest_lib::Ptr{Void}, input::Int, out::Int, io_buffer::Int, n::Int, x::Array{Float64, 1},
    x_l::Array{Float64, 1}, x_u::Array{Float64, 1})
  io_err = Cint[0]
  usetup(cutest_lib, io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n], x,
    x_l, x_u)
  @cutest_error
  return
end

"""
    x, x_l, x_u, y, c_l, c_u, equatn, linear = csetup(input, out, io_buffer, n, m, e_order, l_order, v_order)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - m:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
  - y:         [OUT] Array{Float64, 1}
  - c_l:       [OUT] Array{Float64, 1}
  - c_u:       [OUT] Array{Float64, 1}
  - equatn:    [OUT] Array{Bool, 1}
  - linear:    [OUT] Array{Bool, 1}
  - e_order:   [IN] Int
  - l_order:   [IN] Int
  - v_order:   [IN] Int
"""
function csetup(cutest_lib::Ptr{Void}, input::Int, out::Int, io_buffer::Int, n::Int, m::Int, e_order::Int,
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
  csetup(cutest_lib, io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n],
    Cint[m], x, x_l, x_u, y, c_l, c_u, equatn, linear, Cint[e_order],
    Cint[l_order], Cint[v_order])
  @cutest_error
  return x, x_l, x_u, y, c_l, c_u, equatn, linear
end

"""
    csetup!(input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn, linear, e_order, l_order, v_order)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - m:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
  - y:         [OUT] Array{Float64, 1}
  - c_l:       [OUT] Array{Float64, 1}
  - c_u:       [OUT] Array{Float64, 1}
  - equatn:    [OUT] Array{Bool, 1}
  - linear:    [OUT] Array{Bool, 1}
  - e_order:   [IN] Int
  - l_order:   [IN] Int
  - v_order:   [IN] Int
"""
function csetup!(cutest_lib::Ptr{Void}, input::Int, out::Int, io_buffer::Int, n::Int, m::Int,
    x::Array{Float64, 1}, x_l::Array{Float64, 1}, x_u::Array{Float64, 1},
    y::Array{Float64, 1}, c_l::Array{Float64, 1}, c_u::Array{Float64, 1},
    equatn::Array{Cint, 1}, linear::Array{Cint, 1}, e_order::Int,
    l_order::Int, v_order::Int)
  io_err = Cint[0]
  csetup(cutest_lib, io_err, Cint[input], Cint[out], Cint[io_buffer], Cint[n],
    Cint[m], x, x_l, x_u, y, c_l, c_u, equatn, linear, Cint[e_order],
    Cint[l_order], Cint[v_order])
  @cutest_error
  return
end

"""
    n = udimen(input)

  - input:   [IN] Int
  - n:       [OUT] Int
"""
function udimen(cutest_lib::Ptr{Void}, input::Int)
  io_err = Cint[0]
  n = Cint[0]
  udimen(cutest_lib, io_err, Cint[input], n)
  @cutest_error
  return n[1]
end

"""
    nnzh = udimsh()

  - nnzh:    [OUT] Int
"""
function udimsh(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  nnzh = Cint[0]
  udimsh(cutest_lib, io_err, nnzh)
  @cutest_error
  return nnzh[1]
end

"""
    ne, he_val_ne, he_row_ne = udimse()

  - ne:        [OUT] Int
  - he_val_ne: [OUT] Int
  - he_row_ne: [OUT] Int
"""
function udimse(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  udimse(cutest_lib, io_err, ne, he_val_ne, he_row_ne)
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

"""
    x_type = uvartype(n)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Cint, 1}
"""
function uvartype(cutest_lib::Ptr{Void}, n::Int)
  io_err = Cint[0]
  x_type = Array(Cint, n)
  uvartype(cutest_lib, io_err, Cint[n], x_type)
  @cutest_error
  return x_type
end

"""
    uvartype!(n, x_type)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Cint, 1}
"""
function uvartype!(cutest_lib::Ptr{Void}, n::Int, x_type::Array{Cint, 1})
  io_err = Cint[0]
  uvartype(cutest_lib, io_err, Cint[n], x_type)
  @cutest_error
  return
end

"""
    pname, vname = unames(n)

  - n:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
"""
function unames(cutest_lib::Ptr{Void}, n::Int)
  io_err = Cint[0]
  pname = Cchar[0]
  vname = Array(Cchar, n)
  unames(cutest_lib, io_err, Cint[n], pname, vname)
  @cutest_error
  return pname[1], vname
end

"""
    pname = unames!(n, vname)

  - n:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
"""
function unames!(cutest_lib::Ptr{Void}, n::Int, vname::Array{UInt8, 1})
  io_err = Cint[0]
  pname = Cchar[0]
  unames(cutest_lib, io_err, Cint[n], pname, vname)
  @cutest_error
  return pname[1]
end

"""
    calls, time = ureport()

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
"""
function ureport(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  calls = Array(Cdouble, 4)
  time = Array(Cdouble, 2)
  ureport(cutest_lib, io_err, calls, time)
  @cutest_error
  return calls, time
end

"""
    ureport!(calls, time)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
"""
function ureport!(cutest_lib::Ptr{Void}, calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  ureport(cutest_lib, io_err, calls, time)
  @cutest_error
  return
end

"""
    n, m = cdimen(input)

  - input:   [IN] Int
  - n:       [OUT] Int
  - m:       [OUT] Int
"""
function cdimen(cutest_lib::Ptr{Void}, input::Int)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  cdimen(cutest_lib, io_err, Cint[input], n, m)
  @cutest_error
  return n[1], m[1]
end

"""
    nnzj = cdimsj()

  - nnzj:    [OUT] Int
"""
function cdimsj(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  nnzj = Cint[0]
  cdimsj(cutest_lib, io_err, nnzj)
  @cutest_error
  return nnzj[1]
end

"""
    nnzh = cdimsh()

  - nnzh:    [OUT] Int
"""
function cdimsh(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  nnzh = Cint[0]
  cdimsh(cutest_lib, io_err, nnzh)
  @cutest_error
  return nnzh[1]
end

"""
    nnzchp = cdimchp()

  - nnzchp:  [OUT] Int
"""
function cdimchp(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  nnzchp = Cint[0]
  cdimchp(cutest_lib, io_err, nnzchp)
  @cutest_error
  return nnzchp[1]
end

"""
    ne, he_val_ne, he_row_ne = cdimse()

  - ne:        [OUT] Int
  - he_val_ne: [OUT] Int
  - he_row_ne: [OUT] Int
"""
function cdimse(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  cdimse(cutest_lib, io_err, ne, he_val_ne, he_row_ne)
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

"""
"""
function cstats(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  cstats(cutest_lib, io_err, nonlinear_variables_objective,
    nonlinear_variables_constraints, equality_constraints,
    linear_constraints)
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

"""
    x_type = cvartype(n)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Cint, 1}
"""
function cvartype(cutest_lib::Ptr{Void}, n::Int)
  io_err = Cint[0]
  x_type = Array(Cint, n)
  cvartype(cutest_lib, io_err, Cint[n], x_type)
  @cutest_error
  return x_type
end

"""
    cvartype!(n, x_type)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Cint, 1}
"""
function cvartype!(cutest_lib::Ptr{Void}, n::Int, x_type::Array{Cint, 1})
  io_err = Cint[0]
  cvartype(cutest_lib, io_err, Cint[n], x_type)
  @cutest_error
  return
end

"""
    pname, vname, cname = cnames(n, m)

  - n:       [IN] Int
  - m:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}
"""
function cnames(cutest_lib::Ptr{Void}, n::Int, m::Int)
  io_err = Cint[0]
  pname = Cchar[0]
  vname = Array(Cchar, n)
  cname = Array(Cchar, m)
  cnames(cutest_lib, io_err, Cint[n], Cint[m], pname, vname, cname)
  @cutest_error
  return pname[1], vname, cname
end

"""
    pname = cnames!(n, m, vname, cname)

  - n:       [IN] Int
  - m:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}
"""
function cnames!(cutest_lib::Ptr{Void}, n::Int, m::Int, vname::Array{UInt8, 1}, cname::Array{UInt8, 1})
  io_err = Cint[0]
  pname = Cchar[0]
  cnames(cutest_lib, io_err, Cint[n], Cint[m], pname, vname, cname)
  @cutest_error
  return pname[1]
end

"""
    calls, time = creport()

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
"""
function creport(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  calls = Array(Cdouble, 7)
  time = Array(Cdouble, 2)
  creport(cutest_lib, io_err, calls, time)
  @cutest_error
  return calls, time
end

"""
    creport!(calls, time)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
"""
function creport!(cutest_lib::Ptr{Void}, calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  creport(cutest_lib, io_err, calls, time)
  @cutest_error
  return
end

"""
    cname = connames(m)

  - m:       [IN] Int
  - cname:   [OUT] Array{UInt8, 1}
"""
function connames(cutest_lib::Ptr{Void}, m::Int)
  io_err = Cint[0]
  cname = Array(Cchar, m)
  connames(cutest_lib, io_err, Cint[m], cname)
  @cutest_error
  return cname
end

"""
    connames!(m, cname)

  - m:       [IN] Int
  - cname:   [OUT] Array{UInt8, 1}
"""
function connames!(cutest_lib::Ptr{Void}, m::Int, cname::Array{UInt8, 1})
  io_err = Cint[0]
  connames(cutest_lib, io_err, Cint[m], cname)
  @cutest_error
  return
end

"""
    pname = pname(input)

  - input:   [IN] Int
  - pname:   [OUT] UInt8
"""
function pname(cutest_lib::Ptr{Void}, input::Int)
  io_err = Cint[0]
  pname = Cchar[0]
  pname(cutest_lib, io_err, Cint[input], pname)
  @cutest_error
  return pname[1]
end

"""
    pname = probname()

  - pname:   [OUT] UInt8
"""
function probname(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  pname = Cchar[0]
  probname(cutest_lib, io_err, pname)
  @cutest_error
  return pname[1]
end

"""
    vname = varnames(n)

  - n:       [IN] Int
  - vname:   [OUT] Array{UInt8, 1}
"""
function varnames(cutest_lib::Ptr{Void}, n::Int)
  io_err = Cint[0]
  vname = Array(Cchar, n)
  varnames(cutest_lib, io_err, Cint[n], vname)
  @cutest_error
  return vname
end

"""
    varnames!(n, vname)

  - n:       [IN] Int
  - vname:   [OUT] Array{UInt8, 1}
"""
function varnames!(cutest_lib::Ptr{Void}, n::Int, vname::Array{UInt8, 1})
  io_err = Cint[0]
  varnames(cutest_lib, io_err, Cint[n], vname)
  @cutest_error
  return
end

"""
    f = ufn(n, x)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
"""
function ufn(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1})
  io_err = Cint[0]
  f = Cdouble[0]
  ufn(cutest_lib, io_err, Cint[n], x, f)
  @cutest_error
  return f[1]
end

"""
    g = ugr(n, x)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
"""
function ugr(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1})
  io_err = Cint[0]
  g = Array(Cdouble, n)
  ugr(cutest_lib, io_err, Cint[n], x, g)
  @cutest_error
  return g
end

"""
    ugr!(n, x, g)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
"""
function ugr!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, g::Array{Float64, 1})
  io_err = Cint[0]
  ugr(cutest_lib, io_err, Cint[n], x, g)
  @cutest_error
  return
end

"""
    f, g = uofg(n, x, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
"""
function uofg(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  uofg(cutest_lib, io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1], g
end

"""
    f = uofg!(n, x, g, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
"""
function uofg!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  uofg(cutest_lib, io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1]
end

"""
    h = udh(n, x, lh1)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
"""
function udh(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  h = Array(Cdouble, lh1, n)
  udh(cutest_lib, io_err, Cint[n], x, Cint[lh1], h)
  @cutest_error
  return h
end

"""
    udh!(n, x, lh1, h)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
"""
function udh!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lh1::Int, h::Array{Float64, 2})
  io_err = Cint[0]
  udh(cutest_lib, io_err, Cint[n], x, Cint[lh1], h)
  @cutest_error
  return
end

"""
    nnzh, h_row, h_col = ushp(n, lh)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function ushp(cutest_lib::Ptr{Void}, n::Int, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ushp(cutest_lib, io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1], h_row, h_col
end

"""
    nnzh = ushp!(n, lh, h_row, h_col)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function ushp!(cutest_lib::Ptr{Void}, n::Int, lh::Int, h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  ushp(cutest_lib, io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1]
end

"""
    nnzh, h_val, h_row, h_col = ush(n, x, lh)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function ush(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ush(cutest_lib, io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

"""
    nnzh = ush!(n, x, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function ush!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lh::Int, h_val::Array{Float64, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  ush(cutest_lib, io_err, Cint[n], x, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzh[1]
end

"""
    ne, he_row_ptr, he_val_ptr, he_row, he_val = ueh(n, x, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool
"""
function ueh(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int,
    lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ueh(cutest_lib, io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

"""
    ne = ueh!(n, x, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool
"""
function ueh!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lhe_ptr::Int, he_row_ptr::Array{Cint,
    1}, he_val_ptr::Array{Cint, 1}, lhe_row::Int, he_row::Array{Cint, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  ueh(cutest_lib, io_err, Cint[n], x, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return ne[1]
end

"""
    g, h = ugrdh(n, x, lh1)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
"""
function ugrdh(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  h = Array(Cdouble, lh1, n)
  ugrdh(cutest_lib, io_err, Cint[n], x, g, Cint[lh1], h)
  @cutest_error
  return g, h
end

"""
    ugrdh!(n, x, g, lh1, h)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
"""
function ugrdh!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lh1::Int,
    h::Array{Float64, 2})
  io_err = Cint[0]
  ugrdh(cutest_lib, io_err, Cint[n], x, g, Cint[lh1], h)
  @cutest_error
  return
end

"""
    g, nnzh, h_val, h_row, h_col = ugrsh(n, x, lh)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function ugrsh(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lh::Int)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  ugrsh(cutest_lib, io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return g, nnzh[1], h_val, h_row, h_col
end

"""
    nnzh = ugrsh!(n, x, g, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function ugrsh!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1})
  io_err = Cint[0]
  nnzh = Cint[0]
  ugrsh(cutest_lib, io_err, Cint[n], x, g, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzh[1]
end

"""
    g, ne, he_row_ptr, he_val_ptr, he_row, he_val = ugreh(n, x, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - g:          [OUT] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool
"""
function ugreh(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int,
    lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ugreh(cutest_lib, io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return g, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

"""
    ne = ugreh!(n, x, g, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - g:          [OUT] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool
"""
function ugreh!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1}, lhe_row::Int,
    he_row::Array{Cint, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  ugreh(cutest_lib, io_err, Cint[n], x, g, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return ne[1]
end

"""
    result = uhprod(n, goth, x, vector)

  - n:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
"""
function uhprod(cutest_lib::Ptr{Void}, n::Int, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  result = Array(Cdouble, n)
  uhprod(cutest_lib, io_err, Cint[n], Cint[goth], x, vector, result)
  @cutest_error
  return result
end

"""
    uhprod!(n, goth, x, vector, result)

  - n:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
"""
function uhprod!(cutest_lib::Ptr{Void}, n::Int, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  uhprod(cutest_lib, io_err, Cint[n], Cint[goth], x, vector, result)
  @cutest_error
  return
end

"""
    nnz_result, index_nz_result, result = ushprod(n, goth, x, nnz_vector, index_nz_vector, vector)

  - n:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Float64, 1}
"""
function ushprod(cutest_lib::Ptr{Void}, n::Int, goth::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Cint, 1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, n)
  ushprod(cutest_lib, io_err, Cint[n], Cint[goth], x, Cint[nnz_vector],
    index_nz_vector, vector, nnz_result, index_nz_result, result)
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

"""
    nnz_result = ushprod!(n, goth, x, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - n:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Float64, 1}
"""
function ushprod!(cutest_lib::Ptr{Void}, n::Int, goth::Bool, x::Array{Float64, 1}, nnz_vector::Int,
    index_nz_vector::Array{Cint, 1}, vector::Array{Float64, 1},
    index_nz_result::Array{Cint, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  ushprod(cutest_lib, io_err, Cint[n], Cint[goth], x, Cint[nnz_vector],
    index_nz_vector, vector, nnz_result, index_nz_result, result)
  @cutest_error
  return nnz_result[1]
end

"""
    h_band, max_semibandwidth = ubandh(n, x, semibandwidth, lbandh)

  - n:                 [IN] Int
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int
"""
function ubandh(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, semibandwidth::Int, lbandh::Int)
  io_err = Cint[0]
  h_band = Array(Cdouble, lbandh - 0 + 1, n)
  max_semibandwidth = Cint[0]
  ubandh(cutest_lib, io_err, Cint[n], x, Cint[semibandwidth], h_band,
    Cint[lbandh], max_semibandwidth)
  @cutest_error
  return h_band, max_semibandwidth[1]
end

"""
    max_semibandwidth = ubandh!(n, x, semibandwidth, h_band, lbandh)

  - n:                 [IN] Int
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int
"""
function ubandh!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, semibandwidth::Int,
    h_band::Array{Float64, 2}, lbandh::Int)
  io_err = Cint[0]
  max_semibandwidth = Cint[0]
  ubandh(cutest_lib, io_err, Cint[n], x, Cint[semibandwidth], h_band,
    Cint[lbandh], max_semibandwidth)
  @cutest_error
  return max_semibandwidth[1]
end

"""
    f, c = cfn(n, m, x)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}
"""
function cfn(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1})
  io_err = Cint[0]
  f = Cdouble[0]
  c = Array(Cdouble, m)
  cfn(cutest_lib, io_err, Cint[n], Cint[m], x, f, c)
  @cutest_error
  return f[1], c
end

"""
    f = cfn!(n, m, x, c)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}
"""
function cfn!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1})
  io_err = Cint[0]
  f = Cdouble[0]
  cfn(cutest_lib, io_err, Cint[n], Cint[m], x, f, c)
  @cutest_error
  return f[1]
end

"""
    f, g = cofg(n, x, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
"""
function cofg(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  cofg(cutest_lib, io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1], g
end

"""
    f = cofg!(n, x, g, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
"""
function cofg!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  cofg(cutest_lib, io_err, Cint[n], x, f, g, Cint[grad])
  @cutest_error
  return f[1]
end

"""
    f, nnzg, g_val, g_var = cofsg(n, x, lg, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Cint, 1}
  - grad:    [IN] Bool
"""
function cofsg(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lg::Int, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  g_val = Array(Cdouble, lg)
  g_var = Array(Cint, lg)
  cofsg(cutest_lib, io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var,
    Cint[grad])
  @cutest_error
  return f[1], nnzg[1], g_val, g_var
end

"""
    f, nnzg = cofsg!(n, x, lg, g_val, g_var, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Cint, 1}
  - grad:    [IN] Bool
"""
function cofsg!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, lg::Int, g_val::Array{Float64, 1},
    g_var::Array{Cint, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  cofsg(cutest_lib, io_err, Cint[n], x, f, nnzg, Cint[lg], g_val, g_var,
    Cint[grad])
  @cutest_error
  return f[1], nnzg[1]
end

"""
    c, cjac = ccfg(n, m, x, jtrans, lcjac1, lcjac2, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool
"""
function ccfg(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, jtrans::Bool, lcjac1::Int,
    lcjac2::Int, grad::Bool)
  io_err = Cint[0]
  c = Array(Cdouble, m)
  cjac = Array(Cdouble, lcjac1, lcjac2)
  ccfg(cutest_lib, io_err, Cint[n], Cint[m], x, c, Cint[jtrans], Cint[lcjac1],
    Cint[lcjac2], cjac, Cint[grad])
  @cutest_error
  return c, cjac
end

"""
    ccfg!(n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool
"""
function ccfg!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1},
    jtrans::Bool, lcjac1::Int, lcjac2::Int, cjac::Array{Float64, 2},
    grad::Bool)
  io_err = Cint[0]
  ccfg(cutest_lib, io_err, Cint[n], Cint[m], x, c, Cint[jtrans], Cint[lcjac1],
    Cint[lcjac2], cjac, Cint[grad])
  @cutest_error
  return
end

"""
    f, g = clfg(n, m, x, y, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
"""
function clfg(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  clfg(cutest_lib, io_err, Cint[n], Cint[m], x, y, f, g, Cint[grad])
  @cutest_error
  return f[1], g
end

"""
    f = clfg!(n, m, x, y, g, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
"""
function clfg!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  f = Cdouble[0]
  clfg(cutest_lib, io_err, Cint[n], Cint[m], x, y, f, g, Cint[grad])
  @cutest_error
  return f[1]
end

"""
    g, j_val = cgr(n, m, x, y, grlagf, jtrans, lj1, lj2)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
"""
function cgr(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Int, lj2::Int)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  cgr(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val)
  @cutest_error
  return g, j_val
end

"""
    cgr!(n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
"""
function cgr!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2})
  io_err = Cint[0]
  cgr(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val)
  @cutest_error
  return
end

"""
    nnzj, j_val, j_var, j_fun = csgr(n, m, x, y, grlagf, lj)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Cint, 1}
  - j_fun:   [OUT] Array{Cint, 1}
"""
function csgr(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  csgr(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

"""
    nnzj = csgr!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Cint, 1}
  - j_fun:   [OUT] Array{Cint, 1}
"""
function csgr!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Cint,
    1}, j_fun::Array{Cint, 1})
  io_err = Cint[0]
  nnzj = Cint[0]
  csgr(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun)
  @cutest_error
  return nnzj[1]
end

"""
    c, nnzj, j_val, j_var, j_fun = ccfsg(n, m, x, lj, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Cint, 1}
  - j_fun:   [OUT] Array{Cint, 1}
  - grad:    [IN] Bool
"""
function ccfsg(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, lj::Int, grad::Bool)
  io_err = Cint[0]
  c = Array(Cdouble, m)
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  ccfsg(cutest_lib, io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val, j_var,
    j_fun, Cint[grad])
  @cutest_error
  return c, nnzj[1], j_val, j_var, j_fun
end

"""
    nnzj = ccfsg!(n, m, x, c, lj, j_val, j_var, j_fun, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Cint, 1}
  - j_fun:   [OUT] Array{Cint, 1}
  - grad:    [IN] Bool
"""
function ccfsg!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1}, lj::Int,
    j_val::Array{Float64, 1}, j_var::Array{Cint, 1}, j_fun::Array{Cint,
    1}, grad::Bool)
  io_err = Cint[0]
  nnzj = Cint[0]
  ccfsg(cutest_lib, io_err, Cint[n], Cint[m], x, c, nnzj, Cint[lj], j_val, j_var,
    j_fun, Cint[grad])
  @cutest_error
  return nnzj[1]
end

"""
    ci, gci = ccifg(n, icon, x, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
"""
function ccifg(cutest_lib::Ptr{Void}, n::Int, icon::Int, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  ci = Cdouble[0]
  gci = Array(Cdouble, n)
  ccifg(cutest_lib, io_err, Cint[n], Cint[icon], x, ci, gci, Cint[grad])
  @cutest_error
  return ci[1], gci
end

"""
    ci = ccifg!(n, icon, x, gci, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
"""
function ccifg!(cutest_lib::Ptr{Void}, n::Int, icon::Int, x::Array{Float64, 1}, gci::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  ci = Cdouble[0]
  ccifg(cutest_lib, io_err, Cint[n], Cint[icon], x, ci, gci, Cint[grad])
  @cutest_error
  return ci[1]
end

"""
    ci, nnzgci, gci_val, gci_var = ccifsg(n, icon, x, lgci, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Cint, 1}
  - grad:    [IN] Bool
"""
function ccifsg(cutest_lib::Ptr{Void}, n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int, grad::Bool)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_val = Array(Cdouble, lgci)
  gci_var = Array(Cint, lgci)
  ccifsg(cutest_lib, io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var, Cint[grad])
  @cutest_error
  return ci[1], nnzgci[1], gci_val, gci_var
end

"""
    ci, nnzgci = ccifsg!(n, icon, x, lgci, gci_val, gci_var, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Cint, 1}
  - grad:    [IN] Bool
"""
function ccifsg!(cutest_lib::Ptr{Void}, n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int,
    gci_val::Array{Float64, 1}, gci_var::Array{Cint, 1}, grad::Bool)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  ccifsg(cutest_lib, io_err, Cint[n], Cint[icon], x, ci, nnzgci, Cint[lgci],
    gci_val, gci_var, Cint[grad])
  @cutest_error
  return ci[1], nnzgci[1]
end

"""
    g, j_val, h_val = cgrdh(n, m, x, y, grlagf, jtrans, lj1, lj2, lh1)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}
"""
function cgrdh(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Int, lj2::Int, lh1::Int)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  h_val = Array(Cdouble, lh1, n)
  cgrdh(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, Cint[lh1], h_val)
  @cutest_error
  return g, j_val, h_val
end

"""
    cgrdh!(n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}
"""
function cgrdh!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2}, lh1::Int, h_val::Array{Float64, 2})
  io_err = Cint[0]
  cgrdh(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[grlagf], g, Cint[jtrans],
    Cint[lj1], Cint[lj2], j_val, Cint[lh1], h_val)
  @cutest_error
  return
end

"""
    h_val = cdh(n, m, x, y, lh1)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}
"""
function cdh(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  h_val = Array(Cdouble, lh1, n)
  cdh(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return h_val
end

"""
    cdh!(n, m, x, y, lh1, h_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}
"""
function cdh!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int,
    h_val::Array{Float64, 2})
  io_err = Cint[0]
  cdh(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return
end

"""
    h_val = cdhc(n, m, x, y, lh1)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}
"""
function cdhc(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  h_val = Array(Cdouble, lh1, n)
  cdhc(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return h_val
end

"""
    cdhc!(n, m, x, y, lh1, h_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}
"""
function cdhc!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int,
    h_val::Array{Float64, 2})
  io_err = Cint[0]
  cdhc(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[lh1], h_val)
  @cutest_error
  return
end

"""
    nnzh, h_row, h_col = cshp(n, lh)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function cshp(cutest_lib::Ptr{Void}, n::Int, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cshp(cutest_lib, io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1], h_row, h_col
end

"""
    nnzh = cshp!(n, lh, h_row, h_col)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function cshp!(cutest_lib::Ptr{Void}, n::Int, lh::Int, h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  nnzh = Cint[0]
  cshp(cutest_lib, io_err, Cint[n], nnzh, Cint[lh], h_row, h_col)
  @cutest_error
  return nnzh[1]
end

"""
    nnzh, h_val, h_row, h_col = csh(n, m, x, y, lh)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function csh(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  csh(cutest_lib, io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

"""
    nnzh = csh!(n, m, x, y, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function csh!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1})
  io_err = Cint[0]
  nnzh = Cint[0]
  csh(cutest_lib, io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1]
end

"""
    nnzh, h_val, h_row, h_col = cshc(n, m, x, y, lh)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function cshc(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cshc(cutest_lib, io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

"""
    nnzh = cshc!(n, m, x, y, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function cshc!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1})
  io_err = Cint[0]
  nnzh = Cint[0]
  cshc(cutest_lib, io_err, Cint[n], Cint[m], x, y, nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1]
end

"""
    ne, he_row_ptr, he_val_ptr, he_row, he_val = ceh(n, m, x, y, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool
"""
function ceh(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, lhe_row::Int, lhe_val::Int, byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  ceh(cutest_lib, io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

"""
    ne = ceh!(n, m, x, y, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool
"""
function ceh!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1},
    lhe_row::Int, he_row::Array{Cint, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  ne = Cint[0]
  ceh(cutest_lib, io_err, Cint[n], Cint[m], x, y, ne, Cint[lhe_ptr], he_row_ptr,
    he_val_ptr, Cint[lhe_row], he_row, Cint[lhe_val], he_val,
    Cint[byrows])
  @cutest_error
  return ne[1]
end

"""
    h = cidh(n, x, iprob, lh1)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
"""
function cidh(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, iprob::Int, lh1::Int)
  io_err = Cint[0]
  h = Array(Cdouble, lh1, n)
  cidh(cutest_lib, io_err, Cint[n], x, Cint[iprob], Cint[lh1], h)
  @cutest_error
  return h
end

"""
    cidh!(n, x, iprob, lh1, h)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
"""
function cidh!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, iprob::Int, lh1::Int, h::Array{Float64,
    2})
  io_err = Cint[0]
  cidh(cutest_lib, io_err, Cint[n], x, Cint[iprob], Cint[lh1], h)
  @cutest_error
  return
end

"""
    nnzh, h_val, h_row, h_col = cish(n, x, iprob, lh)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function cish(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, iprob::Int, lh::Int)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  cish(cutest_lib, io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

"""
    nnzh = cish!(n, x, iprob, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function cish!(cutest_lib::Ptr{Void}, n::Int, x::Array{Float64, 1}, iprob::Int, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1})
  io_err = Cint[0]
  nnzh = Cint[0]
  cish(cutest_lib, io_err, Cint[n], x, Cint[iprob], nnzh, Cint[lh], h_val, h_row,
    h_col)
  @cutest_error
  return nnzh[1]
end

"""
    nnzj, j_val, j_var, j_fun, nnzh, h_val, h_row, h_col = csgrsh(n, m, x, y, grlagf, lj, lh)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Cint, 1}
  - j_fun:   [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function csgrsh(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
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
  csgrsh(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, nnzh[1], h_val, h_row, h_col
end

"""
    nnzj, nnzh = csgrsh!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Cint, 1}
  - j_fun:   [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function csgrsh!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Cint,
    1}, j_fun::Array{Cint, 1}, lh::Int, h_val::Array{Float64, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  io_err = Cint[0]
  nnzj = Cint[0]
  nnzh = Cint[0]
  csgrsh(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, nnzh, Cint[lh], h_val, h_row, h_col)
  @cutest_error
  return nnzj[1], nnzh[1]
end

"""
    nnzj, j_val, j_var, j_fun, ne, he_row_ptr, he_val_ptr, he_row, he_val = csgreh(n, m, x, y, grlagf, lj, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - grlagf:     [IN] Bool
  - nnzj:       [OUT] Int
  - lj:         [IN] Int
  - j_val:      [OUT] Array{Float64, 1}
  - j_var:      [OUT] Array{Cint, 1}
  - j_fun:      [OUT] Array{Cint, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool
"""
function csgreh(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
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
  csgreh(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

"""
    nnzj, ne = csgreh!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - grlagf:     [IN] Bool
  - nnzj:       [OUT] Int
  - lj:         [IN] Int
  - j_val:      [OUT] Array{Float64, 1}
  - j_var:      [OUT] Array{Cint, 1}
  - j_fun:      [OUT] Array{Cint, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool
"""
function csgreh!(cutest_lib::Ptr{Void}, n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Cint,
    1}, j_fun::Array{Cint, 1}, lhe_ptr::Int, he_row_ptr::Array{Cint, 1},
    he_val_ptr::Array{Cint, 1}, lhe_row::Int, he_row::Array{Cint, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  nnzj = Cint[0]
  ne = Cint[0]
  csgreh(cutest_lib, io_err, Cint[n], Cint[m], x, y, Cint[grlagf], nnzj, Cint[lj],
    j_val, j_var, j_fun, ne, Cint[lhe_ptr], he_row_ptr, he_val_ptr,
    Cint[lhe_row], he_row, Cint[lhe_val], he_val, Cint[byrows])
  @cutest_error
  return nnzj[1], ne[1]
end

"""
    result = chprod(n, m, goth, x, y, vector)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
"""
function chprod(cutest_lib::Ptr{Void}, n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  result = Array(Cdouble, n)
  chprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return result
end

"""
    chprod!(n, m, goth, x, y, vector, result)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
"""
function chprod!(cutest_lib::Ptr{Void}, n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  chprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return
end

"""
    nnz_result, index_nz_result, result = cshprod(n, m, goth, x, y, nnz_vector, index_nz_vector, vector)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Float64, 1}
"""
function cshprod(cutest_lib::Ptr{Void}, n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, nnz_vector::Int, index_nz_vector::Array{Cint, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, n)
  cshprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

"""
    nnz_result = cshprod!(n, m, goth, x, y, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Float64, 1}
"""
function cshprod!(cutest_lib::Ptr{Void}, n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, nnz_vector::Int, index_nz_vector::Array{Cint, 1},
    vector::Array{Float64, 1}, index_nz_result::Array{Cint, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  cshprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1]
end

"""
    result = chcprod(n, m, goth, x, y, vector)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
"""
function chcprod(cutest_lib::Ptr{Void}, n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  result = Array(Cdouble, n)
  chcprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return result
end

"""
    chcprod!(n, m, goth, x, y, vector, result)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
"""
function chcprod!(cutest_lib::Ptr{Void}, n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  chcprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[goth], x, y, vector, result)
  @cutest_error
  return
end

"""
    nnz_result, index_nz_result, result = cshcprod(n, m, goth, x, y, nnz_vector, index_nz_vector, vector)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Float64, 1}
"""
function cshcprod(cutest_lib::Ptr{Void}, n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, nnz_vector::Int, index_nz_vector::Array{Cint, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, n)
  cshcprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

"""
    nnz_result = cshcprod!(n, m, goth, x, y, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Float64, 1}
"""
function cshcprod!(cutest_lib::Ptr{Void}, n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, nnz_vector::Int, index_nz_vector::Array{Cint, 1},
    vector::Array{Float64, 1}, index_nz_result::Array{Cint, 1},
    result::Array{Float64, 1})
  io_err = Cint[0]
  nnz_result = Cint[0]
  cshcprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[goth], x, y,
    Cint[nnz_vector], index_nz_vector, vector, nnz_result,
    index_nz_result, result)
  @cutest_error
  return nnz_result[1]
end

"""
    result = cjprod(n, m, gotj, jtrans, x, vector, lvector, lresult)

  - n:       [IN] Int
  - m:       [IN] Int
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int
"""
function cjprod(cutest_lib::Ptr{Void}, n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, lresult::Int)
  io_err = Cint[0]
  result = Array(Cdouble, lresult)
  cjprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    vector, Cint[lvector], result, Cint[lresult])
  @cutest_error
  return result
end

"""
    cjprod!(n, m, gotj, jtrans, x, vector, lvector, result, lresult)

  - n:       [IN] Int
  - m:       [IN] Int
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int
"""
function cjprod!(cutest_lib::Ptr{Void}, n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, result::Array{Float64, 1},
    lresult::Int)
  io_err = Cint[0]
  cjprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    vector, Cint[lvector], result, Cint[lresult])
  @cutest_error
  return
end

"""
    nnz_result, index_nz_result, result = csjprod(n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, lresult)

  - n:               [IN] Int
  - m:               [IN] Int
  - gotj:            [IN] Bool
  - jtrans:          [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Float64, 1}
  - lvector:         [IN] Int
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Float64, 1}
  - lresult:         [IN] Int
"""
function csjprod(cutest_lib::Ptr{Void}, n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Cint, 1},
    vector::Array{Float64, 1}, lvector::Int, lresult::Int)
  io_err = Cint[0]
  nnz_result = Cint[0]
  index_nz_result = Array(Cint, n)
  result = Array(Cdouble, lresult)
  csjprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    Cint[nnz_vector], index_nz_vector, vector, Cint[lvector], nnz_result,
    index_nz_result, result, Cint[lresult])
  @cutest_error
  return nnz_result[1], index_nz_result, result
end

"""
    nnz_result = csjprod!(n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, index_nz_result, result, lresult)

  - n:               [IN] Int
  - m:               [IN] Int
  - gotj:            [IN] Bool
  - jtrans:          [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Float64, 1}
  - lvector:         [IN] Int
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Float64, 1}
  - lresult:         [IN] Int
"""
function csjprod!(cutest_lib::Ptr{Void}, n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    nnz_vector::Int, index_nz_vector::Array{Cint, 1},
    vector::Array{Float64, 1}, lvector::Int, index_nz_result::Array{Cint,
    1}, result::Array{Float64, 1}, lresult::Int)
  io_err = Cint[0]
  nnz_result = Cint[0]
  csjprod(cutest_lib, io_err, Cint[n], Cint[m], Cint[gotj], Cint[jtrans], x,
    Cint[nnz_vector], index_nz_vector, vector, Cint[lvector], nnz_result,
    index_nz_result, result, Cint[lresult])
  @cutest_error
  return nnz_result[1]
end

"""
    chp_val = cchprods(n, m, goth, x, vector, lchp, chp_ind, chp_ptr)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lchp:    [IN] Int
  - chp_val: [OUT] Array{Float64, 1}
  - chp_ind: [IN] Array{Cint, 1}
  - chp_ptr: [IN] Array{Cint, 1}
"""
function cchprods(cutest_lib::Ptr{Void}, n::Int, m::Int, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lchp::Int, chp_ind::Array{Cint, 1},
    chp_ptr::Array{Cint, 1})
  io_err = Cint[0]
  chp_val = Array(Cdouble, lchp)
  cchprods(cutest_lib, io_err, Cint[n], Cint[m], Cint[goth], x, vector,
    Cint[lchp], chp_val, chp_ind, chp_ptr)
  @cutest_error
  return chp_val
end

"""
    cchprods!(n, m, goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lchp:    [IN] Int
  - chp_val: [OUT] Array{Float64, 1}
  - chp_ind: [IN] Array{Cint, 1}
  - chp_ptr: [IN] Array{Cint, 1}
"""
function cchprods!(cutest_lib::Ptr{Void}, n::Int, m::Int, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lchp::Int, chp_val::Array{Float64, 1},
    chp_ind::Array{Cint, 1}, chp_ptr::Array{Cint, 1})
  io_err = Cint[0]
  cchprods(cutest_lib, io_err, Cint[n], Cint[m], Cint[goth], x, vector,
    Cint[lchp], chp_val, chp_ind, chp_ptr)
  @cutest_error
  return
end

"""
    uterminate()

"""
function uterminate(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  uterminate(cutest_lib, io_err)
  @cutest_error
  return
end

"""
    cterminate()

"""
function cterminate(cutest_lib::Ptr{Void}, )
  io_err = Cint[0]
  cterminate(cutest_lib, io_err)
  @cutest_error
  return
end
