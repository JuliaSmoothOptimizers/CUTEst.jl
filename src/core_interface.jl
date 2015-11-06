export usetup, csetup, udimen, udimsh, udimse, uvartype, unames,
    ureport, cdimen, cdimsj, cdimsh, cdimse, cstats, cvartype, cnames,
    creport, connames, pname, probname, varnames, ufn, ugr, uofg, ubandh,
    udh, ush, ueh, ugrdh, ugrsh, ugreh, uhprod, cfn, cofg, cofsg, ccfg,
    clfg, cgr, csgr, ccfsg, ccifg, ccifsg, cgrdh, cdh, csh, cshc, ceh,
    cidh, cish, csgrsh, csgreh, chprod, chcprod, cjprod, uterminate,
    cterminate

function usetup(io_err::Array{Cint, 1}, input::Array{Cint, 1}, out::Array{Cint, 1},
    io_buffer::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    x_l::Array{Cdouble, 1}, x_u::Array{Cdouble, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_usetup_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, input, out, io_buffer, n, x, x_l, x_u)
end

function usetup(io_err::Array{Cint, 1}, input::Array{Cint, 1}, out::Array{Cint, 1},
    io_buffer::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    x_l::Array{Cdouble, 1}, x_u::Array{Cdouble, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_usetup_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, input, out, io_buffer, n, x, x_l, x_u)
end

function csetup(io_err::Array{Cint, 1}, input::Array{Cint, 1}, out::Array{Cint, 1},
    io_buffer::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, x_l::Array{Cdouble, 1}, x_u::Array{Cdouble, 1},
    y::Array{Cdouble, 1}, c_l::Array{Cdouble, 1}, c_u::Array{Cdouble, 1},
    equatn::Array{Cint, 1}, linear::Array{Cint, 1}, e_order::Array{Cint,
    1}, l_order::Array{Cint, 1}, v_order::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_csetup_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn,
    linear, e_order, l_order, v_order)
end

function csetup(io_err::Array{Cint, 1}, input::Array{Cint, 1}, out::Array{Cint, 1},
    io_buffer::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, x_l::Array{Cdouble, 1}, x_u::Array{Cdouble, 1},
    y::Array{Cdouble, 1}, c_l::Array{Cdouble, 1}, c_u::Array{Cdouble, 1},
    equatn::Array{Cint, 1}, linear::Array{Cint, 1}, e_order::Array{Cint,
    1}, l_order::Array{Cint, 1}, v_order::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_csetup_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn,
    linear, e_order, l_order, v_order)
end

function udimen(io_err::Array{Cint, 1}, input::Array{Cint, 1}, n::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_udimen_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, input, n)
end

function udimen(io_err::Array{Cint, 1}, input::Array{Cint, 1}, n::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_udimen_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, input, n)
end

function udimsh(io_err::Array{Cint, 1}, nnzh::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_udimsh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}),
    io_err, nnzh)
end

function udimsh(io_err::Array{Cint, 1}, nnzh::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_udimsh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}),
    io_err, nnzh)
end

function udimse(io_err::Array{Cint, 1}, ne::Array{Cint, 1}, he_val_ne::Array{Cint, 1},
    he_row_ne::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_udimse_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, ne, he_val_ne, he_row_ne)
end

function udimse(io_err::Array{Cint, 1}, ne::Array{Cint, 1}, he_val_ne::Array{Cint, 1},
    he_row_ne::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_udimse_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, ne, he_val_ne, he_row_ne)
end

function uvartype(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x_type::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_uvartype_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x_type)
end

function uvartype(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x_type::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_uvartype_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x_type)
end

function unames(io_err::Array{Cint, 1}, n::Array{Cint, 1}, pname::Array{Cchar, 1},
    vname::Array{Cchar, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_unames_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cchar}),
    io_err, n, pname, vname)
end

function unames(io_err::Array{Cint, 1}, n::Array{Cint, 1}, pname::Array{Cchar, 1},
    vname::Array{Cchar, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_unames_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cchar}),
    io_err, n, pname, vname)
end

