#! format: off
function CUTEst_malloc(object, length, s)
  @ccall cutest_lib_path.CUTEst_malloc(object::Ptr{Cvoid}, length::Cint, s::Csize_t)::Ptr{Cvoid}
end

function CUTEst_calloc(object, length, s)
  @ccall cutest_lib_path.CUTEst_calloc(object::Ptr{Cvoid}, length::Cint, s::Csize_t)::Ptr{Cvoid}
end

function CUTEst_realloc(object, length, s)
  @ccall cutest_lib_path.CUTEst_realloc(object::Ptr{Cvoid}, length::Cint, s::Csize_t)::Ptr{Cvoid}
end

function CUTEst_free(object)
  @ccall cutest_lib_path.CUTEst_free(object::Ptr{Ptr{Cvoid}})::Cvoid
end

struct VarTypes
  nbnds::Cint
  neq::Cint
  nlin::Cint
  nrange::Cint
  nlower::Cint
  nupper::Cint
  nineq::Cint
  nineq_lin::Cint
  nineq_nlin::Cint
  neq_lin::Cint
  neq_nlin::Cint
end

function cutest_usetup_(status, funit, iout, io_buffer, n, x, bl, bu)
  @ccall cutest_lib_path.cutest_usetup_(status::Ptr{integer}, funit::Ptr{integer},
                                        iout::Ptr{integer}, io_buffer::Ptr{integer},
                                        n::Ptr{integer}, x::Ptr{doublereal}, bl::Ptr{doublereal},
                                        bu::Ptr{doublereal})::Cvoid
end

function cutest_cint_csetup_(status, funit, iout, io_buffer, n, m, x, bl, bu, v, cl, cu, equatn,
                             linear, e_order, l_order, v_order)
  @ccall cutest_lib_path.cutest_cint_csetup_(status::Ptr{integer}, funit::Ptr{integer},
                                             iout::Ptr{integer}, io_buffer::Ptr{integer},
                                             n::Ptr{integer}, m::Ptr{integer}, x::Ptr{doublereal},
                                             bl::Ptr{doublereal}, bu::Ptr{doublereal},
                                             v::Ptr{doublereal}, cl::Ptr{doublereal},
                                             cu::Ptr{doublereal}, equatn::Ptr{logical},
                                             linear::Ptr{logical}, e_order::Ptr{integer},
                                             l_order::Ptr{integer}, v_order::Ptr{integer})::Cvoid
end

function cutest_udimen_(status, funit, n)
  @ccall cutest_lib_path.cutest_udimen_(status::Ptr{integer}, funit::Ptr{integer},
                                        n::Ptr{integer})::Cvoid
end

function cutest_udimsh_(status, nnzh)
  @ccall cutest_lib_path.cutest_udimsh_(status::Ptr{integer}, nnzh::Ptr{integer})::Cvoid
end

function cutest_udimse_(status, ne, nzh, nzirnh)
  @ccall cutest_lib_path.cutest_udimse_(status::Ptr{integer}, ne::Ptr{integer}, nzh::Ptr{integer},
                                        nzirnh::Ptr{integer})::Cvoid
end

function cutest_uvartype_(status, n, ivarty)
  @ccall cutest_lib_path.cutest_uvartype_(status::Ptr{integer}, n::Ptr{integer},
                                          ivarty::Ptr{integer})::Cvoid
end

function cutest_unames_(status, n, pname, vnames)
  @ccall cutest_lib_path.cutest_unames_(status::Ptr{integer}, n::Ptr{integer}, pname::Ptr{Cchar},
                                        vnames::Ptr{Cchar})::Cvoid
end

function cutest_ureport_(status, calls, time)
  @ccall cutest_lib_path.cutest_ureport_(status::Ptr{integer}, calls::Ptr{doublereal},
                                         time::Ptr{doublereal})::Cvoid
end

function cutest_cdimen_(status, funit, n, m)
  @ccall cutest_lib_path.cutest_cdimen_(status::Ptr{integer}, funit::Ptr{integer}, n::Ptr{integer},
                                        m::Ptr{integer})::Cvoid
end

function cutest_cint_cnoobj_(status, funit, noobj)
  @ccall cutest_lib_path.cutest_cint_cnoobj_(status::Ptr{integer}, funit::Ptr{integer},
                                             noobj::Ptr{logical})::Cvoid
end

function cutest_cdimsg_(status, nnzg)
  @ccall cutest_lib_path.cutest_cdimsg_(status::Ptr{integer}, nnzg::Ptr{integer})::Cvoid
end

function cutest_cdimsj_(status, nnzj)
  @ccall cutest_lib_path.cutest_cdimsj_(status::Ptr{integer}, nnzj::Ptr{integer})::Cvoid
end

function cutest_cdimsh_(status, nnzh)
  @ccall cutest_lib_path.cutest_cdimsh_(status::Ptr{integer}, nnzh::Ptr{integer})::Cvoid
end

function CUTEST_cdimcop(status, nnzohp)
  @ccall cutest_lib_path.CUTEST_cdimcop(status::Ptr{integer}, nnzohp::Ptr{integer})::Cvoid
end

function cutest_cdimohp_(status, nnzohp)
  @ccall cutest_lib_path.cutest_cdimohp_(status::Ptr{integer}, nnzohp::Ptr{integer})::Cvoid
end

function cutest_cdimchp_(status, nnzchp)
  @ccall cutest_lib_path.cutest_cdimchp_(status::Ptr{integer}, nnzchp::Ptr{integer})::Cvoid
end

function cutest_cdimse_(status, ne, nzh, nzirnh)
  @ccall cutest_lib_path.cutest_cdimse_(status::Ptr{integer}, ne::Ptr{integer}, nzh::Ptr{integer},
                                        nzirnh::Ptr{integer})::Cvoid
end

function cutest_cstats_(status, nonlinear_variables_objective, nonlinear_variables_constraints,
                        equality_constraints, linear_constraints)
  @ccall cutest_lib_path.cutest_cstats_(status::Ptr{integer},
                                        nonlinear_variables_objective::Ptr{integer},
                                        nonlinear_variables_constraints::Ptr{integer},
                                        equality_constraints::Ptr{integer},
                                        linear_constraints::Ptr{integer})::Cvoid
end

function cutest_cvartype_(status, n, ivarty)
  @ccall cutest_lib_path.cutest_cvartype_(status::Ptr{integer}, n::Ptr{integer},
                                          ivarty::Ptr{integer})::Cvoid
end

function cutest_cnames_(status, n, m, pname, vnames, gnames)
  @ccall cutest_lib_path.cutest_cnames_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                        pname::Ptr{Cchar}, vnames::Ptr{Cchar},
                                        gnames::Ptr{Cchar})::Cvoid
end

function cutest_creport_(status, calls, time)
  @ccall cutest_lib_path.cutest_creport_(status::Ptr{integer}, calls::Ptr{doublereal},
                                         time::Ptr{doublereal})::Cvoid
end

function cutest_connames_(status, m, gname)
  @ccall cutest_lib_path.cutest_connames_(status::Ptr{integer}, m::Ptr{integer},
                                          gname::Ptr{Cchar})::Cvoid
end

