#! format: off
function cutest_usetup_(libsif, status, funit, iout, io_buffer, n, x, bl, bu)
  ptr_cutest_usetup_ = Libdl.dlsym(libsif, :cutest_usetup_)
  @ccall $ptr_cutest_usetup_(status::Ptr{Cint}, funit::Ptr{Cint}, iout::Ptr{Cint},
                             io_buffer::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, bl::Ptr{Float64},
                             bu::Ptr{Float64})::Cvoid
end

function cutest_cint_csetup_(libsif, status, funit, iout, io_buffer, n, m, x, bl, bu, v, cl, cu,
                             equatn, linear, e_order, l_order, v_order)
  ptr_cutest_cint_csetup_ = Libdl.dlsym(libsif, :cutest_cint_csetup_)
  @ccall $ptr_cutest_cint_csetup_(status::Ptr{Cint}, funit::Ptr{Cint}, iout::Ptr{Cint},
                                  io_buffer::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                  bl::Ptr{Float64}, bu::Ptr{Float64}, v::Ptr{Float64},
                                  cl::Ptr{Float64}, cu::Ptr{Float64}, equatn::Ptr{Bool},
                                  linear::Ptr{Bool}, e_order::Ptr{Cint}, l_order::Ptr{Cint},
                                  v_order::Ptr{Cint})::Cvoid
end

function cutest_udimen_(libsif, status, funit, n)
  ptr_cutest_udimen_ = Libdl.dlsym(libsif, :cutest_udimen_)
  @ccall $ptr_cutest_udimen_(status::Ptr{Cint}, funit::Ptr{Cint}, n::Ptr{Cint})::Cvoid
end

function cutest_udimsh_(libsif, status, nnzh)
  ptr_cutest_udimsh_ = Libdl.dlsym(libsif, :cutest_udimsh_)
  @ccall $ptr_cutest_udimsh_(status::Ptr{Cint}, nnzh::Ptr{Cint})::Cvoid
end

function cutest_udimse_(libsif, status, ne, nzh, nzirnh)
  ptr_cutest_udimse_ = Libdl.dlsym(libsif, :cutest_udimse_)
  @ccall $ptr_cutest_udimse_(status::Ptr{Cint}, ne::Ptr{Cint}, nzh::Ptr{Cint},
                             nzirnh::Ptr{Cint})::Cvoid
end

function cutest_uvartype_(libsif, status, n, ivarty)
  ptr_cutest_uvartype_ = Libdl.dlsym(libsif, :cutest_uvartype_)
  @ccall $ptr_cutest_uvartype_(status::Ptr{Cint}, n::Ptr{Cint}, ivarty::Ptr{Cint})::Cvoid
end

function cutest_unames_(libsif, status, n, pname, vnames)
  ptr_cutest_unames_ = Libdl.dlsym(libsif, :cutest_unames_)
  @ccall $ptr_cutest_unames_(status::Ptr{Cint}, n::Ptr{Cint}, pname::Ptr{Cchar},
                             vnames::Ptr{Cchar})::Cvoid
end

function cutest_ureport_(libsif, status, calls, time)
  ptr_cutest_ureport_ = Libdl.dlsym(libsif, :cutest_ureport_)
  @ccall $ptr_cutest_ureport_(status::Ptr{Cint}, calls::Ptr{Float64}, time::Ptr{Float64})::Cvoid
end

function cutest_cdimen_(libsif, status, funit, n, m)
  ptr_cutest_cdimen_ = Libdl.dlsym(libsif, :cutest_cdimen_)
  @ccall $ptr_cutest_cdimen_(status::Ptr{Cint}, funit::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint})::Cvoid
end

function cutest_cint_cnoobj_(libsif, status, funit, noobj)
  ptr_cutest_cint_cnoobj_ = Libdl.dlsym(libsif, :cutest_cint_cnoobj_)
  @ccall $ptr_cutest_cint_cnoobj_(status::Ptr{Cint}, funit::Ptr{Cint}, noobj::Ptr{Bool})::Cvoid
end

function cutest_cdimsg_(libsif, status, nnzg)
  ptr_cutest_cdimsg_ = Libdl.dlsym(libsif, :cutest_cdimsg_)
  @ccall $ptr_cutest_cdimsg_(status::Ptr{Cint}, nnzg::Ptr{Cint})::Cvoid
end

function cutest_cdimsj_(libsif, status, nnzj)
  ptr_cutest_cdimsj_ = Libdl.dlsym(libsif, :cutest_cdimsj_)
  @ccall $ptr_cutest_cdimsj_(status::Ptr{Cint}, nnzj::Ptr{Cint})::Cvoid
end

function cutest_cdimsh_(libsif, status, nnzh)
  ptr_cutest_cdimsh_ = Libdl.dlsym(libsif, :cutest_cdimsh_)
  @ccall $ptr_cutest_cdimsh_(status::Ptr{Cint}, nnzh::Ptr{Cint})::Cvoid
end

function cutest_cdimohp_(libsif, status, nnzohp)
  ptr_cutest_cdimohp_ = Libdl.dlsym(libsif, :cutest_cdimohp_)
  @ccall $ptr_cutest_cdimohp_(status::Ptr{Cint}, nnzohp::Ptr{Cint})::Cvoid
end

function cutest_cdimchp_(libsif, status, nnzchp)
  ptr_cutest_cdimchp_ = Libdl.dlsym(libsif, :cutest_cdimchp_)
  @ccall $ptr_cutest_cdimchp_(status::Ptr{Cint}, nnzchp::Ptr{Cint})::Cvoid
end

function cutest_cdimse_(libsif, status, ne, nzh, nzirnh)
  ptr_cutest_cdimse_ = Libdl.dlsym(libsif, :cutest_cdimse_)
  @ccall $ptr_cutest_cdimse_(status::Ptr{Cint}, ne::Ptr{Cint}, nzh::Ptr{Cint},
                             nzirnh::Ptr{Cint})::Cvoid
end

function cutest_cstats_(libsif, status, nonlinear_variables_objective,
                        nonlinear_variables_constraints, equality_constraints, linear_constraints)
  ptr_cutest_cstats_ = Libdl.dlsym(libsif, :cutest_cstats_)
  @ccall $ptr_cutest_cstats_(status::Ptr{Cint}, nonlinear_variables_objective::Ptr{Cint},
                             nonlinear_variables_constraints::Ptr{Cint},
                             equality_constraints::Ptr{Cint}, linear_constraints::Ptr{Cint})::Cvoid
end

function cutest_cvartype_(libsif, status, n, ivarty)
  ptr_cutest_cvartype_ = Libdl.dlsym(libsif, :cutest_cvartype_)
  @ccall $ptr_cutest_cvartype_(status::Ptr{Cint}, n::Ptr{Cint}, ivarty::Ptr{Cint})::Cvoid
end

function cutest_cnames_(libsif, status, n, m, pname, vnames, gnames)
  ptr_cutest_cnames_ = Libdl.dlsym(libsif, :cutest_cnames_)
  @ccall $ptr_cutest_cnames_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, pname::Ptr{Cchar},
                             vnames::Ptr{Cchar}, gnames::Ptr{Cchar})::Cvoid
end

function cutest_creport_(libsif, status, calls, time)
  ptr_cutest_creport_ = Libdl.dlsym(libsif, :cutest_creport_)
  @ccall $ptr_cutest_creport_(status::Ptr{Cint}, calls::Ptr{Float64}, time::Ptr{Float64})::Cvoid
end

function cutest_connames_(libsif, status, m, gname)
  ptr_cutest_connames_ = Libdl.dlsym(libsif, :cutest_connames_)
  @ccall $ptr_cutest_connames_(status::Ptr{Cint}, m::Ptr{Cint}, gname::Ptr{Cchar})::Cvoid
end

function cutest_pname_(libsif, status, funit, pname)
  ptr_cutest_pname_ = Libdl.dlsym(libsif, :cutest_pname_)
  @ccall $ptr_cutest_pname_(status::Ptr{Cint}, funit::Ptr{Cint}, pname::Ptr{Cchar})::Cvoid
end

function cutest_probname_(libsif, status, pname)
  ptr_cutest_probname_ = Libdl.dlsym(libsif, :cutest_probname_)
  @ccall $ptr_cutest_probname_(status::Ptr{Cint}, pname::Ptr{Cchar})::Cvoid
end

function cutest_varnames_(libsif, status, n, vname)
  ptr_cutest_varnames_ = Libdl.dlsym(libsif, :cutest_varnames_)
  @ccall $ptr_cutest_varnames_(status::Ptr{Cint}, n::Ptr{Cint}, vname::Ptr{Cchar})::Cvoid
end

function cutest_ufn_(libsif, status, n, x, f)
  ptr_cutest_ufn_ = Libdl.dlsym(libsif, :cutest_ufn_)
  @ccall $ptr_cutest_ufn_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, f::Ptr{Float64})::Cvoid
end

function cutest_ugr_(libsif, status, n, x, g)
  ptr_cutest_ugr_ = Libdl.dlsym(libsif, :cutest_ugr_)
  @ccall $ptr_cutest_ugr_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, g::Ptr{Float64})::Cvoid
end

function cutest_cint_uofg_(libsif, status, n, x, f, g, grad)
  ptr_cutest_cint_uofg_ = Libdl.dlsym(libsif, :cutest_cint_uofg_)
  @ccall $ptr_cutest_cint_uofg_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, f::Ptr{Float64},
                                g::Ptr{Float64}, grad::Ptr{Bool})::Cvoid
end

function cutest_udh_(libsif, status, n, x, lh1, h)
  ptr_cutest_udh_ = Libdl.dlsym(libsif, :cutest_udh_)
  @ccall $ptr_cutest_udh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, lh1::Ptr{Cint},
                          h::Ptr{Float64})::Cvoid
end

function cutest_ushp_(libsif, status, n, nnzh, lh, irnh, icnh)
  ptr_cutest_ushp_ = Libdl.dlsym(libsif, :cutest_ushp_)
  @ccall $ptr_cutest_ushp_(status::Ptr{Cint}, n::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                           irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_ush_(libsif, status, n, x, nnzh, lh, h, irnh, icnh)
  ptr_cutest_ush_ = Libdl.dlsym(libsif, :cutest_ush_)
  @ccall $ptr_cutest_ush_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, nnzh::Ptr{Cint},
                          lh::Ptr{Cint}, h::Ptr{Float64}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ueh_(libsif, status, n, x, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
                          byrows)
  ptr_cutest_cint_ueh_ = Libdl.dlsym(libsif, :cutest_cint_ueh_)
  @ccall $ptr_cutest_cint_ueh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, ne::Ptr{Cint},
                               le::Ptr{Cint}, iprnhi::Ptr{Cint}, iprhi::Ptr{Cint},
                               lirnhi::Ptr{Cint}, irnhi::Ptr{Cint}, lhi::Ptr{Cint},
                               hi::Ptr{Float64}, byrows::Ptr{Bool})::Cvoid
end

function cutest_ugrdh_(libsif, status, n, x, g, lh1, h)
  ptr_cutest_ugrdh_ = Libdl.dlsym(libsif, :cutest_ugrdh_)
  @ccall $ptr_cutest_ugrdh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, g::Ptr{Float64},
                            lh1::Ptr{Cint}, h::Ptr{Float64})::Cvoid
end

function cutest_ugrsh_(libsif, status, n, x, g, nnzh, lh, h, irnh, icnh)
  ptr_cutest_ugrsh_ = Libdl.dlsym(libsif, :cutest_ugrsh_)
  @ccall $ptr_cutest_ugrsh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, g::Ptr{Float64},
                            nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float64}, irnh::Ptr{Cint},
                            icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ugreh_(libsif, status, n, x, g, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
                            byrows)
  ptr_cutest_cint_ugreh_ = Libdl.dlsym(libsif, :cutest_cint_ugreh_)
  @ccall $ptr_cutest_cint_ugreh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, g::Ptr{Float64},
                                 ne::Ptr{Cint}, le::Ptr{Cint}, iprnhi::Ptr{Cint}, iprhi::Ptr{Cint},
                                 lirnhi::Ptr{Cint}, irnhi::Ptr{Cint}, lhi::Ptr{Cint},
                                 hi::Ptr{Float64}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cint_uhprod_(libsif, status, n, goth, x, p, r)
  ptr_cutest_cint_uhprod_ = Libdl.dlsym(libsif, :cutest_cint_uhprod_)
  @ccall $ptr_cutest_cint_uhprod_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool}, x::Ptr{Float64},
                                  p::Ptr{Float64}, r::Ptr{Float64})::Cvoid
end

function cutest_cint_ushprod_(libsif, status, n, goth, x, nnzp, indp, p, nnzr, indr, r)
  ptr_cutest_cint_ushprod_ = Libdl.dlsym(libsif, :cutest_cint_ushprod_)
  @ccall $ptr_cutest_cint_ushprod_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                   x::Ptr{Float64}, nnzp::Ptr{Cint}, indp::Ptr{Cint},
                                   p::Ptr{Float64}, nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                   r::Ptr{Float64})::Cvoid
