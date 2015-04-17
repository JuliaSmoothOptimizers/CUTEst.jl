export jl_usetup, jl_csetup, jl_udimen, jl_udimsh, jl_udimse,
    jl_uvartype, jl_unames, jl_ureport, jl_cdimen, jl_cdimsj, jl_cdimsh,
    jl_cdimse, jl_cstats, jl_cvartype, jl_cnames, jl_creport, jl_connames,
    jl_pname, jl_probname, jl_varnames, jl_ufn, jl_ugr, jl_uofg,
    jl_ubandh, jl_udh, jl_ush, jl_ueh, jl_ugrdh, jl_ugrsh, jl_ugreh,
    jl_uhprod, jl_cfn, jl_cofg, jl_cofsg, jl_ccfg, jl_clfg, jl_cgr,
    jl_csgr, jl_ccfsg, jl_ccifg, jl_ccifsg, jl_cgrdh, jl_cdh, jl_csh,
    jl_cshc, jl_ceh, jl_cidh, jl_cish, jl_csgrsh, jl_csgreh, jl_chprod,
    jl_chcprod, jl_cjprod, jl_uterminate, jl_cterminate
export jl_usetup!, jl_csetup!, jl_udimen!, jl_udimsh!, jl_udimse!,
    jl_uvartype!, jl_unames!, jl_ureport!, jl_cdimen!, jl_cdimsj!,
    jl_cdimsh!, jl_cdimse!, jl_cstats!, jl_cvartype!, jl_cnames!,
    jl_creport!, jl_connames!, jl_pname!, jl_probname!, jl_varnames!,
    jl_ufn!, jl_ugr!, jl_uofg!, jl_ubandh!, jl_udh!, jl_ush!, jl_ueh!,
    jl_ugrdh!, jl_ugrsh!, jl_ugreh!, jl_uhprod!, jl_cfn!, jl_cofg!,
    jl_cofsg!, jl_ccfg!, jl_clfg!, jl_cgr!, jl_csgr!, jl_ccfsg!,
    jl_ccifg!, jl_ccifsg!, jl_cgrdh!, jl_cdh!, jl_csh!, jl_cshc!, jl_ceh!,
    jl_cidh!, jl_cish!, jl_csgrsh!, jl_csgreh!, jl_chprod!, jl_chcprod!,
    jl_cjprod!, jl_uterminate!, jl_cterminate!

function jl_usetup(input::Integer, out::Integer, io_buffer::Integer, n::Integer, libname
    = fixedlibname)
  io_err = Cint[0]
  x = Array(Cdouble, n)
  x_l = Array(Cdouble, n)
  x_u = Array(Cdouble, n)
  @eval CUTEst.usetup($(io_err), $(Cint[input]), $(Cint[out]),
    $(Cint[io_buffer]), $(Cint[n]), $(x), $(x_l), $(x_u), $(libname))
  @cutest_error
  return x, x_l, x_u
end