function ureport(io_err::Array{Cint, 1}, calls::Array{Cdouble, 1}, time::Array{Cdouble,
    1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ureport_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, calls, time)
end

function ureport(io_err::Array{Cint, 1}, calls::Array{Cdouble, 1}, time::Array{Cdouble,
    1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ureport_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, calls, time)
end

function cdimen(io_err::Array{Cint, 1}, input::Array{Cint, 1}, n::Array{Cint, 1},
    m::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cdimen_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, input, n, m)
end

function cdimen(io_err::Array{Cint, 1}, input::Array{Cint, 1}, n::Array{Cint, 1},
    m::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cdimen_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, input, n, m)
end

function cdimsj(io_err::Array{Cint, 1}, nnzj::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cdimsj_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}),
    io_err, nnzj)
end

function cdimsj(io_err::Array{Cint, 1}, nnzj::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cdimsj_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}),
    io_err, nnzj)
end

function cdimsh(io_err::Array{Cint, 1}, nnzh::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cdimsh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}),
    io_err, nnzh)
end

function cdimsh(io_err::Array{Cint, 1}, nnzh::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cdimsh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}),
    io_err, nnzh)
end

function cdimse(io_err::Array{Cint, 1}, ne::Array{Cint, 1}, he_val_ne::Array{Cint, 1},
    he_row_ne::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cdimse_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, ne, he_val_ne, he_row_ne)
end

function cdimse(io_err::Array{Cint, 1}, ne::Array{Cint, 1}, he_val_ne::Array{Cint, 1},
    he_row_ne::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cdimse_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, ne, he_val_ne, he_row_ne)
end

function cstats(io_err::Array{Cint, 1}, nonlinear_variables_objective::Array{Cint, 1},
    nonlinear_variables_constraints::Array{Cint, 1},
    equality_constraints::Array{Cint, 1}, linear_constraints::Array{Cint,
    1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cstats_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, nonlinear_variables_objective,
    nonlinear_variables_constraints, equality_constraints,
    linear_constraints)
end

function cstats(io_err::Array{Cint, 1}, nonlinear_variables_objective::Array{Cint, 1},
    nonlinear_variables_constraints::Array{Cint, 1},
    equality_constraints::Array{Cint, 1}, linear_constraints::Array{Cint,
    1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cstats_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, nonlinear_variables_objective,
    nonlinear_variables_constraints, equality_constraints,
    linear_constraints)
end

function cvartype(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x_type::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cvartype_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x_type)
end

function cvartype(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x_type::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cvartype_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x_type)
end

function cnames(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    pname::Array{Cchar, 1}, vname::Array{Cchar, 1}, cname::Array{Cchar,
    1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cnames_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}),
    io_err, n, m, pname, vname, cname)
end

function cnames(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    pname::Array{Cchar, 1}, vname::Array{Cchar, 1}, cname::Array{Cchar,
    1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cnames_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}),
    io_err, n, m, pname, vname, cname)
end

function creport(io_err::Array{Cint, 1}, calls::Array{Cdouble, 1}, time::Array{Cdouble,
    1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_creport_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, calls, time)
end

function creport(io_err::Array{Cint, 1}, calls::Array{Cdouble, 1}, time::Array{Cdouble,
    1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_creport_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, calls, time)
end

function connames(io_err::Array{Cint, 1}, m::Array{Cint, 1}, cname::Array{Cchar, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_connames_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
    io_err, m, cname)
end

function connames(io_err::Array{Cint, 1}, m::Array{Cint, 1}, cname::Array{Cchar, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_connames_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
    io_err, m, cname)
end

function pname(io_err::Array{Cint, 1}, input::Array{Cint, 1}, pname::Array{Cchar, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_pname_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
    io_err, input, pname)
end

function pname(io_err::Array{Cint, 1}, input::Array{Cint, 1}, pname::Array{Cchar, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_pname_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
    io_err, input, pname)
end

function probname(io_err::Array{Cint, 1}, pname::Array{Cchar, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_probname_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cchar}),
    io_err, pname)
end

function probname(io_err::Array{Cint, 1}, pname::Array{Cchar, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_probname_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cchar}),
    io_err, pname)
end

function varnames(io_err::Array{Cint, 1}, n::Array{Cint, 1}, vname::Array{Cchar, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_varnames_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
    io_err, n, vname)
end

function varnames(io_err::Array{Cint, 1}, n::Array{Cint, 1}, vname::Array{Cchar, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_varnames_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
    io_err, n, vname)
end

function ufn(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ufn_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, x, f)
end

function ufn(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ufn_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, x, f)
end

function ugr(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ugr_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, x, g)
end

function ugr(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ugr_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, x, g)
end

function uofg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, g::Array{Cdouble, 1}, grad::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_uofg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}),
    io_err, n, x, f, g, grad)
end

function uofg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, g::Array{Cdouble, 1}, grad::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_uofg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}),
    io_err, n, x, f, g, grad)