function cutest_pname_(status, funit, pname)
  @ccall cutest_lib_path.cutest_pname_(status::Ptr{integer}, funit::Ptr{integer},
                                       pname::Ptr{Cchar})::Cvoid
end

function cutest_probname_(status, pname)
  @ccall cutest_lib_path.cutest_probname_(status::Ptr{integer}, pname::Ptr{Cchar})::Cvoid
end

function cutest_varnames_(status, n, vname)
  @ccall cutest_lib_path.cutest_varnames_(status::Ptr{integer}, n::Ptr{integer},
                                          vname::Ptr{Cchar})::Cvoid
end

function cutest_ufn_(status, n, x, f)
  @ccall cutest_lib_path.cutest_ufn_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{doublereal},
                                     f::Ptr{doublereal})::Cvoid
end

function cutest_ugr_(status, n, x, g)
  @ccall cutest_lib_path.cutest_ugr_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{doublereal},
                                     g::Ptr{doublereal})::Cvoid
end

function cutest_cint_uofg_(status, n, x, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_uofg_(status::Ptr{integer}, n::Ptr{integer},
                                           x::Ptr{doublereal}, f::Ptr{doublereal},
                                           g::Ptr{doublereal}, grad::Ptr{logical})::Cvoid
end

function cutest_udh_(status, n, x, lh1, h)
  @ccall cutest_lib_path.cutest_udh_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{doublereal},
                                     lh1::Ptr{integer}, h::Ptr{doublereal})::Cvoid
end

function cutest_ushp_(status, n, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_ushp_(status::Ptr{integer}, n::Ptr{integer}, nnzh::Ptr{integer},
                                      lh::Ptr{integer}, irnh::Ptr{integer},
                                      icnh::Ptr{integer})::Cvoid
end

function cutest_ush_(status, n, x, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_ush_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{doublereal},
                                     nnzh::Ptr{integer}, lh::Ptr{integer}, h::Ptr{doublereal},
                                     irnh::Ptr{integer}, icnh::Ptr{integer})::Cvoid
end

function cutest_cint_ueh_(status, n, x, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_ueh_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{doublereal},
                                          ne::Ptr{integer}, le::Ptr{integer}, iprnhi::Ptr{integer},
                                          iprhi::Ptr{integer}, lirnhi::Ptr{integer},
                                          irnhi::Ptr{integer}, lhi::Ptr{integer},
                                          hi::Ptr{doublereal}, byrows::Ptr{logical})::Cvoid
end

function cutest_ugrdh_(status, n, x, g, lh1, h)
  @ccall cutest_lib_path.cutest_ugrdh_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{doublereal},
                                       g::Ptr{doublereal}, lh1::Ptr{integer},
                                       h::Ptr{doublereal})::Cvoid
end

function cutest_ugrsh_(status, n, x, g, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_ugrsh_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{doublereal},
                                       g::Ptr{doublereal}, nnzh::Ptr{integer}, lh::Ptr{integer},
                                       h::Ptr{doublereal}, irnh::Ptr{integer},
                                       icnh::Ptr{integer})::Cvoid
end

function cutest_cint_ugreh_(status, n, x, g, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_ugreh_(status::Ptr{integer}, n::Ptr{integer},
                                            x::Ptr{doublereal}, g::Ptr{doublereal},
                                            ne::Ptr{integer}, le::Ptr{integer},
                                            iprnhi::Ptr{integer}, iprhi::Ptr{integer},
                                            lirnhi::Ptr{integer}, irnhi::Ptr{integer},
                                            lhi::Ptr{integer}, hi::Ptr{doublereal},
                                            byrows::Ptr{logical})::Cvoid
end

function cutest_cint_uhprod_(status, n, goth, x, p, r)
  @ccall cutest_lib_path.cutest_cint_uhprod_(status::Ptr{integer}, n::Ptr{integer},
                                             goth::Ptr{logical}, x::Ptr{doublereal},
                                             p::Ptr{doublereal}, r::Ptr{doublereal})::Cvoid
end

function cutest_cint_ushprod_(status, n, goth, x, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_ushprod_(status::Ptr{integer}, n::Ptr{integer},
                                              goth::Ptr{logical}, x::Ptr{doublereal},
                                              nnzp::Ptr{integer}, indp::Ptr{integer},
                                              p::Ptr{doublereal}, nnzr::Ptr{integer},
                                              indr::Ptr{integer}, r::Ptr{doublereal})::Cvoid
end

function cutest_ubandh_(status, n, x, nsemib, bandh, lbandh, maxsbw)
  @ccall cutest_lib_path.cutest_ubandh_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{doublereal},
                                        nsemib::Ptr{integer}, bandh::Ptr{doublereal},
                                        lbandh::Ptr{integer}, maxsbw::Ptr{integer})::Cvoid
end

function cutest_cfn_(status, n, m, x, f, c)
  @ccall cutest_lib_path.cutest_cfn_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                     x::Ptr{doublereal}, f::Ptr{doublereal},
                                     c::Ptr{doublereal})::Cvoid
end

function CUTEST_cconst(status, m, c)
  @ccall cutest_lib_path.CUTEST_cconst(status::Ptr{integer}, m::Ptr{integer},
                                       c::Ptr{doublereal})::Cvoid
end

function cutest_cint_cofg_(status, n, x, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_cofg_(status::Ptr{integer}, n::Ptr{integer},
                                           x::Ptr{doublereal}, f::Ptr{doublereal},
                                           g::Ptr{doublereal}, grad::Ptr{logical})::Cvoid
end

function cutest_cint_cofsg_(status, n, x, f, nnzg, lg, sg, ivsg, grad)
  @ccall cutest_lib_path.cutest_cint_cofsg_(status::Ptr{integer}, n::Ptr{integer},
                                            x::Ptr{doublereal}, f::Ptr{doublereal},
                                            nnzg::Ptr{integer}, lg::Ptr{integer},
                                            sg::Ptr{doublereal}, ivsg::Ptr{integer},
                                            grad::Ptr{logical})::Cvoid
end

function cutest_cint_ccfg_(status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
  @ccall cutest_lib_path.cutest_cint_ccfg_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                           x::Ptr{doublereal}, c::Ptr{doublereal},
                                           jtrans::Ptr{logical}, lcjac1::Ptr{integer},
                                           lcjac2::Ptr{integer}, cjac::Ptr{doublereal},
                                           grad::Ptr{logical})::Cvoid
end

function cutest_cint_clfg_(status, n, m, x, y, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_clfg_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                           x::Ptr{doublereal}, y::Ptr{doublereal},
                                           f::Ptr{doublereal}, g::Ptr{doublereal},
                                           grad::Ptr{logical})::Cvoid
end

function cutest_cint_cgr_(status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac)
  @ccall cutest_lib_path.cutest_cint_cgr_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                          x::Ptr{doublereal}, y::Ptr{doublereal},
                                          grlagf::Ptr{logical}, g::Ptr{doublereal},
                                          jtrans::Ptr{logical}, lcjac1::Ptr{integer},
                                          lcjac2::Ptr{integer}, cjac::Ptr{doublereal})::Cvoid
end

