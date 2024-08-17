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
  @ccall cutest_lib_path.cutest_usetup_(status::Ptr{Cint}, funit::Ptr{Cint}, iout::Ptr{Cint},
                                        io_buffer::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                        bl::Ptr{Float64}, bu::Ptr{Float64})::Cvoid
end

function cutest_cint_csetup_(status, funit, iout, io_buffer, n, m, x, bl, bu, v, cl, cu, equatn,
                             linear, e_order, l_order, v_order)
  @ccall cutest_lib_path.cutest_cint_csetup_(status::Ptr{Cint}, funit::Ptr{Cint}, iout::Ptr{Cint},
                                             io_buffer::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                             x::Ptr{Float64}, bl::Ptr{Float64}, bu::Ptr{Float64},
                                             v::Ptr{Float64}, cl::Ptr{Float64}, cu::Ptr{Float64},
                                             equatn::Ptr{Bool}, linear::Ptr{Bool},
                                             e_order::Ptr{Cint}, l_order::Ptr{Cint},
                                             v_order::Ptr{Cint})::Cvoid
end

function cutest_udimen_(status, funit, n)
  @ccall cutest_lib_path.cutest_udimen_(status::Ptr{Cint}, funit::Ptr{Cint}, n::Ptr{Cint})::Cvoid
end

function cutest_udimsh_(status, nnzh)
  @ccall cutest_lib_path.cutest_udimsh_(status::Ptr{Cint}, nnzh::Ptr{Cint})::Cvoid
end

function cutest_udimse_(status, ne, nzh, nzirnh)
  @ccall cutest_lib_path.cutest_udimse_(status::Ptr{Cint}, ne::Ptr{Cint}, nzh::Ptr{Cint},
                                        nzirnh::Ptr{Cint})::Cvoid
end

function cutest_uvartype_(status, n, ivarty)
  @ccall cutest_lib_path.cutest_uvartype_(status::Ptr{Cint}, n::Ptr{Cint}, ivarty::Ptr{Cint})::Cvoid
end

function cutest_unames_(status, n, pname, vnames)
  @ccall cutest_lib_path.cutest_unames_(status::Ptr{Cint}, n::Ptr{Cint}, pname::Ptr{Cchar},
                                        vnames::Ptr{Cchar})::Cvoid
end

function cutest_ureport_(status, calls, time)
  @ccall cutest_lib_path.cutest_ureport_(status::Ptr{Cint}, calls::Ptr{Float64},
                                         time::Ptr{Float64})::Cvoid
end

function cutest_cdimen_(status, funit, n, m)
  @ccall cutest_lib_path.cutest_cdimen_(status::Ptr{Cint}, funit::Ptr{Cint}, n::Ptr{Cint},
                                        m::Ptr{Cint})::Cvoid
end

function cutest_cint_cnoobj_(status, funit, noobj)
  @ccall cutest_lib_path.cutest_cint_cnoobj_(status::Ptr{Cint}, funit::Ptr{Cint},
                                             noobj::Ptr{Bool})::Cvoid
end

function cutest_cdimsg_(status, nnzg)
  @ccall cutest_lib_path.cutest_cdimsg_(status::Ptr{Cint}, nnzg::Ptr{Cint})::Cvoid
end

function cutest_cdimsj_(status, nnzj)
  @ccall cutest_lib_path.cutest_cdimsj_(status::Ptr{Cint}, nnzj::Ptr{Cint})::Cvoid
end

function cutest_cdimsh_(status, nnzh)
  @ccall cutest_lib_path.cutest_cdimsh_(status::Ptr{Cint}, nnzh::Ptr{Cint})::Cvoid
end

function CUTEST_cdimcop(status, nnzohp)
  @ccall cutest_lib_path.CUTEST_cdimcop(status::Ptr{Cint}, nnzohp::Ptr{Cint})::Cvoid
end

function cutest_cdimohp_(status, nnzohp)
  @ccall cutest_lib_path.cutest_cdimohp_(status::Ptr{Cint}, nnzohp::Ptr{Cint})::Cvoid
end

function cutest_cdimchp_(status, nnzchp)
  @ccall cutest_lib_path.cutest_cdimchp_(status::Ptr{Cint}, nnzchp::Ptr{Cint})::Cvoid
end

function cutest_cdimse_(status, ne, nzh, nzirnh)
  @ccall cutest_lib_path.cutest_cdimse_(status::Ptr{Cint}, ne::Ptr{Cint}, nzh::Ptr{Cint},
                                        nzirnh::Ptr{Cint})::Cvoid
end

function cutest_cstats_(status, nonlinear_variables_objective, nonlinear_variables_constraints,
                        equality_constraints, linear_constraints)
  @ccall cutest_lib_path.cutest_cstats_(status::Ptr{Cint}, nonlinear_variables_objective::Ptr{Cint},
                                        nonlinear_variables_constraints::Ptr{Cint},
                                        equality_constraints::Ptr{Cint},
                                        linear_constraints::Ptr{Cint})::Cvoid
end

function cutest_cvartype_(status, n, ivarty)
  @ccall cutest_lib_path.cutest_cvartype_(status::Ptr{Cint}, n::Ptr{Cint}, ivarty::Ptr{Cint})::Cvoid
end

function cutest_cnames_(status, n, m, pname, vnames, gnames)
  @ccall cutest_lib_path.cutest_cnames_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                        pname::Ptr{Cchar}, vnames::Ptr{Cchar},
                                        gnames::Ptr{Cchar})::Cvoid
end

function cutest_creport_(status, calls, time)
  @ccall cutest_lib_path.cutest_creport_(status::Ptr{Cint}, calls::Ptr{Float64},
                                         time::Ptr{Float64})::Cvoid
end

function cutest_connames_(status, m, gname)
  @ccall cutest_lib_path.cutest_connames_(status::Ptr{Cint}, m::Ptr{Cint}, gname::Ptr{Cchar})::Cvoid
end

function cutest_pname_(status, funit, pname)
  @ccall cutest_lib_path.cutest_pname_(status::Ptr{Cint}, funit::Ptr{Cint},
                                       pname::Ptr{Cchar})::Cvoid