end

function ubandh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    semibandwidth::Array{Cint, 1}, h_band::Array{Cdouble, 2},
    lbandh::Array{Cint, 1}, max_semibandwidth::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ubandh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, semibandwidth, h_band, lbandh, max_semibandwidth)
end

function ubandh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    semibandwidth::Array{Cint, 1}, h_band::Array{Cdouble, 2},
    lbandh::Array{Cint, 1}, max_semibandwidth::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ubandh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, semibandwidth, h_band, lbandh, max_semibandwidth)
end

function udh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    lh1::Array{Cint, 1}, h::Array{Cdouble, 2}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_udh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, x, lh1, h)
end

function udh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    lh1::Array{Cint, 1}, h::Array{Cdouble, 2}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_udh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, x, lh1, h)
end

function ush(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    nnzh::Array{Cint, 1}, lh::Array{Cint, 1}, h_val::Array{Cdouble, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ush_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, nnzh, lh, h_val, h_row, h_col)
end

function ush(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    nnzh::Array{Cint, 1}, lh::Array{Cint, 1}, h_val::Array{Cdouble, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ush_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, nnzh, lh, h_val, h_row, h_col)
end

function ueh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    ne::Array{Cint, 1}, lhe_ptr::Array{Cint, 1}, he_row_ptr::Array{Cint,
    1}, he_val_ptr::Array{Cint, 1}, lhe_row::Array{Cint, 1},
    he_row::Array{Cint, 1}, lhe_val::Array{Cint, 1},
    he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ueh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, x, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
    lhe_val, he_val, byrows)
end

function ueh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    ne::Array{Cint, 1}, lhe_ptr::Array{Cint, 1}, he_row_ptr::Array{Cint,
    1}, he_val_ptr::Array{Cint, 1}, lhe_row::Array{Cint, 1},
    he_row::Array{Cint, 1}, lhe_val::Array{Cint, 1},
    he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ueh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, x, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
    lhe_val, he_val, byrows)
end

function ugrdh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, lh1::Array{Cint, 1}, h::Array{Cdouble, 2},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ugrdh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cdouble}),
    io_err, n, x, g, lh1, h)
end

function ugrdh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, lh1::Array{Cint, 1}, h::Array{Cdouble, 2},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ugrdh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cdouble}),
    io_err, n, x, g, lh1, h)
end

function ugrsh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, nnzh::Array{Cint, 1}, lh::Array{Cint, 1},
    h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ugrsh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, g, nnzh, lh, h_val, h_row, h_col)
end

function ugrsh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, nnzh::Array{Cint, 1}, lh::Array{Cint, 1},
    h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ugrsh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, g, nnzh, lh, h_val, h_row, h_col)
end

function ugreh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, ne::Array{Cint, 1}, lhe_ptr::Array{Cint, 1},
    he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1},
    lhe_row::Array{Cint, 1}, he_row::Array{Cint, 1}, lhe_val::Array{Cint,
    1}, he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ugreh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, x, g, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
    lhe_val, he_val, byrows)
end

function ugreh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, ne::Array{Cint, 1}, lhe_ptr::Array{Cint, 1},
    he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1},
    lhe_row::Array{Cint, 1}, he_row::Array{Cint, 1}, lhe_val::Array{Cint,
    1}, he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ugreh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, x, g, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
    lhe_val, he_val, byrows)
