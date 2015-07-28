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

function usetup(input::Int, out::Int, io_buffer::Int, n::Int, libname)
  io_err = Cint[0]
  x = Array(Cdouble, n)
  x_l = Array(Cdouble, n)
  x_u = Array(Cdouble, n)
  @eval usetup($(io_err), $(Cint[input]), $(Cint[out]),
    $(Cint[io_buffer]), $(Cint[n]), $(x), $(x_l), $(x_u), $(libname))
  @cutest_error
  return x, x_l, x_u
end

function usetup!(input::Int, out::Int, io_buffer::Int, n::Int, x::Array{Float64, 1},
    x_l::Array{Float64, 1}, x_u::Array{Float64, 1}, libname)
  io_err = Cint[0]
  @eval usetup($(io_err), $(Cint[input]), $(Cint[out]),
    $(Cint[io_buffer]), $(Cint[n]), $(x), $(x_l), $(x_u), $(libname))
  @cutest_error
  return
end


function csetup(input::Int, out::Int, io_buffer::Int, n::Int, m::Int, e_order::Int,
    l_order::Int, v_order::Int, libname)
  io_err = Cint[0]
  x = Array(Cdouble, n)
  x_l = Array(Cdouble, n)
  x_u = Array(Cdouble, n)
  y = Array(Cdouble, m)
  c_l = Array(Cdouble, m)
  c_u = Array(Cdouble, m)
  equatn = Array(Cint, m)
  linear = Array(Cint, m)
  @eval csetup($(io_err), $(Cint[input]), $(Cint[out]),
    $(Cint[io_buffer]), $(Cint[n]), $(Cint[m]), $(x), $(x_l), $(x_u),
    $(y), $(c_l), $(c_u), $(equatn), $(linear), $(Cint[e_order]),
    $(Cint[l_order]), $(Cint[v_order]), $(libname))
  @cutest_error
  return x, x_l, x_u, y, c_l, c_u, equatn, linear
end

function csetup!(input::Int, out::Int, io_buffer::Int, n::Int, m::Int,
    x::Array{Float64, 1}, x_l::Array{Float64, 1}, x_u::Array{Float64, 1},
    y::Array{Float64, 1}, c_l::Array{Float64, 1}, c_u::Array{Float64, 1},
    equatn::Array{Bool, 1}, linear::Array{Bool, 1}, e_order::Int,
    l_order::Int, v_order::Int, libname)
  io_err = Cint[0]
  @eval csetup($(io_err), $(Cint[input]), $(Cint[out]),
    $(Cint[io_buffer]), $(Cint[n]), $(Cint[m]), $(x), $(x_l), $(x_u),
    $(y), $(c_l), $(c_u), $(equatn), $(linear), $(Cint[e_order]),
    $(Cint[l_order]), $(Cint[v_order]), $(libname))
  @cutest_error
  return
end


function udimen(input::Int, libname)
  io_err = Cint[0]
  n = Cint[0]
  @eval udimen($(io_err), $(Cint[input]), $(n), $(libname))
  @cutest_error
  return n[1]
end

function udimen!(input::Int, libname)
  io_err = Cint[0]
  n = Cint[0]
  @eval udimen($(io_err), $(Cint[input]), $(n), $(libname))
  @cutest_error
  return n[1]
end


function udimen(nlp::CUTEstModel, input::Int)
  io_err = Cint[0]
  n = Cint[0]
  @eval udimen($(io_err), $(Cint[input]), $(n), $(nlp.libname))
  @cutest_error
  return n[1]
end

function udimen!(nlp::CUTEstModel, input::Int)
  io_err = Cint[0]
  n = Cint[0]
  @eval udimen($(io_err), $(Cint[input]), $(n), $(nlp.libname))
  @cutest_error
  return n[1]
end