function cutest_cint_csgr_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun)
  @ccall cutest_lib_path.cutest_cint_csgr_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                           x::Ptr{doublereal}, y::Ptr{doublereal},
                                           grlagf::Ptr{logical}, nnzj::Ptr{integer},
                                           lcjac::Ptr{integer}, cjac::Ptr{doublereal},
                                           indvar::Ptr{integer}, indfun::Ptr{integer})::Cvoid
end

function cutest_cint_csgrp_(status, n, nnzj, lj, jvar, jcon)
  @ccall cutest_lib_path.cutest_cint_csgrp_(status::Ptr{integer}, n::Ptr{integer},
                                            nnzj::Ptr{integer}, lj::Ptr{integer},
                                            jvar::Ptr{integer}, jcon::Ptr{integer})::Cvoid
end

function cutest_cint_csjp_(status, nnzj, lj, jvar, jcon)
  @ccall cutest_lib_path.cutest_cint_csjp_(status::Ptr{integer}, nnzj::Ptr{integer},
                                           lj::Ptr{integer}, jvar::Ptr{integer},
                                           jcon::Ptr{integer})::Cvoid
end

function cutest_cint_ccfsg_(status, n, m, x, c, nnzj, lcjac, cjac, indvar, indfun, grad)
  @ccall cutest_lib_path.cutest_cint_ccfsg_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                            x::Ptr{doublereal}, c::Ptr{doublereal},
                                            nnzj::Ptr{integer}, lcjac::Ptr{integer},
                                            cjac::Ptr{doublereal}, indvar::Ptr{integer},
                                            indfun::Ptr{integer}, grad::Ptr{logical})::Cvoid
end

function cutest_cint_ccifg_(status, n, icon, x, ci, gci, grad)
  @ccall cutest_lib_path.cutest_cint_ccifg_(status::Ptr{integer}, n::Ptr{integer},
                                            icon::Ptr{integer}, x::Ptr{doublereal},
                                            ci::Ptr{doublereal}, gci::Ptr{doublereal},
                                            grad::Ptr{logical})::Cvoid
end

function cutest_cint_ccifsg_(status, n, con, x, ci, nnzsgc, lsgci, sgci, ivsgci, grad)
  @ccall cutest_lib_path.cutest_cint_ccifsg_(status::Ptr{integer}, n::Ptr{integer},
                                             con::Ptr{integer}, x::Ptr{doublereal},
                                             ci::Ptr{doublereal}, nnzsgc::Ptr{integer},
                                             lsgci::Ptr{integer}, sgci::Ptr{doublereal},
                                             ivsgci::Ptr{integer}, grad::Ptr{logical})::Cvoid
end

function cutest_cint_cgrdh_(status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac, lh1, h)
  @ccall cutest_lib_path.cutest_cint_cgrdh_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                            x::Ptr{doublereal}, y::Ptr{doublereal},
                                            grlagf::Ptr{logical}, g::Ptr{doublereal},
                                            jtrans::Ptr{logical}, lcjac1::Ptr{integer},
                                            lcjac2::Ptr{integer}, cjac::Ptr{doublereal},
                                            lh1::Ptr{integer}, h::Ptr{doublereal})::Cvoid
end

function cutest_cdh_(status, n, m, x, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdh_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                     x::Ptr{doublereal}, y::Ptr{doublereal}, lh1::Ptr{integer},
                                     h::Ptr{doublereal})::Cvoid
end

function cutest_cdhc_(status, n, m, x, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdhc_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                      x::Ptr{doublereal}, y::Ptr{doublereal}, lh1::Ptr{integer},
                                      h::Ptr{doublereal})::Cvoid
end

function cutest_cdhj_(status, n, m, x, y0, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdhj_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                      x::Ptr{doublereal}, y0::Ptr{doublereal}, y::Ptr{doublereal},
                                      lh1::Ptr{integer}, h::Ptr{doublereal})::Cvoid
end

function cutest_cshp_(status, n, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshp_(status::Ptr{integer}, n::Ptr{integer}, nnzh::Ptr{integer},
                                      lh::Ptr{integer}, irnh::Ptr{integer},
                                      icnh::Ptr{integer})::Cvoid
end

function cutest_csh_(status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_csh_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                     x::Ptr{doublereal}, y::Ptr{doublereal}, nnzh::Ptr{integer},
                                     lh::Ptr{integer}, h::Ptr{doublereal}, irnh::Ptr{integer},
                                     icnh::Ptr{integer})::Cvoid
end

function cutest_cshc_(status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshc_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                      x::Ptr{doublereal}, y::Ptr{doublereal}, nnzh::Ptr{integer},
                                      lh::Ptr{integer}, h::Ptr{doublereal}, irnh::Ptr{integer},
                                      icnh::Ptr{integer})::Cvoid
end

function cutest_cshj_(status, n, m, x, y0, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshj_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                      x::Ptr{doublereal}, y0::Ptr{doublereal}, y::Ptr{doublereal},
                                      nnzh::Ptr{integer}, lh::Ptr{integer}, h::Ptr{doublereal},
                                      irnh::Ptr{integer}, icnh::Ptr{integer})::Cvoid
end

function cutest_cint_ceh_(status, n, m, x, y, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_ceh_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                          x::Ptr{doublereal}, y::Ptr{doublereal}, ne::Ptr{integer},
                                          le::Ptr{integer}, iprnhi::Ptr{integer},
                                          iprhi::Ptr{integer}, lirnhi::Ptr{integer},
                                          irnhi::Ptr{integer}, lhi::Ptr{integer},
                                          hi::Ptr{doublereal}, byrows::Ptr{logical})::Cvoid
end

function cutest_cifn_(status, n, iprob, x, f)
  @ccall cutest_lib_path.cutest_cifn_(status::Ptr{integer}, n::Ptr{integer}, iprob::Ptr{integer},
                                      x::Ptr{doublereal}, f::Ptr{doublereal})::Cvoid
end

function cutest_cigr_(status, n, iprob, x, g)
  @ccall cutest_lib_path.cutest_cigr_(status::Ptr{integer}, n::Ptr{integer}, iprob::Ptr{integer},
                                      x::Ptr{doublereal}, g::Ptr{doublereal})::Cvoid
end

function cutest_cisgr_(status, n, iprob, x, nnzg, lg, sg, ivsg)
  @ccall cutest_lib_path.cutest_cisgr_(status::Ptr{integer}, n::Ptr{integer}, iprob::Ptr{integer},
                                       x::Ptr{doublereal}, nnzg::Ptr{integer}, lg::Ptr{integer},
                                       sg::Ptr{doublereal}, ivsg::Ptr{integer})::Cvoid
end

function cutest_cisgrp_(status, n, iprob, nnzg, lg, ivsg)
  @ccall cutest_lib_path.cutest_cisgrp_(status::Ptr{integer}, n::Ptr{integer}, iprob::Ptr{integer},
                                        nnzg::Ptr{integer}, lg::Ptr{integer},
                                        ivsg::Ptr{integer})::Cvoid
end

function cutest_cidh_(status, n, x, iprob, lh1, h)
  @ccall cutest_lib_path.cutest_cidh_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{doublereal},
                                      iprob::Ptr{integer}, lh1::Ptr{integer},
                                      h::Ptr{doublereal})::Cvoid
end