end

function uhprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, goth::Array{Cint, 1},
    x::Array{Cdouble, 1}, vector::Array{Cdouble, 1},
    result::Array{Cdouble, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_uhprod_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}),
    io_err, n, goth, x, vector, result)
end

function uhprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, goth::Array{Cint, 1},
    x::Array{Cdouble, 1}, vector::Array{Cdouble, 1},
    result::Array{Cdouble, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_uhprod_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}),
    io_err, n, goth, x, vector, result)
end

function cfn(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, f::Array{Cdouble, 1}, c::Array{Cdouble, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cfn_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}),
    io_err, n, m, x, f, c)
end

function cfn(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, f::Array{Cdouble, 1}, c::Array{Cdouble, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cfn_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}),
    io_err, n, m, x, f, c)
end

function cofg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, g::Array{Cdouble, 1}, grad::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cofg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}),
    io_err, n, x, f, g, grad)
end

function cofg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, g::Array{Cdouble, 1}, grad::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cofg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}),
    io_err, n, x, f, g, grad)
end

function cofsg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, nnzg::Array{Cint, 1}, lg::Array{Cint, 1},
    g_val::Array{Cdouble, 1}, g_var::Array{Cint, 1}, grad::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cofsg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, f, nnzg, lg, g_val, g_var, grad)
end

function cofsg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, nnzg::Array{Cint, 1}, lg::Array{Cint, 1},
    g_val::Array{Cdouble, 1}, g_var::Array{Cint, 1}, grad::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cofsg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, f, nnzg, lg, g_val, g_var, grad)
end

function ccfg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, c::Array{Cdouble, 1}, jtrans::Array{Cint, 1},
    lcjac1::Array{Cint, 1}, lcjac2::Array{Cint, 1}, cjac::Array{Cdouble,
    2}, grad::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ccfg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
end

function ccfg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, c::Array{Cdouble, 1}, jtrans::Array{Cint, 1},
    lcjac1::Array{Cint, 1}, lcjac2::Array{Cint, 1}, cjac::Array{Cdouble,
    2}, grad::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ccfg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
end

function clfg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, f::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, grad::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_clfg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, y, f, g, grad)
end

function clfg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, f::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, grad::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_clfg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, y, f, g, grad)
end

function cgr(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    g::Array{Cdouble, 1}, jtrans::Array{Cint, 1}, lj1::Array{Cint, 1},
    lj2::Array{Cint, 1}, j_val::Array{Cdouble, 2}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cgr_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)
end

function cgr(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    g::Array{Cdouble, 1}, jtrans::Array{Cint, 1}, lj1::Array{Cint, 1},
    lj2::Array{Cint, 1}, j_val::Array{Cdouble, 2}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cgr_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)
end

function csgr(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    nnzj::Array{Cint, 1}, lj::Array{Cint, 1}, j_val::Array{Cdouble, 1},
    j_var::Array{Cint, 1}, j_fun::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_csgr_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun)
end

function csgr(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    nnzj::Array{Cint, 1}, lj::Array{Cint, 1}, j_val::Array{Cdouble, 1},
    j_var::Array{Cint, 1}, j_fun::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_csgr_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun)
end

function ccfsg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, c::Array{Cdouble, 1}, nnzj::Array{Cint, 1},
    lj::Array{Cint, 1}, j_val::Array{Cdouble, 1}, j_var::Array{Cint, 1},
    j_fun::Array{Cint, 1}, grad::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ccfsg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad)
end

function ccfsg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, c::Array{Cdouble, 1}, nnzj::Array{Cint, 1},
    lj::Array{Cint, 1}, j_val::Array{Cdouble, 1}, j_var::Array{Cint, 1},
    j_fun::Array{Cint, 1}, grad::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ccfsg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad)
end

function ccifg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, icon::Array{Cint, 1},
    x::Array{Cdouble, 1}, ci::Array{Cdouble, 1}, gci::Array{Cdouble, 1},
    grad::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ccifg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, icon, x, ci, gci, grad)
end