end

function cutest_ubandh_(libsif, status, n, x, nsemib, bandh, lbandh, maxsbw)
  ptr_cutest_ubandh_ = Libdl.dlsym(libsif, :cutest_ubandh_)
  @ccall $ptr_cutest_ubandh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, nsemib::Ptr{Cint},
                             bandh::Ptr{Float64}, lbandh::Ptr{Cint}, maxsbw::Ptr{Cint})::Cvoid
end

function cutest_cfn_(libsif, status, n, m, x, f, c)
  ptr_cutest_cfn_ = Libdl.dlsym(libsif, :cutest_cfn_)
  @ccall $ptr_cutest_cfn_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                          f::Ptr{Float64}, c::Ptr{Float64})::Cvoid
end

function cutest_cconst_(libsif, status, m, c)
  ptr_cutest_cconst_ = Libdl.dlsym(libsif, :cutest_cconst_)
  @ccall $ptr_cutest_cconst_(status::Ptr{Cint}, m::Ptr{Cint}, c::Ptr{Float64})::Cvoid
end

function cutest_cint_cofg_(libsif, status, n, x, f, g, grad)
  ptr_cutest_cint_cofg_ = Libdl.dlsym(libsif, :cutest_cint_cofg_)
  @ccall $ptr_cutest_cint_cofg_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, f::Ptr{Float64},
                                g::Ptr{Float64}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cofsg_(libsif, status, n, x, f, nnzg, lg, sg, ivsg, grad)
  ptr_cutest_cint_cofsg_ = Libdl.dlsym(libsif, :cutest_cint_cofsg_)
  @ccall $ptr_cutest_cint_cofsg_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, f::Ptr{Float64},
                                 nnzg::Ptr{Cint}, lg::Ptr{Cint}, sg::Ptr{Float64}, ivsg::Ptr{Cint},
                                 grad::Ptr{Bool})::Cvoid
end

function cutest_ccf_(libsif, status, n, m, x, c)
  ptr_cutest_ccf_ = Libdl.dlsym(libsif, :cutest_ccf_)
  @ccall $ptr_cutest_ccf_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                          c::Ptr{Float64})::Cvoid
end

function cutest_cint_ccfg_(libsif, status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
  ptr_cutest_cint_ccfg_ = Libdl.dlsym(libsif, :cutest_cint_ccfg_)
  @ccall $ptr_cutest_cint_ccfg_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                c::Ptr{Float64}, jtrans::Ptr{Bool}, lcjac1::Ptr{Cint},
                                lcjac2::Ptr{Cint}, cjac::Ptr{Float64}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_clfg_(libsif, status, n, m, x, y, f, g, grad)
  ptr_cutest_cint_clfg_ = Libdl.dlsym(libsif, :cutest_cint_clfg_)
  @ccall $ptr_cutest_cint_clfg_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                y::Ptr{Float64}, f::Ptr{Float64}, g::Ptr{Float64},
                                grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cgr_(libsif, status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac)
  ptr_cutest_cint_cgr_ = Libdl.dlsym(libsif, :cutest_cint_cgr_)
  @ccall $ptr_cutest_cint_cgr_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                               y::Ptr{Float64}, grlagf::Ptr{Bool}, g::Ptr{Float64},
                               jtrans::Ptr{Bool}, lcjac1::Ptr{Cint}, lcjac2::Ptr{Cint},
                               cjac::Ptr{Float64})::Cvoid
end

function cutest_cint_csgr_(libsif, status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun)
  ptr_cutest_cint_csgr_ = Libdl.dlsym(libsif, :cutest_cint_csgr_)
  @ccall $ptr_cutest_cint_csgr_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                y::Ptr{Float64}, grlagf::Ptr{Bool}, nnzj::Ptr{Cint},
                                lcjac::Ptr{Cint}, cjac::Ptr{Float64}, indvar::Ptr{Cint},
                                indfun::Ptr{Cint})::Cvoid
end

function cutest_csgrp_(libsif, status, n, nnzj, lj, jvar, jcon)
  ptr_cutest_csgrp_ = Libdl.dlsym(libsif, :cutest_csgrp_)
  @ccall $ptr_cutest_csgrp_(status::Ptr{Cint}, n::Ptr{Cint}, nnzj::Ptr{Cint}, lj::Ptr{Cint},
                            jvar::Ptr{Cint}, jcon::Ptr{Cint})::Cvoid
end

function cutest_csjp_(libsif, status, nnzj, lj, jvar, jcon)
  ptr_cutest_csjp_ = Libdl.dlsym(libsif, :cutest_csjp_)
  @ccall $ptr_cutest_csjp_(status::Ptr{Cint}, nnzj::Ptr{Cint}, lj::Ptr{Cint}, jvar::Ptr{Cint},
                           jcon::Ptr{Cint})::Cvoid
end

function cutest_cint_ccfsg_(libsif, status, n, m, x, c, nnzj, lcjac, cjac, indvar, indfun, grad)
  ptr_cutest_cint_ccfsg_ = Libdl.dlsym(libsif, :cutest_cint_ccfsg_)
  @ccall $ptr_cutest_cint_ccfsg_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                 c::Ptr{Float64}, nnzj::Ptr{Cint}, lcjac::Ptr{Cint},
                                 cjac::Ptr{Float64}, indvar::Ptr{Cint}, indfun::Ptr{Cint},
                                 grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccifg_(libsif, status, n, icon, x, ci, gci, grad)
  ptr_cutest_cint_ccifg_ = Libdl.dlsym(libsif, :cutest_cint_ccifg_)
  @ccall $ptr_cutest_cint_ccifg_(status::Ptr{Cint}, n::Ptr{Cint}, icon::Ptr{Cint}, x::Ptr{Float64},
                                 ci::Ptr{Float64}, gci::Ptr{Float64}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccifsg_(libsif, status, n, con, x, ci, nnzsgc, lsgci, sgci, ivsgci, grad)
  ptr_cutest_cint_ccifsg_ = Libdl.dlsym(libsif, :cutest_cint_ccifsg_)
  @ccall $ptr_cutest_cint_ccifsg_(status::Ptr{Cint}, n::Ptr{Cint}, con::Ptr{Cint}, x::Ptr{Float64},
                                  ci::Ptr{Float64}, nnzsgc::Ptr{Cint}, lsgci::Ptr{Cint},
                                  sgci::Ptr{Float64}, ivsgci::Ptr{Cint}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cgrdh_(libsif, status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac,
                            lh1, h)
  ptr_cutest_cint_cgrdh_ = Libdl.dlsym(libsif, :cutest_cint_cgrdh_)
  @ccall $ptr_cutest_cint_cgrdh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                 y::Ptr{Float64}, grlagf::Ptr{Bool}, g::Ptr{Float64},
                                 jtrans::Ptr{Bool}, lcjac1::Ptr{Cint}, lcjac2::Ptr{Cint},
                                 cjac::Ptr{Float64}, lh1::Ptr{Cint}, h::Ptr{Float64})::Cvoid
end

function cutest_cdh_(libsif, status, n, m, x, y, lh1, h)
  ptr_cutest_cdh_ = Libdl.dlsym(libsif, :cutest_cdh_)
  @ccall $ptr_cutest_cdh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                          y::Ptr{Float64}, lh1::Ptr{Cint}, h::Ptr{Float64})::Cvoid
end

function cutest_cdhc_(libsif, status, n, m, x, y, lh1, h)
  ptr_cutest_cdhc_ = Libdl.dlsym(libsif, :cutest_cdhc_)
  @ccall $ptr_cutest_cdhc_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                           y::Ptr{Float64}, lh1::Ptr{Cint}, h::Ptr{Float64})::Cvoid
end

function cutest_cdhj_(libsif, status, n, m, x, y0, y, lh1, h)
  ptr_cutest_cdhj_ = Libdl.dlsym(libsif, :cutest_cdhj_)
  @ccall $ptr_cutest_cdhj_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                           y0::Ptr{Float64}, y::Ptr{Float64}, lh1::Ptr{Cint},
                           h::Ptr{Float64})::Cvoid
end

function cutest_cshp_(libsif, status, n, nnzh, lh, irnh, icnh)
  ptr_cutest_cshp_ = Libdl.dlsym(libsif, :cutest_cshp_)
  @ccall $ptr_cutest_cshp_(status::Ptr{Cint}, n::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                           irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_csh_(libsif, status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  ptr_cutest_csh_ = Libdl.dlsym(libsif, :cutest_csh_)
  @ccall $ptr_cutest_csh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                          y::Ptr{Float64}, nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float64},
                          irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cshc_(libsif, status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cshc_ = Libdl.dlsym(libsif, :cutest_cshc_)
  @ccall $ptr_cutest_cshc_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                           y::Ptr{Float64}, nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float64},
                           irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cshj_(libsif, status, n, m, x, y0, y, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cshj_ = Libdl.dlsym(libsif, :cutest_cshj_)
  @ccall $ptr_cutest_cshj_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                           y0::Ptr{Float64}, y::Ptr{Float64}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                           h::Ptr{Float64}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ceh_(libsif, status, n, m, x, y, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
                          byrows)
  ptr_cutest_cint_ceh_ = Libdl.dlsym(libsif, :cutest_cint_ceh_)
  @ccall $ptr_cutest_cint_ceh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                               y::Ptr{Float64}, ne::Ptr{Cint}, le::Ptr{Cint}, iprnhi::Ptr{Cint},
                               iprhi::Ptr{Cint}, lirnhi::Ptr{Cint}, irnhi::Ptr{Cint},
                               lhi::Ptr{Cint}, hi::Ptr{Float64}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cifn_(libsif, status, n, iprob, x, f)
  ptr_cutest_cifn_ = Libdl.dlsym(libsif, :cutest_cifn_)
  @ccall $ptr_cutest_cifn_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, x::Ptr{Float64},
                           f::Ptr{Float64})::Cvoid
end

function cutest_cigr_(libsif, status, n, iprob, x, g)
  ptr_cutest_cigr_ = Libdl.dlsym(libsif, :cutest_cigr_)
  @ccall $ptr_cutest_cigr_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, x::Ptr{Float64},
                           g::Ptr{Float64})::Cvoid
end

function cutest_cisgr_(libsif, status, n, iprob, x, nnzg, lg, sg, ivsg)
  ptr_cutest_cisgr_ = Libdl.dlsym(libsif, :cutest_cisgr_)
  @ccall $ptr_cutest_cisgr_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, x::Ptr{Float64},
                            nnzg::Ptr{Cint}, lg::Ptr{Cint}, sg::Ptr{Float64},
                            ivsg::Ptr{Cint})::Cvoid
end

function cutest_cisgrp_(libsif, status, n, iprob, nnzg, lg, ivsg)
  ptr_cutest_cisgrp_ = Libdl.dlsym(libsif, :cutest_cisgrp_)
  @ccall $ptr_cutest_cisgrp_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, nnzg::Ptr{Cint},
                             lg::Ptr{Cint}, ivsg::Ptr{Cint})::Cvoid
end

function cutest_cidh_(libsif, status, n, x, iprob, lh1, h)
  ptr_cutest_cidh_ = Libdl.dlsym(libsif, :cutest_cidh_)
  @ccall $ptr_cutest_cidh_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, iprob::Ptr{Cint},
                           lh1::Ptr{Cint}, h::Ptr{Float64})::Cvoid
end

function cutest_cish_(libsif, status, n, x, iprob, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cish_ = Libdl.dlsym(libsif, :cutest_cish_)
  @ccall $ptr_cutest_cish_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float64}, iprob::Ptr{Cint},
                           nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float64}, irnh::Ptr{Cint},
                           icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgrsh_(libsif, status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun,
                             nnzh, lh, h, irnh, icnh)
  ptr_cutest_cint_csgrsh_ = Libdl.dlsym(libsif, :cutest_cint_csgrsh_)
  @ccall $ptr_cutest_cint_csgrsh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                  y::Ptr{Float64}, grlagf::Ptr{Bool}, nnzj::Ptr{Cint},
                                  lcjac::Ptr{Cint}, cjac::Ptr{Float64}, indvar::Ptr{Cint},
                                  indfun::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                  h::Ptr{Float64}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_csgrshp_(libsif, status, n, nnzj, lcjac, indvar, indfun, nnzh, lh, irnh, icnh)
  ptr_cutest_csgrshp_ = Libdl.dlsym(libsif, :cutest_csgrshp_)
  @ccall $ptr_cutest_csgrshp_(status::Ptr{Cint}, n::Ptr{Cint}, nnzj::Ptr{Cint}, lcjac::Ptr{Cint},
                              indvar::Ptr{Cint}, indfun::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                              irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgreh_(libsif, status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun,
                             ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  ptr_cutest_cint_csgreh_ = Libdl.dlsym(libsif, :cutest_cint_csgreh_)
  @ccall $ptr_cutest_cint_csgreh_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float64},
                                  y::Ptr{Float64}, grlagf::Ptr{Bool}, nnzj::Ptr{Cint},
                                  lcjac::Ptr{Cint}, cjac::Ptr{Float64}, indvar::Ptr{Cint},
                                  indfun::Ptr{Cint}, ne::Ptr{Cint}, le::Ptr{Cint},
                                  iprnhi::Ptr{Cint}, iprhi::Ptr{Cint}, lirnhi::Ptr{Cint},
                                  irnhi::Ptr{Cint}, lhi::Ptr{Cint}, hi::Ptr{Float64},
                                  byrows::Ptr{Bool})::Cvoid