end

function cutest_probname_(status, pname)
  @ccall cutest_lib_path.cutest_probname_(status::Ptr{Cint}, pname::Ptr{Cchar})::Cvoid
end

function cutest_varnames_(status, n, vname)
  @ccall cutest_lib_path.cutest_varnames_(status::Ptr{Cint}, n::Ptr{Cint}, vname::Ptr{Cchar})::Cvoid
end

function cutest_ufn_(status, n, x, f)
  @ccall cutest_lib_path.cutest_ufn_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                     f::Ptr{Float64})::Cvoid
end

function cutest_ugr_(status, n, x, g)
  @ccall cutest_lib_path.cutest_ugr_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                     g::Ptr{Float64})::Cvoid
end

function cutest_cint_uofg_(status, n, x, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_uofg_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                           f::Ptr{Float64}, g::Ptr{Float64}, grad::Ptr{Bool})::Cvoid
end

function cutest_udh_(status, n, x, lh1, h)
  @ccall cutest_lib_path.cutest_udh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                     lh1::Ptr{Cint}, h::Ptr{Float64})::Cvoid
end

function cutest_ushp_(status, n, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_ushp_(status::Ptr{Cint}, n::Ptr{Cint}, nnzh::Ptr{Cint},
                                      lh::Ptr{Cint}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_ush_(status, n, x, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_ush_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                     nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float64},
                                     irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ueh_(status, n, x, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_ueh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                          ne::Ptr{Cint}, le::Ptr{Cint}, iprnhi::Ptr{Cint},
                                          iprhi::Ptr{Cint}, lirnhi::Ptr{Cint}, irnhi::Ptr{Cint},
                                          lhi::Ptr{Cint}, hi::Ptr{Float64},
                                          byrows::Ptr{Bool})::Cvoid
end

function cutest_ugrdh_(status, n, x, g, lh1, h)
  @ccall cutest_lib_path.cutest_ugrdh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                       g::Ptr{Float64}, lh1::Ptr{Cint}, h::Ptr{Float64})::Cvoid
end

function cutest_ugrsh_(status, n, x, g, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_ugrsh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                       g::Ptr{Float64}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                       h::Ptr{Float64}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ugreh_(status, n, x, g, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_ugreh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                            g::Ptr{Float64}, ne::Ptr{Cint}, le::Ptr{Cint},
                                            iprnhi::Ptr{Cint}, iprhi::Ptr{Cint}, lirnhi::Ptr{Cint},
                                            irnhi::Ptr{Cint}, lhi::Ptr{Cint}, hi::Ptr{Float64},
                                            byrows::Ptr{Bool})::Cvoid
end

function cutest_cint_uhprod_(status, n, goth, x, p, r)
  @ccall cutest_lib_path.cutest_cint_uhprod_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                             x::Ptr{Float64}, p::Ptr{Float64},
                                             r::Ptr{Float64})::Cvoid
end

function cutest_cint_ushprod_(status, n, goth, x, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_ushprod_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                              x::Ptr{Float64}, nnzp::Ptr{Cint}, indp::Ptr{Cint},
                                              p::Ptr{Float64}, nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                              r::Ptr{Float64})::Cvoid
end

function cutest_ubandh_(status, n, x, nsemib, bandh, lbandh, maxsbw)
  @ccall cutest_lib_path.cutest_ubandh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                        nsemib::Ptr{Cint}, bandh::Ptr{Float64}, lbandh::Ptr{Cint},
                                        maxsbw::Ptr{Cint})::Cvoid
end

function cutest_cfn_(status, n, m, x, f, c)
  @ccall cutest_lib_path.cutest_cfn_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                     f::Ptr{Float64}, c::Ptr{Float64})::Cvoid
end

function CUTEST_cconst(status, m, c)
  @ccall cutest_lib_path.CUTEST_cconst(status::Ptr{Cint}, m::Ptr{Cint}, c::Ptr{Float64})::Cvoid
end

function cutest_cint_cofg_(status, n, x, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_cofg_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                           f::Ptr{Float64}, g::Ptr{Float64}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cofsg_(status, n, x, f, nnzg, lg, sg, ivsg, grad)
  @ccall cutest_lib_path.cutest_cint_cofsg_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                            f::Ptr{Float64}, nnzg::Ptr{Cint}, lg::Ptr{Cint},
                                            sg::Ptr{Float64}, ivsg::Ptr{Cint},
                                            grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccfg_(status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
  @ccall cutest_lib_path.cutest_cint_ccfg_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                           x::Ptr{Float64}, c::Ptr{Float64}, jtrans::Ptr{Bool},
                                           lcjac1::Ptr{Cint}, lcjac2::Ptr{Cint}, cjac::Ptr{Float64},
                                           grad::Ptr{Bool})::Cvoid
end

function cutest_cint_clfg_(status, n, m, x, y, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_clfg_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                           x::Ptr{Float64}, y::Ptr{Float64}, f::Ptr{Float64},
                                           g::Ptr{Float64}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cgr_(status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac)
  @ccall cutest_lib_path.cutest_cint_cgr_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                          x::Ptr{Float64}, y::Ptr{Float64}, grlagf::Ptr{Bool},
                                          g::Ptr{Float64}, jtrans::Ptr{Bool}, lcjac1::Ptr{Cint},
                                          lcjac2::Ptr{Cint}, cjac::Ptr{Float64})::Cvoid
end

function cutest_cint_csgr_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun)
  @ccall cutest_lib_path.cutest_cint_csgr_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                           x::Ptr{Float64}, y::Ptr{Float64}, grlagf::Ptr{Bool},
                                           nnzj::Ptr{Cint}, lcjac::Ptr{Cint}, cjac::Ptr{Float64},
                                           indvar::Ptr{Cint}, indfun::Ptr{Cint})::Cvoid
end

function cutest_cint_csgrp_(status, n, nnzj, lj, jvar, jcon)
  @ccall cutest_lib_path.cutest_cint_csgrp_(status::Ptr{Cint}, n::Ptr{Cint}, nnzj::Ptr{Cint},
                                            lj::Ptr{Cint}, jvar::Ptr{Cint}, jcon::Ptr{Cint})::Cvoid