function cutest_cish_(status, n, x, iprob, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cish_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{doublereal},
                                      iprob::Ptr{integer}, nnzh::Ptr{integer}, lh::Ptr{integer},
                                      h::Ptr{doublereal}, irnh::Ptr{integer},
                                      icnh::Ptr{integer})::Cvoid
end

function cutest_cint_csgrsh_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun, nnzh,
                             lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cint_csgrsh_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                             x::Ptr{doublereal}, y::Ptr{doublereal},
                                             grlagf::Ptr{logical}, nnzj::Ptr{integer},
                                             lcjac::Ptr{integer}, cjac::Ptr{doublereal},
                                             indvar::Ptr{integer}, indfun::Ptr{integer},
                                             nnzh::Ptr{integer}, lh::Ptr{integer},
                                             h::Ptr{doublereal}, irnh::Ptr{integer},
                                             icnh::Ptr{integer})::Cvoid
end

function cutest_cint_csgrshp_(status, n, nnzj, lcjac, indvar, indfun, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_cint_csgrshp_(status::Ptr{integer}, n::Ptr{integer},
                                              nnzj::Ptr{integer}, lcjac::Ptr{integer},
                                              indvar::Ptr{integer}, indfun::Ptr{integer},
                                              nnzh::Ptr{integer}, lh::Ptr{integer},
                                              irnh::Ptr{integer}, icnh::Ptr{integer})::Cvoid
end

function cutest_cint_csgreh_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun, ne, le,
                             iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_csgreh_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                             x::Ptr{doublereal}, y::Ptr{doublereal},
                                             grlagf::Ptr{logical}, nnzj::Ptr{integer},
                                             lcjac::Ptr{integer}, cjac::Ptr{doublereal},
                                             indvar::Ptr{integer}, indfun::Ptr{integer},
                                             ne::Ptr{integer}, le::Ptr{integer},
                                             iprnhi::Ptr{integer}, iprhi::Ptr{integer},
                                             lirnhi::Ptr{integer}, irnhi::Ptr{integer},
                                             lhi::Ptr{integer}, hi::Ptr{doublereal},
                                             byrows::Ptr{logical})::Cvoid
end

function cutest_cint_chprod_(status, n, m, goth, x, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chprod_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                             goth::Ptr{logical}, x::Ptr{doublereal},
                                             y::Ptr{doublereal}, p::Ptr{doublereal},
                                             q::Ptr{doublereal})::Cvoid
end

