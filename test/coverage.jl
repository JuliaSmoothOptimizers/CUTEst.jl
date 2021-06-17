# Tests made to increase the coverage.

io_err = Cint[0]

function coverage_increase(nlp::CUTEstModel)
  n, m = nlp.meta.nvar, nlp.meta.ncon
  pname = Array{UInt8, 1}(undef, 10)
  probname(io_err, pname)
  vname = Array{UInt8, 2}(undef, 10, n)
  varnames(io_err, Cint[n], vname)
  if m == 0
    unames(io_err, Cint[n], pname, vname)
    calls, time = Array{Cdouble}(undef, 4), Array{Cdouble}(undef, 2)
    ureport(io_err, calls, time)
  else
    cname = Array{UInt8, 2}(undef, 10, m)
    connames(io_err, Cint[m], cname)
    cnames(io_err, Cint[n], Cint[m], pname, vname, cname)
    calls, time = Array{Cdouble}(undef, 7), Array{Cdouble}(undef, 2)
    creport(io_err, calls, time)
    nvo, nvc, ec, lc = Cint[0], Cint[0], Cint[0], Cint[0]
    cstats(io_err, nvo, nvc, ec, lc)

    lchp = Cint[0]
    cdimchp(io_err, lchp)
    chp_ind, chp_ptr = Array{Cint}(undef, lchp[1]), Array{Cint}(undef, m + 1)
    cchprodsp(io_err, Cint[m], lchp, chp_ind, chp_ptr)
    lj, nnzj = Cint[0], Cint[0]
    cdimsj(io_err, lj)
    j_var, j_fun = Array{Cint}(undef, lj[1]), Array{Cint}(undef, lj[1])
    csgrp(io_err, Cint[n], nnzj, lj, j_var, j_fun)
    lh, nnzh = Cint[0], Cint[0]
    cdimsh(io_err, lh)
    h_row, h_col = Array{Cint}(undef, lh[1]), Array{Cint}(undef, lh[1])
    csgrshp(io_err, Cint[n], nnzj, lj, j_var, j_fun, nnzh, lh, h_row, h_col)
  end
end