end

function cutest_cint_csjp_(status, nnzj, lj, jvar, jcon)
  @ccall cutest_lib_path.cutest_cint_csjp_(status::Ptr{Cint}, nnzj::Ptr{Cint}, lj::Ptr{Cint},
                                           jvar::Ptr{Cint}, jcon::Ptr{Cint})::Cvoid
end

function cutest_cint_ccfsg_(status, n, m, x, c, nnzj, lcjac, cjac, indvar, indfun, grad)
  @ccall cutest_lib_path.cutest_cint_ccfsg_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                            x::Ptr{Float64}, c::Ptr{Float64}, nnzj::Ptr{Cint},
                                            lcjac::Ptr{Cint}, cjac::Ptr{Float64}, indvar::Ptr{Cint},
                                            indfun::Ptr{Cint}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccifg_(status, n, icon, x, ci, gci, grad)
  @ccall cutest_lib_path.cutest_cint_ccifg_(status::Ptr{Cint}, n::Ptr{Cint}, icon::Ptr{Cint},
                                            x::Ptr{Float64}, ci::Ptr{Float64}, gci::Ptr{Float64},
                                            grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccifsg_(status, n, con, x, ci, nnzsgc, lsgci, sgci, ivsgci, grad)
  @ccall cutest_lib_path.cutest_cint_ccifsg_(status::Ptr{Cint}, n::Ptr{Cint}, con::Ptr{Cint},
                                             x::Ptr{Float64}, ci::Ptr{Float64}, nnzsgc::Ptr{Cint},
                                             lsgci::Ptr{Cint}, sgci::Ptr{Float64},
                                             ivsgci::Ptr{Cint}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cgrdh_(status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac, lh1, h)
  @ccall cutest_lib_path.cutest_cint_cgrdh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                            x::Ptr{Float64}, y::Ptr{Float64}, grlagf::Ptr{Bool},
                                            g::Ptr{Float64}, jtrans::Ptr{Bool}, lcjac1::Ptr{Cint},
                                            lcjac2::Ptr{Cint}, cjac::Ptr{Float64}, lh1::Ptr{Cint},
                                            h::Ptr{Float64})::Cvoid
end

function cutest_cdh_(status, n, m, x, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                     y::Ptr{Float64}, lh1::Ptr{Cint}, h::Ptr{Float64})::Cvoid
end

function cutest_cdhc_(status, n, m, x, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdhc_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                      x::Ptr{Float64}, y::Ptr{Float64}, lh1::Ptr{Cint},
                                      h::Ptr{Float64})::Cvoid
end

function cutest_cdhj_(status, n, m, x, y0, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdhj_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                      x::Ptr{Float64}, y0::Ptr{Float64}, y::Ptr{Float64},
                                      lh1::Ptr{Cint}, h::Ptr{Float64})::Cvoid
end

function cutest_cshp_(status, n, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshp_(status::Ptr{Cint}, n::Ptr{Cint}, nnzh::Ptr{Cint},
                                      lh::Ptr{Cint}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_csh_(status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_csh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                     y::Ptr{Float64}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                     h::Ptr{Float64}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cshc_(status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshc_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                      x::Ptr{Float64}, y::Ptr{Float64}, nnzh::Ptr{Cint},
                                      lh::Ptr{Cint}, h::Ptr{Float64}, irnh::Ptr{Cint},
                                      icnh::Ptr{Cint})::Cvoid
end

function cutest_cshj_(status, n, m, x, y0, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshj_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                      x::Ptr{Float64}, y0::Ptr{Float64}, y::Ptr{Float64},
                                      nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float64},
                                      irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ceh_(status, n, m, x, y, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_ceh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                          x::Ptr{Float64}, y::Ptr{Float64}, ne::Ptr{Cint},
                                          le::Ptr{Cint}, iprnhi::Ptr{Cint}, iprhi::Ptr{Cint},
                                          lirnhi::Ptr{Cint}, irnhi::Ptr{Cint}, lhi::Ptr{Cint},
                                          hi::Ptr{Float64}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cifn_(status, n, iprob, x, f)
  @ccall cutest_lib_path.cutest_cifn_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint},
                                      x::Ptr{Float64}, f::Ptr{Float64})::Cvoid
end

function cutest_cigr_(status, n, iprob, x, g)
  @ccall cutest_lib_path.cutest_cigr_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint},
                                      x::Ptr{Float64}, g::Ptr{Float64})::Cvoid
end

function cutest_cisgr_(status, n, iprob, x, nnzg, lg, sg, ivsg)
  @ccall cutest_lib_path.cutest_cisgr_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint},
                                       x::Ptr{Float64}, nnzg::Ptr{Cint}, lg::Ptr{Cint},
                                       sg::Ptr{Float64}, ivsg::Ptr{Cint})::Cvoid
end

function cutest_cisgrp_(status, n, iprob, nnzg, lg, ivsg)
  @ccall cutest_lib_path.cutest_cisgrp_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint},
                                        nnzg::Ptr{Cint}, lg::Ptr{Cint}, ivsg::Ptr{Cint})::Cvoid
end

function cutest_cidh_(status, n, x, iprob, lh1, h)
  @ccall cutest_lib_path.cutest_cidh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                      iprob::Ptr{Cint}, lh1::Ptr{Cint}, h::Ptr{Float64})::Cvoid
end