end

function cutest_cint_chprod_(libsif, status, n, m, goth, x, y, p, q)
  ptr_cutest_cint_chprod_ = Libdl.dlsym(libsif, :cutest_cint_chprod_)
  @ccall $ptr_cutest_cint_chprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                  x::Ptr{Float64}, y::Ptr{Float64}, p::Ptr{Float64},
                                  q::Ptr{Float64})::Cvoid
end

function cutest_cint_chsprod_(libsif, status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  ptr_cutest_cint_chsprod_ = Libdl.dlsym(libsif, :cutest_cint_chsprod_)
  @ccall $ptr_cutest_cint_chsprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                   x::Ptr{Float64}, y::Ptr{Float64}, nnzp::Ptr{Cint},
                                   indp::Ptr{Cint}, p::Ptr{Float64}, nnzr::Ptr{Cint},
                                   indr::Ptr{Cint}, r::Ptr{Float64})::Cvoid
end

function cutest_cint_chcprod_(libsif, status, n, m, goth, x, y, p, q)
  ptr_cutest_cint_chcprod_ = Libdl.dlsym(libsif, :cutest_cint_chcprod_)
  @ccall $ptr_cutest_cint_chcprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                   x::Ptr{Float64}, y::Ptr{Float64}, p::Ptr{Float64},
                                   q::Ptr{Float64})::Cvoid
end

function cutest_cint_cshcprod_(libsif, status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  ptr_cutest_cint_cshcprod_ = Libdl.dlsym(libsif, :cutest_cint_cshcprod_)
  @ccall $ptr_cutest_cint_cshcprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                    x::Ptr{Float64}, y::Ptr{Float64}, nnzp::Ptr{Cint},
                                    indp::Ptr{Cint}, p::Ptr{Float64}, nnzr::Ptr{Cint},
                                    indr::Ptr{Cint}, r::Ptr{Float64})::Cvoid
end

function cutest_cint_chjprod_(libsif, status, n, m, goth, x, y0, y, p, q)
  ptr_cutest_cint_chjprod_ = Libdl.dlsym(libsif, :cutest_cint_chjprod_)
  @ccall $ptr_cutest_cint_chjprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                   x::Ptr{Float64}, y0::Ptr{Float64}, y::Ptr{Float64},
                                   p::Ptr{Float64}, q::Ptr{Float64})::Cvoid
end

function cutest_cint_cjprod_(libsif, status, n, m, gotj, jtrans, x, p, lp, r, lr)
  ptr_cutest_cint_cjprod_ = Libdl.dlsym(libsif, :cutest_cint_cjprod_)
  @ccall $ptr_cutest_cint_cjprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, gotj::Ptr{Bool},
                                  jtrans::Ptr{Bool}, x::Ptr{Float64}, p::Ptr{Float64},
                                  lp::Ptr{Cint}, r::Ptr{Float64}, lr::Ptr{Cint})::Cvoid
end

function cutest_cint_csjprod_(libsif, status, n, m, gotj, jtrans, x, nnzp, indp, p, lp, nnzr, indr,
                              r, lr)
  ptr_cutest_cint_csjprod_ = Libdl.dlsym(libsif, :cutest_cint_csjprod_)
  @ccall $ptr_cutest_cint_csjprod_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, gotj::Ptr{Bool},
                                   jtrans::Ptr{Bool}, x::Ptr{Float64}, nnzp::Ptr{Cint},
                                   indp::Ptr{Cint}, p::Ptr{Float64}, lp::Ptr{Cint}, nnzr::Ptr{Cint},
                                   indr::Ptr{Cint}, r::Ptr{Float64}, lr::Ptr{Cint})::Cvoid
end

function cutest_cint_cchprods_(libsif, status, n, m, goth, x, p, lchp, chpval, chpind, chpptr)
  ptr_cutest_cint_cchprods_ = Libdl.dlsym(libsif, :cutest_cint_cchprods_)
  @ccall $ptr_cutest_cint_cchprods_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                    x::Ptr{Float64}, p::Ptr{Float64}, lchp::Ptr{Cint},
                                    chpval::Ptr{Float64}, chpind::Ptr{Cint},
                                    chpptr::Ptr{Cint})::Cvoid
end

function cutest_cchprodsp_(libsif, status, m, lchp, chpind, chpptr)
  ptr_cutest_cchprodsp_ = Libdl.dlsym(libsif, :cutest_cchprodsp_)
  @ccall $ptr_cutest_cchprodsp_(status::Ptr{Cint}, m::Ptr{Cint}, lchp::Ptr{Cint}, chpind::Ptr{Cint},
                                chpptr::Ptr{Cint})::Cvoid
end

function cutest_cint_cohprods_(libsif, status, n, goth, x, p, nnzohp, lohp, ohpval, ohpind)
  ptr_cutest_cint_cohprods_ = Libdl.dlsym(libsif, :cutest_cint_cohprods_)
  @ccall $ptr_cutest_cint_cohprods_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                    x::Ptr{Float64}, p::Ptr{Float64}, nnzohp::Ptr{Cint},
                                    lohp::Ptr{Cint}, ohpval::Ptr{Float64}, ohpind::Ptr{Cint})::Cvoid
end

function cutest_cohprodsp_(libsif, status, nnzohp, lohp, chpind)
  ptr_cutest_cohprodsp_ = Libdl.dlsym(libsif, :cutest_cohprodsp_)
  @ccall $ptr_cutest_cohprodsp_(status::Ptr{Cint}, nnzohp::Ptr{Cint}, lohp::Ptr{Cint},
                                chpind::Ptr{Cint})::Cvoid
end

function cutest_uterminate_(libsif, status)
  ptr_cutest_uterminate_ = Libdl.dlsym(libsif, :cutest_uterminate_)
  @ccall $ptr_cutest_uterminate_(status::Ptr{Cint})::Cvoid
end

function cutest_cterminate_(libsif, status)
  ptr_cutest_cterminate_ = Libdl.dlsym(libsif, :cutest_cterminate_)
  @ccall $ptr_cutest_cterminate_(status::Ptr{Cint})::Cvoid
end

function fortran_open_(libsif, funit, fname, ierr)
  ptr_fortran_open_ = Libdl.dlsym(libsif, :fortran_open_)
  @ccall $ptr_fortran_open_(funit::Ptr{Cint}, fname::Ptr{Cchar}, ierr::Ptr{Cint})::Cvoid
end

function fortran_close_(libsif, funit, ierr)
  ptr_fortran_close_ = Libdl.dlsym(libsif, :fortran_close_)
  @ccall $ptr_fortran_close_(funit::Ptr{Cint}, ierr::Ptr{Cint})::Cvoid
end

function cutest_usetup_s_(libsif, status, funit, iout, io_buffer, n, x, bl, bu)
  ptr_cutest_usetup_s_ = Libdl.dlsym(libsif, :cutest_usetup_s_)
  @ccall $ptr_cutest_usetup_s_(status::Ptr{Cint}, funit::Ptr{Cint}, iout::Ptr{Cint},
                               io_buffer::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                               bl::Ptr{Float32}, bu::Ptr{Float32})::Cvoid
end

function cutest_cint_csetup_s_(libsif, status, funit, iout, io_buffer, n, m, x, bl, bu, v, cl, cu,
                               equatn, linear, e_order, l_order, v_order)
  ptr_cutest_cint_csetup_s_ = Libdl.dlsym(libsif, :cutest_cint_csetup_s_)
  @ccall $ptr_cutest_cint_csetup_s_(status::Ptr{Cint}, funit::Ptr{Cint}, iout::Ptr{Cint},
                                    io_buffer::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                    x::Ptr{Float32}, bl::Ptr{Float32}, bu::Ptr{Float32},
                                    v::Ptr{Float32}, cl::Ptr{Float32}, cu::Ptr{Float32},
                                    equatn::Ptr{Bool}, linear::Ptr{Bool}, e_order::Ptr{Cint},
                                    l_order::Ptr{Cint}, v_order::Ptr{Cint})::Cvoid
end

function cutest_udimen_s_(libsif, status, funit, n)
  ptr_cutest_udimen_s_ = Libdl.dlsym(libsif, :cutest_udimen_s_)
  @ccall $ptr_cutest_udimen_s_(status::Ptr{Cint}, funit::Ptr{Cint}, n::Ptr{Cint})::Cvoid
end

function cutest_udimsh_s_(libsif, status, nnzh)
  ptr_cutest_udimsh_s_ = Libdl.dlsym(libsif, :cutest_udimsh_s_)
  @ccall $ptr_cutest_udimsh_s_(status::Ptr{Cint}, nnzh::Ptr{Cint})::Cvoid
end

function cutest_udimse_s_(libsif, status, ne, nzh, nzirnh)
  ptr_cutest_udimse_s_ = Libdl.dlsym(libsif, :cutest_udimse_s_)
  @ccall $ptr_cutest_udimse_s_(status::Ptr{Cint}, ne::Ptr{Cint}, nzh::Ptr{Cint},
                               nzirnh::Ptr{Cint})::Cvoid
end

function cutest_uvartype_s_(libsif, status, n, ivarty)
  ptr_cutest_uvartype_s_ = Libdl.dlsym(libsif, :cutest_uvartype_s_)
  @ccall $ptr_cutest_uvartype_s_(status::Ptr{Cint}, n::Ptr{Cint}, ivarty::Ptr{Cint})::Cvoid
end

function cutest_unames_s_(libsif, status, n, pname, vnames)
  ptr_cutest_unames_s_ = Libdl.dlsym(libsif, :cutest_unames_s_)
  @ccall $ptr_cutest_unames_s_(status::Ptr{Cint}, n::Ptr{Cint}, pname::Ptr{Cchar},
                               vnames::Ptr{Cchar})::Cvoid
end

function cutest_ureport_s_(libsif, status, calls, time)
  ptr_cutest_ureport_s_ = Libdl.dlsym(libsif, :cutest_ureport_s_)
  @ccall $ptr_cutest_ureport_s_(status::Ptr{Cint}, calls::Ptr{Float32}, time::Ptr{Float32})::Cvoid
end

function cutest_cdimen_s_(libsif, status, funit, n, m)
  ptr_cutest_cdimen_s_ = Libdl.dlsym(libsif, :cutest_cdimen_s_)
  @ccall $ptr_cutest_cdimen_s_(status::Ptr{Cint}, funit::Ptr{Cint}, n::Ptr{Cint},
                               m::Ptr{Cint})::Cvoid
end

function cutest_cint_cnoobj_s_(libsif, status, funit, noobj)
  ptr_cutest_cint_cnoobj_s_ = Libdl.dlsym(libsif, :cutest_cint_cnoobj_s_)
  @ccall $ptr_cutest_cint_cnoobj_s_(status::Ptr{Cint}, funit::Ptr{Cint}, noobj::Ptr{Bool})::Cvoid
end

function cutest_cdimsg_s_(libsif, status, nnzg)
  ptr_cutest_cdimsg_s_ = Libdl.dlsym(libsif, :cutest_cdimsg_s_)
  @ccall $ptr_cutest_cdimsg_s_(status::Ptr{Cint}, nnzg::Ptr{Cint})::Cvoid
end

function cutest_cdimsj_s_(libsif, status, nnzj)
  ptr_cutest_cdimsj_s_ = Libdl.dlsym(libsif, :cutest_cdimsj_s_)
  @ccall $ptr_cutest_cdimsj_s_(status::Ptr{Cint}, nnzj::Ptr{Cint})::Cvoid
end

function cutest_cdimsh_s_(libsif, status, nnzh)
  ptr_cutest_cdimsh_s_ = Libdl.dlsym(libsif, :cutest_cdimsh_s_)
  @ccall $ptr_cutest_cdimsh_s_(status::Ptr{Cint}, nnzh::Ptr{Cint})::Cvoid
end

function cutest_cdimohp_s_(libsif, status, nnzohp)
  ptr_cutest_cdimohp_s_ = Libdl.dlsym(libsif, :cutest_cdimohp_s_)
  @ccall $ptr_cutest_cdimohp_s_(status::Ptr{Cint}, nnzohp::Ptr{Cint})::Cvoid
end

function cutest_cdimchp_s_(libsif, status, nnzchp)
  ptr_cutest_cdimchp_s_ = Libdl.dlsym(libsif, :cutest_cdimchp_s_)
  @ccall $ptr_cutest_cdimchp_s_(status::Ptr{Cint}, nnzchp::Ptr{Cint})::Cvoid
end

function cutest_cdimse_s_(libsif, status, ne, nzh, nzirnh)
  ptr_cutest_cdimse_s_ = Libdl.dlsym(libsif, :cutest_cdimse_s_)
  @ccall $ptr_cutest_cdimse_s_(status::Ptr{Cint}, ne::Ptr{Cint}, nzh::Ptr{Cint},
                               nzirnh::Ptr{Cint})::Cvoid