function udimsh(libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval udimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end

function udimsh!(libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval udimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end


function udimsh(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval udimsh($(io_err), $(nnzh), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function udimsh!(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval udimsh($(io_err), $(nnzh), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end


function udimse(libname)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval udimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function udimse!(libname)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval udimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end


function udimse(nlp::CUTEstModel)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval udimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(nlp.libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function udimse!(nlp::CUTEstModel)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval udimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(nlp.libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end


function uvartype(n::Int, libname)
  io_err = Cint[0]
  x_type = Array(Cint, n)
  @eval uvartype($(io_err), $(Cint[n]), $(x_type), $(libname))
  @cutest_error
  return x_type
end

function uvartype!(n::Int, x_type::Array{Int, 1}, libname)
  io_err = Cint[0]
  x_type_cp = Array(Cint, n)
  @eval uvartype($(io_err), $(Cint[n]), $(x_type_cp), $(libname))
  @cutest_error
  for i = 1:n
    x_type[i] = x_type_cp[i]
  end
  return
end

function uvartype!(n::Int, x_type::Array{Cint, 1}, libname)
  io_err = Cint[0]
  @eval uvartype($(io_err), $(Cint[n]), $(x_type), $(libname))
  @cutest_error
  return
end

function uvartype(nlp::CUTEstModel)
  io_err = Cint[0]
  n = nlp.meta.nvar
  x_type = Array(Cint, n)
  @eval uvartype($(io_err), $(Cint[n]), $(x_type), $(nlp.libname))
  @cutest_error
  return x_type
end

function uvartype!(nlp::CUTEstModel, x_type::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  x_type_cp = Array(Cint, n)
  @eval uvartype($(io_err), $(Cint[n]), $(x_type_cp), $(nlp.libname))
  @cutest_error
  for i = 1:n
    x_type[i] = x_type_cp[i]
  end
  return
end

function uvartype!(nlp::CUTEstModel, x_type::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval uvartype($(io_err), $(Cint[n]), $(x_type), $(nlp.libname))
  @cutest_error
  return
end

function unames(n::Int, libname)
  io_err = Cint[0]
  pname = Cchar[0]
  vname = Array(Cchar, n)
  @eval unames($(io_err), $(Cint[n]), $(pname), $(vname), $(libname))
  @cutest_error
  return pname[1], vname
end

function unames!(n::Int, vname::Array{Uint8, 1}, libname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval unames($(io_err), $(Cint[n]), $(pname), $(vname), $(libname))
  @cutest_error
  return pname[1]
end


function unames(nlp::CUTEstModel)
  io_err = Cint[0]
  n = nlp.meta.nvar
  pname = Cchar[0]
  vname = Array(Cchar, n)
  @eval unames($(io_err), $(Cint[n]), $(pname), $(vname),
    $(nlp.libname))
  @cutest_error
  return pname[1], vname
end

function unames!(nlp::CUTEstModel, vname::Array{Uint8, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  pname = Cchar[0]
  @eval unames($(io_err), $(Cint[n]), $(pname), $(vname),
    $(nlp.libname))
  @cutest_error
  return pname[1]
end


function ureport(libname)
  io_err = Cint[0]
  calls = Array(Cdouble, 4)
  time = Array(Cdouble, 2)
  @eval ureport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return calls, time
end

function ureport!(calls::Array{Float64, 1}, time::Array{Float64, 1}, libname)
  io_err = Cint[0]
  @eval ureport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return
end


function ureport(nlp::CUTEstModel)
  io_err = Cint[0]
  calls = Array(Cdouble, 4)
  time = Array(Cdouble, 2)
  @eval ureport($(io_err), $(calls), $(time), $(nlp.libname))
  @cutest_error
  return calls, time
end

function ureport!(nlp::CUTEstModel, calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  @eval ureport($(io_err), $(calls), $(time), $(nlp.libname))
  @cutest_error
  return
end


function cdimen(input::Int, libname)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  @eval cdimen($(io_err), $(Cint[input]), $(n), $(m), $(libname))
  @cutest_error
  return n[1], m[1]
end

function cdimen!(input::Int, libname)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  @eval cdimen($(io_err), $(Cint[input]), $(n), $(m), $(libname))
  @cutest_error
  return n[1], m[1]
end


function cdimen(nlp::CUTEstModel, input::Int)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  @eval cdimen($(io_err), $(Cint[input]), $(n), $(m), $(nlp.libname))
  @cutest_error
  return n[1], m[1]
end

function cdimen!(nlp::CUTEstModel, input::Int)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  @eval cdimen($(io_err), $(Cint[input]), $(n), $(m), $(nlp.libname))
  @cutest_error
  return n[1], m[1]
end


function cdimsj(libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval cdimsj($(io_err), $(nnzj), $(libname))
  @cutest_error
  return nnzj[1]
end

function cdimsj!(libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval cdimsj($(io_err), $(nnzj), $(libname))
  @cutest_error
  return nnzj[1]
end


function cdimsj(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval cdimsj($(io_err), $(nnzj), $(nlp.libname))
  @cutest_error
  return nnzj[1]
end

function cdimsj!(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval cdimsj($(io_err), $(nnzj), $(nlp.libname))
  @cutest_error
  return nnzj[1]
end


function cdimsh(libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval cdimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end

function cdimsh!(libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval cdimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end


function cdimsh(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval cdimsh($(io_err), $(nnzh), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function cdimsh!(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval cdimsh($(io_err), $(nnzh), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end


function cdimse(libname)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval cdimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function cdimse!(libname)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval cdimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end


function cdimse(nlp::CUTEstModel)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval cdimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(nlp.libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function cdimse!(nlp::CUTEstModel)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval cdimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(nlp.libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end


function cstats(libname)
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  @eval cstats($(io_err), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(equality_constraints),
    $(linear_constraints), $(libname))
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function cstats!(libname)
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  @eval cstats($(io_err), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(equality_constraints),
    $(linear_constraints), $(libname))
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end


function cstats(nlp::CUTEstModel)
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  @eval cstats($(io_err), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(equality_constraints),
    $(linear_constraints), $(nlp.libname))
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function cstats!(nlp::CUTEstModel)
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  @eval cstats($(io_err), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(equality_constraints),
    $(linear_constraints), $(nlp.libname))
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end


function cvartype(n::Int, libname)
  io_err = Cint[0]
  x_type = Array(Cint, n)
  @eval cvartype($(io_err), $(Cint[n]), $(x_type), $(libname))
  @cutest_error
  return x_type
end

function cvartype!(n::Int, x_type::Array{Int, 1}, libname)
  io_err = Cint[0]
  x_type_cp = Array(Cint, n)
  @eval cvartype($(io_err), $(Cint[n]), $(x_type_cp), $(libname))
  @cutest_error
  for i = 1:n
    x_type[i] = x_type_cp[i]
  end
  return
end

function cvartype!(n::Int, x_type::Array{Cint, 1}, libname)
  io_err = Cint[0]
  @eval cvartype($(io_err), $(Cint[n]), $(x_type), $(libname))
  @cutest_error
  return
end

function cvartype(nlp::CUTEstModel)
  io_err = Cint[0]
  n = nlp.meta.nvar
  x_type = Array(Cint, n)
  @eval cvartype($(io_err), $(Cint[n]), $(x_type), $(nlp.libname))
  @cutest_error
  return x_type
end

function cvartype!(nlp::CUTEstModel, x_type::Array{Int, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  x_type_cp = Array(Cint, n)
  @eval cvartype($(io_err), $(Cint[n]), $(x_type_cp), $(nlp.libname))
  @cutest_error
  for i = 1:n
    x_type[i] = x_type_cp[i]
  end
  return
end

function cvartype!(nlp::CUTEstModel, x_type::Array{Cint, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval cvartype($(io_err), $(Cint[n]), $(x_type), $(nlp.libname))
  @cutest_error
  return
end

function cnames(n::Int, m::Int, libname)
  io_err = Cint[0]
  pname = Cchar[0]
  vname = Array(Cchar, n)
  cname = Array(Cchar, m)
  @eval cnames($(io_err), $(Cint[n]), $(Cint[m]), $(pname), $(vname),
    $(cname), $(libname))
  @cutest_error
  return pname[1], vname, cname
end

function cnames!(n::Int, m::Int, vname::Array{Uint8, 1}, cname::Array{Uint8, 1},
    libname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval cnames($(io_err), $(Cint[n]), $(Cint[m]), $(pname), $(vname),
    $(cname), $(libname))
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
  @eval cnames($(io_err), $(Cint[n]), $(Cint[m]), $(pname), $(vname),
    $(cname), $(nlp.libname))
  @cutest_error
  return pname[1], vname, cname
end

function cnames!(nlp::CUTEstModel, vname::Array{Uint8, 1}, cname::Array{Uint8, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  pname = Cchar[0]
  @eval cnames($(io_err), $(Cint[n]), $(Cint[m]), $(pname), $(vname),
    $(cname), $(nlp.libname))
  @cutest_error
  return pname[1]
end


function creport(libname)
  io_err = Cint[0]
  calls = Array(Cdouble, 7)
  time = Array(Cdouble, 2)
  @eval creport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return calls, time
end

function creport!(calls::Array{Float64, 1}, time::Array{Float64, 1}, libname)
  io_err = Cint[0]
  @eval creport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return
end


function creport(nlp::CUTEstModel)
  io_err = Cint[0]
  calls = Array(Cdouble, 7)
  time = Array(Cdouble, 2)
  @eval creport($(io_err), $(calls), $(time), $(nlp.libname))
  @cutest_error
  return calls, time
end

function creport!(nlp::CUTEstModel, calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  @eval creport($(io_err), $(calls), $(time), $(nlp.libname))
  @cutest_error
  return
end


function connames(m::Int, libname)
  io_err = Cint[0]
  cname = Array(Cchar, m)
  @eval connames($(io_err), $(Cint[m]), $(cname), $(libname))
  @cutest_error
  return cname
end

function connames!(m::Int, cname::Array{Uint8, 1}, libname)
  io_err = Cint[0]
  @eval connames($(io_err), $(Cint[m]), $(cname), $(libname))
  @cutest_error
  return
end


function connames(nlp::CUTEstModel)
  io_err = Cint[0]
  m = nlp.meta.ncon
  cname = Array(Cchar, m)
  @eval connames($(io_err), $(Cint[m]), $(cname), $(nlp.libname))
  @cutest_error
  return cname
end

function connames!(nlp::CUTEstModel, cname::Array{Uint8, 1})
  io_err = Cint[0]
  m = nlp.meta.ncon
  @eval connames($(io_err), $(Cint[m]), $(cname), $(nlp.libname))
  @cutest_error
  return
end


function pname(input::Int, libname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval pname($(io_err), $(Cint[input]), $(pname), $(libname))
  @cutest_error
  return pname[1]
end

function pname!(input::Int, libname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval pname($(io_err), $(Cint[input]), $(pname), $(libname))
  @cutest_error
  return pname[1]
end


function pname(nlp::CUTEstModel, input::Int)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval pname($(io_err), $(Cint[input]), $(pname), $(nlp.libname))
  @cutest_error
  return pname[1]
end

function pname!(nlp::CUTEstModel, input::Int)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval pname($(io_err), $(Cint[input]), $(pname), $(nlp.libname))
  @cutest_error
  return pname[1]
end


function probname(libname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval probname($(io_err), $(pname), $(libname))
  @cutest_error
  return pname[1]
end

function probname!(libname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval probname($(io_err), $(pname), $(libname))
  @cutest_error
  return pname[1]
end


function probname(nlp::CUTEstModel)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval probname($(io_err), $(pname), $(nlp.libname))
  @cutest_error
  return pname[1]
end

function probname!(nlp::CUTEstModel)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval probname($(io_err), $(pname), $(nlp.libname))
  @cutest_error
  return pname[1]
end


function varnames(n::Int, libname)
  io_err = Cint[0]
  vname = Array(Cchar, n)
  @eval varnames($(io_err), $(Cint[n]), $(vname), $(libname))
  @cutest_error
  return vname
end

function varnames!(n::Int, vname::Array{Uint8, 1}, libname)
  io_err = Cint[0]
  @eval varnames($(io_err), $(Cint[n]), $(vname), $(libname))
  @cutest_error
  return
end


function varnames(nlp::CUTEstModel)
  io_err = Cint[0]
  n = nlp.meta.nvar
  vname = Array(Cchar, n)
  @eval varnames($(io_err), $(Cint[n]), $(vname), $(nlp.libname))
  @cutest_error
  return vname
end

function varnames!(nlp::CUTEstModel, vname::Array{Uint8, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval varnames($(io_err), $(Cint[n]), $(vname), $(nlp.libname))
  @cutest_error
  return
end


function ufn(n::Int, x::Array{Float64, 1}, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval ufn($(io_err), $(Cint[n]), $(x), $(f), $(libname))
  @cutest_error
  return f[1]
end

function ufn!(n::Int, x::Array{Float64, 1}, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval ufn($(io_err), $(Cint[n]), $(x), $(f), $(libname))
  @cutest_error
  return f[1]
end


function ufn(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  @eval ufn($(io_err), $(Cint[n]), $(x), $(f), $(nlp.libname))
  @cutest_error
  return f[1]
end

function ufn!(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  @eval ufn($(io_err), $(Cint[n]), $(x), $(f), $(nlp.libname))
  @cutest_error
  return f[1]
end


function ugr(n::Int, x::Array{Float64, 1}, libname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  @eval ugr($(io_err), $(Cint[n]), $(x), $(g), $(libname))
  @cutest_error
  return g
end

function ugr!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, libname)
  io_err = Cint[0]
  @eval ugr($(io_err), $(Cint[n]), $(x), $(g), $(libname))
  @cutest_error
  return
end


function ugr(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  g = Array(Cdouble, n)
  @eval ugr($(io_err), $(Cint[n]), $(x), $(g), $(nlp.libname))
  @cutest_error
  return g
end

function ugr!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval ugr($(io_err), $(Cint[n]), $(x), $(g), $(nlp.libname))
  @cutest_error
  return
end


function uofg(n::Int, x::Array{Float64, 1}, grad::Bool, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval uofg($(io_err), $(Cint[n]), $(x), $(f), $(g), $(Cint[grad]),
    $(libname))
  @cutest_error
  return f[1], g
end

function uofg!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool,
    libname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval uofg($(io_err), $(Cint[n]), $(x), $(f), $(g), $(Cint[grad]),
    $(libname))
  @cutest_error
  return f[1]
end


function uofg(nlp::CUTEstModel, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval uofg($(io_err), $(Cint[n]), $(x), $(f), $(g), $(Cint[grad]),
    $(nlp.libname))
  @cutest_error
  return f[1], g
end

function uofg!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  @eval uofg($(io_err), $(Cint[n]), $(x), $(f), $(g), $(Cint[grad]),
    $(nlp.libname))
  @cutest_error
  return f[1]
end


function ubandh(n::Int, x::Array{Float64, 1}, semibandwidth::Int, lbandh::Int,
    libname)
  io_err = Cint[0]
  h_band = Array(Cdouble, lbandh - 0 + 1, n)
  max_semibandwidth = Cint[0]
  @eval ubandh($(io_err), $(Cint[n]), $(x), $(Cint[semibandwidth]),
    $(h_band), $(Cint[lbandh]), $(max_semibandwidth), $(libname))
  @cutest_error
  return h_band, max_semibandwidth[1]
end

function ubandh!(n::Int, x::Array{Float64, 1}, semibandwidth::Int,
    h_band::Array{Float64, 2}, lbandh::Int, libname)
  io_err = Cint[0]
  max_semibandwidth = Cint[0]
  @eval ubandh($(io_err), $(Cint[n]), $(x), $(Cint[semibandwidth]),
    $(h_band), $(Cint[lbandh]), $(max_semibandwidth), $(libname))
  @cutest_error
  return max_semibandwidth[1]
end


function ubandh(nlp::CUTEstModel, x::Array{Float64, 1}, semibandwidth::Int,
    lbandh::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  h_band = Array(Cdouble, lbandh - 0 + 1, n)
  max_semibandwidth = Cint[0]
  @eval ubandh($(io_err), $(Cint[n]), $(x), $(Cint[semibandwidth]),
    $(h_band), $(Cint[lbandh]), $(max_semibandwidth), $(nlp.libname))
  @cutest_error
  return h_band, max_semibandwidth[1]
end

function ubandh!(nlp::CUTEstModel, x::Array{Float64, 1}, semibandwidth::Int,
    h_band::Array{Float64, 2}, lbandh::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  max_semibandwidth = Cint[0]
  @eval ubandh($(io_err), $(Cint[n]), $(x), $(Cint[semibandwidth]),
    $(h_band), $(Cint[lbandh]), $(max_semibandwidth), $(nlp.libname))
  @cutest_error
  return max_semibandwidth[1]
end


function udh(n::Int, x::Array{Float64, 1}, lh1::Int, libname)
  io_err = Cint[0]
  h = Array(Cdouble, lh1, n)
  @eval udh($(io_err), $(Cint[n]), $(x), $(Cint[lh1]), $(h),
    $(libname))
  @cutest_error
  return h
end

function udh!(n::Int, x::Array{Float64, 1}, lh1::Int, h::Array{Float64, 2},
    libname)
  io_err = Cint[0]
  @eval udh($(io_err), $(Cint[n]), $(x), $(Cint[lh1]), $(h),
    $(libname))
  @cutest_error
  return
end


function udh(nlp::CUTEstModel, x::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  h = Array(Cdouble, lh1, n)
  @eval udh($(io_err), $(Cint[n]), $(x), $(Cint[lh1]), $(h),
    $(nlp.libname))
  @cutest_error
  return h
end

function udh!(nlp::CUTEstModel, x::Array{Float64, 1}, lh1::Int, h::Array{Float64,
    2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval udh($(io_err), $(Cint[n]), $(x), $(Cint[lh1]), $(h),
    $(nlp.libname))
  @cutest_error
  return
end


function ush(n::Int, x::Array{Float64, 1}, lh::Int, libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval ush($(io_err), $(Cint[n]), $(x), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function ush!(n::Int, x::Array{Float64, 1}, lh::Int, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1}, libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  @eval ush($(io_err), $(Cint[n]), $(x), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row_cp), $(h_col_cp), $(libname))
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
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1}, libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval ush($(io_err), $(Cint[n]), $(x), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(libname))
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
  @eval ush($(io_err), $(Cint[n]), $(x), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(nlp.libname))
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
  @eval ush($(io_err), $(Cint[n]), $(x), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row_cp), $(h_col_cp), $(nlp.libname))
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
  @eval ush($(io_err), $(Cint[n]), $(x), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function ueh(n::Int, x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int,
    lhe_val::Int, byrows::Bool, libname)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval ueh($(io_err), $(Cint[n]), $(x), $(ne), $(Cint[lhe_ptr]),
    $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]), $(he_row),
    $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ueh!(n::Int, x::Array{Float64, 1}, lhe_ptr::Int, he_row_ptr::Array{Int,
    1}, he_val_ptr::Array{Int, 1}, lhe_row::Int, he_row::Array{Int, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool, libname)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  @eval ueh($(io_err), $(Cint[n]), $(x), $(ne), $(Cint[lhe_ptr]),
    $(he_row_ptr_cp), $(he_val_ptr_cp), $(Cint[lhe_row]), $(he_row_cp),
    $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
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
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool, libname)
  io_err = Cint[0]
  ne = Cint[0]
  @eval ueh($(io_err), $(Cint[n]), $(x), $(ne), $(Cint[lhe_ptr]),
    $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]), $(he_row),
    $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
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
  @eval ueh($(io_err), $(Cint[n]), $(x), $(ne), $(Cint[lhe_ptr]),
    $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]), $(he_row),
    $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(nlp.libname))
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
  @eval ueh($(io_err), $(Cint[n]), $(x), $(ne), $(Cint[lhe_ptr]),
    $(he_row_ptr_cp), $(he_val_ptr_cp), $(Cint[lhe_row]), $(he_row_cp),
    $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(nlp.libname))
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
  @eval ueh($(io_err), $(Cint[n]), $(x), $(ne), $(Cint[lhe_ptr]),
    $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]), $(he_row),
    $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(nlp.libname))
  @cutest_error
  return ne[1]
end

function ugrdh(n::Int, x::Array{Float64, 1}, lh1::Int, libname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  h = Array(Cdouble, lh1, n)
  @eval ugrdh($(io_err), $(Cint[n]), $(x), $(g), $(Cint[lh1]), $(h),
    $(libname))
  @cutest_error
  return g, h
end

function ugrdh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lh1::Int,
    h::Array{Float64, 2}, libname)
  io_err = Cint[0]
  @eval ugrdh($(io_err), $(Cint[n]), $(x), $(g), $(Cint[lh1]), $(h),
    $(libname))
  @cutest_error
  return
end


function ugrdh(nlp::CUTEstModel, x::Array{Float64, 1}, lh1::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  g = Array(Cdouble, n)
  h = Array(Cdouble, lh1, n)
  @eval ugrdh($(io_err), $(Cint[n]), $(x), $(g), $(Cint[lh1]), $(h),
    $(nlp.libname))
  @cutest_error
  return g, h
end

function ugrdh!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    lh1::Int, h::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval ugrdh($(io_err), $(Cint[n]), $(x), $(g), $(Cint[lh1]), $(h),
    $(nlp.libname))
  @cutest_error
  return
end


function ugrsh(n::Int, x::Array{Float64, 1}, lh::Int, libname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval ugrsh($(io_err), $(Cint[n]), $(x), $(g), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return g, nnzh[1], h_val, h_row, h_col
end

function ugrsh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1},
    libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  @eval ugrsh($(io_err), $(Cint[n]), $(x), $(g), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row_cp), $(h_col_cp), $(libname))
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
    1}, libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval ugrsh($(io_err), $(Cint[n]), $(x), $(g), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(libname))
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
  @eval ugrsh($(io_err), $(Cint[n]), $(x), $(g), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(nlp.libname))
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
  @eval ugrsh($(io_err), $(Cint[n]), $(x), $(g), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row_cp), $(h_col_cp), $(nlp.libname))
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
  @eval ugrsh($(io_err), $(Cint[n]), $(x), $(g), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function ugreh(n::Int, x::Array{Float64, 1}, lhe_ptr::Int, lhe_row::Int,
    lhe_val::Int, byrows::Bool, libname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval ugreh($(io_err), $(Cint[n]), $(x), $(g), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
  @cutest_error
  return g, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ugreh!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, lhe_ptr::Int,
    he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1}, lhe_row::Int,
    he_row::Array{Int, 1}, lhe_val::Int, he_val::Array{Float64, 1},
    byrows::Bool, libname)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  @eval ugreh($(io_err), $(Cint[n]), $(x), $(g), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr_cp), $(he_val_ptr_cp),
    $(Cint[lhe_row]), $(he_row_cp), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(libname))
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
    byrows::Bool, libname)
  io_err = Cint[0]
  ne = Cint[0]
  @eval ugreh($(io_err), $(Cint[n]), $(x), $(g), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
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
  @eval ugreh($(io_err), $(Cint[n]), $(x), $(g), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]),
    $(nlp.libname))
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
  @eval ugreh($(io_err), $(Cint[n]), $(x), $(g), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr_cp), $(he_val_ptr_cp),
    $(Cint[lhe_row]), $(he_row_cp), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(nlp.libname))
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
  @eval ugreh($(io_err), $(Cint[n]), $(x), $(g), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]),
    $(nlp.libname))
  @cutest_error
  return ne[1]
end

function uhprod(n::Int, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1},
    libname)
  io_err = Cint[0]
  result = Array(Cdouble, n)
  @eval uhprod($(io_err), $(Cint[n]), $(Cint[goth]), $(x), $(vector),
    $(result), $(libname))
  @cutest_error
  return result
end

function uhprod!(n::Int, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64, 1},
    result::Array{Float64, 1}, libname)
  io_err = Cint[0]
  @eval uhprod($(io_err), $(Cint[n]), $(Cint[goth]), $(x), $(vector),
    $(result), $(libname))
  @cutest_error
  return
end


function uhprod(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  result = Array(Cdouble, n)
  @eval uhprod($(io_err), $(Cint[n]), $(Cint[goth]), $(x), $(vector),
    $(result), $(nlp.libname))
  @cutest_error
  return result
end

function uhprod!(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval uhprod($(io_err), $(Cint[n]), $(Cint[goth]), $(x), $(vector),
    $(result), $(nlp.libname))
  @cutest_error
  return
end


function cfn(n::Int, m::Int, x::Array{Float64, 1}, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  c = Array(Cdouble, m)
  @eval cfn($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(f), $(c),
    $(libname))
  @cutest_error
  return f[1], c
end

function cfn!(n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1}, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval cfn($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(f), $(c),
    $(libname))
  @cutest_error
  return f[1]
end


function cfn(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  c = Array(Cdouble, m)
  @eval cfn($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(f), $(c),
    $(nlp.libname))
  @cutest_error
  return f[1], c
end

function cfn!(nlp::CUTEstModel, x::Array{Float64, 1}, c::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  @eval cfn($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(f), $(c),
    $(nlp.libname))
  @cutest_error
  return f[1]
end


function cofg(n::Int, x::Array{Float64, 1}, grad::Bool, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval cofg($(io_err), $(Cint[n]), $(x), $(f), $(g), $(Cint[grad]),
    $(libname))
  @cutest_error
  return f[1], g
end

function cofg!(n::Int, x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool,
    libname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval cofg($(io_err), $(Cint[n]), $(x), $(f), $(g), $(Cint[grad]),
    $(libname))
  @cutest_error
  return f[1]
end


function cofg(nlp::CUTEstModel, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval cofg($(io_err), $(Cint[n]), $(x), $(f), $(g), $(Cint[grad]),
    $(nlp.libname))
  @cutest_error
  return f[1], g
end

function cofg!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  @eval cofg($(io_err), $(Cint[n]), $(x), $(f), $(g), $(Cint[grad]),
    $(nlp.libname))
  @cutest_error
  return f[1]
end


function cofsg(n::Int, x::Array{Float64, 1}, lg::Int, grad::Bool, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  g_val = Array(Cdouble, lg)
  g_var = Array(Cint, lg)
  @eval cofsg($(io_err), $(Cint[n]), $(x), $(f), $(nnzg), $(Cint[lg]),
    $(g_val), $(g_var), $(Cint[grad]), $(libname))
  @cutest_error
  return f[1], nnzg[1], g_val, g_var
end

function cofsg!(n::Int, x::Array{Float64, 1}, lg::Int, g_val::Array{Float64, 1},
    g_var::Array{Int, 1}, grad::Bool, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  g_var_cp = Array(Cint, lg)
  @eval cofsg($(io_err), $(Cint[n]), $(x), $(f), $(nnzg), $(Cint[lg]),
    $(g_val), $(g_var_cp), $(Cint[grad]), $(libname))
  @cutest_error
  for i = 1:lg
    g_var[i] = g_var_cp[i]
  end
  return f[1], nnzg[1]
end

function cofsg!(n::Int, x::Array{Float64, 1}, lg::Int, g_val::Array{Float64, 1},
    g_var::Array{Cint, 1}, grad::Bool, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  @eval cofsg($(io_err), $(Cint[n]), $(x), $(f), $(nnzg), $(Cint[lg]),
    $(g_val), $(g_var), $(Cint[grad]), $(libname))
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
  @eval cofsg($(io_err), $(Cint[n]), $(x), $(f), $(nnzg), $(Cint[lg]),
    $(g_val), $(g_var), $(Cint[grad]), $(nlp.libname))
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
  @eval cofsg($(io_err), $(Cint[n]), $(x), $(f), $(nnzg), $(Cint[lg]),
    $(g_val), $(g_var_cp), $(Cint[grad]), $(nlp.libname))
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
  @eval cofsg($(io_err), $(Cint[n]), $(x), $(f), $(nnzg), $(Cint[lg]),
    $(g_val), $(g_var), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1], nnzg[1]
end

function ccfg(n::Int, m::Int, x::Array{Float64, 1}, jtrans::Bool, lcjac1::Int,
    lcjac2::Int, grad::Bool, libname)
  io_err = Cint[0]
  c = Array(Cdouble, m)
  cjac = Array(Cdouble, lcjac1, lcjac2)
  @eval ccfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(Cint[jtrans]), $(Cint[lcjac1]), $(Cint[lcjac2]), $(cjac),
    $(Cint[grad]), $(libname))
  @cutest_error
  return c, cjac
end

function ccfg!(n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1},
    jtrans::Bool, lcjac1::Int, lcjac2::Int, cjac::Array{Float64, 2},
    grad::Bool, libname)
  io_err = Cint[0]
  @eval ccfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(Cint[jtrans]), $(Cint[lcjac1]), $(Cint[lcjac2]), $(cjac),
    $(Cint[grad]), $(libname))
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
  @eval ccfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(Cint[jtrans]), $(Cint[lcjac1]), $(Cint[lcjac2]), $(cjac),
    $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return c, cjac
end

function ccfg!(nlp::CUTEstModel, x::Array{Float64, 1}, c::Array{Float64, 1},
    jtrans::Bool, lcjac1::Int, lcjac2::Int, cjac::Array{Float64, 2},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval ccfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(Cint[jtrans]), $(Cint[lcjac1]), $(Cint[lcjac2]), $(cjac),
    $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return
end


function clfg(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grad::Bool, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval clfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(f),
    $(g), $(Cint[grad]), $(libname))
  @cutest_error
  return f[1], g
end

function clfg!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    g::Array{Float64, 1}, grad::Bool, libname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval clfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(f),
    $(g), $(Cint[grad]), $(libname))
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
  @eval clfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(f),
    $(g), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1], g
end

function clfg!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  @eval clfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(f),
    $(g), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1]
end


function cgr(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Int, lj2::Int, libname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  @eval cgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(libname))
  @cutest_error
  return g, j_val
end

function cgr!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2}, libname)
  io_err = Cint[0]
  @eval cgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(libname))
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
  @eval cgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(nlp.libname))
  @cutest_error
  return g, j_val
end

function cgr!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval cgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(nlp.libname))
  @cutest_error
  return
end


function csgr(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  @eval csgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

function csgr!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1}, libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  @eval csgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var_cp),
    $(j_fun_cp), $(libname))
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
    1}, j_fun::Array{Cint, 1}, libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval csgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(libname))
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
  @eval csgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nlp.libname))
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
  @eval csgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var_cp),
    $(j_fun_cp), $(nlp.libname))
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
  @eval csgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nlp.libname))
  @cutest_error
  return nnzj[1]
end

function ccfsg(n::Int, m::Int, x::Array{Float64, 1}, lj::Int, grad::Bool, libname)
  io_err = Cint[0]
  c = Array(Cdouble, m)
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  @eval ccfsg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c), $(nnzj),
    $(Cint[lj]), $(j_val), $(j_var), $(j_fun), $(Cint[grad]), $(libname))
  @cutest_error
  return c, nnzj[1], j_val, j_var, j_fun
end

function ccfsg!(n::Int, m::Int, x::Array{Float64, 1}, c::Array{Float64, 1}, lj::Int,
    j_val::Array{Float64, 1}, j_var::Array{Int, 1}, j_fun::Array{Int, 1},
    grad::Bool, libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  @eval ccfsg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c), $(nnzj),
    $(Cint[lj]), $(j_val), $(j_var_cp), $(j_fun_cp), $(Cint[grad]),
    $(libname))
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
    1}, grad::Bool, libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval ccfsg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c), $(nnzj),
    $(Cint[lj]), $(j_val), $(j_var), $(j_fun), $(Cint[grad]), $(libname))
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
  @eval ccfsg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c), $(nnzj),
    $(Cint[lj]), $(j_val), $(j_var), $(j_fun), $(Cint[grad]),
    $(nlp.libname))
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
  @eval ccfsg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c), $(nnzj),
    $(Cint[lj]), $(j_val), $(j_var_cp), $(j_fun_cp), $(Cint[grad]),
    $(nlp.libname))
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
  @eval ccfsg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c), $(nnzj),
    $(Cint[lj]), $(j_val), $(j_var), $(j_fun), $(Cint[grad]),
    $(nlp.libname))
  @cutest_error
  return nnzj[1]
end

function ccifg(n::Int, icon::Int, x::Array{Float64, 1}, grad::Bool, libname)
  io_err = Cint[0]
  ci = Cdouble[0]
  gci = Array(Cdouble, n)
  @eval ccifg($(io_err), $(Cint[n]), $(Cint[icon]), $(x), $(ci),
    $(gci), $(Cint[grad]), $(libname))
  @cutest_error
  return ci[1], gci
end

function ccifg!(n::Int, icon::Int, x::Array{Float64, 1}, gci::Array{Float64, 1},
    grad::Bool, libname)
  io_err = Cint[0]
  ci = Cdouble[0]
  @eval ccifg($(io_err), $(Cint[n]), $(Cint[icon]), $(x), $(ci),
    $(gci), $(Cint[grad]), $(libname))
  @cutest_error
  return ci[1]
end


function ccifg(nlp::CUTEstModel, icon::Int, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  gci = Array(Cdouble, n)
  @eval ccifg($(io_err), $(Cint[n]), $(Cint[icon]), $(x), $(ci),
    $(gci), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return ci[1], gci
end

function ccifg!(nlp::CUTEstModel, icon::Int, x::Array{Float64, 1},
    gci::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  @eval ccifg($(io_err), $(Cint[n]), $(Cint[icon]), $(x), $(ci),
    $(gci), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return ci[1]
end


function ccifsg(n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int, grad::Bool,
    libname)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_val = Array(Cdouble, lgci)
  gci_var = Array(Cint, lgci)
  @eval ccifsg($(io_err), $(Cint[n]), $(Cint[icon]), $(x), $(ci),
    $(nnzgci), $(Cint[lgci]), $(gci_val), $(gci_var), $(Cint[grad]),
    $(libname))
  @cutest_error
  return ci[1], nnzgci[1], gci_val, gci_var
end

function ccifsg!(n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int,
    gci_val::Array{Float64, 1}, gci_var::Array{Int, 1}, grad::Bool,
    libname)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_var_cp = Array(Cint, lgci)
  @eval ccifsg($(io_err), $(Cint[n]), $(Cint[icon]), $(x), $(ci),
    $(nnzgci), $(Cint[lgci]), $(gci_val), $(gci_var_cp), $(Cint[grad]),
    $(libname))
  @cutest_error
  for i = 1:lgci
    gci_var[i] = gci_var_cp[i]
  end
  return ci[1], nnzgci[1]
end

function ccifsg!(n::Int, icon::Int, x::Array{Float64, 1}, lgci::Int,
    gci_val::Array{Float64, 1}, gci_var::Array{Cint, 1}, grad::Bool,
    libname)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  @eval ccifsg($(io_err), $(Cint[n]), $(Cint[icon]), $(x), $(ci),
    $(nnzgci), $(Cint[lgci]), $(gci_val), $(gci_var), $(Cint[grad]),
    $(libname))
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
  @eval ccifsg($(io_err), $(Cint[n]), $(Cint[icon]), $(x), $(ci),
    $(nnzgci), $(Cint[lgci]), $(gci_val), $(gci_var), $(Cint[grad]),
    $(nlp.libname))
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
  @eval ccifsg($(io_err), $(Cint[n]), $(Cint[icon]), $(x), $(ci),
    $(nnzgci), $(Cint[lgci]), $(gci_val), $(gci_var_cp), $(Cint[grad]),
    $(nlp.libname))
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
  @eval ccifsg($(io_err), $(Cint[n]), $(Cint[icon]), $(x), $(ci),
    $(nnzgci), $(Cint[lgci]), $(gci_val), $(gci_var), $(Cint[grad]),
    $(nlp.libname))
  @cutest_error
  return ci[1], nnzgci[1]
end

function cgrdh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Int, lj2::Int, lh1::Int, libname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  h_val = Array(Cdouble, lh1, n)
  @eval cgrdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(Cint[lh1]), $(h_val), $(libname))
  @cutest_error
  return g, j_val, h_val
end

function cgrdh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2}, lh1::Int, h_val::Array{Float64, 2}, libname)
  io_err = Cint[0]
  @eval cgrdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(Cint[lh1]), $(h_val), $(libname))
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
  @eval cgrdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(Cint[lh1]), $(h_val), $(nlp.libname))
  @cutest_error
  return g, j_val, h_val
end

function cgrdh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Int, lj2::Int,
    j_val::Array{Float64, 2}, lh1::Int, h_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval cgrdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(Cint[lh1]), $(h_val), $(nlp.libname))
  @cutest_error
  return
end


function cdh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int,
    libname)
  io_err = Cint[0]
  h_val = Array(Cdouble, lh1, n)
  @eval cdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[lh1]), $(h_val), $(libname))
  @cutest_error
  return h_val
end

function cdh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh1::Int,
    h_val::Array{Float64, 2}, libname)
  io_err = Cint[0]
  @eval cdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[lh1]), $(h_val), $(libname))
  @cutest_error
  return
end


function cdh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh1::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  h_val = Array(Cdouble, lh1, n)
  @eval cdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[lh1]), $(h_val), $(nlp.libname))
  @cutest_error
  return h_val
end

function cdh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh1::Int, h_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval cdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[lh1]), $(h_val), $(nlp.libname))
  @cutest_error
  return
end


function csh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval csh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function csh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1},
    libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  @eval csh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row_cp), $(h_col_cp), $(libname))
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
    1}, libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval csh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
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
  @eval csh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
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
  @eval csh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row_cp), $(h_col_cp), $(nlp.libname))
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
  @eval csh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function cshc(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval cshc($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function cshc!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1}, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1},
    libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  @eval cshc($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row_cp), $(h_col_cp), $(libname))
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
    1}, libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval cshc($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
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
  @eval cshc($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
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
  @eval cshc($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row_cp), $(h_col_cp), $(nlp.libname))
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
  @eval cshc($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function ceh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, lhe_row::Int, lhe_val::Int, byrows::Bool, libname)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval ceh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function ceh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Int, he_row_ptr::Array{Int, 1}, he_val_ptr::Array{Int, 1},
    lhe_row::Int, he_row::Array{Int, 1}, lhe_val::Int,
    he_val::Array{Float64, 1}, byrows::Bool, libname)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  @eval ceh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr_cp), $(he_val_ptr_cp),
    $(Cint[lhe_row]), $(he_row_cp), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(libname))
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
    he_val::Array{Float64, 1}, byrows::Bool, libname)
  io_err = Cint[0]
  ne = Cint[0]
  @eval ceh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
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
  @eval ceh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]),
    $(nlp.libname))
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
  @eval ceh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr_cp), $(he_val_ptr_cp),
    $(Cint[lhe_row]), $(he_row_cp), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(nlp.libname))
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
  @eval ceh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]),
    $(nlp.libname))
  @cutest_error
  return ne[1]