function cutest_cish_(status, n, x, iprob, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cish_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64},
                                      iprob::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                      h::Ptr{Float64}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgrsh_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun, nnzh,
                             lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cint_csgrsh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                             x::Ptr{Float64}, y::Ptr{Float64}, grlagf::Ptr{Bool},
                                             nnzj::Ptr{Cint}, lcjac::Ptr{Cint}, cjac::Ptr{Float64},
                                             indvar::Ptr{Cint}, indfun::Ptr{Cint}, nnzh::Ptr{Cint},
                                             lh::Ptr{Cint}, h::Ptr{Float64}, irnh::Ptr{Cint},
                                             icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgrshp_(status, n, nnzj, lcjac, indvar, indfun, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_cint_csgrshp_(status::Ptr{Cint}, n::Ptr{Cint}, nnzj::Ptr{Cint},
                                              lcjac::Ptr{Cint}, indvar::Ptr{Cint},
                                              indfun::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                              irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgreh_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun, ne, le,
                             iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_csgreh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                             x::Ptr{Float64}, y::Ptr{Float64}, grlagf::Ptr{Bool},
                                             nnzj::Ptr{Cint}, lcjac::Ptr{Cint}, cjac::Ptr{Float64},
                                             indvar::Ptr{Cint}, indfun::Ptr{Cint}, ne::Ptr{Cint},
                                             le::Ptr{Cint}, iprnhi::Ptr{Cint}, iprhi::Ptr{Cint},
                                             lirnhi::Ptr{Cint}, irnhi::Ptr{Cint}, lhi::Ptr{Cint},
                                             hi::Ptr{Float64}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cint_chprod_(status, n, m, goth, x, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                             goth::Ptr{Bool}, x::Ptr{Float64}, y::Ptr{Float64},
                                             p::Ptr{Float64}, q::Ptr{Float64})::Cvoid
end

function cutest_cint_chsprod_(status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_chsprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                              goth::Ptr{Bool}, x::Ptr{Float64}, y::Ptr{Float64},
                                              nnzp::Ptr{Cint}, indp::Ptr{Cint}, p::Ptr{Float64},
                                              nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                              r::Ptr{Float64})::Cvoid
end

function cutest_cint_chcprod_(status, n, m, goth, x, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chcprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                              goth::Ptr{Bool}, x::Ptr{Float64}, y::Ptr{Float64},
                                              p::Ptr{Float64}, q::Ptr{Float64})::Cvoid
end

function cutest_cint_cshcprod_(status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_cshcprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                               goth::Ptr{Bool}, x::Ptr{Float64}, y::Ptr{Float64},
                                               nnzp::Ptr{Cint}, indp::Ptr{Cint}, p::Ptr{Float64},
                                               nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                               r::Ptr{Float64})::Cvoid
end

function cutest_cint_chjprod_(status, n, m, goth, x, y0, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chjprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                              goth::Ptr{Bool}, x::Ptr{Float64}, y0::Ptr{Float64},
                                              y::Ptr{Float64}, p::Ptr{Float64},
                                              q::Ptr{Float64})::Cvoid
end

function cutest_cint_cjprod_(status, n, m, gotj, jtrans, x, p, lp, r, lr)
  @ccall cutest_lib_path.cutest_cint_cjprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                             gotj::Ptr{Bool}, jtrans::Ptr{Bool}, x::Ptr{Float64},
                                             p::Ptr{Float64}, lp::Ptr{Cint}, r::Ptr{Float64},
                                             lr::Ptr{Cint})::Cvoid
end

function cutest_cint_csjprod_(status, n, m, gotj, jtrans, x, nnzp, indp, p, lp, nnzr, indr, r, lr)
  @ccall cutest_lib_path.cutest_cint_csjprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                              gotj::Ptr{Bool}, jtrans::Ptr{Bool}, x::Ptr{Float64},
                                              nnzp::Ptr{Cint}, indp::Ptr{Cint}, p::Ptr{Float64},
                                              lp::Ptr{Cint}, nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                              r::Ptr{Float64}, lr::Ptr{Cint})::Cvoid
end

function cutest_cint_cchprods_(status, n, m, goth, x, p, lchp, chpval, chpind, chpptr)
  @ccall cutest_lib_path.cutest_cint_cchprods_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                               goth::Ptr{Bool}, x::Ptr{Float64}, p::Ptr{Float64},
                                               lchp::Ptr{Cint}, chpval::Ptr{Float64},
                                               chpind::Ptr{Cint}, chpptr::Ptr{Cint})::Cvoid
end

function cutest_cint_cchprodsp_(status, m, lchp, chpind, chpptr)
  @ccall cutest_lib_path.cutest_cint_cchprodsp_(status::Ptr{Cint}, m::Ptr{Cint}, lchp::Ptr{Cint},
                                                chpind::Ptr{Cint}, chpptr::Ptr{Cint})::Cvoid
end

function cutest_cint_cohprods_(status, n, goth, x, p, nnzohp, lohp, ohpval, ohpind)
  @ccall cutest_lib_path.cutest_cint_cohprods_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                               x::Ptr{Float64}, p::Ptr{Float64}, nnzohp::Ptr{Cint},
                                               lohp::Ptr{Cint}, ohpval::Ptr{Float64},
                                               ohpind::Ptr{Cint})::Cvoid
end

function cutest_cohprodsp_(status, nnzohp, lohp, chpind)
  @ccall cutest_lib_path.cutest_cohprodsp_(status::Ptr{Cint}, nnzohp::Ptr{Cint}, lohp::Ptr{Cint},
                                           chpind::Ptr{Cint})::Cvoid
end

function cutest_uterminate_(status)
  @ccall cutest_lib_path.cutest_uterminate_(status::Ptr{Cint})::Cvoid
end

function cutest_cterminate_(status)
  @ccall cutest_lib_path.cutest_cterminate_(status::Ptr{Cint})::Cvoid
end

function cutest_usetup_s_(status, funit, iout, io_buffer, n, x, bl, bu)
  @ccall cutest_lib_path.cutest_usetup_s_(status::Ptr{Cint}, funit::Ptr{Cint}, iout::Ptr{Cint},
                                          io_buffer::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                          bl::Ptr{Float32}, bu::Ptr{Float32})::Cvoid
end

function cutest_cint_csetup_s_(status, funit, iout, io_buffer, n, m, x, bl, bu, v, cl, cu, equatn,
                               linear, e_order, l_order, v_order)
  @ccall cutest_lib_path.cutest_cint_csetup_s_(status::Ptr{Cint}, funit::Ptr{Cint}, iout::Ptr{Cint},
                                               io_buffer::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                               x::Ptr{Float32}, bl::Ptr{Float32}, bu::Ptr{Float32},
                                               v::Ptr{Float32}, cl::Ptr{Float32}, cu::Ptr{Float32},
                                               equatn::Ptr{Bool}, linear::Ptr{Bool},
                                               e_order::Ptr{Cint}, l_order::Ptr{Cint},
                                               v_order::Ptr{Cint})::Cvoid