function cutest_cint_chsprod_(status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_chsprod_(status::Ptr{integer}, n::Ptr{integer},
                                              m::Ptr{integer}, goth::Ptr{logical},
                                              x::Ptr{doublereal}, y::Ptr{doublereal},
                                              nnzp::Ptr{integer}, indp::Ptr{integer},
                                              p::Ptr{doublereal}, nnzr::Ptr{integer},
                                              indr::Ptr{integer}, r::Ptr{doublereal})::Cvoid
end

function cutest_cint_chcprod_(status, n, m, goth, x, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chcprod_(status::Ptr{integer}, n::Ptr{integer},
                                              m::Ptr{integer}, goth::Ptr{logical},
                                              x::Ptr{doublereal}, y::Ptr{doublereal},
                                              p::Ptr{doublereal}, q::Ptr{doublereal})::Cvoid
end

function cutest_cint_cshcprod_(status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_cshcprod_(status::Ptr{integer}, n::Ptr{integer},
                                               m::Ptr{integer}, goth::Ptr{logical},
                                               x::Ptr{doublereal}, y::Ptr{doublereal},
                                               nnzp::Ptr{integer}, indp::Ptr{integer},
                                               p::Ptr{doublereal}, nnzr::Ptr{integer},
                                               indr::Ptr{integer}, r::Ptr{doublereal})::Cvoid
end

function cutest_cint_chjprod_(status, n, m, goth, x, y0, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chjprod_(status::Ptr{integer}, n::Ptr{integer},
                                              m::Ptr{integer}, goth::Ptr{logical},
                                              x::Ptr{doublereal}, y0::Ptr{doublereal},
                                              y::Ptr{doublereal}, p::Ptr{doublereal},
                                              q::Ptr{doublereal})::Cvoid
end

function cutest_cint_cjprod_(status, n, m, gotj, jtrans, x, p, lp, r, lr)
  @ccall cutest_lib_path.cutest_cint_cjprod_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                             gotj::Ptr{logical}, jtrans::Ptr{logical},
                                             x::Ptr{doublereal}, p::Ptr{doublereal},
                                             lp::Ptr{integer}, r::Ptr{doublereal},
                                             lr::Ptr{integer})::Cvoid
end

function cutest_cint_csjprod_(status, n, m, gotj, jtrans, x, nnzp, indp, p, lp, nnzr, indr, r, lr)
  @ccall cutest_lib_path.cutest_cint_csjprod_(status::Ptr{integer}, n::Ptr{integer},
                                              m::Ptr{integer}, gotj::Ptr{logical},
                                              jtrans::Ptr{logical}, x::Ptr{doublereal},
                                              nnzp::Ptr{integer}, indp::Ptr{integer},
                                              p::Ptr{doublereal}, lp::Ptr{integer},
                                              nnzr::Ptr{integer}, indr::Ptr{integer},
                                              r::Ptr{doublereal}, lr::Ptr{integer})::Cvoid
end

function cutest_cint_cchprods_(status, n, m, goth, x, p, lchp, chpval, chpind, chpptr)
  @ccall cutest_lib_path.cutest_cint_cchprods_(status::Ptr{integer}, n::Ptr{integer},
                                               m::Ptr{integer}, goth::Ptr{logical},
                                               x::Ptr{doublereal}, p::Ptr{doublereal},
                                               lchp::Ptr{integer}, chpval::Ptr{doublereal},
                                               chpind::Ptr{integer}, chpptr::Ptr{integer})::Cvoid
end

function cutest_cint_cchprodsp_(status, m, lchp, chpind, chpptr)
  @ccall cutest_lib_path.cutest_cint_cchprodsp_(status::Ptr{integer}, m::Ptr{integer},
                                                lchp::Ptr{integer}, chpind::Ptr{integer},
                                                chpptr::Ptr{integer})::Cvoid
end

function cutest_cint_cohprods_(status, n, goth, x, p, nnzohp, lohp, ohpval, ohpind)
  @ccall cutest_lib_path.cutest_cint_cohprods_(status::Ptr{integer}, n::Ptr{integer},
                                               goth::Ptr{logical}, x::Ptr{doublereal},
                                               p::Ptr{doublereal}, nnzohp::Ptr{integer},
                                               lohp::Ptr{integer}, ohpval::Ptr{doublereal},
                                               ohpind::Ptr{integer})::Cvoid
end

function cutest_cohprodsp_(status, nnzohp, lohp, chpind)
  @ccall cutest_lib_path.cutest_cohprodsp_(status::Ptr{integer}, nnzohp::Ptr{integer},
                                           lohp::Ptr{integer}, chpind::Ptr{integer})::Cvoid
end

function cutest_uterminate_(status)
  @ccall cutest_lib_path.cutest_uterminate_(status::Ptr{integer})::Cvoid
end

function cutest_cterminate_(status)
  @ccall cutest_lib_path.cutest_cterminate_(status::Ptr{integer})::Cvoid
end

function cutest_usetup_s_(status, funit, iout, io_buffer, n, x, bl, bu)
  @ccall cutest_lib_path.cutest_usetup_s_(status::Ptr{integer}, funit::Ptr{integer},
                                          iout::Ptr{integer}, io_buffer::Ptr{integer},
                                          n::Ptr{integer}, x::Ptr{real}, bl::Ptr{real},
                                          bu::Ptr{real})::Cvoid
end

function cutest_cint_csetup_s_(status, funit, iout, io_buffer, n, m, x, bl, bu, v, cl, cu, equatn,
                               linear, e_order, l_order, v_order)
  @ccall cutest_lib_path.cutest_cint_csetup_s_(status::Ptr{integer}, funit::Ptr{integer},
                                               iout::Ptr{integer}, io_buffer::Ptr{integer},
                                               n::Ptr{integer}, m::Ptr{integer}, x::Ptr{real},
                                               bl::Ptr{real}, bu::Ptr{real}, v::Ptr{real},
                                               cl::Ptr{real}, cu::Ptr{real}, equatn::Ptr{logical},
                                               linear::Ptr{logical}, e_order::Ptr{integer},
                                               l_order::Ptr{integer}, v_order::Ptr{integer})::Cvoid
end

function cutest_udimen_s_(status, funit, n)
  @ccall cutest_lib_path.cutest_udimen_s_(status::Ptr{integer}, funit::Ptr{integer},
                                          n::Ptr{integer})::Cvoid
end

function cutest_udimsh_s_(status, nnzh)
  @ccall cutest_lib_path.cutest_udimsh_s_(status::Ptr{integer}, nnzh::Ptr{integer})::Cvoid
end

function cutest_udimse_s_(status, ne, nzh, nzirnh)
  @ccall cutest_lib_path.cutest_udimse_s_(status::Ptr{integer}, ne::Ptr{integer}, nzh::Ptr{integer},
                                          nzirnh::Ptr{integer})::Cvoid
end

function cutest_uvartype_s_(status, n, ivarty)
  @ccall cutest_lib_path.cutest_uvartype_s_(status::Ptr{integer}, n::Ptr{integer},
                                            ivarty::Ptr{integer})::Cvoid
end

function cutest_unames_s_(status, n, pname, vnames)
  @ccall cutest_lib_path.cutest_unames_s_(status::Ptr{integer}, n::Ptr{integer}, pname::Ptr{Cchar},
                                          vnames::Ptr{Cchar})::Cvoid
end

function cutest_ureport_s_(status, calls, time)
  @ccall cutest_lib_path.cutest_ureport_s_(status::Ptr{integer}, calls::Ptr{real},
                                           time::Ptr{real})::Cvoid
end

function cutest_cdimen_s_(status, funit, n, m)
  @ccall cutest_lib_path.cutest_cdimen_s_(status::Ptr{integer}, funit::Ptr{integer},
                                          n::Ptr{integer}, m::Ptr{integer})::Cvoid
end

function cutest_cint_cnoobj_s_(status, funit, noobj)
  @ccall cutest_lib_path.cutest_cint_cnoobj_s_(status::Ptr{integer}, funit::Ptr{integer},
                                               noobj::Ptr{logical})::Cvoid
end

function cutest_cdimsg_s_(status, nnzg)
  @ccall cutest_lib_path.cutest_cdimsg_s_(status::Ptr{integer}, nnzg::Ptr{integer})::Cvoid
end

function cutest_cdimsj_s_(status, nnzj)
  @ccall cutest_lib_path.cutest_cdimsj_s_(status::Ptr{integer}, nnzj::Ptr{integer})::Cvoid
end

function cutest_cdimsh_s_(status, nnzh)
  @ccall cutest_lib_path.cutest_cdimsh_s_(status::Ptr{integer}, nnzh::Ptr{integer})::Cvoid
end

function CUTEST_cdimcop_s(status, nnzohp)
  @ccall cutest_lib_path.CUTEST_cdimcop_s(status::Ptr{integer}, nnzohp::Ptr{integer})::Cvoid
end

function cutest_cdimohp_s_(status, nnzohp)
  @ccall cutest_lib_path.cutest_cdimohp_s_(status::Ptr{integer}, nnzohp::Ptr{integer})::Cvoid
end

function cutest_cdimchp_s_(status, nnzchp)
  @ccall cutest_lib_path.cutest_cdimchp_s_(status::Ptr{integer}, nnzchp::Ptr{integer})::Cvoid
end

function cutest_cdimse_s_(status, ne, nzh, nzirnh)
  @ccall cutest_lib_path.cutest_cdimse_s_(status::Ptr{integer}, ne::Ptr{integer}, nzh::Ptr{integer},
                                          nzirnh::Ptr{integer})::Cvoid
end

function cutest_cstats_s_(status, nonlinear_variables_objective, nonlinear_variables_constraints,
                          equality_constraints, linear_constraints)
  @ccall cutest_lib_path.cutest_cstats_s_(status::Ptr{integer},
                                          nonlinear_variables_objective::Ptr{integer},
                                          nonlinear_variables_constraints::Ptr{integer},
                                          equality_constraints::Ptr{integer},
                                          linear_constraints::Ptr{integer})::Cvoid
end

function cutest_cvartype_s_(status, n, ivarty)
  @ccall cutest_lib_path.cutest_cvartype_s_(status::Ptr{integer}, n::Ptr{integer},
                                            ivarty::Ptr{integer})::Cvoid
end

function cutest_cnames_s_(status, n, m, pname, vnames, gnames)
  @ccall cutest_lib_path.cutest_cnames_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                          pname::Ptr{Cchar}, vnames::Ptr{Cchar},
                                          gnames::Ptr{Cchar})::Cvoid
end

function cutest_creport_s_(status, calls, time)
  @ccall cutest_lib_path.cutest_creport_s_(status::Ptr{integer}, calls::Ptr{real},
                                           time::Ptr{real})::Cvoid
end

function cutest_connames_s_(status, m, gname)
  @ccall cutest_lib_path.cutest_connames_s_(status::Ptr{integer}, m::Ptr{integer},
                                            gname::Ptr{Cchar})::Cvoid
end

function cutest_pname_s_(status, funit, pname)
  @ccall cutest_lib_path.cutest_pname_s_(status::Ptr{integer}, funit::Ptr{integer},
                                         pname::Ptr{Cchar})::Cvoid
end

function cutest_probname_s_(status, pname)
  @ccall cutest_lib_path.cutest_probname_s_(status::Ptr{integer}, pname::Ptr{Cchar})::Cvoid
end

function cutest_varnames_s_(status, n, vname)
  @ccall cutest_lib_path.cutest_varnames_s_(status::Ptr{integer}, n::Ptr{integer},
                                            vname::Ptr{Cchar})::Cvoid
end

function cutest_ufn_s_(status, n, x, f)
  @ccall cutest_lib_path.cutest_ufn_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                       f::Ptr{real})::Cvoid
end

function cutest_ugr_s_(status, n, x, g)
  @ccall cutest_lib_path.cutest_ugr_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                       g::Ptr{real})::Cvoid
end

function cutest_cint_uofg_s_(status, n, x, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_uofg_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                             f::Ptr{real}, g::Ptr{real}, grad::Ptr{logical})::Cvoid
end