end

function cidh(n::Int, x::Array{Float64, 1}, iprob::Int, lh1::Int, libname)
  io_err = Cint[0]
  h = Array(Cdouble, lh1, n)
  @eval cidh($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(Cint[lh1]), $(h), $(libname))
  @cutest_error
  return h
end

function cidh!(n::Int, x::Array{Float64, 1}, iprob::Int, lh1::Int, h::Array{Float64,
    2}, libname)
  io_err = Cint[0]
  @eval cidh($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(Cint[lh1]), $(h), $(libname))
  @cutest_error
  return
end


function cidh(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Int, lh1::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  h = Array(Cdouble, lh1, n)
  @eval cidh($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(Cint[lh1]), $(h), $(nlp.libname))
  @cutest_error
  return h
end

function cidh!(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Int, lh1::Int,
    h::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval cidh($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(Cint[lh1]), $(h), $(nlp.libname))
  @cutest_error
  return
end


function cish(n::Int, x::Array{Float64, 1}, iprob::Int, lh::Int, libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval cish($(io_err), $(Cint[n]), $(x), $(Cint[iprob]), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function cish!(n::Int, x::Array{Float64, 1}, iprob::Int, lh::Int,
    h_val::Array{Float64, 1}, h_row::Array{Int, 1}, h_col::Array{Int, 1},
    libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  @eval cish($(io_err), $(Cint[n]), $(x), $(Cint[iprob]), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row_cp), $(h_col_cp), $(libname))
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
    1}, libname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval cish($(io_err), $(Cint[n]), $(x), $(Cint[iprob]), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
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
  @eval cish($(io_err), $(Cint[n]), $(x), $(Cint[iprob]), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
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
  @eval cish($(io_err), $(Cint[n]), $(x), $(Cint[iprob]), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row_cp), $(h_col_cp), $(nlp.libname))
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
  @eval cish($(io_err), $(Cint[n]), $(x), $(Cint[iprob]), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function csgrsh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, lh::Int, libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval csgrsh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, nnzh[1], h_val, h_row, h_col
end

function csgrsh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1}, lh::Int, h_val::Array{Float64, 1},
    h_row::Array{Int, 1}, h_col::Array{Int, 1}, libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  nnzh = Cint[0]
  h_row_cp = Array(Cint, lh)
  h_col_cp = Array(Cint, lh)
  @eval csgrsh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var_cp),
    $(j_fun_cp), $(nnzh), $(Cint[lh]), $(h_val), $(h_row_cp), $(h_col_cp),
    $(libname))
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
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1}, libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  nnzh = Cint[0]
  @eval csgrsh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
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
  @eval csgrsh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
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
  @eval csgrsh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var_cp),
    $(j_fun_cp), $(nnzh), $(Cint[lh]), $(h_val), $(h_row_cp), $(h_col_cp),
    $(nlp.libname))
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
  @eval csgrsh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzj[1], nnzh[1]