end

function cutest_udimen_s_(status, funit, n)
  @ccall cutest_lib_path.cutest_udimen_s_(status::Ptr{Cint}, funit::Ptr{Cint}, n::Ptr{Cint})::Cvoid
end

function cutest_udimsh_s_(status, nnzh)
  @ccall cutest_lib_path.cutest_udimsh_s_(status::Ptr{Cint}, nnzh::Ptr{Cint})::Cvoid
end

function cutest_udimse_s_(status, ne, nzh, nzirnh)
  @ccall cutest_lib_path.cutest_udimse_s_(status::Ptr{Cint}, ne::Ptr{Cint}, nzh::Ptr{Cint},
                                          nzirnh::Ptr{Cint})::Cvoid
end

function cutest_uvartype_s_(status, n, ivarty)
  @ccall cutest_lib_path.cutest_uvartype_s_(status::Ptr{Cint}, n::Ptr{Cint},
                                            ivarty::Ptr{Cint})::Cvoid
end

function cutest_unames_s_(status, n, pname, vnames)
  @ccall cutest_lib_path.cutest_unames_s_(status::Ptr{Cint}, n::Ptr{Cint}, pname::Ptr{Cchar},
                                          vnames::Ptr{Cchar})::Cvoid
end

function cutest_ureport_s_(status, calls, time)
  @ccall cutest_lib_path.cutest_ureport_s_(status::Ptr{Cint}, calls::Ptr{Float32},
                                           time::Ptr{Float32})::Cvoid
end

function cutest_cdimen_s_(status, funit, n, m)
  @ccall cutest_lib_path.cutest_cdimen_s_(status::Ptr{Cint}, funit::Ptr{Cint}, n::Ptr{Cint},
                                          m::Ptr{Cint})::Cvoid
end

function cutest_cint_cnoobj_s_(status, funit, noobj)
  @ccall cutest_lib_path.cutest_cint_cnoobj_s_(status::Ptr{Cint}, funit::Ptr{Cint},
                                               noobj::Ptr{Bool})::Cvoid
end

function cutest_cdimsg_s_(status, nnzg)
  @ccall cutest_lib_path.cutest_cdimsg_s_(status::Ptr{Cint}, nnzg::Ptr{Cint})::Cvoid
end

function cutest_cdimsj_s_(status, nnzj)
  @ccall cutest_lib_path.cutest_cdimsj_s_(status::Ptr{Cint}, nnzj::Ptr{Cint})::Cvoid
end

function cutest_cdimsh_s_(status, nnzh)
  @ccall cutest_lib_path.cutest_cdimsh_s_(status::Ptr{Cint}, nnzh::Ptr{Cint})::Cvoid
end

function CUTEST_cdimcop_s(status, nnzohp)
  @ccall cutest_lib_path.CUTEST_cdimcop_s(status::Ptr{Cint}, nnzohp::Ptr{Cint})::Cvoid
end

function cutest_cdimohp_s_(status, nnzohp)
  @ccall cutest_lib_path.cutest_cdimohp_s_(status::Ptr{Cint}, nnzohp::Ptr{Cint})::Cvoid
end

function cutest_cdimchp_s_(status, nnzchp)
  @ccall cutest_lib_path.cutest_cdimchp_s_(status::Ptr{Cint}, nnzchp::Ptr{Cint})::Cvoid
end

function cutest_cdimse_s_(status, ne, nzh, nzirnh)
  @ccall cutest_lib_path.cutest_cdimse_s_(status::Ptr{Cint}, ne::Ptr{Cint}, nzh::Ptr{Cint},
                                          nzirnh::Ptr{Cint})::Cvoid
end

function cutest_cstats_s_(status, nonlinear_variables_objective, nonlinear_variables_constraints,
                          equality_constraints, linear_constraints)
  @ccall cutest_lib_path.cutest_cstats_s_(status::Ptr{Cint},
                                          nonlinear_variables_objective::Ptr{Cint},
                                          nonlinear_variables_constraints::Ptr{Cint},
                                          equality_constraints::Ptr{Cint},
                                          linear_constraints::Ptr{Cint})::Cvoid
end

function cutest_cvartype_s_(status, n, ivarty)
  @ccall cutest_lib_path.cutest_cvartype_s_(status::Ptr{Cint}, n::Ptr{Cint},
                                            ivarty::Ptr{Cint})::Cvoid
end

function cutest_cnames_s_(status, n, m, pname, vnames, gnames)
  @ccall cutest_lib_path.cutest_cnames_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                          pname::Ptr{Cchar}, vnames::Ptr{Cchar},
                                          gnames::Ptr{Cchar})::Cvoid
end

function cutest_creport_s_(status, calls, time)
  @ccall cutest_lib_path.cutest_creport_s_(status::Ptr{Cint}, calls::Ptr{Float32},
                                           time::Ptr{Float32})::Cvoid
end

function cutest_connames_s_(status, m, gname)
  @ccall cutest_lib_path.cutest_connames_s_(status::Ptr{Cint}, m::Ptr{Cint},
                                            gname::Ptr{Cchar})::Cvoid
end

function cutest_pname_s_(status, funit, pname)
  @ccall cutest_lib_path.cutest_pname_s_(status::Ptr{Cint}, funit::Ptr{Cint},
                                         pname::Ptr{Cchar})::Cvoid
end

function cutest_probname_s_(status, pname)
  @ccall cutest_lib_path.cutest_probname_s_(status::Ptr{Cint}, pname::Ptr{Cchar})::Cvoid
end

function cutest_varnames_s_(status, n, vname)
  @ccall cutest_lib_path.cutest_varnames_s_(status::Ptr{Cint}, n::Ptr{Cint},
                                            vname::Ptr{Cchar})::Cvoid
end

function cutest_ufn_s_(status, n, x, f)
  @ccall cutest_lib_path.cutest_ufn_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                       f::Ptr{Float32})::Cvoid
end

function cutest_ugr_s_(status, n, x, g)
  @ccall cutest_lib_path.cutest_ugr_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                       g::Ptr{Float32})::Cvoid