function ccifg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, icon::Array{Cint, 1},
    x::Array{Cdouble, 1}, ci::Array{Cdouble, 1}, gci::Array{Cdouble, 1},
    grad::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ccifg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, icon, x, ci, gci, grad)
end

function ccifsg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, icon::Array{Cint, 1},
    x::Array{Cdouble, 1}, ci::Array{Cdouble, 1}, nnzgci::Array{Cint, 1},
    lgci::Array{Cint, 1}, gci_val::Array{Cdouble, 1}, gci_var::Array{Cint,
    1}, grad::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ccifsg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad)
end

function ccifsg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, icon::Array{Cint, 1},
    x::Array{Cdouble, 1}, ci::Array{Cdouble, 1}, nnzgci::Array{Cint, 1},
    lgci::Array{Cint, 1}, gci_val::Array{Cdouble, 1}, gci_var::Array{Cint,
    1}, grad::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ccifsg_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad)
end

function cgrdh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    g::Array{Cdouble, 1}, jtrans::Array{Cint, 1}, lj1::Array{Cint, 1},
    lj2::Array{Cint, 1}, j_val::Array{Cdouble, 2}, lh1::Array{Cint, 1},
    h_val::Array{Cdouble, 2}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cgrdh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)
end

function cgrdh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    g::Array{Cdouble, 1}, jtrans::Array{Cint, 1}, lj1::Array{Cint, 1},
    lj2::Array{Cint, 1}, j_val::Array{Cdouble, 2}, lh1::Array{Cint, 1},
    h_val::Array{Cdouble, 2}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cgrdh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)
end

function cdh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, lh1::Array{Cint, 1},
    h_val::Array{Cdouble, 2}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cdh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, x, y, lh1, h_val)
end

function cdh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, lh1::Array{Cint, 1},
    h_val::Array{Cdouble, 2}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cdh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, x, y, lh1, h_val)
end

function csh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1},
    h_col::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_csh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)
end

function csh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1},
    h_col::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_csh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)
end

function cshc(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1},
    h_col::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cshc_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)
end

function cshc(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1},
    h_col::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cshc_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)
end

function ceh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, ne::Array{Cint, 1},
    lhe_ptr::Array{Cint, 1}, he_row_ptr::Array{Cint, 1},
    he_val_ptr::Array{Cint, 1}, lhe_row::Array{Cint, 1},
    he_row::Array{Cint, 1}, lhe_val::Array{Cint, 1},
    he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_ceh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, y, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row,
    he_row, lhe_val, he_val, byrows)
end

function ceh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, ne::Array{Cint, 1},
    lhe_ptr::Array{Cint, 1}, he_row_ptr::Array{Cint, 1},
    he_val_ptr::Array{Cint, 1}, lhe_row::Array{Cint, 1},
    he_row::Array{Cint, 1}, lhe_val::Array{Cint, 1},
    he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_ceh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, y, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row,
    he_row, lhe_val, he_val, byrows)
end

function cidh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    iprob::Array{Cint, 1}, lh1::Array{Cint, 1}, h::Array{Cdouble, 2},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cidh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, x, iprob, lh1, h)
end

function cidh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    iprob::Array{Cint, 1}, lh1::Array{Cint, 1}, h::Array{Cdouble, 2},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cidh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, x, iprob, lh1, h)
end

function cish(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    iprob::Array{Cint, 1}, nnzh::Array{Cint, 1}, lh::Array{Cint, 1},
    h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cish_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, iprob, nnzh, lh, h_val, h_row, h_col)
end

function cish(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    iprob::Array{Cint, 1}, nnzh::Array{Cint, 1}, lh::Array{Cint, 1},
    h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint,
    1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cish_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, iprob, nnzh, lh, h_val, h_row, h_col)
end

function csgrsh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    nnzj::Array{Cint, 1}, lj::Array{Cint, 1}, j_val::Array{Cdouble, 1},
    j_var::Array{Cint, 1}, j_fun::Array{Cint, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1},
    h_col::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_csgrsh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, nnzh, lh,
    h_val, h_row, h_col)
end