end

function csgreh(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, lhe_ptr::Int, lhe_row::Int, lhe_val::Int,
    byrows::Bool, libname)
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
  @eval csgreh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function csgreh!(n::Int, m::Int, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Int, j_val::Array{Float64, 1}, j_var::Array{Int, 1},
    j_fun::Array{Int, 1}, lhe_ptr::Int, he_row_ptr::Array{Int, 1},
    he_val_ptr::Array{Int, 1}, lhe_row::Int, he_row::Array{Int, 1},
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool, libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_var_cp = Array(Cint, lj)
  j_fun_cp = Array(Cint, lj)
  ne = Cint[0]
  he_row_ptr_cp = Array(Cint, lhe_ptr)
  he_val_ptr_cp = Array(Cint, lhe_ptr)
  he_row_cp = Array(Cint, lhe_row)
  @eval csgreh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var_cp),
    $(j_fun_cp), $(ne), $(Cint[lhe_ptr]), $(he_row_ptr_cp),
    $(he_val_ptr_cp), $(Cint[lhe_row]), $(he_row_cp), $(Cint[lhe_val]),
    $(he_val), $(Cint[byrows]), $(libname))
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
    lhe_val::Int, he_val::Array{Float64, 1}, byrows::Bool, libname)
  io_err = Cint[0]
  nnzj = Cint[0]
  ne = Cint[0]
  @eval csgreh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(libname))
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
  @eval csgreh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(nlp.libname))
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
  @eval csgreh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var_cp),
    $(j_fun_cp), $(ne), $(Cint[lhe_ptr]), $(he_row_ptr_cp),
    $(he_val_ptr_cp), $(Cint[lhe_row]), $(he_row_cp), $(Cint[lhe_val]),
    $(he_val), $(Cint[byrows]), $(nlp.libname))
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
  @eval csgreh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(nlp.libname))
  @cutest_error
  return nnzj[1], ne[1]