end

function cutest_cint_uofg_s_(status, n, x, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_uofg_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                             f::Ptr{Float32}, g::Ptr{Float32},
                                             grad::Ptr{Bool})::Cvoid
end

function cutest_udh_s_(status, n, x, lh1, h)
  @ccall cutest_lib_path.cutest_udh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                       lh1::Ptr{Cint}, h::Ptr{Float32})::Cvoid
end

function cutest_ushp_s_(status, n, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_ushp_s_(status::Ptr{Cint}, n::Ptr{Cint}, nnzh::Ptr{Cint},
                                        lh::Ptr{Cint}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_ush_s_(status, n, x, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_ush_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                       nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float32},
                                       irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ueh_s_(status, n, x, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_ueh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                            ne::Ptr{Cint}, le::Ptr{Cint}, iprnhi::Ptr{Cint},
                                            iprhi::Ptr{Cint}, lirnhi::Ptr{Cint}, irnhi::Ptr{Cint},
                                            lhi::Ptr{Cint}, hi::Ptr{Float32},
                                            byrows::Ptr{Bool})::Cvoid
end

function cutest_ugrdh_s_(status, n, x, g, lh1, h)
  @ccall cutest_lib_path.cutest_ugrdh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                         g::Ptr{Float32}, lh1::Ptr{Cint}, h::Ptr{Float32})::Cvoid
end

function cutest_ugrsh_s_(status, n, x, g, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_ugrsh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                         g::Ptr{Float32}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                         h::Ptr{Float32}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ugreh_s_(status, n, x, g, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
                              byrows)
  @ccall cutest_lib_path.cutest_cint_ugreh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                              g::Ptr{Float32}, ne::Ptr{Cint}, le::Ptr{Cint},
                                              iprnhi::Ptr{Cint}, iprhi::Ptr{Cint},
                                              lirnhi::Ptr{Cint}, irnhi::Ptr{Cint}, lhi::Ptr{Cint},
                                              hi::Ptr{Float32}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cint_uhprod_s_(status, n, goth, x, p, r)
  @ccall cutest_lib_path.cutest_cint_uhprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                               x::Ptr{Float32}, p::Ptr{Float32},
                                               r::Ptr{Float32})::Cvoid
end

function cutest_cint_ushprod_s_(status, n, goth, x, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_ushprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                                x::Ptr{Float32}, nnzp::Ptr{Cint}, indp::Ptr{Cint},
                                                p::Ptr{Float32}, nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                                r::Ptr{Float32})::Cvoid
end

function cutest_ubandh_s_(status, n, x, nsemib, bandh, lbandh, maxsbw)
  @ccall cutest_lib_path.cutest_ubandh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                          nsemib::Ptr{Cint}, bandh::Ptr{Float32}, lbandh::Ptr{Cint},
                                          maxsbw::Ptr{Cint})::Cvoid
end

function cutest_cfn_s_(status, n, m, x, f, c)
  @ccall cutest_lib_path.cutest_cfn_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                       x::Ptr{Float32}, f::Ptr{Float32}, c::Ptr{Float32})::Cvoid
end

function CUTEST_cconst_s(status, m, c)
  @ccall cutest_lib_path.CUTEST_cconst_s(status::Ptr{Cint}, m::Ptr{Cint}, c::Ptr{Float32})::Cvoid
end

function cutest_cint_cofg_s_(status, n, x, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_cofg_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                             f::Ptr{Float32}, g::Ptr{Float32},
                                             grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cofsg_s_(status, n, x, f, nnzg, lg, sg, ivsg, grad)
  @ccall cutest_lib_path.cutest_cint_cofsg_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                              f::Ptr{Float32}, nnzg::Ptr{Cint}, lg::Ptr{Cint},
                                              sg::Ptr{Float32}, ivsg::Ptr{Cint},
                                              grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccfg_s_(status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
  @ccall cutest_lib_path.cutest_cint_ccfg_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                             x::Ptr{Float32}, c::Ptr{Float32}, jtrans::Ptr{Bool},
                                             lcjac1::Ptr{Cint}, lcjac2::Ptr{Cint},
                                             cjac::Ptr{Float32}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_clfg_s_(status, n, m, x, y, f, g, grad)
  @ccall cutest_lib_path.cutest_cint_clfg_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                             x::Ptr{Float32}, y::Ptr{Float32}, f::Ptr{Float32},
                                             g::Ptr{Float32}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cgr_s_(status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac)
  @ccall cutest_lib_path.cutest_cint_cgr_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                            x::Ptr{Float32}, y::Ptr{Float32}, grlagf::Ptr{Bool},
                                            g::Ptr{Float32}, jtrans::Ptr{Bool}, lcjac1::Ptr{Cint},
                                            lcjac2::Ptr{Cint}, cjac::Ptr{Float32})::Cvoid
end

function cutest_cint_csgr_s_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun)
  @ccall cutest_lib_path.cutest_cint_csgr_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                             x::Ptr{Float32}, y::Ptr{Float32}, grlagf::Ptr{Bool},
                                             nnzj::Ptr{Cint}, lcjac::Ptr{Cint}, cjac::Ptr{Float32},
                                             indvar::Ptr{Cint}, indfun::Ptr{Cint})::Cvoid
end

function cutest_cint_csgrp_s_(status, n, nnzj, lj, jvar, jcon)
  @ccall cutest_lib_path.cutest_cint_csgrp_s_(status::Ptr{Cint}, n::Ptr{Cint}, nnzj::Ptr{Cint},
                                              lj::Ptr{Cint}, jvar::Ptr{Cint},
                                              jcon::Ptr{Cint})::Cvoid
end

function cutest_cint_csjp_s_(status, nnzj, lj, jvar, jcon)
  @ccall cutest_lib_path.cutest_cint_csjp_s_(status::Ptr{Cint}, nnzj::Ptr{Cint}, lj::Ptr{Cint},
                                             jvar::Ptr{Cint}, jcon::Ptr{Cint})::Cvoid
end