function csgrsh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    nnzj::Array{Cint, 1}, lj::Array{Cint, 1}, j_val::Array{Cdouble, 1},
    j_var::Array{Cint, 1}, j_fun::Array{Cint, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1},
    h_col::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_csgrsh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, nnzh, lh,
    h_val, h_row, h_col)
end

function csgreh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    nnzj::Array{Cint, 1}, lj::Array{Cint, 1}, j_val::Array{Cdouble, 1},
    j_var::Array{Cint, 1}, j_fun::Array{Cint, 1}, ne::Array{Cint, 1},
    lhe_ptr::Array{Cint, 1}, he_row_ptr::Array{Cint, 1},
    he_val_ptr::Array{Cint, 1}, lhe_row::Array{Cint, 1},
    he_row::Array{Cint, 1}, lhe_val::Array{Cint, 1},
    he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_csgreh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, ne,
    lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val,
    byrows)
end

function csgreh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    nnzj::Array{Cint, 1}, lj::Array{Cint, 1}, j_val::Array{Cdouble, 1},
    j_var::Array{Cint, 1}, j_fun::Array{Cint, 1}, ne::Array{Cint, 1},
    lhe_ptr::Array{Cint, 1}, he_row_ptr::Array{Cint, 1},
    he_val_ptr::Array{Cint, 1}, lhe_row::Array{Cint, 1},
    he_row::Array{Cint, 1}, lhe_val::Array{Cint, 1},
    he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_csgreh_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, ne,
    lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val,
    byrows)
end

function chprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    goth::Array{Cint, 1}, x::Array{Cdouble, 1}, y::Array{Cdouble, 1},
    vector::Array{Cdouble, 1}, result::Array{Cdouble, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_chprod_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, m, goth, x, y, vector, result)
end

function chprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    goth::Array{Cint, 1}, x::Array{Cdouble, 1}, y::Array{Cdouble, 1},
    vector::Array{Cdouble, 1}, result::Array{Cdouble, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_chprod_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, m, goth, x, y, vector, result)
end

function chcprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    goth::Array{Cint, 1}, x::Array{Cdouble, 1}, y::Array{Cdouble, 1},
    vector::Array{Cdouble, 1}, result::Array{Cdouble, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_chcprod_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, m, goth, x, y, vector, result)
end

function chcprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    goth::Array{Cint, 1}, x::Array{Cdouble, 1}, y::Array{Cdouble, 1},
    vector::Array{Cdouble, 1}, result::Array{Cdouble, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_chcprod_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, m, goth, x, y, vector, result)
end

function cjprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    gotj::Array{Cint, 1}, jtrans::Array{Cint, 1}, x::Array{Cdouble, 1},
    vector::Array{Cdouble, 1}, lvector::Array{Cint, 1},
    result::Array{Cdouble, 1}, lresult::Array{Cint, 1},
    libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cjprod_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, gotj, jtrans, x, vector, lvector, result, lresult)
end

function cjprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    gotj::Array{Cint, 1}, jtrans::Array{Cint, 1}, x::Array{Cdouble, 1},
    vector::Array{Cdouble, 1}, lvector::Array{Cint, 1},
    result::Array{Cdouble, 1}, lresult::Array{Cint, 1},
    cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cjprod_", cutest_lib), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, gotj, jtrans, x, vector, lvector, result, lresult)
end

function uterminate(io_err::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_uterminate_", cutest_lib), Void,
    (Ptr{Cint},),
    io_err)
end

function uterminate(io_err::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_uterminate_", cutest_lib), Void,
    (Ptr{Cint},),
    io_err)
end

function cterminate(io_err::Array{Cint, 1}, libname::ASCIIString)
  cutest_lib = Libdl.dlopen(libname)
  ccall(@dlsym("cutest_cterminate_", cutest_lib), Void,
    (Ptr{Cint},),
    io_err)
end

function cterminate(io_err::Array{Cint, 1}, cutest_lib::Ptr{Void})
  ccall(@dlsym("cutest_cterminate_", cutest_lib), Void,
    (Ptr{Cint},),
    io_err)
end