end

function chprod(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, libname)
  io_err = Cint[0]
  result = Array(Cdouble, n)
  @eval chprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[goth]), $(x),
    $(y), $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function chprod!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1}, libname)
  io_err = Cint[0]
  @eval chprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[goth]), $(x),
    $(y), $(vector), $(result), $(libname))
  @cutest_error
  return
end


function chprod(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  result = Array(Cdouble, n)
  @eval chprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[goth]), $(x),
    $(y), $(vector), $(result), $(nlp.libname))
  @cutest_error
  return result
end

function chprod!(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval chprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[goth]), $(x),
    $(y), $(vector), $(result), $(nlp.libname))
  @cutest_error
  return
end


function chcprod(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, libname)
  io_err = Cint[0]
  result = Array(Cdouble, n)
  @eval chcprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[goth]),
    $(x), $(y), $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function chcprod!(n::Int, m::Int, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1}, libname)
  io_err = Cint[0]
  @eval chcprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[goth]),
    $(x), $(y), $(vector), $(result), $(libname))
  @cutest_error
  return
end


function chcprod(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  result = Array(Cdouble, n)
  @eval chcprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[goth]),
    $(x), $(y), $(vector), $(result), $(nlp.libname))
  @cutest_error
  return result
end

function chcprod!(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval chcprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[goth]),
    $(x), $(y), $(vector), $(result), $(nlp.libname))
  @cutest_error
  return