end

function cutest_cstats_s_(libsif, status, nonlinear_variables_objective,
                          nonlinear_variables_constraints, equality_constraints, linear_constraints)
  ptr_cutest_cstats_s_ = Libdl.dlsym(libsif, :cutest_cstats_s_)
  @ccall $ptr_cutest_cstats_s_(status::Ptr{Cint}, nonlinear_variables_objective::Ptr{Cint},
                               nonlinear_variables_constraints::Ptr{Cint},
                               equality_constraints::Ptr{Cint},
                               linear_constraints::Ptr{Cint})::Cvoid
end

function cutest_cvartype_s_(libsif, status, n, ivarty)
  ptr_cutest_cvartype_s_ = Libdl.dlsym(libsif, :cutest_cvartype_s_)
  @ccall $ptr_cutest_cvartype_s_(status::Ptr{Cint}, n::Ptr{Cint}, ivarty::Ptr{Cint})::Cvoid
end

function cutest_cnames_s_(libsif, status, n, m, pname, vnames, gnames)
  ptr_cutest_cnames_s_ = Libdl.dlsym(libsif, :cutest_cnames_s_)
  @ccall $ptr_cutest_cnames_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, pname::Ptr{Cchar},
                               vnames::Ptr{Cchar}, gnames::Ptr{Cchar})::Cvoid
end

function cutest_creport_s_(libsif, status, calls, time)
  ptr_cutest_creport_s_ = Libdl.dlsym(libsif, :cutest_creport_s_)
  @ccall $ptr_cutest_creport_s_(status::Ptr{Cint}, calls::Ptr{Float32}, time::Ptr{Float32})::Cvoid
end

function cutest_connames_s_(libsif, status, m, gname)
  ptr_cutest_connames_s_ = Libdl.dlsym(libsif, :cutest_connames_s_)
  @ccall $ptr_cutest_connames_s_(status::Ptr{Cint}, m::Ptr{Cint}, gname::Ptr{Cchar})::Cvoid
end

function cutest_pname_s_(libsif, status, funit, pname)
  ptr_cutest_pname_s_ = Libdl.dlsym(libsif, :cutest_pname_s_)
  @ccall $ptr_cutest_pname_s_(status::Ptr{Cint}, funit::Ptr{Cint}, pname::Ptr{Cchar})::Cvoid
end

function cutest_probname_s_(libsif, status, pname)
  ptr_cutest_probname_s_ = Libdl.dlsym(libsif, :cutest_probname_s_)
  @ccall $ptr_cutest_probname_s_(status::Ptr{Cint}, pname::Ptr{Cchar})::Cvoid
end

function cutest_varnames_s_(libsif, status, n, vname)
  ptr_cutest_varnames_s_ = Libdl.dlsym(libsif, :cutest_varnames_s_)
  @ccall $ptr_cutest_varnames_s_(status::Ptr{Cint}, n::Ptr{Cint}, vname::Ptr{Cchar})::Cvoid
end

function cutest_ufn_s_(libsif, status, n, x, f)
  ptr_cutest_ufn_s_ = Libdl.dlsym(libsif, :cutest_ufn_s_)
  @ccall $ptr_cutest_ufn_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                            f::Ptr{Float32})::Cvoid
end

function cutest_ugr_s_(libsif, status, n, x, g)
  ptr_cutest_ugr_s_ = Libdl.dlsym(libsif, :cutest_ugr_s_)
  @ccall $ptr_cutest_ugr_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                            g::Ptr{Float32})::Cvoid
end

function cutest_cint_uofg_s_(libsif, status, n, x, f, g, grad)
  ptr_cutest_cint_uofg_s_ = Libdl.dlsym(libsif, :cutest_cint_uofg_s_)
  @ccall $ptr_cutest_cint_uofg_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32}, f::Ptr{Float32},
                                  g::Ptr{Float32}, grad::Ptr{Bool})::Cvoid
end

function cutest_udh_s_(libsif, status, n, x, lh1, h)
  ptr_cutest_udh_s_ = Libdl.dlsym(libsif, :cutest_udh_s_)
  @ccall $ptr_cutest_udh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32}, lh1::Ptr{Cint},
                            h::Ptr{Float32})::Cvoid
end

function cutest_ushp_s_(libsif, status, n, nnzh, lh, irnh, icnh)
  ptr_cutest_ushp_s_ = Libdl.dlsym(libsif, :cutest_ushp_s_)
  @ccall $ptr_cutest_ushp_s_(status::Ptr{Cint}, n::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                             irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_ush_s_(libsif, status, n, x, nnzh, lh, h, irnh, icnh)
  ptr_cutest_ush_s_ = Libdl.dlsym(libsif, :cutest_ush_s_)
  @ccall $ptr_cutest_ush_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32}, nnzh::Ptr{Cint},
                            lh::Ptr{Cint}, h::Ptr{Float32}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ueh_s_(libsif, status, n, x, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
                            byrows)
  ptr_cutest_cint_ueh_s_ = Libdl.dlsym(libsif, :cutest_cint_ueh_s_)
  @ccall $ptr_cutest_cint_ueh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32}, ne::Ptr{Cint},
                                 le::Ptr{Cint}, iprnhi::Ptr{Cint}, iprhi::Ptr{Cint},
                                 lirnhi::Ptr{Cint}, irnhi::Ptr{Cint}, lhi::Ptr{Cint},
                                 hi::Ptr{Float32}, byrows::Ptr{Bool})::Cvoid
end

function cutest_ugrdh_s_(libsif, status, n, x, g, lh1, h)
  ptr_cutest_ugrdh_s_ = Libdl.dlsym(libsif, :cutest_ugrdh_s_)
  @ccall $ptr_cutest_ugrdh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32}, g::Ptr{Float32},
                              lh1::Ptr{Cint}, h::Ptr{Float32})::Cvoid
end

function cutest_ugrsh_s_(libsif, status, n, x, g, nnzh, lh, h, irnh, icnh)
  ptr_cutest_ugrsh_s_ = Libdl.dlsym(libsif, :cutest_ugrsh_s_)
  @ccall $ptr_cutest_ugrsh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32}, g::Ptr{Float32},
                              nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float32}, irnh::Ptr{Cint},
                              icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ugreh_s_(libsif, status, n, x, g, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi,
                              hi, byrows)
  ptr_cutest_cint_ugreh_s_ = Libdl.dlsym(libsif, :cutest_cint_ugreh_s_)
  @ccall $ptr_cutest_cint_ugreh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                   g::Ptr{Float32}, ne::Ptr{Cint}, le::Ptr{Cint}, iprnhi::Ptr{Cint},
                                   iprhi::Ptr{Cint}, lirnhi::Ptr{Cint}, irnhi::Ptr{Cint},
                                   lhi::Ptr{Cint}, hi::Ptr{Float32}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cint_uhprod_s_(libsif, status, n, goth, x, p, r)
  ptr_cutest_cint_uhprod_s_ = Libdl.dlsym(libsif, :cutest_cint_uhprod_s_)
  @ccall $ptr_cutest_cint_uhprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                    x::Ptr{Float32}, p::Ptr{Float32}, r::Ptr{Float32})::Cvoid
end

function cutest_cint_ushprod_s_(libsif, status, n, goth, x, nnzp, indp, p, nnzr, indr, r)
  ptr_cutest_cint_ushprod_s_ = Libdl.dlsym(libsif, :cutest_cint_ushprod_s_)
  @ccall $ptr_cutest_cint_ushprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                     x::Ptr{Float32}, nnzp::Ptr{Cint}, indp::Ptr{Cint},
                                     p::Ptr{Float32}, nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                     r::Ptr{Float32})::Cvoid
end

function cutest_ubandh_s_(libsif, status, n, x, nsemib, bandh, lbandh, maxsbw)
  ptr_cutest_ubandh_s_ = Libdl.dlsym(libsif, :cutest_ubandh_s_)
  @ccall $ptr_cutest_ubandh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32}, nsemib::Ptr{Cint},
                               bandh::Ptr{Float32}, lbandh::Ptr{Cint}, maxsbw::Ptr{Cint})::Cvoid
end

function cutest_cfn_s_(libsif, status, n, m, x, f, c)
  ptr_cutest_cfn_s_ = Libdl.dlsym(libsif, :cutest_cfn_s_)
  @ccall $ptr_cutest_cfn_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                            f::Ptr{Float32}, c::Ptr{Float32})::Cvoid
end

function cutest_cconst_s_(libsif, status, m, c)
  ptr_cutest_cconst_s_ = Libdl.dlsym(libsif, :cutest_cconst_s_)
  @ccall $ptr_cutest_cconst_s_(status::Ptr{Cint}, m::Ptr{Cint}, c::Ptr{Float32})::Cvoid
end

function cutest_cint_cofg_s_(libsif, status, n, x, f, g, grad)
  ptr_cutest_cint_cofg_s_ = Libdl.dlsym(libsif, :cutest_cint_cofg_s_)
  @ccall $ptr_cutest_cint_cofg_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32}, f::Ptr{Float32},
                                  g::Ptr{Float32}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cofsg_s_(libsif, status, n, x, f, nnzg, lg, sg, ivsg, grad)
  ptr_cutest_cint_cofsg_s_ = Libdl.dlsym(libsif, :cutest_cint_cofsg_s_)
  @ccall $ptr_cutest_cint_cofsg_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32},
                                   f::Ptr{Float32}, nnzg::Ptr{Cint}, lg::Ptr{Cint},
                                   sg::Ptr{Float32}, ivsg::Ptr{Cint}, grad::Ptr{Bool})::Cvoid
end

function cutest_ccf_s_(libsif, status, n, m, x, c)
  ptr_cutest_ccf_s_ = Libdl.dlsym(libsif, :cutest_ccf_s_)
  @ccall $ptr_cutest_ccf_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                            c::Ptr{Float32})::Cvoid
end

function cutest_cint_ccfg_s_(libsif, status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
  ptr_cutest_cint_ccfg_s_ = Libdl.dlsym(libsif, :cutest_cint_ccfg_s_)
  @ccall $ptr_cutest_cint_ccfg_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                                  c::Ptr{Float32}, jtrans::Ptr{Bool}, lcjac1::Ptr{Cint},
                                  lcjac2::Ptr{Cint}, cjac::Ptr{Float32}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_clfg_s_(libsif, status, n, m, x, y, f, g, grad)
  ptr_cutest_cint_clfg_s_ = Libdl.dlsym(libsif, :cutest_cint_clfg_s_)
  @ccall $ptr_cutest_cint_clfg_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                                  y::Ptr{Float32}, f::Ptr{Float32}, g::Ptr{Float32},
                                  grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cgr_s_(libsif, status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac)
  ptr_cutest_cint_cgr_s_ = Libdl.dlsym(libsif, :cutest_cint_cgr_s_)
  @ccall $ptr_cutest_cint_cgr_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                                 y::Ptr{Float32}, grlagf::Ptr{Bool}, g::Ptr{Float32},
                                 jtrans::Ptr{Bool}, lcjac1::Ptr{Cint}, lcjac2::Ptr{Cint},
                                 cjac::Ptr{Float32})::Cvoid
end

function cutest_cint_csgr_s_(libsif, status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun)
  ptr_cutest_cint_csgr_s_ = Libdl.dlsym(libsif, :cutest_cint_csgr_s_)
  @ccall $ptr_cutest_cint_csgr_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                                  y::Ptr{Float32}, grlagf::Ptr{Bool}, nnzj::Ptr{Cint},
                                  lcjac::Ptr{Cint}, cjac::Ptr{Float32}, indvar::Ptr{Cint},
                                  indfun::Ptr{Cint})::Cvoid
end

function cutest_csgrp_s_(libsif, status, n, nnzj, lj, jvar, jcon)
  ptr_cutest_csgrp_s_ = Libdl.dlsym(libsif, :cutest_csgrp_s_)
  @ccall $ptr_cutest_csgrp_s_(status::Ptr{Cint}, n::Ptr{Cint}, nnzj::Ptr{Cint}, lj::Ptr{Cint},
                              jvar::Ptr{Cint}, jcon::Ptr{Cint})::Cvoid
end

function cutest_csjp_s_(libsif, status, nnzj, lj, jvar, jcon)
  ptr_cutest_csjp_s_ = Libdl.dlsym(libsif, :cutest_csjp_s_)
  @ccall $ptr_cutest_csjp_s_(status::Ptr{Cint}, nnzj::Ptr{Cint}, lj::Ptr{Cint}, jvar::Ptr{Cint},
                             jcon::Ptr{Cint})::Cvoid
end