function jl_usetup!(input::Integer, out::Integer, io_buffer::Integer, n::Integer,
    x::Array{Float64, 1}, x_l::Array{Float64, 1}, x_u::Array{Float64, 1},
    libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.usetup($(io_err), $(Cint[input]), $(Cint[out]),
    $(Cint[io_buffer]), $(Cint[n]), $(x), $(x_l), $(x_u), $(libname))
  @cutest_error
  return 
end

function jl_csetup(input::Integer, out::Integer, io_buffer::Integer, n::Integer,
    m::Integer, e_order::Integer, l_order::Integer, v_order::Integer,
    libname = fixedlibname)
  io_err = Cint[0]
  x = Array(Cdouble, n)
  x_l = Array(Cdouble, n)
  x_u = Array(Cdouble, n)
  y = Array(Cdouble, m)
  c_l = Array(Cdouble, m)
  c_u = Array(Cdouble, m)
  equatn = Array(Cint, m)
  linear = Array(Cint, m)
  @eval CUTEst.csetup($(io_err), $(Cint[input]), $(Cint[out]),
    $(Cint[io_buffer]), $(Cint[n]), $(Cint[m]), $(x), $(x_l), $(x_u),
    $(y), $(c_l), $(c_u), $(equatn), $(linear), $(Cint[e_order]),
    $(Cint[l_order]), $(Cint[v_order]), $(libname))
  @cutest_error
  return x, x_l, x_u, y, c_l, c_u, equatn, linear
end

function jl_csetup!(input::Integer, out::Integer, io_buffer::Integer, n::Integer,
    m::Integer, x::Array{Float64, 1}, x_l::Array{Float64, 1},
    x_u::Array{Float64, 1}, y::Array{Float64, 1}, c_l::Array{Float64, 1},
    c_u::Array{Float64, 1}, equatn::Array{Bool, 1}, linear::Array{Bool,
    1}, e_order::Integer, l_order::Integer, v_order::Integer, libname =
    fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.csetup($(io_err), $(Cint[input]), $(Cint[out]),
    $(Cint[io_buffer]), $(Cint[n]), $(Cint[m]), $(x), $(x_l), $(x_u),
    $(y), $(c_l), $(c_u), $(equatn), $(linear), $(Cint[e_order]),
    $(Cint[l_order]), $(Cint[v_order]), $(libname))
  @cutest_error
  return 
end

function jl_udimen(input::Integer, libname = fixedlibname)
  io_err = Cint[0]
  n = Cint[0]
  @eval CUTEst.udimen($(io_err), $(Cint[input]), $(n), $(libname))
  @cutest_error
  return n[1]
end

function jl_udimen!(input::Integer, libname = fixedlibname)
  io_err = Cint[0]
  n = Cint[0]
  @eval CUTEst.udimen($(io_err), $(Cint[input]), $(n), $(libname))
  @cutest_error
  return n[1]
end

function jl_udimen(nlp::CUTEstModel, input::Integer)
  io_err = Cint[0]
  n = Cint[0]
  @eval CUTEst.udimen($(io_err), $(Cint[input]), $(n), $(nlp.libname))
  @cutest_error
  return n[1]
end

function jl_udimen!(nlp::CUTEstModel, input::Integer)
  io_err = Cint[0]
  n = Cint[0]
  @eval CUTEst.udimen($(io_err), $(Cint[input]), $(n), $(nlp.libname))
  @cutest_error
  return n[1]
end

function jl_udimsh(libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.udimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_udimsh!(libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.udimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_udimsh(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.udimsh($(io_err), $(nnzh), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function jl_udimsh!(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.udimsh($(io_err), $(nnzh), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function jl_udimse(libname = fixedlibname)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval CUTEst.udimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_udimse!(libname = fixedlibname)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval CUTEst.udimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_udimse(nlp::CUTEstModel)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval CUTEst.udimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(nlp.libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_udimse!(nlp::CUTEstModel)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval CUTEst.udimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(nlp.libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_uvartype(n::Integer, libname = fixedlibname)
  io_err = Cint[0]
  x_type = Array(Cint, n)
  @eval CUTEst.uvartype($(io_err), $(Cint[n]), $(x_type), $(libname))
  @cutest_error
  return x_type
end

function jl_uvartype!(n::Integer, x_type::Array{Integer, 1}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.uvartype($(io_err), $(Cint[n]), $(x_type), $(libname))
  @cutest_error
  return 
end

function jl_uvartype(nlp::CUTEstModel)
  io_err = Cint[0]
  n = nlp.meta.nvar
  x_type = Array(Cint, n)
  @eval CUTEst.uvartype($(io_err), $(Cint[n]), $(x_type),
    $(nlp.libname))
  @cutest_error
  return x_type
end

function jl_uvartype!(nlp::CUTEstModel, x_type::Array{Integer, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval CUTEst.uvartype($(io_err), $(Cint[n]), $(x_type),
    $(nlp.libname))
  @cutest_error
  return 
end

function jl_unames(n::Integer, libname = fixedlibname)
  io_err = Cint[0]
  pname = Cchar[0]
  vname = Array(Cchar, n)
  @eval CUTEst.unames($(io_err), $(Cint[n]), $(pname), $(vname),
    $(libname))
  @cutest_error
  return pname[1], vname
end

function jl_unames!(n::Integer, vname::Array{Uint8, 1}, libname = fixedlibname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval CUTEst.unames($(io_err), $(Cint[n]), $(pname), $(vname),
    $(libname))
  @cutest_error
  return pname[1]
end

function jl_unames(nlp::CUTEstModel)
  io_err = Cint[0]
  n = nlp.meta.nvar
  pname = Cchar[0]
  vname = Array(Cchar, n)
  @eval CUTEst.unames($(io_err), $(Cint[n]), $(pname), $(vname),
    $(nlp.libname))
  @cutest_error
  return pname[1], vname
end

function jl_unames!(nlp::CUTEstModel, vname::Array{Uint8, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  pname = Cchar[0]
  @eval CUTEst.unames($(io_err), $(Cint[n]), $(pname), $(vname),
    $(nlp.libname))
  @cutest_error
  return pname[1]
end

function jl_ureport(libname = fixedlibname)
  io_err = Cint[0]
  calls = Array(Cdouble, 4)
  time = Array(Cdouble, 2)
  @eval CUTEst.ureport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return calls, time
end

function jl_ureport!(calls::Array{Float64, 1}, time::Array{Float64, 1}, libname =
    fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.ureport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return 
end

function jl_ureport(nlp::CUTEstModel)
  io_err = Cint[0]
  calls = Array(Cdouble, 4)
  time = Array(Cdouble, 2)
  @eval CUTEst.ureport($(io_err), $(calls), $(time), $(nlp.libname))
  @cutest_error
  return calls, time
end

function jl_ureport!(nlp::CUTEstModel, calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  @eval CUTEst.ureport($(io_err), $(calls), $(time), $(nlp.libname))
  @cutest_error
  return 
end

function jl_cdimen(input::Integer, libname = fixedlibname)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  @eval CUTEst.cdimen($(io_err), $(Cint[input]), $(n), $(m),
    $(libname))
  @cutest_error
  return n[1], m[1]
end

function jl_cdimen!(input::Integer, libname = fixedlibname)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  @eval CUTEst.cdimen($(io_err), $(Cint[input]), $(n), $(m),
    $(libname))
  @cutest_error
  return n[1], m[1]
end

function jl_cdimen(nlp::CUTEstModel, input::Integer)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  @eval CUTEst.cdimen($(io_err), $(Cint[input]), $(n), $(m),
    $(nlp.libname))
  @cutest_error
  return n[1], m[1]
end

function jl_cdimen!(nlp::CUTEstModel, input::Integer)
  io_err = Cint[0]
  n = Cint[0]
  m = Cint[0]
  @eval CUTEst.cdimen($(io_err), $(Cint[input]), $(n), $(m),
    $(nlp.libname))
  @cutest_error
  return n[1], m[1]
end

function jl_cdimsj(libname = fixedlibname)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval CUTEst.cdimsj($(io_err), $(nnzj), $(libname))
  @cutest_error
  return nnzj[1]
end

function jl_cdimsj!(libname = fixedlibname)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval CUTEst.cdimsj($(io_err), $(nnzj), $(libname))
  @cutest_error
  return nnzj[1]
end

function jl_cdimsj(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval CUTEst.cdimsj($(io_err), $(nnzj), $(nlp.libname))
  @cutest_error
  return nnzj[1]
end

function jl_cdimsj!(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval CUTEst.cdimsj($(io_err), $(nnzj), $(nlp.libname))
  @cutest_error
  return nnzj[1]
end

function jl_cdimsh(libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.cdimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_cdimsh!(libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.cdimsh($(io_err), $(nnzh), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_cdimsh(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.cdimsh($(io_err), $(nnzh), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function jl_cdimsh!(nlp::CUTEstModel)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.cdimsh($(io_err), $(nnzh), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function jl_cdimse(libname = fixedlibname)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval CUTEst.cdimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_cdimse!(libname = fixedlibname)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval CUTEst.cdimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_cdimse(nlp::CUTEstModel)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval CUTEst.cdimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(nlp.libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_cdimse!(nlp::CUTEstModel)
  io_err = Cint[0]
  ne = Cint[0]
  he_val_ne = Cint[0]
  he_row_ne = Cint[0]
  @eval CUTEst.cdimse($(io_err), $(ne), $(he_val_ne), $(he_row_ne),
    $(nlp.libname))
  @cutest_error
  return ne[1], he_val_ne[1], he_row_ne[1]
end

function jl_cstats(libname = fixedlibname)
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  @eval CUTEst.cstats($(io_err), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(equality_constraints),
    $(linear_constraints), $(libname))
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function jl_cstats!(libname = fixedlibname)
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  @eval CUTEst.cstats($(io_err), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(equality_constraints),
    $(linear_constraints), $(libname))
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function jl_cstats(nlp::CUTEstModel)
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  @eval CUTEst.cstats($(io_err), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(equality_constraints),
    $(linear_constraints), $(nlp.libname))
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function jl_cstats!(nlp::CUTEstModel)
  io_err = Cint[0]
  nonlinear_variables_objective = Cint[0]
  nonlinear_variables_constraints = Cint[0]
  equality_constraints = Cint[0]
  linear_constraints = Cint[0]
  @eval CUTEst.cstats($(io_err), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(equality_constraints),
    $(linear_constraints), $(nlp.libname))
  @cutest_error
  return nonlinear_variables_objective[1], nonlinear_variables_constraints[1], equality_constraints[1], linear_constraints[1]
end

function jl_cvartype(n::Integer, libname = fixedlibname)
  io_err = Cint[0]
  x_type = Array(Cint, n)
  @eval CUTEst.cvartype($(io_err), $(Cint[n]), $(x_type), $(libname))
  @cutest_error
  return x_type
end

function jl_cvartype!(n::Integer, x_type::Array{Integer, 1}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.cvartype($(io_err), $(Cint[n]), $(x_type), $(libname))
  @cutest_error
  return 
end

function jl_cvartype(nlp::CUTEstModel)
  io_err = Cint[0]
  n = nlp.meta.nvar
  x_type = Array(Cint, n)
  @eval CUTEst.cvartype($(io_err), $(Cint[n]), $(x_type),
    $(nlp.libname))
  @cutest_error
  return x_type
end

function jl_cvartype!(nlp::CUTEstModel, x_type::Array{Integer, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval CUTEst.cvartype($(io_err), $(Cint[n]), $(x_type),
    $(nlp.libname))
  @cutest_error
  return 
end

function jl_cnames(n::Integer, m::Integer, libname = fixedlibname)
  io_err = Cint[0]
  pname = Cchar[0]
  vname = Array(Cchar, n)
  cname = Array(Cchar, m)
  @eval CUTEst.cnames($(io_err), $(Cint[n]), $(Cint[m]), $(pname),
    $(vname), $(cname), $(libname))
  @cutest_error
  return pname[1], vname, cname
end

function jl_cnames!(n::Integer, m::Integer, vname::Array{Uint8, 1}, cname::Array{Uint8,
    1}, libname = fixedlibname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval CUTEst.cnames($(io_err), $(Cint[n]), $(Cint[m]), $(pname),
    $(vname), $(cname), $(libname))
  @cutest_error
  return pname[1]
end

function jl_cnames(nlp::CUTEstModel)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  pname = Cchar[0]
  vname = Array(Cchar, n)
  cname = Array(Cchar, m)
  @eval CUTEst.cnames($(io_err), $(Cint[n]), $(Cint[m]), $(pname),
    $(vname), $(cname), $(nlp.libname))
  @cutest_error
  return pname[1], vname, cname
end

function jl_cnames!(nlp::CUTEstModel, vname::Array{Uint8, 1}, cname::Array{Uint8, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  pname = Cchar[0]
  @eval CUTEst.cnames($(io_err), $(Cint[n]), $(Cint[m]), $(pname),
    $(vname), $(cname), $(nlp.libname))
  @cutest_error
  return pname[1]
end

function jl_creport(libname = fixedlibname)
  io_err = Cint[0]
  calls = Array(Cdouble, 7)
  time = Array(Cdouble, 2)
  @eval CUTEst.creport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return calls, time
end

function jl_creport!(calls::Array{Float64, 1}, time::Array{Float64, 1}, libname =
    fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.creport($(io_err), $(calls), $(time), $(libname))
  @cutest_error
  return 
end

function jl_creport(nlp::CUTEstModel)
  io_err = Cint[0]
  calls = Array(Cdouble, 7)
  time = Array(Cdouble, 2)
  @eval CUTEst.creport($(io_err), $(calls), $(time), $(nlp.libname))
  @cutest_error
  return calls, time
end

function jl_creport!(nlp::CUTEstModel, calls::Array{Float64, 1}, time::Array{Float64, 1})
  io_err = Cint[0]
  @eval CUTEst.creport($(io_err), $(calls), $(time), $(nlp.libname))
  @cutest_error
  return 
end

function jl_connames(m::Integer, libname = fixedlibname)
  io_err = Cint[0]
  cname = Array(Cchar, m)
  @eval CUTEst.connames($(io_err), $(Cint[m]), $(cname), $(libname))
  @cutest_error
  return cname
end

function jl_connames!(m::Integer, cname::Array{Uint8, 1}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.connames($(io_err), $(Cint[m]), $(cname), $(libname))
  @cutest_error
  return 
end

function jl_connames(nlp::CUTEstModel)
  io_err = Cint[0]
  m = nlp.meta.ncon
  cname = Array(Cchar, m)
  @eval CUTEst.connames($(io_err), $(Cint[m]), $(cname),
    $(nlp.libname))
  @cutest_error
  return cname
end

function jl_connames!(nlp::CUTEstModel, cname::Array{Uint8, 1})
  io_err = Cint[0]
  m = nlp.meta.ncon
  @eval CUTEst.connames($(io_err), $(Cint[m]), $(cname),
    $(nlp.libname))
  @cutest_error
  return 
end

function jl_pname(input::Integer, libname = fixedlibname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval CUTEst.pname($(io_err), $(Cint[input]), $(pname), $(libname))
  @cutest_error
  return pname[1]
end

function jl_pname!(input::Integer, libname = fixedlibname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval CUTEst.pname($(io_err), $(Cint[input]), $(pname), $(libname))
  @cutest_error
  return pname[1]
end

function jl_pname(nlp::CUTEstModel, input::Integer)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval CUTEst.pname($(io_err), $(Cint[input]), $(pname),
    $(nlp.libname))
  @cutest_error
  return pname[1]
end

function jl_pname!(nlp::CUTEstModel, input::Integer)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval CUTEst.pname($(io_err), $(Cint[input]), $(pname),
    $(nlp.libname))
  @cutest_error
  return pname[1]
end

function jl_probname(libname = fixedlibname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval CUTEst.probname($(io_err), $(pname), $(libname))
  @cutest_error
  return pname[1]
end

function jl_probname!(libname = fixedlibname)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval CUTEst.probname($(io_err), $(pname), $(libname))
  @cutest_error
  return pname[1]
end

function jl_probname(nlp::CUTEstModel)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval CUTEst.probname($(io_err), $(pname), $(nlp.libname))
  @cutest_error
  return pname[1]
end

function jl_probname!(nlp::CUTEstModel)
  io_err = Cint[0]
  pname = Cchar[0]
  @eval CUTEst.probname($(io_err), $(pname), $(nlp.libname))
  @cutest_error
  return pname[1]
end

function jl_varnames(n::Integer, libname = fixedlibname)
  io_err = Cint[0]
  vname = Array(Cchar, n)
  @eval CUTEst.varnames($(io_err), $(Cint[n]), $(vname), $(libname))
  @cutest_error
  return vname
end

function jl_varnames!(n::Integer, vname::Array{Uint8, 1}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.varnames($(io_err), $(Cint[n]), $(vname), $(libname))
  @cutest_error
  return 
end

function jl_varnames(nlp::CUTEstModel)
  io_err = Cint[0]
  n = nlp.meta.nvar
  vname = Array(Cchar, n)
  @eval CUTEst.varnames($(io_err), $(Cint[n]), $(vname),
    $(nlp.libname))
  @cutest_error
  return vname
end

function jl_varnames!(nlp::CUTEstModel, vname::Array{Uint8, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval CUTEst.varnames($(io_err), $(Cint[n]), $(vname),
    $(nlp.libname))
  @cutest_error
  return 
end

function jl_ufn(n::Integer, x::Array{Float64, 1}, libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval CUTEst.ufn($(io_err), $(Cint[n]), $(x), $(f), $(libname))
  @cutest_error
  return f[1]
end

function jl_ufn!(n::Integer, x::Array{Float64, 1}, libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval CUTEst.ufn($(io_err), $(Cint[n]), $(x), $(f), $(libname))
  @cutest_error
  return f[1]
end

function jl_ufn(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  @eval CUTEst.ufn($(io_err), $(Cint[n]), $(x), $(f), $(nlp.libname))
  @cutest_error
  return f[1]
end

function jl_ufn!(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  @eval CUTEst.ufn($(io_err), $(Cint[n]), $(x), $(f), $(nlp.libname))
  @cutest_error
  return f[1]
end

function jl_ugr(n::Integer, x::Array{Float64, 1}, libname = fixedlibname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  @eval CUTEst.ugr($(io_err), $(Cint[n]), $(x), $(g), $(libname))
  @cutest_error
  return g
end

function jl_ugr!(n::Integer, x::Array{Float64, 1}, g::Array{Float64, 1}, libname =
    fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.ugr($(io_err), $(Cint[n]), $(x), $(g), $(libname))
  @cutest_error
  return 
end

function jl_ugr(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  g = Array(Cdouble, n)
  @eval CUTEst.ugr($(io_err), $(Cint[n]), $(x), $(g), $(nlp.libname))
  @cutest_error
  return g
end

function jl_ugr!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval CUTEst.ugr($(io_err), $(Cint[n]), $(x), $(g), $(nlp.libname))
  @cutest_error
  return 
end

function jl_uofg(n::Integer, x::Array{Float64, 1}, grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval CUTEst.uofg($(io_err), $(Cint[n]), $(x), $(f), $(g),
    $(Cint[grad]), $(libname))
  @cutest_error
  return f[1], g
end

function jl_uofg!(n::Integer, x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool,
    libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval CUTEst.uofg($(io_err), $(Cint[n]), $(x), $(f), $(g),
    $(Cint[grad]), $(libname))
  @cutest_error
  return f[1]
end

function jl_uofg(nlp::CUTEstModel, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval CUTEst.uofg($(io_err), $(Cint[n]), $(x), $(f), $(g),
    $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1], g
end

function jl_uofg!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  @eval CUTEst.uofg($(io_err), $(Cint[n]), $(x), $(f), $(g),
    $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1]
end

function jl_ubandh(n::Integer, x::Array{Float64, 1}, semibandwidth::Integer,
    lbandh::Integer, libname = fixedlibname)
  io_err = Cint[0]
  h_band = Array(Cdouble, lbandh - 0 + 1, n)
  max_semibandwidth = Cint[0]
  @eval CUTEst.ubandh($(io_err), $(Cint[n]), $(x),
    $(Cint[semibandwidth]), $(h_band), $(Cint[lbandh]),
    $(max_semibandwidth), $(libname))
  @cutest_error
  return h_band, max_semibandwidth[1]
end

function jl_ubandh!(n::Integer, x::Array{Float64, 1}, semibandwidth::Integer,
    h_band::Array{Float64, 2}, lbandh::Integer, libname = fixedlibname)
  io_err = Cint[0]
  max_semibandwidth = Cint[0]
  @eval CUTEst.ubandh($(io_err), $(Cint[n]), $(x),
    $(Cint[semibandwidth]), $(h_band), $(Cint[lbandh]),
    $(max_semibandwidth), $(libname))
  @cutest_error
  return max_semibandwidth[1]
end

function jl_ubandh(nlp::CUTEstModel, x::Array{Float64, 1}, semibandwidth::Integer,
    lbandh::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  h_band = Array(Cdouble, lbandh - 0 + 1, n)
  max_semibandwidth = Cint[0]
  @eval CUTEst.ubandh($(io_err), $(Cint[n]), $(x),
    $(Cint[semibandwidth]), $(h_band), $(Cint[lbandh]),
    $(max_semibandwidth), $(nlp.libname))
  @cutest_error
  return h_band, max_semibandwidth[1]
end

function jl_ubandh!(nlp::CUTEstModel, x::Array{Float64, 1}, semibandwidth::Integer,
    h_band::Array{Float64, 2}, lbandh::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  max_semibandwidth = Cint[0]
  @eval CUTEst.ubandh($(io_err), $(Cint[n]), $(x),
    $(Cint[semibandwidth]), $(h_band), $(Cint[lbandh]),
    $(max_semibandwidth), $(nlp.libname))
  @cutest_error
  return max_semibandwidth[1]
end

function jl_udh(n::Integer, x::Array{Float64, 1}, lh1::Integer, libname =
    fixedlibname)
  io_err = Cint[0]
  h = Array(Cdouble, lh1, n)
  @eval CUTEst.udh($(io_err), $(Cint[n]), $(x), $(Cint[lh1]), $(h),
    $(libname))
  @cutest_error
  return h
end

function jl_udh!(n::Integer, x::Array{Float64, 1}, lh1::Integer, h::Array{Float64, 2},
    libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.udh($(io_err), $(Cint[n]), $(x), $(Cint[lh1]), $(h),
    $(libname))
  @cutest_error
  return 
end

function jl_udh(nlp::CUTEstModel, x::Array{Float64, 1}, lh1::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  h = Array(Cdouble, lh1, n)
  @eval CUTEst.udh($(io_err), $(Cint[n]), $(x), $(Cint[lh1]), $(h),
    $(nlp.libname))
  @cutest_error
  return h
end

function jl_udh!(nlp::CUTEstModel, x::Array{Float64, 1}, lh1::Integer,
    h::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval CUTEst.udh($(io_err), $(Cint[n]), $(x), $(Cint[lh1]), $(h),
    $(nlp.libname))
  @cutest_error
  return 
end

function jl_ush(n::Integer, x::Array{Float64, 1}, lh::Integer, libname =
    fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.ush($(io_err), $(Cint[n]), $(x), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_ush!(n::Integer, x::Array{Float64, 1}, lh::Integer, h_val::Array{Float64,
    1}, h_row::Array{Integer, 1}, h_col::Array{Integer, 1}, libname =
    fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.ush($(io_err), $(Cint[n]), $(x), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_ush(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.ush($(io_err), $(Cint[n]), $(x), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_ush!(nlp::CUTEstModel, x::Array{Float64, 1}, h_val::Array{Float64, 1},
    h_row::Array{Integer, 1}, h_col::Array{Integer, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  @eval CUTEst.ush($(io_err), $(Cint[n]), $(x), $(nnzh), $(Cint[lh]),
    $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function jl_ueh(n::Integer, x::Array{Float64, 1}, lhe_ptr::Integer, lhe_row::Integer,
    lhe_val::Integer, byrows::Bool, libname = fixedlibname)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval CUTEst.ueh($(io_err), $(Cint[n]), $(x), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_ueh!(n::Integer, x::Array{Float64, 1}, lhe_ptr::Integer,
    he_row_ptr::Array{Integer, 1}, he_val_ptr::Array{Integer, 1},
    lhe_row::Integer, he_row::Array{Integer, 1}, lhe_val::Integer,
    he_val::Array{Float64, 1}, byrows::Bool, libname = fixedlibname)
  io_err = Cint[0]
  ne = Cint[0]
  @eval CUTEst.ueh($(io_err), $(Cint[n]), $(x), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
  @cutest_error
  return ne[1]
end

function jl_ueh(nlp::CUTEstModel, x::Array{Float64, 1}, lhe_ptr::Integer,
    lhe_row::Integer, lhe_val::Integer, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval CUTEst.ueh($(io_err), $(Cint[n]), $(x), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]),
    $(nlp.libname))
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_ueh!(nlp::CUTEstModel, x::Array{Float64, 1}, lhe_ptr::Integer,
    he_row_ptr::Array{Integer, 1}, he_val_ptr::Array{Integer, 1},
    lhe_row::Integer, he_row::Array{Integer, 1}, lhe_val::Integer,
    he_val::Array{Float64, 1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ne = Cint[0]
  @eval CUTEst.ueh($(io_err), $(Cint[n]), $(x), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]),
    $(nlp.libname))
  @cutest_error
  return ne[1]
end

function jl_ugrdh(n::Integer, x::Array{Float64, 1}, lh1::Integer, libname =
    fixedlibname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  h = Array(Cdouble, lh1, n)
  @eval CUTEst.ugrdh($(io_err), $(Cint[n]), $(x), $(g), $(Cint[lh1]),
    $(h), $(libname))
  @cutest_error
  return g, h
end

function jl_ugrdh!(n::Integer, x::Array{Float64, 1}, g::Array{Float64, 1}, lh1::Integer,
    h::Array{Float64, 2}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.ugrdh($(io_err), $(Cint[n]), $(x), $(g), $(Cint[lh1]),
    $(h), $(libname))
  @cutest_error
  return 
end

function jl_ugrdh(nlp::CUTEstModel, x::Array{Float64, 1}, lh1::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  g = Array(Cdouble, n)
  h = Array(Cdouble, lh1, n)
  @eval CUTEst.ugrdh($(io_err), $(Cint[n]), $(x), $(g), $(Cint[lh1]),
    $(h), $(nlp.libname))
  @cutest_error
  return g, h
end

function jl_ugrdh!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    lh1::Integer, h::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval CUTEst.ugrdh($(io_err), $(Cint[n]), $(x), $(g), $(Cint[lh1]),
    $(h), $(nlp.libname))
  @cutest_error
  return 
end

function jl_ugrsh(n::Integer, x::Array{Float64, 1}, lh::Integer, libname =
    fixedlibname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.ugrsh($(io_err), $(Cint[n]), $(x), $(g), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return g, nnzh[1], h_val, h_row, h_col
end

function jl_ugrsh!(n::Integer, x::Array{Float64, 1}, g::Array{Float64, 1}, lh::Integer,
    h_val::Array{Float64, 1}, h_row::Array{Integer, 1},
    h_col::Array{Integer, 1}, libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.ugrsh($(io_err), $(Cint[n]), $(x), $(g), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_ugrsh(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  g = Array(Cdouble, n)
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.ugrsh($(io_err), $(Cint[n]), $(x), $(g), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return g, nnzh[1], h_val, h_row, h_col
end

function jl_ugrsh!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    h_val::Array{Float64, 1}, h_row::Array{Integer, 1},
    h_col::Array{Integer, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  @eval CUTEst.ugrsh($(io_err), $(Cint[n]), $(x), $(g), $(nnzh),
    $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function jl_ugreh(n::Integer, x::Array{Float64, 1}, lhe_ptr::Integer, lhe_row::Integer,
    lhe_val::Integer, byrows::Bool, libname = fixedlibname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval CUTEst.ugreh($(io_err), $(Cint[n]), $(x), $(g), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
  @cutest_error
  return g, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_ugreh!(n::Integer, x::Array{Float64, 1}, g::Array{Float64, 1},
    lhe_ptr::Integer, he_row_ptr::Array{Integer, 1},
    he_val_ptr::Array{Integer, 1}, lhe_row::Integer,
    he_row::Array{Integer, 1}, lhe_val::Integer, he_val::Array{Float64,
    1}, byrows::Bool, libname = fixedlibname)
  io_err = Cint[0]
  ne = Cint[0]
  @eval CUTEst.ugreh($(io_err), $(Cint[n]), $(x), $(g), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]), $(libname))
  @cutest_error
  return ne[1]
end

function jl_ugreh(nlp::CUTEstModel, x::Array{Float64, 1}, lhe_ptr::Integer,
    lhe_row::Integer, lhe_val::Integer, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  g = Array(Cdouble, n)
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval CUTEst.ugreh($(io_err), $(Cint[n]), $(x), $(g), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]),
    $(nlp.libname))
  @cutest_error
  return g, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_ugreh!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    lhe_ptr::Integer, he_row_ptr::Array{Integer, 1},
    he_val_ptr::Array{Integer, 1}, lhe_row::Integer,
    he_row::Array{Integer, 1}, lhe_val::Integer, he_val::Array{Float64,
    1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ne = Cint[0]
  @eval CUTEst.ugreh($(io_err), $(Cint[n]), $(x), $(g), $(ne),
    $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr), $(Cint[lhe_row]),
    $(he_row), $(Cint[lhe_val]), $(he_val), $(Cint[byrows]),
    $(nlp.libname))
  @cutest_error
  return ne[1]
end

function jl_uhprod(n::Integer, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64,
    1}, libname = fixedlibname)
  io_err = Cint[0]
  result = Array(Cdouble, n)
  @eval CUTEst.uhprod($(io_err), $(Cint[n]), $(Cint[goth]), $(x),
    $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function jl_uhprod!(n::Integer, goth::Bool, x::Array{Float64, 1}, vector::Array{Float64,
    1}, result::Array{Float64, 1}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.uhprod($(io_err), $(Cint[n]), $(Cint[goth]), $(x),
    $(vector), $(result), $(libname))
  @cutest_error
  return 
end

function jl_uhprod(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  result = Array(Cdouble, n)
  @eval CUTEst.uhprod($(io_err), $(Cint[n]), $(Cint[goth]), $(x),
    $(vector), $(result), $(nlp.libname))
  @cutest_error
  return result
end

function jl_uhprod!(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval CUTEst.uhprod($(io_err), $(Cint[n]), $(Cint[goth]), $(x),
    $(vector), $(result), $(nlp.libname))
  @cutest_error
  return 
end

function jl_cfn(n::Integer, m::Integer, x::Array{Float64, 1}, libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  c = Array(Cdouble, m)
  @eval CUTEst.cfn($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(f),
    $(c), $(libname))
  @cutest_error
  return f[1], c
end

function jl_cfn!(n::Integer, m::Integer, x::Array{Float64, 1}, c::Array{Float64, 1},
    libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval CUTEst.cfn($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(f),
    $(c), $(libname))
  @cutest_error
  return f[1]
end

function jl_cfn(nlp::CUTEstModel, x::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  c = Array(Cdouble, m)
  @eval CUTEst.cfn($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(f),
    $(c), $(nlp.libname))
  @cutest_error
  return f[1], c
end

function jl_cfn!(nlp::CUTEstModel, x::Array{Float64, 1}, c::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  @eval CUTEst.cfn($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(f),
    $(c), $(nlp.libname))
  @cutest_error
  return f[1]
end

function jl_cofg(n::Integer, x::Array{Float64, 1}, grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval CUTEst.cofg($(io_err), $(Cint[n]), $(x), $(f), $(g),
    $(Cint[grad]), $(libname))
  @cutest_error
  return f[1], g
end

function jl_cofg!(n::Integer, x::Array{Float64, 1}, g::Array{Float64, 1}, grad::Bool,
    libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval CUTEst.cofg($(io_err), $(Cint[n]), $(x), $(f), $(g),
    $(Cint[grad]), $(libname))
  @cutest_error
  return f[1]
end

function jl_cofg(nlp::CUTEstModel, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval CUTEst.cofg($(io_err), $(Cint[n]), $(x), $(f), $(g),
    $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1], g
end

function jl_cofg!(nlp::CUTEstModel, x::Array{Float64, 1}, g::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  @eval CUTEst.cofg($(io_err), $(Cint[n]), $(x), $(f), $(g),
    $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1]
end

function jl_cofsg(n::Integer, x::Array{Float64, 1}, lg::Integer, grad::Bool, libname =
    fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  g_val = Array(Cdouble, lg)
  g_var = Array(Cint, lg)
  @eval CUTEst.cofsg($(io_err), $(Cint[n]), $(x), $(f), $(nnzg),
    $(Cint[lg]), $(g_val), $(g_var), $(Cint[grad]), $(libname))
  @cutest_error
  return f[1], nnzg[1], g_val, g_var
end

function jl_cofsg!(n::Integer, x::Array{Float64, 1}, lg::Integer, g_val::Array{Float64,
    1}, g_var::Array{Integer, 1}, grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  nnzg = Cint[0]
  @eval CUTEst.cofsg($(io_err), $(Cint[n]), $(x), $(f), $(nnzg),
    $(Cint[lg]), $(g_val), $(g_var), $(Cint[grad]), $(libname))
  @cutest_error
  return f[1], nnzg[1]
end

function jl_cofsg(nlp::CUTEstModel, x::Array{Float64, 1}, lg::Integer, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  nnzg = Cint[0]
  g_val = Array(Cdouble, lg)
  g_var = Array(Cint, lg)
  @eval CUTEst.cofsg($(io_err), $(Cint[n]), $(x), $(f), $(nnzg),
    $(Cint[lg]), $(g_val), $(g_var), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1], nnzg[1], g_val, g_var
end

function jl_cofsg!(nlp::CUTEstModel, x::Array{Float64, 1}, lg::Integer,
    g_val::Array{Float64, 1}, g_var::Array{Integer, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  f = Cdouble[0]
  nnzg = Cint[0]
  @eval CUTEst.cofsg($(io_err), $(Cint[n]), $(x), $(f), $(nnzg),
    $(Cint[lg]), $(g_val), $(g_var), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1], nnzg[1]
end

function jl_ccfg(n::Integer, m::Integer, x::Array{Float64, 1}, jtrans::Bool,
    lcjac1::Integer, lcjac2::Integer, grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  c = Array(Cdouble, m)
  cjac = Array(Cdouble, lcjac1, lcjac2)
  @eval CUTEst.ccfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(Cint[jtrans]), $(Cint[lcjac1]), $(Cint[lcjac2]), $(cjac),
    $(Cint[grad]), $(libname))
  @cutest_error
  return c, cjac
end

function jl_ccfg!(n::Integer, m::Integer, x::Array{Float64, 1}, c::Array{Float64, 1},
    jtrans::Bool, lcjac1::Integer, lcjac2::Integer, cjac::Array{Float64,
    2}, grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.ccfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(Cint[jtrans]), $(Cint[lcjac1]), $(Cint[lcjac2]), $(cjac),
    $(Cint[grad]), $(libname))
  @cutest_error
  return 
end

function jl_ccfg(nlp::CUTEstModel, x::Array{Float64, 1}, jtrans::Bool,
    lcjac1::Integer, lcjac2::Integer, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  c = Array(Cdouble, m)
  cjac = Array(Cdouble, lcjac1, lcjac2)
  @eval CUTEst.ccfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(Cint[jtrans]), $(Cint[lcjac1]), $(Cint[lcjac2]), $(cjac),
    $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return c, cjac
end

function jl_ccfg!(nlp::CUTEstModel, x::Array{Float64, 1}, c::Array{Float64, 1},
    jtrans::Bool, lcjac1::Integer, lcjac2::Integer, cjac::Array{Float64,
    2}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval CUTEst.ccfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(Cint[jtrans]), $(Cint[lcjac1]), $(Cint[lcjac2]), $(cjac),
    $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return 
end

function jl_clfg(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval CUTEst.clfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(f), $(g), $(Cint[grad]), $(libname))
  @cutest_error
  return f[1], g
end

function jl_clfg!(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    g::Array{Float64, 1}, grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  f = Cdouble[0]
  @eval CUTEst.clfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(f), $(g), $(Cint[grad]), $(libname))
  @cutest_error
  return f[1]
end

function jl_clfg(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  g = Array(Cdouble, n)
  @eval CUTEst.clfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(f), $(g), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1], g
end

function jl_clfg!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    g::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  f = Cdouble[0]
  @eval CUTEst.clfg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(f), $(g), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return f[1]
end

function jl_cgr(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Integer, lj2::Integer, libname =
    fixedlibname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  @eval CUTEst.cgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(libname))
  @cutest_error
  return g, j_val
end

function jl_cgr!(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Integer,
    lj2::Integer, j_val::Array{Float64, 2}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.cgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(libname))
  @cutest_error
  return 
end

function jl_cgr(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Integer, lj2::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  @eval CUTEst.cgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(nlp.libname))
  @cutest_error
  return g, j_val
end

function jl_cgr!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Integer,
    lj2::Integer, j_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval CUTEst.cgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(nlp.libname))
  @cutest_error
  return 
end

function jl_csgr(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Integer, libname = fixedlibname)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  @eval CUTEst.csgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

function jl_csgr!(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Integer, j_val::Array{Float64, 1},
    j_var::Array{Integer, 1}, j_fun::Array{Integer, 1}, libname =
    fixedlibname)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval CUTEst.csgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(libname))
  @cutest_error
  return nnzj[1]
end

function jl_csgr(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  @eval CUTEst.csgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nlp.libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun
end

function jl_csgr!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, j_val::Array{Float64, 1}, j_var::Array{Integer, 1},
    j_fun::Array{Integer, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  @eval CUTEst.csgr($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nlp.libname))
  @cutest_error
  return nnzj[1]
end

function jl_ccfsg(n::Integer, m::Integer, x::Array{Float64, 1}, lj::Integer,
    grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  c = Array(Cdouble, m)
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  @eval CUTEst.ccfsg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun), $(Cint[grad]),
    $(libname))
  @cutest_error
  return c, nnzj[1], j_val, j_var, j_fun
end

function jl_ccfsg!(n::Integer, m::Integer, x::Array{Float64, 1}, c::Array{Float64, 1},
    lj::Integer, j_val::Array{Float64, 1}, j_var::Array{Integer, 1},
    j_fun::Array{Integer, 1}, grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  nnzj = Cint[0]
  @eval CUTEst.ccfsg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun), $(Cint[grad]),
    $(libname))
  @cutest_error
  return nnzj[1]
end

function jl_ccfsg(nlp::CUTEstModel, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  c = Array(Cdouble, m)
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  @eval CUTEst.ccfsg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun), $(Cint[grad]),
    $(nlp.libname))
  @cutest_error
  return c, nnzj[1], j_val, j_var, j_fun
end

function jl_ccfsg!(nlp::CUTEstModel, x::Array{Float64, 1}, c::Array{Float64, 1},
    j_val::Array{Float64, 1}, j_var::Array{Integer, 1},
    j_fun::Array{Integer, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  @eval CUTEst.ccfsg($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(c),
    $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun), $(Cint[grad]),
    $(nlp.libname))
  @cutest_error
  return nnzj[1]
end

function jl_ccifg(n::Integer, icon::Integer, x::Array{Float64, 1}, grad::Bool, libname
    = fixedlibname)
  io_err = Cint[0]
  ci = Cdouble[0]
  gci = Array(Cdouble, n)
  @eval CUTEst.ccifg($(io_err), $(Cint[n]), $(Cint[icon]), $(x),
    $(ci), $(gci), $(Cint[grad]), $(libname))
  @cutest_error
  return ci[1], gci
end

function jl_ccifg!(n::Integer, icon::Integer, x::Array{Float64, 1}, gci::Array{Float64,
    1}, grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  ci = Cdouble[0]
  @eval CUTEst.ccifg($(io_err), $(Cint[n]), $(Cint[icon]), $(x),
    $(ci), $(gci), $(Cint[grad]), $(libname))
  @cutest_error
  return ci[1]
end

function jl_ccifg(nlp::CUTEstModel, icon::Integer, x::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  gci = Array(Cdouble, n)
  @eval CUTEst.ccifg($(io_err), $(Cint[n]), $(Cint[icon]), $(x),
    $(ci), $(gci), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return ci[1], gci
end

function jl_ccifg!(nlp::CUTEstModel, icon::Integer, x::Array{Float64, 1},
    gci::Array{Float64, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  @eval CUTEst.ccifg($(io_err), $(Cint[n]), $(Cint[icon]), $(x),
    $(ci), $(gci), $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return ci[1]
end

function jl_ccifsg(n::Integer, icon::Integer, x::Array{Float64, 1}, lgci::Integer,
    grad::Bool, libname = fixedlibname)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_val = Array(Cdouble, lgci)
  gci_var = Array(Cint, lgci)
  @eval CUTEst.ccifsg($(io_err), $(Cint[n]), $(Cint[icon]), $(x),
    $(ci), $(nnzgci), $(Cint[lgci]), $(gci_val), $(gci_var),
    $(Cint[grad]), $(libname))
  @cutest_error
  return ci[1], nnzgci[1], gci_val, gci_var
end

function jl_ccifsg!(n::Integer, icon::Integer, x::Array{Float64, 1}, lgci::Integer,
    gci_val::Array{Float64, 1}, gci_var::Array{Integer, 1}, grad::Bool,
    libname = fixedlibname)
  io_err = Cint[0]
  ci = Cdouble[0]
  nnzgci = Cint[0]
  @eval CUTEst.ccifsg($(io_err), $(Cint[n]), $(Cint[icon]), $(x),
    $(ci), $(nnzgci), $(Cint[lgci]), $(gci_val), $(gci_var),
    $(Cint[grad]), $(libname))
  @cutest_error
  return ci[1], nnzgci[1]
end

function jl_ccifsg(nlp::CUTEstModel, icon::Integer, x::Array{Float64, 1}, lgci::Integer,
    grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  nnzgci = Cint[0]
  gci_val = Array(Cdouble, lgci)
  gci_var = Array(Cint, lgci)
  @eval CUTEst.ccifsg($(io_err), $(Cint[n]), $(Cint[icon]), $(x),
    $(ci), $(nnzgci), $(Cint[lgci]), $(gci_val), $(gci_var),
    $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return ci[1], nnzgci[1], gci_val, gci_var
end

function jl_ccifsg!(nlp::CUTEstModel, icon::Integer, x::Array{Float64, 1}, lgci::Integer,
    gci_val::Array{Float64, 1}, gci_var::Array{Integer, 1}, grad::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  ci = Cdouble[0]
  nnzgci = Cint[0]
  @eval CUTEst.ccifsg($(io_err), $(Cint[n]), $(Cint[icon]), $(x),
    $(ci), $(nnzgci), $(Cint[lgci]), $(gci_val), $(gci_var),
    $(Cint[grad]), $(nlp.libname))
  @cutest_error
  return ci[1], nnzgci[1]
end

function jl_cgrdh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Integer, lj2::Integer, lh1::Integer,
    libname = fixedlibname)
  io_err = Cint[0]
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  h_val = Array(Cdouble, lh1, n)
  @eval CUTEst.cgrdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(Cint[lh1]), $(h_val), $(libname))
  @cutest_error
  return g, j_val, h_val
end

function jl_cgrdh!(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Integer,
    lj2::Integer, j_val::Array{Float64, 2}, lh1::Integer,
    h_val::Array{Float64, 2}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.cgrdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(Cint[lh1]), $(h_val), $(libname))
  @cutest_error
  return 
end

function jl_cgrdh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, jtrans::Bool, lj1::Integer, lj2::Integer, lh1::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  g = Array(Cdouble, n)
  j_val = Array(Cdouble, lj1, lj2)
  h_val = Array(Cdouble, lh1, n)
  @eval CUTEst.cgrdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(Cint[lh1]), $(h_val), $(nlp.libname))
  @cutest_error
  return g, j_val, h_val
end

function jl_cgrdh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, g::Array{Float64, 1}, jtrans::Bool, lj1::Integer,
    lj2::Integer, j_val::Array{Float64, 2}, lh1::Integer,
    h_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval CUTEst.cgrdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(g), $(Cint[jtrans]), $(Cint[lj1]), $(Cint[lj2]),
    $(j_val), $(Cint[lh1]), $(h_val), $(nlp.libname))
  @cutest_error
  return 
end

function jl_cdh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh1::Integer, libname = fixedlibname)
  io_err = Cint[0]
  h_val = Array(Cdouble, lh1, n)
  @eval CUTEst.cdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[lh1]), $(h_val), $(libname))
  @cutest_error
  return h_val
end

function jl_cdh!(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh1::Integer, h_val::Array{Float64, 2}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.cdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[lh1]), $(h_val), $(libname))
  @cutest_error
  return 
end

function jl_cdh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh1::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  h_val = Array(Cdouble, lh1, n)
  @eval CUTEst.cdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[lh1]), $(h_val), $(nlp.libname))
  @cutest_error
  return h_val
end

function jl_cdh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh1::Integer, h_val::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval CUTEst.cdh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[lh1]), $(h_val), $(nlp.libname))
  @cutest_error
  return 
end

function jl_csh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh::Integer, libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.csh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_csh!(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh::Integer, h_val::Array{Float64, 1}, h_row::Array{Integer, 1},
    h_col::Array{Integer, 1}, libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.csh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_csh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.csh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_csh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    h_val::Array{Float64, 1}, h_row::Array{Integer, 1},
    h_col::Array{Integer, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  @eval CUTEst.csh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function jl_cshc(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh::Integer, libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.cshc($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_cshc!(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lh::Integer, h_val::Array{Float64, 1}, h_row::Array{Integer, 1},
    h_col::Array{Integer, 1}, libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.cshc($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_cshc(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.cshc($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_cshc!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    h_val::Array{Float64, 1}, h_row::Array{Integer, 1},
    h_col::Array{Integer, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  @eval CUTEst.cshc($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function jl_ceh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Integer, lhe_row::Integer, lhe_val::Integer, byrows::Bool,
    libname = fixedlibname)
  io_err = Cint[0]
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval CUTEst.ceh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(libname))
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_ceh!(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Integer, he_row_ptr::Array{Integer, 1},
    he_val_ptr::Array{Integer, 1}, lhe_row::Integer,
    he_row::Array{Integer, 1}, lhe_val::Integer, he_val::Array{Float64,
    1}, byrows::Bool, libname = fixedlibname)
  io_err = Cint[0]
  ne = Cint[0]
  @eval CUTEst.ceh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(libname))
  @cutest_error
  return ne[1]
end

function jl_ceh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Integer, lhe_row::Integer, lhe_val::Integer, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  ne = Cint[0]
  he_row_ptr = Array(Cint, lhe_ptr)
  he_val_ptr = Array(Cint, lhe_ptr)
  he_row = Array(Cint, lhe_row)
  he_val = Array(Cdouble, lhe_val)
  @eval CUTEst.ceh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(nlp.libname))
  @cutest_error
  return ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_ceh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    lhe_ptr::Integer, he_row_ptr::Array{Integer, 1},
    he_val_ptr::Array{Integer, 1}, lhe_row::Integer,
    he_row::Array{Integer, 1}, lhe_val::Integer, he_val::Array{Float64,
    1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  ne = Cint[0]
  @eval CUTEst.ceh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(nlp.libname))
  @cutest_error
  return ne[1]
end

function jl_cidh(n::Integer, x::Array{Float64, 1}, iprob::Integer, lh1::Integer,
    libname = fixedlibname)
  io_err = Cint[0]
  h = Array(Cdouble, lh1, n)
  @eval CUTEst.cidh($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(Cint[lh1]), $(h), $(libname))
  @cutest_error
  return h
end

function jl_cidh!(n::Integer, x::Array{Float64, 1}, iprob::Integer, lh1::Integer,
    h::Array{Float64, 2}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.cidh($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(Cint[lh1]), $(h), $(libname))
  @cutest_error
  return 
end

function jl_cidh(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Integer, lh1::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  h = Array(Cdouble, lh1, n)
  @eval CUTEst.cidh($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(Cint[lh1]), $(h), $(nlp.libname))
  @cutest_error
  return h
end

function jl_cidh!(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Integer, lh1::Integer,
    h::Array{Float64, 2})
  io_err = Cint[0]
  n = nlp.meta.nvar
  @eval CUTEst.cidh($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(Cint[lh1]), $(h), $(nlp.libname))
  @cutest_error
  return 
end

function jl_cish(n::Integer, x::Array{Float64, 1}, iprob::Integer, lh::Integer,
    libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.cish($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_cish!(n::Integer, x::Array{Float64, 1}, iprob::Integer, lh::Integer,
    h_val::Array{Float64, 1}, h_row::Array{Integer, 1},
    h_col::Array{Integer, 1}, libname = fixedlibname)
  io_err = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.cish($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzh[1]
end

function jl_cish(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.cish($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1], h_val, h_row, h_col
end

function jl_cish!(nlp::CUTEstModel, x::Array{Float64, 1}, iprob::Integer,
    h_val::Array{Float64, 1}, h_row::Array{Integer, 1},
    h_col::Array{Integer, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  @eval CUTEst.cish($(io_err), $(Cint[n]), $(x), $(Cint[iprob]),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzh[1]
end

function jl_csgrsh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Integer, lh::Integer, libname = fixedlibname)
  io_err = Cint[0]
  nnzj = Cint[0]
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  nnzh = Cint[0]
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.csgrsh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, nnzh[1], h_val, h_row, h_col
end

function jl_csgrsh!(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Integer, j_val::Array{Float64, 1},
    j_var::Array{Integer, 1}, j_fun::Array{Integer, 1}, lh::Integer,
    h_val::Array{Float64, 1}, h_row::Array{Integer, 1},
    h_col::Array{Integer, 1}, libname = fixedlibname)
  io_err = Cint[0]
  nnzj = Cint[0]
  nnzh = Cint[0]
  @eval CUTEst.csgrsh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(libname))
  @cutest_error
  return nnzj[1], nnzh[1]
end

function jl_csgrsh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  j_val = Array(Cdouble, lj)
  j_var = Array(Cint, lj)
  j_fun = Array(Cint, lj)
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  h_val = Array(Cdouble, lh)
  h_row = Array(Cint, lh)
  h_col = Array(Cint, lh)
  @eval CUTEst.csgrsh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, nnzh[1], h_val, h_row, h_col
end

function jl_csgrsh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, j_val::Array{Float64, 1}, j_var::Array{Integer, 1},
    j_fun::Array{Integer, 1}, h_val::Array{Float64, 1},
    h_row::Array{Integer, 1}, h_col::Array{Integer, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  nnzh = Cint[0]
  lh = nlp.meta.nnzh
  @eval CUTEst.csgrsh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(nnzh), $(Cint[lh]), $(h_val), $(h_row), $(h_col), $(nlp.libname))
  @cutest_error
  return nnzj[1], nnzh[1]
end

function jl_csgreh(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Integer, lhe_ptr::Integer, lhe_row::Integer,
    lhe_val::Integer, byrows::Bool, libname = fixedlibname)
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
  @eval CUTEst.csgreh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_csgreh!(n::Integer, m::Integer, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lj::Integer, j_val::Array{Float64, 1},
    j_var::Array{Integer, 1}, j_fun::Array{Integer, 1}, lhe_ptr::Integer,
    he_row_ptr::Array{Integer, 1}, he_val_ptr::Array{Integer, 1},
    lhe_row::Integer, he_row::Array{Integer, 1}, lhe_val::Integer,
    he_val::Array{Float64, 1}, byrows::Bool, libname = fixedlibname)
  io_err = Cint[0]
  nnzj = Cint[0]
  ne = Cint[0]
  @eval CUTEst.csgreh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(libname))
  @cutest_error
  return nnzj[1], ne[1]
end

function jl_csgreh(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, lhe_ptr::Integer, lhe_row::Integer, lhe_val::Integer,
    byrows::Bool)
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
  @eval CUTEst.csgreh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(nlp.libname))
  @cutest_error
  return nnzj[1], j_val, j_var, j_fun, ne[1], he_row_ptr, he_val_ptr, he_row, he_val
end

function jl_csgreh!(nlp::CUTEstModel, x::Array{Float64, 1}, y::Array{Float64, 1},
    grlagf::Bool, j_val::Array{Float64, 1}, j_var::Array{Integer, 1},
    j_fun::Array{Integer, 1}, lhe_ptr::Integer, he_row_ptr::Array{Integer,
    1}, he_val_ptr::Array{Integer, 1}, lhe_row::Integer,
    he_row::Array{Integer, 1}, lhe_val::Integer, he_val::Array{Float64,
    1}, byrows::Bool)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  nnzj = Cint[0]
  lj = nlp.meta.nnzj
  ne = Cint[0]
  @eval CUTEst.csgreh($(io_err), $(Cint[n]), $(Cint[m]), $(x), $(y),
    $(Cint[grlagf]), $(nnzj), $(Cint[lj]), $(j_val), $(j_var), $(j_fun),
    $(ne), $(Cint[lhe_ptr]), $(he_row_ptr), $(he_val_ptr),
    $(Cint[lhe_row]), $(he_row), $(Cint[lhe_val]), $(he_val),
    $(Cint[byrows]), $(nlp.libname))
  @cutest_error
  return nnzj[1], ne[1]
end

function jl_chprod(n::Integer, m::Integer, goth::Bool, x::Array{Float64, 1},
    y::Array{Float64, 1}, vector::Array{Float64, 1}, libname =
    fixedlibname)
  io_err = Cint[0]
  result = Array(Cdouble, n)
  @eval CUTEst.chprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[goth]), $(x), $(y), $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function jl_chprod!(n::Integer, m::Integer, goth::Bool, x::Array{Float64, 1},
    y::Array{Float64, 1}, vector::Array{Float64, 1},
    result::Array{Float64, 1}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.chprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[goth]), $(x), $(y), $(vector), $(result), $(libname))
  @cutest_error
  return 
end

function jl_chprod(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  result = Array(Cdouble, n)
  @eval CUTEst.chprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[goth]), $(x), $(y), $(vector), $(result), $(nlp.libname))
  @cutest_error
  return result
end

function jl_chprod!(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval CUTEst.chprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[goth]), $(x), $(y), $(vector), $(result), $(nlp.libname))
  @cutest_error
  return 
end

function jl_chcprod(n::Integer, m::Integer, goth::Bool, x::Array{Float64, 1},
    y::Array{Float64, 1}, vector::Array{Float64, 1}, libname =
    fixedlibname)
  io_err = Cint[0]
  result = Array(Cdouble, n)
  @eval CUTEst.chcprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[goth]), $(x), $(y), $(vector), $(result), $(libname))
  @cutest_error
  return result
end

function jl_chcprod!(n::Integer, m::Integer, goth::Bool, x::Array{Float64, 1},
    y::Array{Float64, 1}, vector::Array{Float64, 1},
    result::Array{Float64, 1}, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.chcprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[goth]), $(x), $(y), $(vector), $(result), $(libname))
  @cutest_error
  return 
end

function jl_chcprod(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  result = Array(Cdouble, n)
  @eval CUTEst.chcprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[goth]), $(x), $(y), $(vector), $(result), $(nlp.libname))
  @cutest_error
  return result
end

function jl_chcprod!(nlp::CUTEstModel, goth::Bool, x::Array{Float64, 1}, y::Array{Float64,
    1}, vector::Array{Float64, 1}, result::Array{Float64, 1})
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval CUTEst.chcprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[goth]), $(x), $(y), $(vector), $(result), $(nlp.libname))
  @cutest_error
  return 
end

function jl_cjprod(n::Integer, m::Integer, gotj::Bool, jtrans::Bool, x::Array{Float64,
    1}, vector::Array{Float64, 1}, lvector::Integer, lresult::Integer,
    libname = fixedlibname)
  io_err = Cint[0]
  result = Array(Cdouble, lresult)
  @eval CUTEst.cjprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[gotj]), $(Cint[jtrans]), $(x), $(vector), $(Cint[lvector]),
    $(result), $(Cint[lresult]), $(libname))
  @cutest_error
  return result
end

function jl_cjprod!(n::Integer, m::Integer, gotj::Bool, jtrans::Bool, x::Array{Float64,
    1}, vector::Array{Float64, 1}, lvector::Integer,
    result::Array{Float64, 1}, lresult::Integer, libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.cjprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[gotj]), $(Cint[jtrans]), $(x), $(vector), $(Cint[lvector]),
    $(result), $(Cint[lresult]), $(libname))
  @cutest_error
  return 
end

function jl_cjprod(nlp::CUTEstModel, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Integer, lresult::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  result = Array(Cdouble, lresult)
  @eval CUTEst.cjprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[gotj]), $(Cint[jtrans]), $(x), $(vector), $(Cint[lvector]),
    $(result), $(Cint[lresult]), $(nlp.libname))
  @cutest_error
  return result
end

function jl_cjprod!(nlp::CUTEstModel, gotj::Bool, jtrans::Bool, x::Array{Float64, 1},
    vector::Array{Float64, 1}, lvector::Integer, result::Array{Float64,
    1}, lresult::Integer)
  io_err = Cint[0]
  n = nlp.meta.nvar
  m = nlp.meta.ncon
  @eval CUTEst.cjprod($(io_err), $(Cint[n]), $(Cint[m]),
    $(Cint[gotj]), $(Cint[jtrans]), $(x), $(vector), $(Cint[lvector]),
    $(result), $(Cint[lresult]), $(nlp.libname))
  @cutest_error
  return 
end

function jl_uterminate(libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.uterminate($(io_err), $(libname))
  @cutest_error
  return 
end

function jl_uterminate!(libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.uterminate($(io_err), $(libname))
  @cutest_error
  return 
end

function jl_uterminate(nlp::CUTEstModel)
  io_err = Cint[0]
  @eval CUTEst.uterminate($(io_err), $(nlp.libname))
  @cutest_error
  return 
end

function jl_uterminate!(nlp::CUTEstModel)
  io_err = Cint[0]
  @eval CUTEst.uterminate($(io_err), $(nlp.libname))
  @cutest_error
  return 
end

function jl_cterminate(libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.cterminate($(io_err), $(libname))
  @cutest_error
  return 
end

function jl_cterminate!(libname = fixedlibname)
  io_err = Cint[0]
  @eval CUTEst.cterminate($(io_err), $(libname))
  @cutest_error
  return 
end

function jl_cterminate(nlp::CUTEstModel)
  io_err = Cint[0]
  @eval CUTEst.cterminate($(io_err), $(nlp.libname))
  @cutest_error
  return 
end

function jl_cterminate!(nlp::CUTEstModel)
  io_err = Cint[0]
  @eval CUTEst.cterminate($(io_err), $(nlp.libname))
  @cutest_error
  return 
end