function cutest_udh_s_(status, n, x, lh1, h)
  @ccall cutest_lib_path.cutest_udh_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                       lh1::Ptr{integer}, h::Ptr{real})::Cvoid
end

function cutest_ushp_s_(status, n, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_ushp_s_(status::Ptr{integer}, n::Ptr{integer}, nnzh::Ptr{integer},
                                        lh::Ptr{integer}, irnh::Ptr{integer},
                                        icnh::Ptr{integer})::Cvoid
end

function cutest_ush_s_(status, n, x, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_ush_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                       nnzh::Ptr{integer}, lh::Ptr{integer}, h::Ptr{real},
                                       irnh::Ptr{integer}, icnh::Ptr{integer})::Cvoid
end

function cutest_cint_ueh_s_(status, n, x, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_ueh_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                            ne::Ptr{integer}, le::Ptr{integer},
                                            iprnhi::Ptr{integer}, iprhi::Ptr{integer},
                                            lirnhi::Ptr{integer}, irnhi::Ptr{integer},
                                            lhi::Ptr{integer}, hi::Ptr{real},
                                            byrows::Ptr{logical})::Cvoid
end

function cutest_ugrdh_s_(status, n, x, g, lh1, h)
  @ccall cutest_lib_path.cutest_ugrdh_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                         g::Ptr{real}, lh1::Ptr{integer}, h::Ptr{real})::Cvoid
end

function cutest_ugrsh_s_(status, n, x, g, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_ugrsh_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                         g::Ptr{real}, nnzh::Ptr{integer}, lh::Ptr{integer},
                                         h::Ptr{real}, irnh::Ptr{integer},
                                         icnh::Ptr{integer})::Cvoid
end

function cutest_cint_ugreh_s_(status, n, x, g, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
                              byrows)
  @ccall cutest_lib_path.cutest_cint_ugreh_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                              g::Ptr{real}, ne::Ptr{integer}, le::Ptr{integer},
                                              iprnhi::Ptr{integer}, iprhi::Ptr{integer},
                                              lirnhi::Ptr{integer}, irnhi::Ptr{integer},
                                              lhi::Ptr{integer}, hi::Ptr{real},
                                              byrows::Ptr{logical})::Cvoid
end

function cutest_cint_uhprod_s_(status, n, goth, x, p, r)
  @ccall cutest_lib_path.cutest_cint_uhprod_s_(status::Ptr{integer}, n::Ptr{integer},
                                               goth::Ptr{logical}, x::Ptr{real}, p::Ptr{real},
                                               r::Ptr{real})::Cvoid
end

function cutest_cint_ushprod_s_(status, n, goth, x, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_ushprod_s_(status::Ptr{integer}, n::Ptr{integer},
                                                goth::Ptr{logical}, x::Ptr{real},
                                                nnzp::Ptr{integer}, indp::Ptr{integer},
                                                p::Ptr{real}, nnzr::Ptr{integer},
                                                indr::Ptr{integer}, r::Ptr{real})::Cvoid
end

function cutest_ubandh_s_(status, n, x, nsemib, bandh, lbandh, maxsbw)
  @ccall cutest_lib_path.cutest_ubandh_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                          nsemib::Ptr{integer}, bandh::Ptr{real},
                                          lbandh::Ptr{integer}, maxsbw::Ptr{integer})::Cvoid
end

function cutest_cfn_s_(status, n, m, x, f, c)
  @ccall cutest_lib_path.cutest_cfn_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                       x::Ptr{real}, f::Ptr{real}, c::Ptr{real})::Cvoid
end

function CUTEST_cconst_s(status, m, c)
  @ccall cutest_lib_path.CUTEST_cconst_s(status::Ptr{integer}, m::Ptr{integer}, c::Ptr{real})::Cvoid
end

function cutest_cint_cofg_s_(status, n, x, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_cofg_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                             f::Ptr{real}, g::Ptr{real}, grad::Ptr{logical})::Cvoid
end

function cutest_cint_cofsg_s_(status, n, x, f, nnzg, lg, sg, ivsg, grad)
  @ccall cutest_lib_path.cutest_cint_cofsg_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                              f::Ptr{real}, nnzg::Ptr{integer}, lg::Ptr{integer},
                                              sg::Ptr{real}, ivsg::Ptr{integer},
                                              grad::Ptr{logical})::Cvoid
end

function cutest_cint_ccfg_s_(status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
  @ccall cutest_lib_path.cutest_cint_ccfg_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                             x::Ptr{real}, c::Ptr{real}, jtrans::Ptr{logical},
                                             lcjac1::Ptr{integer}, lcjac2::Ptr{integer},
                                             cjac::Ptr{real}, grad::Ptr{logical})::Cvoid
end

function cutest_cint_clfg_s_(status, n, m, x, y, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_clfg_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                             x::Ptr{real}, y::Ptr{real}, f::Ptr{real}, g::Ptr{real},
                                             grad::Ptr{logical})::Cvoid
end

function cutest_cint_cgr_s_(status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac)
  @ccall cutest_lib_path.cutest_cint_cgr_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                            x::Ptr{real}, y::Ptr{real}, grlagf::Ptr{logical},
                                            g::Ptr{real}, jtrans::Ptr{logical},
                                            lcjac1::Ptr{integer}, lcjac2::Ptr{integer},
                                            cjac::Ptr{real})::Cvoid
end

function cutest_cint_csgr_s_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun)
  @ccall cutest_lib_path.cutest_cint_csgr_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                             x::Ptr{real}, y::Ptr{real}, grlagf::Ptr{logical},
                                             nnzj::Ptr{integer}, lcjac::Ptr{integer},
                                             cjac::Ptr{real}, indvar::Ptr{integer},
                                             indfun::Ptr{integer})::Cvoid
end

function cutest_cint_csgrp_s_(status, n, nnzj, lj, jvar, jcon)
  @ccall cutest_lib_path.cutest_cint_csgrp_s_(status::Ptr{integer}, n::Ptr{integer},
                                              nnzj::Ptr{integer}, lj::Ptr{integer},
                                              jvar::Ptr{integer}, jcon::Ptr{integer})::Cvoid
end

function cutest_cint_csjp_s_(status, nnzj, lj, jvar, jcon)
  @ccall cutest_lib_path.cutest_cint_csjp_s_(status::Ptr{integer}, nnzj::Ptr{integer},
                                             lj::Ptr{integer}, jvar::Ptr{integer},
                                             jcon::Ptr{integer})::Cvoid
end

function cutest_cint_ccfsg_s_(status, n, m, x, c, nnzj, lcjac, cjac, indvar, indfun, grad)
  @ccall cutest_lib_path.cutest_cint_ccfsg_s_(status::Ptr{integer}, n::Ptr{integer},
                                              m::Ptr{integer}, x::Ptr{real}, c::Ptr{real},
                                              nnzj::Ptr{integer}, lcjac::Ptr{integer},
                                              cjac::Ptr{real}, indvar::Ptr{integer},
                                              indfun::Ptr{integer}, grad::Ptr{logical})::Cvoid
end