function cutest_cint_ccfsg_s_(libsif, status, n, m, x, c, nnzj, lcjac, cjac, indvar, indfun, grad)
  ptr_cutest_cint_ccfsg_s_ = Libdl.dlsym(libsif, :cutest_cint_ccfsg_s_)
  @ccall $ptr_cutest_cint_ccfsg_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                                   c::Ptr{Float32}, nnzj::Ptr{Cint}, lcjac::Ptr{Cint},
                                   cjac::Ptr{Float32}, indvar::Ptr{Cint}, indfun::Ptr{Cint},
                                   grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccifg_s_(libsif, status, n, icon, x, ci, gci, grad)
  ptr_cutest_cint_ccifg_s_ = Libdl.dlsym(libsif, :cutest_cint_ccifg_s_)
  @ccall $ptr_cutest_cint_ccifg_s_(status::Ptr{Cint}, n::Ptr{Cint}, icon::Ptr{Cint},
                                   x::Ptr{Float32}, ci::Ptr{Float32}, gci::Ptr{Float32},
                                   grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccifsg_s_(libsif, status, n, con, x, ci, nnzsgc, lsgci, sgci, ivsgci, grad)
  ptr_cutest_cint_ccifsg_s_ = Libdl.dlsym(libsif, :cutest_cint_ccifsg_s_)
  @ccall $ptr_cutest_cint_ccifsg_s_(status::Ptr{Cint}, n::Ptr{Cint}, con::Ptr{Cint},
                                    x::Ptr{Float32}, ci::Ptr{Float32}, nnzsgc::Ptr{Cint},
                                    lsgci::Ptr{Cint}, sgci::Ptr{Float32}, ivsgci::Ptr{Cint},
                                    grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cgrdh_s_(libsif, status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac,
                              lh1, h)
  ptr_cutest_cint_cgrdh_s_ = Libdl.dlsym(libsif, :cutest_cint_cgrdh_s_)
  @ccall $ptr_cutest_cint_cgrdh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                                   y::Ptr{Float32}, grlagf::Ptr{Bool}, g::Ptr{Float32},
                                   jtrans::Ptr{Bool}, lcjac1::Ptr{Cint}, lcjac2::Ptr{Cint},
                                   cjac::Ptr{Float32}, lh1::Ptr{Cint}, h::Ptr{Float32})::Cvoid
end

function cutest_cdh_s_(libsif, status, n, m, x, y, lh1, h)
  ptr_cutest_cdh_s_ = Libdl.dlsym(libsif, :cutest_cdh_s_)
  @ccall $ptr_cutest_cdh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                            y::Ptr{Float32}, lh1::Ptr{Cint}, h::Ptr{Float32})::Cvoid
end

function cutest_cdhc_s_(libsif, status, n, m, x, y, lh1, h)
  ptr_cutest_cdhc_s_ = Libdl.dlsym(libsif, :cutest_cdhc_s_)
  @ccall $ptr_cutest_cdhc_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                             y::Ptr{Float32}, lh1::Ptr{Cint}, h::Ptr{Float32})::Cvoid
end

function cutest_cdhj_s_(libsif, status, n, m, x, y0, y, lh1, h)
  ptr_cutest_cdhj_s_ = Libdl.dlsym(libsif, :cutest_cdhj_s_)
  @ccall $ptr_cutest_cdhj_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                             y0::Ptr{Float32}, y::Ptr{Float32}, lh1::Ptr{Cint},
                             h::Ptr{Float32})::Cvoid
end

function cutest_cshp_s_(libsif, status, n, nnzh, lh, irnh, icnh)
  ptr_cutest_cshp_s_ = Libdl.dlsym(libsif, :cutest_cshp_s_)
  @ccall $ptr_cutest_cshp_s_(status::Ptr{Cint}, n::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                             irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_csh_s_(libsif, status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  ptr_cutest_csh_s_ = Libdl.dlsym(libsif, :cutest_csh_s_)
  @ccall $ptr_cutest_csh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                            y::Ptr{Float32}, nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float32},
                            irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cshc_s_(libsif, status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cshc_s_ = Libdl.dlsym(libsif, :cutest_cshc_s_)
  @ccall $ptr_cutest_cshc_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                             y::Ptr{Float32}, nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float32},
                             irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cshj_s_(libsif, status, n, m, x, y0, y, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cshj_s_ = Libdl.dlsym(libsif, :cutest_cshj_s_)
  @ccall $ptr_cutest_cshj_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                             y0::Ptr{Float32}, y::Ptr{Float32}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                             h::Ptr{Float32}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ceh_s_(libsif, status, n, m, x, y, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi,
                            hi, byrows)
  ptr_cutest_cint_ceh_s_ = Libdl.dlsym(libsif, :cutest_cint_ceh_s_)
  @ccall $ptr_cutest_cint_ceh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                                 y::Ptr{Float32}, ne::Ptr{Cint}, le::Ptr{Cint}, iprnhi::Ptr{Cint},
                                 iprhi::Ptr{Cint}, lirnhi::Ptr{Cint}, irnhi::Ptr{Cint},
                                 lhi::Ptr{Cint}, hi::Ptr{Float32}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cifn_s_(libsif, status, n, iprob, x, f)
  ptr_cutest_cifn_s_ = Libdl.dlsym(libsif, :cutest_cifn_s_)
  @ccall $ptr_cutest_cifn_s_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, x::Ptr{Float32},
                             f::Ptr{Float32})::Cvoid
end

function cutest_cigr_s_(libsif, status, n, iprob, x, g)
  ptr_cutest_cigr_s_ = Libdl.dlsym(libsif, :cutest_cigr_s_)
  @ccall $ptr_cutest_cigr_s_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, x::Ptr{Float32},
                             g::Ptr{Float32})::Cvoid
end

function cutest_cisgr_s_(libsif, status, n, iprob, x, nnzg, lg, sg, ivsg)
  ptr_cutest_cisgr_s_ = Libdl.dlsym(libsif, :cutest_cisgr_s_)
  @ccall $ptr_cutest_cisgr_s_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, x::Ptr{Float32},
                              nnzg::Ptr{Cint}, lg::Ptr{Cint}, sg::Ptr{Float32},
                              ivsg::Ptr{Cint})::Cvoid
end

function cutest_cisgrp_s_(libsif, status, n, iprob, nnzg, lg, ivsg)
  ptr_cutest_cisgrp_s_ = Libdl.dlsym(libsif, :cutest_cisgrp_s_)
  @ccall $ptr_cutest_cisgrp_s_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, nnzg::Ptr{Cint},
                               lg::Ptr{Cint}, ivsg::Ptr{Cint})::Cvoid
end

function cutest_cidh_s_(libsif, status, n, x, iprob, lh1, h)
  ptr_cutest_cidh_s_ = Libdl.dlsym(libsif, :cutest_cidh_s_)
  @ccall $ptr_cutest_cidh_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32}, iprob::Ptr{Cint},
                             lh1::Ptr{Cint}, h::Ptr{Float32})::Cvoid
end

function cutest_cish_s_(libsif, status, n, x, iprob, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cish_s_ = Libdl.dlsym(libsif, :cutest_cish_s_)
  @ccall $ptr_cutest_cish_s_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float32}, iprob::Ptr{Cint},
                             nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float32}, irnh::Ptr{Cint},
                             icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgrsh_s_(libsif, status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar,
                               indfun, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cint_csgrsh_s_ = Libdl.dlsym(libsif, :cutest_cint_csgrsh_s_)
  @ccall $ptr_cutest_cint_csgrsh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                                    y::Ptr{Float32}, grlagf::Ptr{Bool}, nnzj::Ptr{Cint},
                                    lcjac::Ptr{Cint}, cjac::Ptr{Float32}, indvar::Ptr{Cint},
                                    indfun::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                    h::Ptr{Float32}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_csgrshp_s_(libsif, status, n, nnzj, lcjac, indvar, indfun, nnzh, lh, irnh, icnh)
  ptr_cutest_csgrshp_s_ = Libdl.dlsym(libsif, :cutest_csgrshp_s_)
  @ccall $ptr_cutest_csgrshp_s_(status::Ptr{Cint}, n::Ptr{Cint}, nnzj::Ptr{Cint}, lcjac::Ptr{Cint},
                                indvar::Ptr{Cint}, indfun::Ptr{Cint}, nnzh::Ptr{Cint},
                                lh::Ptr{Cint}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgreh_s_(libsif, status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar,
                               indfun, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  ptr_cutest_cint_csgreh_s_ = Libdl.dlsym(libsif, :cutest_cint_csgreh_s_)
  @ccall $ptr_cutest_cint_csgreh_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float32},
                                    y::Ptr{Float32}, grlagf::Ptr{Bool}, nnzj::Ptr{Cint},
                                    lcjac::Ptr{Cint}, cjac::Ptr{Float32}, indvar::Ptr{Cint},
                                    indfun::Ptr{Cint}, ne::Ptr{Cint}, le::Ptr{Cint},
                                    iprnhi::Ptr{Cint}, iprhi::Ptr{Cint}, lirnhi::Ptr{Cint},
                                    irnhi::Ptr{Cint}, lhi::Ptr{Cint}, hi::Ptr{Float32},
                                    byrows::Ptr{Bool})::Cvoid
end

function cutest_cint_chprod_s_(libsif, status, n, m, goth, x, y, p, q)
  ptr_cutest_cint_chprod_s_ = Libdl.dlsym(libsif, :cutest_cint_chprod_s_)
  @ccall $ptr_cutest_cint_chprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                    x::Ptr{Float32}, y::Ptr{Float32}, p::Ptr{Float32},
                                    q::Ptr{Float32})::Cvoid
end

function cutest_cint_chsprod_s_(libsif, status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  ptr_cutest_cint_chsprod_s_ = Libdl.dlsym(libsif, :cutest_cint_chsprod_s_)
  @ccall $ptr_cutest_cint_chsprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                     x::Ptr{Float32}, y::Ptr{Float32}, nnzp::Ptr{Cint},
                                     indp::Ptr{Cint}, p::Ptr{Float32}, nnzr::Ptr{Cint},
                                     indr::Ptr{Cint}, r::Ptr{Float32})::Cvoid
end

function cutest_cint_chcprod_s_(libsif, status, n, m, goth, x, y, p, q)
  ptr_cutest_cint_chcprod_s_ = Libdl.dlsym(libsif, :cutest_cint_chcprod_s_)
  @ccall $ptr_cutest_cint_chcprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                     x::Ptr{Float32}, y::Ptr{Float32}, p::Ptr{Float32},
                                     q::Ptr{Float32})::Cvoid
end

function cutest_cint_cshcprod_s_(libsif, status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  ptr_cutest_cint_cshcprod_s_ = Libdl.dlsym(libsif, :cutest_cint_cshcprod_s_)
  @ccall $ptr_cutest_cint_cshcprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                      goth::Ptr{Bool}, x::Ptr{Float32}, y::Ptr{Float32},
                                      nnzp::Ptr{Cint}, indp::Ptr{Cint}, p::Ptr{Float32},
                                      nnzr::Ptr{Cint}, indr::Ptr{Cint}, r::Ptr{Float32})::Cvoid
end

function cutest_cint_chjprod_s_(libsif, status, n, m, goth, x, y0, y, p, q)
  ptr_cutest_cint_chjprod_s_ = Libdl.dlsym(libsif, :cutest_cint_chjprod_s_)
  @ccall $ptr_cutest_cint_chjprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                     x::Ptr{Float32}, y0::Ptr{Float32}, y::Ptr{Float32},
                                     p::Ptr{Float32}, q::Ptr{Float32})::Cvoid
end

function cutest_cint_cjprod_s_(libsif, status, n, m, gotj, jtrans, x, p, lp, r, lr)
  ptr_cutest_cint_cjprod_s_ = Libdl.dlsym(libsif, :cutest_cint_cjprod_s_)
  @ccall $ptr_cutest_cint_cjprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, gotj::Ptr{Bool},
                                    jtrans::Ptr{Bool}, x::Ptr{Float32}, p::Ptr{Float32},
                                    lp::Ptr{Cint}, r::Ptr{Float32}, lr::Ptr{Cint})::Cvoid
end

function cutest_cint_csjprod_s_(libsif, status, n, m, gotj, jtrans, x, nnzp, indp, p, lp, nnzr,
                                indr, r, lr)
  ptr_cutest_cint_csjprod_s_ = Libdl.dlsym(libsif, :cutest_cint_csjprod_s_)
  @ccall $ptr_cutest_cint_csjprod_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, gotj::Ptr{Bool},
                                     jtrans::Ptr{Bool}, x::Ptr{Float32}, nnzp::Ptr{Cint},
                                     indp::Ptr{Cint}, p::Ptr{Float32}, lp::Ptr{Cint},
                                     nnzr::Ptr{Cint}, indr::Ptr{Cint}, r::Ptr{Float32},
                                     lr::Ptr{Cint})::Cvoid
end

function cutest_cint_cchprods_s_(libsif, status, n, m, goth, x, p, lchp, chpval, chpind, chpptr)
  ptr_cutest_cint_cchprods_s_ = Libdl.dlsym(libsif, :cutest_cint_cchprods_s_)
  @ccall $ptr_cutest_cint_cchprods_s_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                      goth::Ptr{Bool}, x::Ptr{Float32}, p::Ptr{Float32},
                                      lchp::Ptr{Cint}, chpval::Ptr{Float32}, chpind::Ptr{Cint},
                                      chpptr::Ptr{Cint})::Cvoid