function cutest_cint_ccfsg_s_(status, n, m, x, c, nnzj, lcjac, cjac, indvar, indfun, grad)
  @ccall cutest_lib_path.cutest_cint_ccfsg_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                              x::Ptr{Float32}, c::Ptr{Float32}, nnzj::Ptr{Cint},
                                              lcjac::Ptr{Cint}, cjac::Ptr{Float32},
                                              indvar::Ptr{Cint}, indfun::Ptr{Cint},
                                              grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccifg_s_(status, n, icon, x, ci, gci, grad)
  @ccall cutest_lib_path.cutest_cint_ccifg_s_(status::Ptr{Cint}, n::Ptr{Cint}, icon::Ptr{Cint},
                                              x::Ptr{Float32}, ci::Ptr{Float32}, gci::Ptr{Float32},
                                              grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccifsg_s_(status, n, con, x, ci, nnzsgc, lsgci, sgci, ivsgci, grad)
  @ccall cutest_lib_path.cutest_cint_ccifsg_s_(status::Ptr{Cint}, n::Ptr{Cint}, con::Ptr{Cint},
                                               x::Ptr{Float32}, ci::Ptr{Float32}, nnzsgc::Ptr{Cint},
                                               lsgci::Ptr{Cint}, sgci::Ptr{Float32},
                                               ivsgci::Ptr{Cint}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cgrdh_s_(status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac, lh1, h)
  @ccall cutest_lib_path.cutest_cint_cgrdh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                              x::Ptr{Float32}, y::Ptr{Float32}, grlagf::Ptr{Bool},
                                              g::Ptr{Float32}, jtrans::Ptr{Bool}, lcjac1::Ptr{Cint},
                                              lcjac2::Ptr{Cint}, cjac::Ptr{Float32}, lh1::Ptr{Cint},
                                              h::Ptr{Float32})::Cvoid
end

function cutest_cdh_s_(status, n, m, x, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                       x::Ptr{Float32}, y::Ptr{Float32}, lh1::Ptr{Cint},
                                       h::Ptr{Float32})::Cvoid
end

function cutest_cdhc_s_(status, n, m, x, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdhc_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                        x::Ptr{Float32}, y::Ptr{Float32}, lh1::Ptr{Cint},
                                        h::Ptr{Float32})::Cvoid
end

function cutest_cdhj_s_(status, n, m, x, y0, y, lh1, h)
  @ccall cutest_lib_path.cutest_cdhj_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                        x::Ptr{Float32}, y0::Ptr{Float32}, y::Ptr{Float32},
                                        lh1::Ptr{Cint}, h::Ptr{Float32})::Cvoid
end

function cutest_cshp_s_(status, n, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshp_s_(status::Ptr{Cint}, n::Ptr{Cint}, nnzh::Ptr{Cint},
                                        lh::Ptr{Cint}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_csh_s_(status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_csh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                       x::Ptr{Float32}, y::Ptr{Float32}, nnzh::Ptr{Cint},
                                       lh::Ptr{Cint}, h::Ptr{Float32}, irnh::Ptr{Cint},
                                       icnh::Ptr{Cint})::Cvoid
end

function cutest_cshc_s_(status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshc_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                        x::Ptr{Float32}, y::Ptr{Float32}, nnzh::Ptr{Cint},
                                        lh::Ptr{Cint}, h::Ptr{Float32}, irnh::Ptr{Cint},
                                        icnh::Ptr{Cint})::Cvoid
end

function cutest_cshj_s_(status, n, m, x, y0, y, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cshj_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                        x::Ptr{Float32}, y0::Ptr{Float32}, y::Ptr{Float32},
                                        nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float32},
                                        irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ceh_s_(status, n, m, x, y, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
                            byrows)
  @ccall cutest_lib_path.cutest_cint_ceh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                            x::Ptr{Float32}, y::Ptr{Float32}, ne::Ptr{Cint},
                                            le::Ptr{Cint}, iprnhi::Ptr{Cint}, iprhi::Ptr{Cint},
                                            lirnhi::Ptr{Cint}, irnhi::Ptr{Cint}, lhi::Ptr{Cint},
                                            hi::Ptr{Float32}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cifn_s_(status, n, iprob, x, f)
  @ccall cutest_lib_path.cutest_cifn_s_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint},
                                        x::Ptr{Float32}, f::Ptr{Float32})::Cvoid
end

function cutest_cigr_s_(status, n, iprob, x, g)
  @ccall cutest_lib_path.cutest_cigr_s_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint},
                                        x::Ptr{Float32}, g::Ptr{Float32})::Cvoid
end

function cutest_cisgr_s_(status, n, iprob, x, nnzg, lg, sg, ivsg)
  @ccall cutest_lib_path.cutest_cisgr_s_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint},
                                         x::Ptr{Float32}, nnzg::Ptr{Cint}, lg::Ptr{Cint},
                                         sg::Ptr{Float32}, ivsg::Ptr{Cint})::Cvoid
end

function cutest_cisgrp_s_(status, n, iprob, nnzg, lg, ivsg)
  @ccall cutest_lib_path.cutest_cisgrp_s_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint},
                                          nnzg::Ptr{Cint}, lg::Ptr{Cint}, ivsg::Ptr{Cint})::Cvoid
end

function cutest_cidh_s_(status, n, x, iprob, lh1, h)
  @ccall cutest_lib_path.cutest_cidh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                        iprob::Ptr{Cint}, lh1::Ptr{Cint}, h::Ptr{Float32})::Cvoid
end