function cutest_cint_ccifg_s_(status, n, icon, x, ci, gci, grad)
  @ccall cutest_lib_path.cutest_cint_ccifg_s_(status::Ptr{integer}, n::Ptr{integer},
                                              icon::Ptr{integer}, x::Ptr{real}, ci::Ptr{real},
                                              gci::Ptr{real}, grad::Ptr{logical})::Cvoid
end

function cutest_cint_ccifsg_s_(status, n, con, x, ci, nnzsgc, lsgci, sgci, ivsgci, grad)
  @ccall cutest_lib_path.cutest_cint_ccifsg_s_(status::Ptr{integer}, n::Ptr{integer},
                                               con::Ptr{integer}, x::Ptr{real}, ci::Ptr{real},
                                               nnzsgc::Ptr{integer}, lsgci::Ptr{integer},
                                               sgci::Ptr{real}, ivsgci::Ptr{integer},
                                               grad::Ptr{logical})::Cvoid
end

function cutest_cint_cgrdh_s_(status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac, lh1, h)
  @ccall cutest_lib_path.cutest_cint_cgrdh_s_(status::Ptr{integer}, n::Ptr{integer},
                                              m::Ptr{integer}, x::Ptr{real}, y::Ptr{real},
                                              grlagf::Ptr{logical}, g::Ptr{real},
                                              jtrans::Ptr{logical}, lcjac1::Ptr{integer},
                                              lcjac2::Ptr{integer}, cjac::Ptr{real},
                                              lh1::Ptr{integer}, h::Ptr{real})::Cvoid
end

function cutest_cdh_s_(status, n, m, x, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdh_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                       x::Ptr{real}, y::Ptr{real}, lh1::Ptr{integer},
                                       h::Ptr{real})::Cvoid
end

function cutest_cdhc_s_(status, n, m, x, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdhc_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                        x::Ptr{real}, y::Ptr{real}, lh1::Ptr{integer},
                                        h::Ptr{real})::Cvoid
end

function cutest_cdhj_s_(status, n, m, x, y0, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdhj_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                        x::Ptr{real}, y0::Ptr{real}, y::Ptr{real},
                                        lh1::Ptr{integer}, h::Ptr{real})::Cvoid
end

function cutest_cshp_s_(status, n, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshp_s_(status::Ptr{integer}, n::Ptr{integer}, nnzh::Ptr{integer},
                                        lh::Ptr{integer}, irnh::Ptr{integer},
                                        icnh::Ptr{integer})::Cvoid
end

function cutest_csh_s_(status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_csh_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                       x::Ptr{real}, y::Ptr{real}, nnzh::Ptr{integer},
                                       lh::Ptr{integer}, h::Ptr{real}, irnh::Ptr{integer},
                                       icnh::Ptr{integer})::Cvoid
end

function cutest_cshc_s_(status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshc_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                        x::Ptr{real}, y::Ptr{real}, nnzh::Ptr{integer},
                                        lh::Ptr{integer}, h::Ptr{real}, irnh::Ptr{integer},
                                        icnh::Ptr{integer})::Cvoid
end

function cutest_cshj_s_(status, n, m, x, y0, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshj_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                        x::Ptr{real}, y0::Ptr{real}, y::Ptr{real},
                                        nnzh::Ptr{integer}, lh::Ptr{integer}, h::Ptr{real},
                                        irnh::Ptr{integer}, icnh::Ptr{integer})::Cvoid
end

function cutest_cint_ceh_s_(status, n, m, x, y, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
                            byrows)
  @ccall cutest_lib_path.cutest_cint_ceh_s_(status::Ptr{integer}, n::Ptr{integer}, m::Ptr{integer},
                                            x::Ptr{real}, y::Ptr{real}, ne::Ptr{integer},
                                            le::Ptr{integer}, iprnhi::Ptr{integer},
                                            iprhi::Ptr{integer}, lirnhi::Ptr{integer},
                                            irnhi::Ptr{integer}, lhi::Ptr{integer}, hi::Ptr{real},
                                            byrows::Ptr{logical})::Cvoid
end

function cutest_cifn_s_(status, n, iprob, x, f)
  @ccall cutest_lib_path.cutest_cifn_s_(status::Ptr{integer}, n::Ptr{integer}, iprob::Ptr{integer},
                                        x::Ptr{real}, f::Ptr{real})::Cvoid
end

function cutest_cigr_s_(status, n, iprob, x, g)
  @ccall cutest_lib_path.cutest_cigr_s_(status::Ptr{integer}, n::Ptr{integer}, iprob::Ptr{integer},
                                        x::Ptr{real}, g::Ptr{real})::Cvoid
end

function cutest_cisgr_s_(status, n, iprob, x, nnzg, lg, sg, ivsg)
  @ccall cutest_lib_path.cutest_cisgr_s_(status::Ptr{integer}, n::Ptr{integer}, iprob::Ptr{integer},
                                         x::Ptr{real}, nnzg::Ptr{integer}, lg::Ptr{integer},
                                         sg::Ptr{real}, ivsg::Ptr{integer})::Cvoid
end

function cutest_cisgrp_s_(status, n, iprob, nnzg, lg, ivsg)
  @ccall cutest_lib_path.cutest_cisgrp_s_(status::Ptr{integer}, n::Ptr{integer},
                                          iprob::Ptr{integer}, nnzg::Ptr{integer}, lg::Ptr{integer},
                                          ivsg::Ptr{integer})::Cvoid
end

function cutest_cidh_s_(status, n, x, iprob, lh1, h)
  @ccall cutest_lib_path.cutest_cidh_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                        iprob::Ptr{integer}, lh1::Ptr{integer}, h::Ptr{real})::Cvoid
end