end

function cutest_cchprodsp_s_(libsif, status, m, lchp, chpind, chpptr)
  ptr_cutest_cchprodsp_s_ = Libdl.dlsym(libsif, :cutest_cchprodsp_s_)
  @ccall $ptr_cutest_cchprodsp_s_(status::Ptr{Cint}, m::Ptr{Cint}, lchp::Ptr{Cint},
                                  chpind::Ptr{Cint}, chpptr::Ptr{Cint})::Cvoid
end

function cutest_cint_cohprods_s_(libsif, status, n, goth, x, p, nnzohp, lohp, ohpval, ohpind)
  ptr_cutest_cint_cohprods_s_ = Libdl.dlsym(libsif, :cutest_cint_cohprods_s_)
  @ccall $ptr_cutest_cint_cohprods_s_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                      x::Ptr{Float32}, p::Ptr{Float32}, nnzohp::Ptr{Cint},
                                      lohp::Ptr{Cint}, ohpval::Ptr{Float32},
                                      ohpind::Ptr{Cint})::Cvoid
end

function cutest_cohprodsp_s_(libsif, status, nnzohp, lohp, chpind)
  ptr_cutest_cohprodsp_s_ = Libdl.dlsym(libsif, :cutest_cohprodsp_s_)
  @ccall $ptr_cutest_cohprodsp_s_(status::Ptr{Cint}, nnzohp::Ptr{Cint}, lohp::Ptr{Cint},
                                  chpind::Ptr{Cint})::Cvoid
end

function cutest_uterminate_s_(libsif, status)
  ptr_cutest_uterminate_s_ = Libdl.dlsym(libsif, :cutest_uterminate_s_)
  @ccall $ptr_cutest_uterminate_s_(status::Ptr{Cint})::Cvoid
end

function cutest_cterminate_s_(libsif, status)
  ptr_cutest_cterminate_s_ = Libdl.dlsym(libsif, :cutest_cterminate_s_)
  @ccall $ptr_cutest_cterminate_s_(status::Ptr{Cint})::Cvoid
end

function fortran_open_s_(libsif, funit, fname, ierr)
  ptr_fortran_open_s_ = Libdl.dlsym(libsif, :fortran_open_s_)
  @ccall $ptr_fortran_open_s_(funit::Ptr{Cint}, fname::Ptr{Cchar}, ierr::Ptr{Cint})::Cvoid
end

function fortran_close_s_(libsif, funit, ierr)
  ptr_fortran_close_s_ = Libdl.dlsym(libsif, :fortran_close_s_)
  @ccall $ptr_fortran_close_s_(funit::Ptr{Cint}, ierr::Ptr{Cint})::Cvoid
end

function cutest_usetup_q_(libsif, status, funit, iout, io_buffer, n, x, bl, bu)
  ptr_cutest_usetup_q_ = Libdl.dlsym(libsif, :cutest_usetup_q_)
  @ccall $ptr_cutest_usetup_q_(status::Ptr{Cint}, funit::Ptr{Cint}, iout::Ptr{Cint},
                               io_buffer::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128},
                               bl::Ptr{Float128}, bu::Ptr{Float128})::Cvoid
end

function cutest_cint_csetup_q_(libsif, status, funit, iout, io_buffer, n, m, x, bl, bu, v, cl, cu,
                               equatn, linear, e_order, l_order, v_order)
  ptr_cutest_cint_csetup_q_ = Libdl.dlsym(libsif, :cutest_cint_csetup_q_)
  @ccall $ptr_cutest_cint_csetup_q_(status::Ptr{Cint}, funit::Ptr{Cint}, iout::Ptr{Cint},
                                    io_buffer::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                    x::Ptr{Float128}, bl::Ptr{Float128}, bu::Ptr{Float128},
                                    v::Ptr{Float128}, cl::Ptr{Float128}, cu::Ptr{Float128},
                                    equatn::Ptr{Bool}, linear::Ptr{Bool}, e_order::Ptr{Cint},
                                    l_order::Ptr{Cint}, v_order::Ptr{Cint})::Cvoid
end

function cutest_udimen_q_(libsif, status, funit, n)
  ptr_cutest_udimen_q_ = Libdl.dlsym(libsif, :cutest_udimen_q_)
  @ccall $ptr_cutest_udimen_q_(status::Ptr{Cint}, funit::Ptr{Cint}, n::Ptr{Cint})::Cvoid
end

function cutest_udimsh_q_(libsif, status, nnzh)
  ptr_cutest_udimsh_q_ = Libdl.dlsym(libsif, :cutest_udimsh_q_)
  @ccall $ptr_cutest_udimsh_q_(status::Ptr{Cint}, nnzh::Ptr{Cint})::Cvoid
end

function cutest_udimse_q_(libsif, status, ne, nzh, nzirnh)
  ptr_cutest_udimse_q_ = Libdl.dlsym(libsif, :cutest_udimse_q_)
  @ccall $ptr_cutest_udimse_q_(status::Ptr{Cint}, ne::Ptr{Cint}, nzh::Ptr{Cint},
                               nzirnh::Ptr{Cint})::Cvoid
end

function cutest_uvartype_q_(libsif, status, n, ivarty)
  ptr_cutest_uvartype_q_ = Libdl.dlsym(libsif, :cutest_uvartype_q_)
  @ccall $ptr_cutest_uvartype_q_(status::Ptr{Cint}, n::Ptr{Cint}, ivarty::Ptr{Cint})::Cvoid
end

function cutest_unames_q_(libsif, status, n, pname, vnames)
  ptr_cutest_unames_q_ = Libdl.dlsym(libsif, :cutest_unames_q_)
  @ccall $ptr_cutest_unames_q_(status::Ptr{Cint}, n::Ptr{Cint}, pname::Ptr{Cchar},
                               vnames::Ptr{Cchar})::Cvoid
end

function cutest_ureport_q_(libsif, status, calls, time)
  ptr_cutest_ureport_q_ = Libdl.dlsym(libsif, :cutest_ureport_q_)
  @ccall $ptr_cutest_ureport_q_(status::Ptr{Cint}, calls::Ptr{Float128}, time::Ptr{Float128})::Cvoid
end

function cutest_cdimen_q_(libsif, status, funit, n, m)
  ptr_cutest_cdimen_q_ = Libdl.dlsym(libsif, :cutest_cdimen_q_)
  @ccall $ptr_cutest_cdimen_q_(status::Ptr{Cint}, funit::Ptr{Cint}, n::Ptr{Cint},
                               m::Ptr{Cint})::Cvoid
end

function cutest_cint_cnoobj_q_(libsif, status, funit, noobj)
  ptr_cutest_cint_cnoobj_q_ = Libdl.dlsym(libsif, :cutest_cint_cnoobj_q_)
  @ccall $ptr_cutest_cint_cnoobj_q_(status::Ptr{Cint}, funit::Ptr{Cint}, noobj::Ptr{Bool})::Cvoid
end

function cutest_cdimsg_q_(libsif, status, nnzg)
  ptr_cutest_cdimsg_q_ = Libdl.dlsym(libsif, :cutest_cdimsg_q_)
  @ccall $ptr_cutest_cdimsg_q_(status::Ptr{Cint}, nnzg::Ptr{Cint})::Cvoid
end

function cutest_cdimsj_q_(libsif, status, nnzj)
  ptr_cutest_cdimsj_q_ = Libdl.dlsym(libsif, :cutest_cdimsj_q_)
  @ccall $ptr_cutest_cdimsj_q_(status::Ptr{Cint}, nnzj::Ptr{Cint})::Cvoid
end

function cutest_cdimsh_q_(libsif, status, nnzh)
  ptr_cutest_cdimsh_q_ = Libdl.dlsym(libsif, :cutest_cdimsh_q_)
  @ccall $ptr_cutest_cdimsh_q_(status::Ptr{Cint}, nnzh::Ptr{Cint})::Cvoid
end

function cutest_cdimohp_q_(libsif, status, nnzohp)
  ptr_cutest_cdimohp_q_ = Libdl.dlsym(libsif, :cutest_cdimohp_q_)
  @ccall $ptr_cutest_cdimohp_q_(status::Ptr{Cint}, nnzohp::Ptr{Cint})::Cvoid
end

function cutest_cdimchp_q_(libsif, status, nnzchp)
  ptr_cutest_cdimchp_q_ = Libdl.dlsym(libsif, :cutest_cdimchp_q_)
  @ccall $ptr_cutest_cdimchp_q_(status::Ptr{Cint}, nnzchp::Ptr{Cint})::Cvoid
end

function cutest_cdimse_q_(libsif, status, ne, nzh, nzirnh)
  ptr_cutest_cdimse_q_ = Libdl.dlsym(libsif, :cutest_cdimse_q_)
  @ccall $ptr_cutest_cdimse_q_(status::Ptr{Cint}, ne::Ptr{Cint}, nzh::Ptr{Cint},
                               nzirnh::Ptr{Cint})::Cvoid
end

function cutest_cstats_q_(libsif, status, nonlinear_variables_objective,
                          nonlinear_variables_constraints, equality_constraints, linear_constraints)
  ptr_cutest_cstats_q_ = Libdl.dlsym(libsif, :cutest_cstats_q_)
  @ccall $ptr_cutest_cstats_q_(status::Ptr{Cint}, nonlinear_variables_objective::Ptr{Cint},
                               nonlinear_variables_constraints::Ptr{Cint},
                               equality_constraints::Ptr{Cint},
                               linear_constraints::Ptr{Cint})::Cvoid
end

function cutest_cvartype_q_(libsif, status, n, ivarty)
  ptr_cutest_cvartype_q_ = Libdl.dlsym(libsif, :cutest_cvartype_q_)
  @ccall $ptr_cutest_cvartype_q_(status::Ptr{Cint}, n::Ptr{Cint}, ivarty::Ptr{Cint})::Cvoid
end

function cutest_cnames_q_(libsif, status, n, m, pname, vnames, gnames)
  ptr_cutest_cnames_q_ = Libdl.dlsym(libsif, :cutest_cnames_q_)
  @ccall $ptr_cutest_cnames_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, pname::Ptr{Cchar},
                               vnames::Ptr{Cchar}, gnames::Ptr{Cchar})::Cvoid
end

function cutest_creport_q_(libsif, status, calls, time)
  ptr_cutest_creport_q_ = Libdl.dlsym(libsif, :cutest_creport_q_)
  @ccall $ptr_cutest_creport_q_(status::Ptr{Cint}, calls::Ptr{Float128}, time::Ptr{Float128})::Cvoid
end

function cutest_connames_q_(libsif, status, m, gname)
  ptr_cutest_connames_q_ = Libdl.dlsym(libsif, :cutest_connames_q_)
  @ccall $ptr_cutest_connames_q_(status::Ptr{Cint}, m::Ptr{Cint}, gname::Ptr{Cchar})::Cvoid
end

function cutest_pname_q_(libsif, status, funit, pname)
  ptr_cutest_pname_q_ = Libdl.dlsym(libsif, :cutest_pname_q_)
  @ccall $ptr_cutest_pname_q_(status::Ptr{Cint}, funit::Ptr{Cint}, pname::Ptr{Cchar})::Cvoid
end

function cutest_probname_q_(libsif, status, pname)
  ptr_cutest_probname_q_ = Libdl.dlsym(libsif, :cutest_probname_q_)
  @ccall $ptr_cutest_probname_q_(status::Ptr{Cint}, pname::Ptr{Cchar})::Cvoid
end

function cutest_varnames_q_(libsif, status, n, vname)
  ptr_cutest_varnames_q_ = Libdl.dlsym(libsif, :cutest_varnames_q_)
  @ccall $ptr_cutest_varnames_q_(status::Ptr{Cint}, n::Ptr{Cint}, vname::Ptr{Cchar})::Cvoid
end

function cutest_ufn_q_(libsif, status, n, x, f)
  ptr_cutest_ufn_q_ = Libdl.dlsym(libsif, :cutest_ufn_q_)
  @ccall $ptr_cutest_ufn_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128},
                            f::Ptr{Float128})::Cvoid
end

function cutest_ugr_q_(libsif, status, n, x, g)
  ptr_cutest_ugr_q_ = Libdl.dlsym(libsif, :cutest_ugr_q_)
  @ccall $ptr_cutest_ugr_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128},
                            g::Ptr{Float128})::Cvoid
end

function cutest_cint_uofg_q_(libsif, status, n, x, f, g, grad)
  ptr_cutest_cint_uofg_q_ = Libdl.dlsym(libsif, :cutest_cint_uofg_q_)
  @ccall $ptr_cutest_cint_uofg_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128}, f::Ptr{Float128},
                                  g::Ptr{Float128}, grad::Ptr{Bool})::Cvoid
end

function cutest_udh_q_(libsif, status, n, x, lh1, h)
  ptr_cutest_udh_q_ = Libdl.dlsym(libsif, :cutest_udh_q_)
  @ccall $ptr_cutest_udh_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128}, lh1::Ptr{Cint},
                            h::Ptr{Float128})::Cvoid
