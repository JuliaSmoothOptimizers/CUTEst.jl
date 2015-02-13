function usetup (status, funit, iout, io_buffer, n, x, bl, bu, libname =
    fixedlibname)
  @eval ccall(("cutest_usetup_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}),
    $(status), $(funit), $(iout), $(io_buffer), $(n), $(x), $(bl), $(bu))
end

function csetup (status, funit, iout, io_buffer, n, m, x, bl, bu, v, cl, cu,
    equatn, linear, e_order, l_order, v_order, libname = fixedlibname)
  @eval ccall(("cutest_csetup_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(funit), $(iout), $(io_buffer), $(n), $(m), $(x), $(bl), $(bu),
    $(v), $(cl), $(cu), $(equatn), $(linear), $(e_order), $(l_order), $(v_order))
end

function udimen (status, funit, n, libname = fixedlibname)
  @eval ccall(("cutest_udimen_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(funit), $(n))
end

function udimsh (status, nnzh, libname = fixedlibname)
  @eval ccall(("cutest_udimsh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}),
    $(status), $(nnzh))
end

function udimse (status, ne, nzh, nzirnh, libname = fixedlibname)
  @eval ccall(("cutest_udimse_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(ne), $(nzh), $(nzirnh))
end

function uvartype (status, n, ivarty, libname = fixedlibname)
  @eval ccall(("cutest_uvartype_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(ivarty))
end

function unames (status, n, pname, vnames, libname = fixedlibname)
  @eval ccall(("cutest_unames_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cchar}),
    $(status), $(n), $(pname), $(vnames))
end

function ureport (status, calls, time, libname = fixedlibname)
  @eval ccall(("cutest_ureport_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    $(status), $(calls), $(time))
end

function cdimen (status, funit, n, m, libname = fixedlibname)
  @eval ccall(("cutest_cdimen_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(funit), $(n), $(m))
end

function cdimsj (status, nnzj, libname = fixedlibname)
  @eval ccall(("cutest_cdimsj_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}),
    $(status), $(nnzj))
end

function cdimsh (status, nnzh, libname = fixedlibname)
  @eval ccall(("cutest_cdimsh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}),
    $(status), $(nnzh))
end

function cdimse (status, ne, nzh, nzirnh, libname = fixedlibname)
  @eval ccall(("cutest_cdimse_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(ne), $(nzh), $(nzirnh))
end

function cstats (status, nonlinear_variables_objective,
    nonlinear_variables_constraints, equality_constraints, linear_constraints,
    libname = fixedlibname)
  @eval ccall(("cutest_cstats_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(nonlinear_variables_objective),
    $(nonlinear_variables_constraints), $(equality_constraints),
    $(linear_constraints))
end

function cvartype (status, n, ivarty, libname = fixedlibname)
  @eval ccall(("cutest_cvartype_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(ivarty))
end

function cnames (status, n, m, pname, vnames, gnames, libname = fixedlibname)
  @eval ccall(("cutest_cnames_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}),
    $(status), $(n), $(m), $(pname), $(vnames), $(gnames))
end

function creport (status, calls, time, libname = fixedlibname)
  @eval ccall(("cutest_creport_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    $(status), $(calls), $(time))
end

function connames (status, m, gname, libname = fixedlibname)
  @eval ccall(("cutest_connames_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
    $(status), $(m), $(gname))
end

function pname (status, funit, pname, libname = fixedlibname)
  @eval ccall(("cutest_pname_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
    $(status), $(funit), $(pname))
end

function probname (status, pname, libname = fixedlibname)
  @eval ccall(("cutest_probname_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cchar}),
    $(status), $(pname))
end

function varnames (status, n, vname, libname = fixedlibname)
  @eval ccall(("cutest_varnames_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
    $(status), $(n), $(vname))
end

function ufn (status, n, x, f, libname = fixedlibname)
  @eval ccall(("cutest_ufn_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    $(status), $(n), $(x), $(f))
end

function ugr (status, n, x, g, libname = fixedlibname)
  @eval ccall(("cutest_ugr_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    $(status), $(n), $(x), $(g))
end

function uofg (status, n, x, f, g, grad, libname = fixedlibname)
  @eval ccall(("cutest_uofg_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}),
    $(status), $(n), $(x), $(f), $(g), $(grad))
end

function ubandh (status, n, x, nsemib, bandh, lbandh, maxsbw, libname =
    fixedlibname)
  @eval ccall(("cutest_ubandh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}),
    $(status), $(n), $(x), $(nsemib), $(bandh), $(lbandh), $(maxsbw))
end

function udh (status, n, x, lh1, h, libname = fixedlibname)
  @eval ccall(("cutest_udh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    $(status), $(n), $(x), $(lh1), $(h))
end

function ush (status, n, x, nnzh, lh, h, irnh, icnh, libname = fixedlibname)
  @eval ccall(("cutest_ush_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(x), $(nnzh), $(lh), $(h), $(irnh), $(icnh))
end

function ueh (status, n, x, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
    byrows, libname = fixedlibname)
  @eval ccall(("cutest_ueh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    $(status), $(n), $(x), $(ne), $(le), $(iprnhi), $(iprhi), $(lirnhi),
    $(irnhi), $(lhi), $(hi), $(byrows))
end

function ugrdh (status, n, x, g, lh1, h, libname = fixedlibname)
  @eval ccall(("cutest_ugrdh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    $(status), $(n), $(x), $(g), $(lh1), $(h))
end

function ugrsh (status, n, x, g, nnzh, lh, h, irnh, icnh, libname =
    fixedlibname)
  @eval ccall(("cutest_ugrsh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(x), $(g), $(nnzh), $(lh), $(h), $(irnh), $(icnh))
end

function ugreh (status, n, x, g, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
    byrows, libname = fixedlibname)
  @eval ccall(("cutest_ugreh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    $(status), $(n), $(x), $(g), $(ne), $(le), $(iprnhi), $(iprhi), $(lirnhi),
    $(irnhi), $(lhi), $(hi), $(byrows))
end

function uhprod (status, n, goth, x, p, q, libname = fixedlibname)
  @eval ccall(("cutest_uhprod_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}),
    $(status), $(n), $(goth), $(x), $(p), $(q))
end

function cfn (status, n, m, x, f, c, libname = fixedlibname)
  @eval ccall(("cutest_cfn_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}),
    $(status), $(n), $(m), $(x), $(f), $(c))
end

function cofg (status, n, x, f, g, grad, libname = fixedlibname)
  @eval ccall(("cutest_cofg_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}),
    $(status), $(n), $(x), $(f), $(g), $(grad))
end

function cofsg (status, n, x, f, nnzg, lg, sg, ivsg, grad, libname =
    fixedlibname)
  @eval ccall(("cutest_cofsg_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(x), $(f), $(nnzg), $(lg), $(sg), $(ivsg), $(grad))
end

function ccfg (status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad, libname =
    fixedlibname)
  @eval ccall(("cutest_ccfg_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    $(status), $(n), $(m), $(x), $(c), $(jtrans), $(lcjac1), $(lcjac2), $(cjac),
    $(grad))
end

function clfg (status, n, m, x, v, f, g, grad, libname = fixedlibname)
  @eval ccall(("cutest_clfg_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}),
    $(status), $(n), $(m), $(x), $(v), $(f), $(g), $(grad))
end

function cgr (status, n, m, x, v, grlagf, g, jtrans, lcjac1, lcjac2, cjac,
    libname = fixedlibname)
  @eval ccall(("cutest_cgr_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}),
    $(status), $(n), $(m), $(x), $(v), $(grlagf), $(g), $(jtrans), $(lcjac1),
    $(lcjac2), $(cjac))
end

function csgr (status, n, m, x, v, grlagf, nnzj, lcjac, cjac, indvar, indfun,
    libname = fixedlibname)
  @eval ccall(("cutest_csgr_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(m), $(x), $(v), $(grlagf), $(nnzj), $(lcjac), $(cjac),
    $(indvar), $(indfun))
end

function ccfsg (status, n, m, x, c, nnzj, lcjac, cjac, indvar, indfun, grad,
    libname = fixedlibname)
  @eval ccall(("cutest_ccfsg_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(m), $(x), $(c), $(nnzj), $(lcjac), $(cjac), $(indvar),
    $(indfun), $(grad))
end

function ccifg (status, n, i, x, ci, gci, grad, libname = fixedlibname)
  @eval ccall(("cutest_ccifg_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}),
    $(status), $(n), $(i), $(x), $(ci), $(gci), $(grad))
end

function ccifsg (status, n, i, x, ci, nnzsgc, lsgci, sgci, ivsgci, grad, libname
    = fixedlibname)
  @eval ccall(("cutest_ccifsg_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(i), $(x), $(ci), $(nnzsgc), $(lsgci), $(sgci), $(ivsgci),
    $(grad))
end

function cgrdh (status, n, m, x, v, grlagf, g, jtrans, lcjac1, lcjac2, cjac,
    lh1, h, libname = fixedlibname)
  @eval ccall(("cutest_cgrdh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cdouble}),
    $(status), $(n), $(m), $(x), $(v), $(grlagf), $(g), $(jtrans), $(lcjac1),
    $(lcjac2), $(cjac), $(lh1), $(h))
end

function cdh (status, n, m, x, v, lh1, h, libname = fixedlibname)
  @eval ccall(("cutest_cdh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cdouble}),
    $(status), $(n), $(m), $(x), $(v), $(lh1), $(h))
end

function csh (status, n, m, x, v, nnzh, lh, h, irnh, icnh, libname =
    fixedlibname)
  @eval ccall(("cutest_csh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(m), $(x), $(v), $(nnzh), $(lh), $(h), $(irnh), $(icnh))
end

function cshc (status, n, m, x, v, nnzh, lh, h, irnh, icnh, libname =
    fixedlibname)
  @eval ccall(("cutest_cshc_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(m), $(x), $(v), $(nnzh), $(lh), $(h), $(irnh), $(icnh))
end

function ceh (status, n, m, x, lv, v, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi,
    hi, byrows, libname = fixedlibname)
  @eval ccall(("cutest_ceh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}),
    $(status), $(n), $(m), $(x), $(lv), $(v), $(ne), $(le), $(iprnhi), $(iprhi),
    $(lirnhi), $(irnhi), $(lhi), $(hi), $(byrows))
end

function cidh (status, n, x, iprob, lh1, h, libname = fixedlibname)
  @eval ccall(("cutest_cidh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}),
    $(status), $(n), $(x), $(iprob), $(lh1), $(h))
end

function cish (status, n, x, iprob, nnzh, lh, h, irnh, icnh, libname =
    fixedlibname)
  @eval ccall(("cutest_cish_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(x), $(iprob), $(nnzh), $(lh), $(h), $(irnh), $(icnh))
end

function csgrsh (status, n, m, x, v, grlagf, nnzj, lcjac, cjac, indvar, indfun,
    nnzh, lh, h, irnh, icnh, libname = fixedlibname)
  @eval ccall(("cutest_csgrsh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    $(status), $(n), $(m), $(x), $(v), $(grlagf), $(nnzj), $(lcjac), $(cjac),
    $(indvar), $(indfun), $(nnzh), $(lh), $(h), $(irnh), $(icnh))
end

function csgreh (status, n, m, x, v, grlagf, nnzj, lcjac, cjac, indvar, indfun,
    ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows, libname = fixedlibname)
  @eval ccall(("cutest_csgreh_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    $(status), $(n), $(m), $(x), $(v), $(grlagf), $(nnzj), $(lcjac), $(cjac),
    $(indvar), $(indfun), $(ne), $(le), $(iprnhi), $(iprhi), $(lirnhi), $(irnhi),
    $(lhi), $(hi), $(byrows))
end

function chprod (status, n, m, goth, x, v, p, q, libname = fixedlibname)
  @eval ccall(("cutest_chprod_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}),
    $(status), $(n), $(m), $(goth), $(x), $(v), $(p), $(q))
end

function chcprod (status, n, m, goth, x, v, p, q, libname = fixedlibname)
  @eval ccall(("cutest_chcprod_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}),
    $(status), $(n), $(m), $(goth), $(x), $(v), $(p), $(q))
end

function cjprod (status, n, m, gotj, jtrans, x, p, lp, r, lr, libname =
    fixedlibname)
  @eval ccall(("cutest_cjprod_", $(libname)), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    $(status), $(n), $(m), $(gotj), $(jtrans), $(x), $(p), $(lp), $(r), $(lr))
end

function uterminate (status, libname = fixedlibname)
  @eval ccall(("cutest_uterminate_", $(libname)), Void,
    (Ptr{Cint},),
    $(status))
end

function cterminate (status, libname = fixedlibname)
  @eval ccall(("cutest_cterminate_", $(libname)), Void,
    (Ptr{Cint},),
    $(status))
end