function cutest_cish_s_(status, n, x, iprob, nnzh, lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cish_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                        iprob::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                        h::Ptr{Float32}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgrsh_s_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun, nnzh,
                               lh, h, irnh, icnh)
  @ccall cutest_lib_path.cutest_cint_csgrsh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                               x::Ptr{Float32}, y::Ptr{Float32}, grlagf::Ptr{Bool},
                                               nnzj::Ptr{Cint}, lcjac::Ptr{Cint},
                                               cjac::Ptr{Float32}, indvar::Ptr{Cint},
                                               indfun::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                               h::Ptr{Float32}, irnh::Ptr{Cint},
                                               icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgrshp_s_(status, n, nnzj, lcjac, indvar, indfun, nnzh, lh, irnh, icnh)
  @ccall cutest_lib_path.cutest_cint_csgrshp_s_(status::Ptr{Cint}, n::Ptr{Cint}, nnzj::Ptr{Cint},
                                                lcjac::Ptr{Cint}, indvar::Ptr{Cint},
                                                indfun::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                                irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgreh_s_(status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun, ne,
                               le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  @ccall cutest_lib_path.cutest_cint_csgreh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                               x::Ptr{Float32}, y::Ptr{Float32}, grlagf::Ptr{Bool},
                                               nnzj::Ptr{Cint}, lcjac::Ptr{Cint},
                                               cjac::Ptr{Float32}, indvar::Ptr{Cint},
                                               indfun::Ptr{Cint}, ne::Ptr{Cint}, le::Ptr{Cint},
                                               iprnhi::Ptr{Cint}, iprhi::Ptr{Cint},
                                               lirnhi::Ptr{Cint}, irnhi::Ptr{Cint}, lhi::Ptr{Cint},
                                               hi::Ptr{Float32}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cint_chprod_s_(status, n, m, goth, x, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                               goth::Ptr{Bool}, x::Ptr{Float32}, y::Ptr{Float32},
                                               p::Ptr{Float32}, q::Ptr{Float32})::Cvoid
end

function cutest_cint_chsprod_s_(status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_chsprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                                goth::Ptr{Bool}, x::Ptr{Float32}, y::Ptr{Float32},
                                                nnzp::Ptr{Cint}, indp::Ptr{Cint}, p::Ptr{Float32},
                                                nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                                r::Ptr{Float32})::Cvoid
end

function cutest_cint_chcprod_s_(status, n, m, goth, x, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chcprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                                goth::Ptr{Bool}, x::Ptr{Float32}, y::Ptr{Float32},
                                                p::Ptr{Float32}, q::Ptr{Float32})::Cvoid
end

function cutest_cint_cshcprod_s_(status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  @ccall cutest_lib_path.cutest_cint_cshcprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                                 goth::Ptr{Bool}, x::Ptr{Float32}, y::Ptr{Float32},
                                                 nnzp::Ptr{Cint}, indp::Ptr{Cint}, p::Ptr{Float32},
                                                 nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                                 r::Ptr{Float32})::Cvoid
end

function cutest_cint_chjprod_s_(status, n, m, goth, x, y0, y, p, q)
  @ccall cutest_lib_path.cutest_cint_chjprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                                goth::Ptr{Bool}, x::Ptr{Float32}, y0::Ptr{Float32},
                                                y::Ptr{Float32}, p::Ptr{Float32},
                                                q::Ptr{Float32})::Cvoid
end

function cutest_cint_cjprod_s_(status, n, m, gotj, jtrans, x, p, lp, r, lr)
  @ccall cutest_lib_path.cutest_cint_cjprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                               gotj::Ptr{Bool}, jtrans::Ptr{Bool}, x::Ptr{Float32},
                                               p::Ptr{Float32}, lp::Ptr{Cint}, r::Ptr{Float32},
                                               lr::Ptr{Cint})::Cvoid
end

function cutest_cint_csjprod_s_(status, n, m, gotj, jtrans, x, nnzp, indp, p, lp, nnzr, indr, r, lr)
  @ccall cutest_lib_path.cutest_cint_csjprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                                gotj::Ptr{Bool}, jtrans::Ptr{Bool}, x::Ptr{Float32},
                                                nnzp::Ptr{Cint}, indp::Ptr{Cint}, p::Ptr{Float32},
                                                lp::Ptr{Cint}, nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                                r::Ptr{Float32}, lr::Ptr{Cint})::Cvoid
end

function cutest_cint_cchprods_s_(status, n, m, goth, x, p, lchp, chpval, chpind, chpptr)
  @ccall cutest_lib_path.cutest_cint_cchprods_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                                 goth::Ptr{Bool}, x::Ptr{Float32}, p::Ptr{Float32},
                                                 lchp::Ptr{Cint}, chpval::Ptr{Float32},
                                                 chpind::Ptr{Cint}, chpptr::Ptr{Cint})::Cvoid
end

function cutest_cint_cchprodsp_s_(status, m, lchp, chpind, chpptr)
  @ccall cutest_lib_path.cutest_cint_cchprodsp_s_(status::Ptr{Cint}, m::Ptr{Cint}, lchp::Ptr{Cint},
                                                  chpind::Ptr{Cint}, chpptr::Ptr{Cint})::Cvoid
end

function cutest_cint_cohprods_s_(status, n, goth, x, p, nnzohp, lohp, ohpval, ohpind)
  @ccall cutest_lib_path.cutest_cint_cohprods_s_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                                 x::Ptr{Float32}, p::Ptr{Float32},
                                                 nnzohp::Ptr{Cint}, lohp::Ptr{Cint},
                                                 ohpval::Ptr{Float32}, ohpind::Ptr{Cint})::Cvoid
end

function cutest_cohprodsp_s_(status, nnzohp, lohp, chpind)
  @ccall cutest_lib_path.cutest_cohprodsp_s_(status::Ptr{Cint}, nnzohp::Ptr{Cint}, lohp::Ptr{Cint},
                                             chpind::Ptr{Cint})::Cvoid
end

function cutest_uterminate_s_(status)
  @ccall cutest_lib_path.cutest_uterminate_s_(status::Ptr{Cint})::Cvoid
end

function cutest_cterminate_s_(status)
  @ccall cutest_lib_path.cutest_cterminate_s_(status::Ptr{Cint})::Cvoid
end

function fortran_open_(funit, fname, ierr)
  fortran_open_ptr = Libdl.dlsym(cutest_lib, :fortran_open_)
  @ccall $fortran_open_ptr(funit::Ptr{Cint}, fname::Ptr{Cchar}, ierr::Ptr{Cint})::Cvoid
end

function fortran_close_(funit, ierr)
  fortran_close_ptr = Libdl.dlsym(cutest_lib, :fortran_close_)
  @ccall $fortran_close_ptr(funit::Ptr{Cint}, ierr::Ptr{Cint})::Cvoid
end
#! format: on