end

function cutest_ushp_q_(libsif, status, n, nnzh, lh, irnh, icnh)
  ptr_cutest_ushp_q_ = Libdl.dlsym(libsif, :cutest_ushp_q_)
  @ccall $ptr_cutest_ushp_q_(status::Ptr{Cint}, n::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                             irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_ush_q_(libsif, status, n, x, nnzh, lh, h, irnh, icnh)
  ptr_cutest_ush_q_ = Libdl.dlsym(libsif, :cutest_ush_q_)
  @ccall $ptr_cutest_ush_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128}, nnzh::Ptr{Cint},
                            lh::Ptr{Cint}, h::Ptr{Float128}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ueh_q_(libsif, status, n, x, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi,
                            byrows)
  ptr_cutest_cint_ueh_q_ = Libdl.dlsym(libsif, :cutest_cint_ueh_q_)
  @ccall $ptr_cutest_cint_ueh_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128}, ne::Ptr{Cint},
                                 le::Ptr{Cint}, iprnhi::Ptr{Cint}, iprhi::Ptr{Cint},
                                 lirnhi::Ptr{Cint}, irnhi::Ptr{Cint}, lhi::Ptr{Cint},
                                 hi::Ptr{Float128}, byrows::Ptr{Bool})::Cvoid
end

function cutest_ugrdh_q_(libsif, status, n, x, g, lh1, h)
  ptr_cutest_ugrdh_q_ = Libdl.dlsym(libsif, :cutest_ugrdh_q_)
  @ccall $ptr_cutest_ugrdh_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128}, g::Ptr{Float128},
                              lh1::Ptr{Cint}, h::Ptr{Float128})::Cvoid
end

function cutest_ugrsh_q_(libsif, status, n, x, g, nnzh, lh, h, irnh, icnh)
  ptr_cutest_ugrsh_q_ = Libdl.dlsym(libsif, :cutest_ugrsh_q_)
  @ccall $ptr_cutest_ugrsh_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128}, g::Ptr{Float128},
                              nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float128}, irnh::Ptr{Cint},
                              icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ugreh_q_(libsif, status, n, x, g, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi,
                              hi, byrows)
  ptr_cutest_cint_ugreh_q_ = Libdl.dlsym(libsif, :cutest_cint_ugreh_q_)
  @ccall $ptr_cutest_cint_ugreh_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128},
                                   g::Ptr{Float128}, ne::Ptr{Cint}, le::Ptr{Cint}, iprnhi::Ptr{Cint},
                                   iprhi::Ptr{Cint}, lirnhi::Ptr{Cint}, irnhi::Ptr{Cint},
                                   lhi::Ptr{Cint}, hi::Ptr{Float128}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cint_uhprod_q_(libsif, status, n, goth, x, p, r)
  ptr_cutest_cint_uhprod_q_ = Libdl.dlsym(libsif, :cutest_cint_uhprod_q_)
  @ccall $ptr_cutest_cint_uhprod_q_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                    x::Ptr{Float128}, p::Ptr{Float128}, r::Ptr{Float128})::Cvoid
end

function cutest_cint_ushprod_q_(libsif, status, n, goth, x, nnzp, indp, p, nnzr, indr, r)
  ptr_cutest_cint_ushprod_q_ = Libdl.dlsym(libsif, :cutest_cint_ushprod_q_)
  @ccall $ptr_cutest_cint_ushprod_q_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                     x::Ptr{Float128}, nnzp::Ptr{Cint}, indp::Ptr{Cint},
                                     p::Ptr{Float128}, nnzr::Ptr{Cint}, indr::Ptr{Cint},
                                     r::Ptr{Float128})::Cvoid
end

function cutest_ubandh_q_(libsif, status, n, x, nsemib, bandh, lbandh, maxsbw)
  ptr_cutest_ubandh_q_ = Libdl.dlsym(libsif, :cutest_ubandh_q_)
  @ccall $ptr_cutest_ubandh_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128}, nsemib::Ptr{Cint},
                               bandh::Ptr{Float128}, lbandh::Ptr{Cint}, maxsbw::Ptr{Cint})::Cvoid
end

function cutest_cfn_q_(libsif, status, n, m, x, f, c)
  ptr_cutest_cfn_q_ = Libdl.dlsym(libsif, :cutest_cfn_q_)
  @ccall $ptr_cutest_cfn_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                            f::Ptr{Float128}, c::Ptr{Float128})::Cvoid
end

function cutest_cconst_q_(libsif, status, m, c)
  ptr_cutest_cconst_q_ = Libdl.dlsym(libsif, :cutest_cconst_q_)
  @ccall $ptr_cutest_cconst_q_(status::Ptr{Cint}, m::Ptr{Cint}, c::Ptr{Float128})::Cvoid
end

function cutest_cint_cofg_q_(libsif, status, n, x, f, g, grad)
  ptr_cutest_cint_cofg_q_ = Libdl.dlsym(libsif, :cutest_cint_cofg_q_)
  @ccall $ptr_cutest_cint_cofg_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128}, f::Ptr{Float128},
                                  g::Ptr{Float128}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cofsg_q_(libsif, status, n, x, f, nnzg, lg, sg, ivsg, grad)
  ptr_cutest_cint_cofsg_q_ = Libdl.dlsym(libsif, :cutest_cint_cofsg_q_)
  @ccall $ptr_cutest_cint_cofsg_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128},
                                   f::Ptr{Float128}, nnzg::Ptr{Cint}, lg::Ptr{Cint},
                                   sg::Ptr{Float128}, ivsg::Ptr{Cint}, grad::Ptr{Bool})::Cvoid
end

function cutest_ccf_q_(libsif, status, n, m, x, c)
  ptr_cutest_ccf_q_ = Libdl.dlsym(libsif, :cutest_ccf_q_)
  @ccall $ptr_cutest_ccf_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                            c::Ptr{Float128})::Cvoid
end

function cutest_cint_ccfg_q_(libsif, status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
  ptr_cutest_cint_ccfg_q_ = Libdl.dlsym(libsif, :cutest_cint_ccfg_q_)
  @ccall $ptr_cutest_cint_ccfg_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                                  c::Ptr{Float128}, jtrans::Ptr{Bool}, lcjac1::Ptr{Cint},
                                  lcjac2::Ptr{Cint}, cjac::Ptr{Float128}, grad::Ptr{Bool})::Cvoid
end

function cutest_cint_clfg_q_(libsif, status, n, m, x, y, f, g, grad)
  ptr_cutest_cint_clfg_q_ = Libdl.dlsym(libsif, :cutest_cint_clfg_q_)
  @ccall $ptr_cutest_cint_clfg_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                                  y::Ptr{Float128}, f::Ptr{Float128}, g::Ptr{Float128},
                                  grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cgr_q_(libsif, status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac)
  ptr_cutest_cint_cgr_q_ = Libdl.dlsym(libsif, :cutest_cint_cgr_q_)
  @ccall $ptr_cutest_cint_cgr_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                                 y::Ptr{Float128}, grlagf::Ptr{Bool}, g::Ptr{Float128},
                                 jtrans::Ptr{Bool}, lcjac1::Ptr{Cint}, lcjac2::Ptr{Cint},
                                 cjac::Ptr{Float128})::Cvoid
end

function cutest_cint_csgr_q_(libsif, status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar, indfun)
  ptr_cutest_cint_csgr_q_ = Libdl.dlsym(libsif, :cutest_cint_csgr_q_)
  @ccall $ptr_cutest_cint_csgr_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                                  y::Ptr{Float128}, grlagf::Ptr{Bool}, nnzj::Ptr{Cint},
                                  lcjac::Ptr{Cint}, cjac::Ptr{Float128}, indvar::Ptr{Cint},
                                  indfun::Ptr{Cint})::Cvoid
end

function cutest_csgrp_q_(libsif, status, n, nnzj, lj, jvar, jcon)
  ptr_cutest_csgrp_q_ = Libdl.dlsym(libsif, :cutest_csgrp_q_)
  @ccall $ptr_cutest_csgrp_q_(status::Ptr{Cint}, n::Ptr{Cint}, nnzj::Ptr{Cint}, lj::Ptr{Cint},
                              jvar::Ptr{Cint}, jcon::Ptr{Cint})::Cvoid
end

function cutest_csjp_q_(libsif, status, nnzj, lj, jvar, jcon)
  ptr_cutest_csjp_q_ = Libdl.dlsym(libsif, :cutest_csjp_q_)
  @ccall $ptr_cutest_csjp_q_(status::Ptr{Cint}, nnzj::Ptr{Cint}, lj::Ptr{Cint}, jvar::Ptr{Cint},
                             jcon::Ptr{Cint})::Cvoid
end

function cutest_cint_ccfsg_q_(libsif, status, n, m, x, c, nnzj, lcjac, cjac, indvar, indfun, grad)
  ptr_cutest_cint_ccfsg_q_ = Libdl.dlsym(libsif, :cutest_cint_ccfsg_q_)
  @ccall $ptr_cutest_cint_ccfsg_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                                   c::Ptr{Float128}, nnzj::Ptr{Cint}, lcjac::Ptr{Cint},
                                   cjac::Ptr{Float128}, indvar::Ptr{Cint}, indfun::Ptr{Cint},
                                   grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccifg_q_(libsif, status, n, icon, x, ci, gci, grad)
  ptr_cutest_cint_ccifg_q_ = Libdl.dlsym(libsif, :cutest_cint_ccifg_q_)
  @ccall $ptr_cutest_cint_ccifg_q_(status::Ptr{Cint}, n::Ptr{Cint}, icon::Ptr{Cint},
                                   x::Ptr{Float128}, ci::Ptr{Float128}, gci::Ptr{Float128},
                                   grad::Ptr{Bool})::Cvoid
end

function cutest_cint_ccifsg_q_(libsif, status, n, con, x, ci, nnzsgc, lsgci, sgci, ivsgci, grad)
  ptr_cutest_cint_ccifsg_q_ = Libdl.dlsym(libsif, :cutest_cint_ccifsg_q_)
  @ccall $ptr_cutest_cint_ccifsg_q_(status::Ptr{Cint}, n::Ptr{Cint}, con::Ptr{Cint},
                                    x::Ptr{Float128}, ci::Ptr{Float128}, nnzsgc::Ptr{Cint},
                                    lsgci::Ptr{Cint}, sgci::Ptr{Float128}, ivsgci::Ptr{Cint},
                                    grad::Ptr{Bool})::Cvoid
end

function cutest_cint_cgrdh_q_(libsif, status, n, m, x, y, grlagf, g, jtrans, lcjac1, lcjac2, cjac,
                              lh1, h)
  ptr_cutest_cint_cgrdh_q_ = Libdl.dlsym(libsif, :cutest_cint_cgrdh_q_)
  @ccall $ptr_cutest_cint_cgrdh_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                                   y::Ptr{Float128}, grlagf::Ptr{Bool}, g::Ptr{Float128},
                                   jtrans::Ptr{Bool}, lcjac1::Ptr{Cint}, lcjac2::Ptr{Cint},
                                   cjac::Ptr{Float128}, lh1::Ptr{Cint}, h::Ptr{Float128})::Cvoid
end

function cutest_cdh_q_(libsif, status, n, m, x, y, lh1, h)
  ptr_cutest_cdh_q_ = Libdl.dlsym(libsif, :cutest_cdh_q_)
  @ccall $ptr_cutest_cdh_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                            y::Ptr{Float128}, lh1::Ptr{Cint}, h::Ptr{Float128})::Cvoid
end

function cutest_cdhc_q_(libsif, status, n, m, x, y, lh1, h)
  ptr_cutest_cdhc_q_ = Libdl.dlsym(libsif, :cutest_cdhc_q_)
  @ccall $ptr_cutest_cdhc_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                             y::Ptr{Float128}, lh1::Ptr{Cint}, h::Ptr{Float128})::Cvoid
end

function cutest_cdhj_q_(libsif, status, n, m, x, y0, y, lh1, h)
  ptr_cutest_cdhj_q_ = Libdl.dlsym(libsif, :cutest_cdhj_q_)
  @ccall $ptr_cutest_cdhj_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                             y0::Ptr{Float128}, y::Ptr{Float128}, lh1::Ptr{Cint},
                             h::Ptr{Float128})::Cvoid
end