function cutest_cish_s_(status, n, x, iprob, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cish_s_(status::Ptr{integer}, n::Ptr{integer}, x::Ptr{real},
                                        iprob::Ptr{integer}, nnzh::Ptr{integer}, lh::Ptr{integer},
                                        h::Ptr{real}, irnh::Ptr{integer}, icnh::Ptr{integer})::Cvoid
end

function cutest_cint_csgrsh_s_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun, nnzh,
                               lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cint_csgrsh_s_(status::Ptr{integer}, n::Ptr{integer},
                                               m::Ptr{integer}, x::Ptr{real}, y::Ptr{real},
                                               grlagf::Ptr{logical}, nnzj::Ptr{integer},
                                               lcjac::Ptr{integer}, cjac::Ptr{real},
                                               indvar::Ptr{integer}, indfun::Ptr{integer},
                                               nnzh::Ptr{integer}, lh::Ptr{integer}, h::Ptr{real},
                                               irnh::Ptr{integer}, icnh::Ptr{integer})::Cvoid
end

function cutest_cint_csgrshp_s_(status, n, nnzj, lcjac, indvar, indfun, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_cint_csgrshp_s_(status::Ptr{integer}, n::Ptr{integer},
                                                nnzj::Ptr{integer}, lcjac::Ptr{integer},
                                                indvar::Ptr{integer}, indfun::Ptr{integer},
                                                nnzh::Ptr{integer}, lh::Ptr{integer},
                                                irnh::Ptr{integer}, icnh::Ptr{integer})::Cvoid
end

function cutest_cint_csgreh_s_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun, ne,
                               le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_csgreh_s_(status::Ptr{integer}, n::Ptr{integer},
                                               m::Ptr{integer}, x::Ptr{real}, y::Ptr{real},
                                               grlagf::Ptr{logical}, nnzj::Ptr{integer},
                                               lcjac::Ptr{integer}, cjac::Ptr{real},
                                               indvar::Ptr{integer}, indfun::Ptr{integer},
                                               ne::Ptr{integer}, le::Ptr{integer},
                                               iprnhi::Ptr{integer}, iprhi::Ptr{integer},
                                               lirnhi::Ptr{integer}, irnhi::Ptr{integer},
                                               lhi::Ptr{integer}, hi::Ptr{real},
                                               byrows::Ptr{logical})::Cvoid
end

function cutest_cint_chprod_s_(status, n, m, goth, x, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chprod_s_(status::Ptr{integer}, n::Ptr{integer},
                                               m::Ptr{integer}, goth::Ptr{logical}, x::Ptr{real},
                                               y::Ptr{real}, p::Ptr{real}, q::Ptr{real})::Cvoid
end

function cutest_cint_chsprod_s_(status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_chsprod_s_(status::Ptr{integer}, n::Ptr{integer},
                                                m::Ptr{integer}, goth::Ptr{logical}, x::Ptr{real},
                                                y::Ptr{real}, nnzp::Ptr{integer},
                                                indp::Ptr{integer}, p::Ptr{real},
                                                nnzr::Ptr{integer}, indr::Ptr{integer},
                                                r::Ptr{real})::Cvoid
end

function cutest_cint_chcprod_s_(status, n, m, goth, x, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chcprod_s_(status::Ptr{integer}, n::Ptr{integer},
                                                m::Ptr{integer}, goth::Ptr{logical}, x::Ptr{real},
                                                y::Ptr{real}, p::Ptr{real}, q::Ptr{real})::Cvoid
end

function cutest_cint_cshcprod_s_(status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_cshcprod_s_(status::Ptr{integer}, n::Ptr{integer},
                                                 m::Ptr{integer}, goth::Ptr{logical}, x::Ptr{real},
                                                 y::Ptr{real}, nnzp::Ptr{integer},
                                                 indp::Ptr{integer}, p::Ptr{real},
                                                 nnzr::Ptr{integer}, indr::Ptr{integer},
                                                 r::Ptr{real})::Cvoid
end

function cutest_cint_chjprod_s_(status, n, m, goth, x, y0, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chjprod_s_(status::Ptr{integer}, n::Ptr{integer},
                                                m::Ptr{integer}, goth::Ptr{logical}, x::Ptr{real},
                                                y0::Ptr{real}, y::Ptr{real}, p::Ptr{real},
                                                q::Ptr{real})::Cvoid
end

function cutest_cint_cjprod_s_(status, n, m, gotj, jtrans, x, p, lp, r, lr)
  @ccall cutest_lib_path.cutest_cint_cjprod_s_(status::Ptr{integer}, n::Ptr{integer},
                                               m::Ptr{integer}, gotj::Ptr{logical},
                                               jtrans::Ptr{logical}, x::Ptr{real}, p::Ptr{real},
                                               lp::Ptr{integer}, r::Ptr{real},
                                               lr::Ptr{integer})::Cvoid
end

function cutest_cint_csjprod_s_(status, n, m, gotj, jtrans, x, nnzp, indp, p, lp, nnzr, indr, r, lr)
  @ccall cutest_lib_path.cutest_cint_csjprod_s_(status::Ptr{integer}, n::Ptr{integer},
                                                m::Ptr{integer}, gotj::Ptr{logical},
                                                jtrans::Ptr{logical}, x::Ptr{real},
                                                nnzp::Ptr{integer}, indp::Ptr{integer},
                                                p::Ptr{real}, lp::Ptr{integer}, nnzr::Ptr{integer},
                                                indr::Ptr{integer}, r::Ptr{real},
                                                lr::Ptr{integer})::Cvoid
end

function cutest_cint_cchprods_s_(status, n, m, goth, x, p, lchp, chpval, chpind, chpptr)
  @ccall cutest_lib_path.cutest_cint_cchprods_s_(status::Ptr{integer}, n::Ptr{integer},
                                                 m::Ptr{integer}, goth::Ptr{logical}, x::Ptr{real},
                                                 p::Ptr{real}, lchp::Ptr{integer},
                                                 chpval::Ptr{real}, chpind::Ptr{integer},
                                                 chpptr::Ptr{integer})::Cvoid
end

function cutest_cint_cchprodsp_s_(status, m, lchp, chpind, chpptr)
  @ccall cutest_lib_path.cutest_cint_cchprodsp_s_(status::Ptr{integer}, m::Ptr{integer},
                                                  lchp::Ptr{integer}, chpind::Ptr{integer},
                                                  chpptr::Ptr{integer})::Cvoid
end

function cutest_cint_cohprods_s_(status, n, goth, x, p, nnzohp, lohp, ohpval, ohpind)
  @ccall cutest_lib_path.cutest_cint_cohprods_s_(status::Ptr{integer}, n::Ptr{integer},
                                                 goth::Ptr{logical}, x::Ptr{real}, p::Ptr{real},
                                                 nnzohp::Ptr{integer}, lohp::Ptr{integer},
                                                 ohpval::Ptr{real}, ohpind::Ptr{integer})::Cvoid
end

function cutest_cohprodsp_s_(status, nnzohp, lohp, chpind)
  @ccall cutest_lib_path.cutest_cohprodsp_s_(status::Ptr{integer}, nnzohp::Ptr{integer},
                                             lohp::Ptr{integer}, chpind::Ptr{integer})::Cvoid
end

function cutest_uterminate_s_(status)
  @ccall cutest_lib_path.cutest_uterminate_s_(status::Ptr{integer})::Cvoid
end

function cutest_cterminate_s_(status)
  @ccall cutest_lib_path.cutest_cterminate_s_(status::Ptr{integer})::Cvoid
end

function fortran_open_(funit, fname, ierr)
  @ccall cutest_lib_path.fortran_open_(funit::Ptr{integer}, fname::Ptr{Cchar},
                                       ierr::Ptr{integer})::Cvoid
end

function fortran_close_(funit, ierr)
  @ccall cutest_lib_path.fortran_close_(funit::Ptr{integer}, ierr::Ptr{integer})::Cvoid
end

function cutest_uofg_(status, n, x, f, g, grad)
  @ccall cutest_lib_path.cutest_uofg_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                      f::Ptr{Float64}, g::Ptr{Float64}, grad::Ptr{Bool})::Cvoid
end

function cutest_uofg_s_(status, n, x, f, g, grad)
  @ccall cutest_lib_path.cutest_uofg_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                      f::Ptr{Float32}, g::Ptr{Float32}, grad::Ptr{Bool})::Cvoid
end

function cutest_uhprod_(status, n, goth, x, vector, result)
  @ccall cutest_lib_path.cutest_uhprod_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Cint},
                                        x::Ptr{Float64}, vector::Ptr{Float64},
                                        result::Ptr{Float64})::Cvoid
end

function cutest_uhprod_s(status, n, goth, x, vector, result)
  @ccall cutest_lib_path.cutest_uhprod_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Float32},
                                        x::Ptr{Float32}, vector::Ptr{Float32},
                                        result::Ptr{Float32})::Cvoid
end
#! format: on