end


function cjprod(n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, lresult::Int, libname)
  io_err = Cint[0]
  result = Array(Cdouble, lresult)
  @eval cjprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[gotj]),
    $(Cint[jtrans]), $(x), $(vector), $(Cint[lvector]), $(result),
    $(Cint[lresult]), $(libname))
  @cutest_error
  return result
end

function cjprod!(n::Int, m::Int, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, result::Array{Float64, 1},
    lresult::Int, libname)
  io_err = Cint[0]
  @eval cjprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[gotj]),
    $(Cint[jtrans]), $(x), $(vector), $(Cint[lvector]), $(result),
    $(Cint[lresult]), $(libname))
  @cutest_error
  return
end


function cjprod(nlp::CUTEstModel, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, lresult::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  result = Array(Cdouble, lresult)
  @eval cjprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[gotj]),
    $(Cint[jtrans]), $(x), $(vector), $(Cint[lvector]), $(result),
    $(Cint[lresult]), $(nlp.libname))
  @cutest_error
  return result
end

function cjprod!(nlp::CUTEstModel, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Int, result::Array{Float64, 1},
    lresult::Int)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval cjprod($(io_err), $(Cint[n]), $(Cint[m]), $(Cint[gotj]),
    $(Cint[jtrans]), $(x), $(vector), $(Cint[lvector]), $(result),
    $(Cint[lresult]), $(nlp.libname))
  @cutest_error
  return
end


function uterminate(libname)
  io_err = Cint[0]
  @eval uterminate($(io_err), $(libname))
  @cutest_error
  return
end

function uterminate!(libname)
  io_err = Cint[0]
  @eval uterminate($(io_err), $(libname))
  @cutest_error
  return
end


function uterminate(nlp::CUTEstModel)
  io_err = Cint[0]
  @eval uterminate($(io_err), $(nlp.libname))
  @cutest_error
  return
end

function uterminate!(nlp::CUTEstModel)
  io_err = Cint[0]
  @eval uterminate($(io_err), $(nlp.libname))
  @cutest_error
  return
end


function cterminate(libname)
  io_err = Cint[0]
  @eval cterminate($(io_err), $(libname))
  @cutest_error
  return
end

function cterminate!(libname)
  io_err = Cint[0]
  @eval cterminate($(io_err), $(libname))
  @cutest_error
  return
end


function cterminate(nlp::CUTEstModel)
  io_err = Cint[0]
  @eval cterminate($(io_err), $(nlp.libname))
  @cutest_error
  return
end

function cterminate!(nlp::CUTEstModel)
  io_err = Cint[0]
  @eval cterminate($(io_err), $(nlp.libname))
  @cutest_error
  return
end