function cutest_cshp_q_(libsif, status, n, nnzh, lh, irnh, icnh)
  ptr_cutest_cshp_q_ = Libdl.dlsym(libsif, :cutest_cshp_q_)
  @ccall $ptr_cutest_cshp_q_(status::Ptr{Cint}, n::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                             irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_csh_q_(libsif, status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  ptr_cutest_csh_q_ = Libdl.dlsym(libsif, :cutest_csh_q_)
  @ccall $ptr_cutest_csh_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                            y::Ptr{Float128}, nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float128},
                            irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cshc_q_(libsif, status, n, m, x, y, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cshc_q_ = Libdl.dlsym(libsif, :cutest_cshc_q_)
  @ccall $ptr_cutest_cshc_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                             y::Ptr{Float128}, nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float128},
                             irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cshj_q_(libsif, status, n, m, x, y0, y, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cshj_q_ = Libdl.dlsym(libsif, :cutest_cshj_q_)
  @ccall $ptr_cutest_cshj_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                             y0::Ptr{Float128}, y::Ptr{Float128}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                             h::Ptr{Float128}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_ceh_q_(libsif, status, n, m, x, y, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi,
                            hi, byrows)
  ptr_cutest_cint_ceh_q_ = Libdl.dlsym(libsif, :cutest_cint_ceh_q_)
  @ccall $ptr_cutest_cint_ceh_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                                 y::Ptr{Float128}, ne::Ptr{Cint}, le::Ptr{Cint}, iprnhi::Ptr{Cint},
                                 iprhi::Ptr{Cint}, lirnhi::Ptr{Cint}, irnhi::Ptr{Cint},
                                 lhi::Ptr{Cint}, hi::Ptr{Float128}, byrows::Ptr{Bool})::Cvoid
end

function cutest_cifn_q_(libsif, status, n, iprob, x, f)
  ptr_cutest_cifn_q_ = Libdl.dlsym(libsif, :cutest_cifn_q_)
  @ccall $ptr_cutest_cifn_q_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, x::Ptr{Float128},
                             f::Ptr{Float128})::Cvoid
end

function cutest_cigr_q_(libsif, status, n, iprob, x, g)
  ptr_cutest_cigr_q_ = Libdl.dlsym(libsif, :cutest_cigr_q_)
  @ccall $ptr_cutest_cigr_q_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, x::Ptr{Float128},
                             g::Ptr{Float128})::Cvoid
end

function cutest_cisgr_q_(libsif, status, n, iprob, x, nnzg, lg, sg, ivsg)
  ptr_cutest_cisgr_q_ = Libdl.dlsym(libsif, :cutest_cisgr_q_)
  @ccall $ptr_cutest_cisgr_q_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, x::Ptr{Float128},
                              nnzg::Ptr{Cint}, lg::Ptr{Cint}, sg::Ptr{Float128},
                              ivsg::Ptr{Cint})::Cvoid
end

function cutest_cisgrp_q_(libsif, status, n, iprob, nnzg, lg, ivsg)
  ptr_cutest_cisgrp_q_ = Libdl.dlsym(libsif, :cutest_cisgrp_q_)
  @ccall $ptr_cutest_cisgrp_q_(status::Ptr{Cint}, n::Ptr{Cint}, iprob::Ptr{Cint}, nnzg::Ptr{Cint},
                               lg::Ptr{Cint}, ivsg::Ptr{Cint})::Cvoid
end

function cutest_cidh_q_(libsif, status, n, x, iprob, lh1, h)
  ptr_cutest_cidh_q_ = Libdl.dlsym(libsif, :cutest_cidh_q_)
  @ccall $ptr_cutest_cidh_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128}, iprob::Ptr{Cint},
                             lh1::Ptr{Cint}, h::Ptr{Float128})::Cvoid
end

function cutest_cish_q_(libsif, status, n, x, iprob, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cish_q_ = Libdl.dlsym(libsif, :cutest_cish_q_)
  @ccall $ptr_cutest_cish_q_(status::Ptr{Cint}, n::Ptr{Cint}, x::Ptr{Float128}, iprob::Ptr{Cint},
                             nnzh::Ptr{Cint}, lh::Ptr{Cint}, h::Ptr{Float128}, irnh::Ptr{Cint},
                             icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgrsh_q_(libsif, status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar,
                               indfun, nnzh, lh, h, irnh, icnh)
  ptr_cutest_cint_csgrsh_q_ = Libdl.dlsym(libsif, :cutest_cint_csgrsh_q_)
  @ccall $ptr_cutest_cint_csgrsh_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                                    y::Ptr{Float128}, grlagf::Ptr{Bool}, nnzj::Ptr{Cint},
                                    lcjac::Ptr{Cint}, cjac::Ptr{Float128}, indvar::Ptr{Cint},
                                    indfun::Ptr{Cint}, nnzh::Ptr{Cint}, lh::Ptr{Cint},
                                    h::Ptr{Float128}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_csgrshp_q_(libsif, status, n, nnzj, lcjac, indvar, indfun, nnzh, lh, irnh, icnh)
  ptr_cutest_csgrshp_q_ = Libdl.dlsym(libsif, :cutest_csgrshp_q_)
  @ccall $ptr_cutest_csgrshp_q_(status::Ptr{Cint}, n::Ptr{Cint}, nnzj::Ptr{Cint}, lcjac::Ptr{Cint},
                                indvar::Ptr{Cint}, indfun::Ptr{Cint}, nnzh::Ptr{Cint},
                                lh::Ptr{Cint}, irnh::Ptr{Cint}, icnh::Ptr{Cint})::Cvoid
end

function cutest_cint_csgreh_q_(libsif, status, n, m, x, y, grlagf, nnzj, lcjac, cjac, indvar,
                               indfun, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
  ptr_cutest_cint_csgreh_q_ = Libdl.dlsym(libsif, :cutest_cint_csgreh_q_)
  @ccall $ptr_cutest_cint_csgreh_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, x::Ptr{Float128},
                                    y::Ptr{Float128}, grlagf::Ptr{Bool}, nnzj::Ptr{Cint},
                                    lcjac::Ptr{Cint}, cjac::Ptr{Float128}, indvar::Ptr{Cint},
                                    indfun::Ptr{Cint}, ne::Ptr{Cint}, le::Ptr{Cint},
                                    iprnhi::Ptr{Cint}, iprhi::Ptr{Cint}, lirnhi::Ptr{Cint},
                                    irnhi::Ptr{Cint}, lhi::Ptr{Cint}, hi::Ptr{Float128},
                                    byrows::Ptr{Bool})::Cvoid
end

function cutest_cint_chprod_q_(libsif, status, n, m, goth, x, y, p, q)
  ptr_cutest_cint_chprod_q_ = Libdl.dlsym(libsif, :cutest_cint_chprod_q_)
  @ccall $ptr_cutest_cint_chprod_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                    x::Ptr{Float128}, y::Ptr{Float128}, p::Ptr{Float128},
                                    q::Ptr{Float128})::Cvoid
end

function cutest_cint_chsprod_q_(libsif, status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  ptr_cutest_cint_chsprod_q_ = Libdl.dlsym(libsif, :cutest_cint_chsprod_q_)
  @ccall $ptr_cutest_cint_chsprod_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                     x::Ptr{Float128}, y::Ptr{Float128}, nnzp::Ptr{Cint},
                                     indp::Ptr{Cint}, p::Ptr{Float128}, nnzr::Ptr{Cint},
                                     indr::Ptr{Cint}, r::Ptr{Float128})::Cvoid
end

function cutest_cint_chcprod_q_(libsif, status, n, m, goth, x, y, p, q)
  ptr_cutest_cint_chcprod_q_ = Libdl.dlsym(libsif, :cutest_cint_chcprod_q_)
  @ccall $ptr_cutest_cint_chcprod_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                     x::Ptr{Float128}, y::Ptr{Float128}, p::Ptr{Float128},
                                     q::Ptr{Float128})::Cvoid
end

function cutest_cint_cshcprod_q_(libsif, status, n, m, goth, x, y, nnzp, indp, p, nnzr, indr, r)
  ptr_cutest_cint_cshcprod_q_ = Libdl.dlsym(libsif, :cutest_cint_cshcprod_q_)
  @ccall $ptr_cutest_cint_cshcprod_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                      goth::Ptr{Bool}, x::Ptr{Float128}, y::Ptr{Float128},
                                      nnzp::Ptr{Cint}, indp::Ptr{Cint}, p::Ptr{Float128},
                                      nnzr::Ptr{Cint}, indr::Ptr{Cint}, r::Ptr{Float128})::Cvoid
end

function cutest_cint_chjprod_q_(libsif, status, n, m, goth, x, y0, y, p, q)
  ptr_cutest_cint_chjprod_q_ = Libdl.dlsym(libsif, :cutest_cint_chjprod_q_)
  @ccall $ptr_cutest_cint_chjprod_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, goth::Ptr{Bool},
                                     x::Ptr{Float128}, y0::Ptr{Float128}, y::Ptr{Float128},
                                     p::Ptr{Float128}, q::Ptr{Float128})::Cvoid
end

function cutest_cint_cjprod_q_(libsif, status, n, m, gotj, jtrans, x, p, lp, r, lr)
  ptr_cutest_cint_cjprod_q_ = Libdl.dlsym(libsif, :cutest_cint_cjprod_q_)
  @ccall $ptr_cutest_cint_cjprod_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, gotj::Ptr{Bool},
                                    jtrans::Ptr{Bool}, x::Ptr{Float128}, p::Ptr{Float128},
                                    lp::Ptr{Cint}, r::Ptr{Float128}, lr::Ptr{Cint})::Cvoid
end

function cutest_cint_csjprod_q_(libsif, status, n, m, gotj, jtrans, x, nnzp, indp, p, lp, nnzr,
                                indr, r, lr)
  ptr_cutest_cint_csjprod_q_ = Libdl.dlsym(libsif, :cutest_cint_csjprod_q_)
  @ccall $ptr_cutest_cint_csjprod_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint}, gotj::Ptr{Bool},
                                     jtrans::Ptr{Bool}, x::Ptr{Float128}, nnzp::Ptr{Cint},
                                     indp::Ptr{Cint}, p::Ptr{Float128}, lp::Ptr{Cint},
                                     nnzr::Ptr{Cint}, indr::Ptr{Cint}, r::Ptr{Float128},
                                     lr::Ptr{Cint})::Cvoid
end

function cutest_cint_cchprods_q_(libsif, status, n, m, goth, x, p, lchp, chpval, chpind, chpptr)
  ptr_cutest_cint_cchprods_q_ = Libdl.dlsym(libsif, :cutest_cint_cchprods_q_)
  @ccall $ptr_cutest_cint_cchprods_q_(status::Ptr{Cint}, n::Ptr{Cint}, m::Ptr{Cint},
                                      goth::Ptr{Bool}, x::Ptr{Float128}, p::Ptr{Float128},
                                      lchp::Ptr{Cint}, chpval::Ptr{Float128}, chpind::Ptr{Cint},
                                      chpptr::Ptr{Cint})::Cvoid
end

function cutest_cchprodsp_q_(libsif, status, m, lchp, chpind, chpptr)
  ptr_cutest_cchprodsp_q_ = Libdl.dlsym(libsif, :cutest_cchprodsp_q_)
  @ccall $ptr_cutest_cchprodsp_q_(status::Ptr{Cint}, m::Ptr{Cint}, lchp::Ptr{Cint},
                                  chpind::Ptr{Cint}, chpptr::Ptr{Cint})::Cvoid
end

function cutest_cint_cohprods_q_(libsif, status, n, goth, x, p, nnzohp, lohp, ohpval, ohpind)
  ptr_cutest_cint_cohprods_q_ = Libdl.dlsym(libsif, :cutest_cint_cohprods_q_)
  @ccall $ptr_cutest_cint_cohprods_q_(status::Ptr{Cint}, n::Ptr{Cint}, goth::Ptr{Bool},
                                      x::Ptr{Float128}, p::Ptr{Float128}, nnzohp::Ptr{Cint},
                                      lohp::Ptr{Cint}, ohpval::Ptr{Float128},
                                      ohpind::Ptr{Cint})::Cvoid
end

function cutest_cohprodsp_q_(libsif, status, nnzohp, lohp, chpind)
  ptr_cutest_cohprodsp_q_ = Libdl.dlsym(libsif, :cutest_cohprodsp_q_)
  @ccall $ptr_cutest_cohprodsp_q_(status::Ptr{Cint}, nnzohp::Ptr{Cint}, lohp::Ptr{Cint},
                                  chpind::Ptr{Cint})::Cvoid
end

function cutest_uterminate_q_(libsif, status)
  ptr_cutest_uterminate_q_ = Libdl.dlsym(libsif, :cutest_uterminate_q_)
  @ccall $ptr_cutest_uterminate_q_(status::Ptr{Cint})::Cvoid
end

function cutest_cterminate_q_(libsif, status)
  ptr_cutest_cterminate_q_ = Libdl.dlsym(libsif, :cutest_cterminate_q_)
  @ccall $ptr_cutest_cterminate_q_(status::Ptr{Cint})::Cvoid
end

function fortran_open_q_(libsif, funit, fname, ierr)
  ptr_fortran_open_q_ = Libdl.dlsym(libsif, :fortran_open_q_)
  @ccall $ptr_fortran_open_q_(funit::Ptr{Cint}, fname::Ptr{Cchar}, ierr::Ptr{Cint})::Cvoid
end

function fortran_close_q_(libsif, funit, ierr)
  ptr_fortran_close_q_ = Libdl.dlsym(libsif, :fortran_close_q_)
  @ccall $ptr_fortran_close_q_(funit::Ptr{Cint}, ierr::Ptr{Cint})::Cvoid
end
#! format: on
