# Tests made to increase the coverage.

status = Cint[0]

function coverage_increase(nlp::CUTEstModel{Float64})
  n, m = nlp.meta.nvar, nlp.meta.ncon
  pname = Vector{Cchar}(undef, 10)
  probname(Float64, status, pname)
  vname = Matrix{Cchar}(undef, 10, n)
  varnames(Float64, status, Cint[n], vname)
  if m == 0
    unames(Float64, status, Cint[n], pname, vname)
    calls = Vector{Float64}(undef, 4)
    time = Vector{Float64}(undef, 4)
    ureport(Float64, status, calls, time)
  else
    cname = Matrix{Cchar}(undef, 10, m)
    connames(Float64, status, Cint[m], cname)
    cnames(Float64, status, Cint[n], Cint[m], pname, vname, cname)
    calls = Vector{Float64}(undef, 7)
    time = Vector{Float64}(undef, 4)
    creport(Float64, status, calls, time)
    nvo, nvc, ec, lc = Cint[0], Cint[0], Cint[0], Cint[0]
    cstats(Float64, status, nvo, nvc, ec, lc)

    lchp = Cint[0]
    cdimchp(Float64, status, lchp)
    chp_ind, chp_ptr = Vector{Cint}(undef, lchp[1]), Vector{Cint}(undef, m + 1)
    cchprodsp(Float64, status, Cint[m], lchp, chp_ind, chp_ptr)
    lj, nnzj = Cint[0], Cint[0]
    cdimsj(Float64, status, lj)
    j_var, j_fun = Vector{Cint}(undef, lj[1]), Vector{Cint}(undef, lj[1])
    csgrp(Float64, status, Cint[n], nnzj, lj, j_var, j_fun)
    lh, nnzh = Cint[0], Cint[0]
    cdimsh(Float64, status, lh)
    h_row, h_col = Vector{Cint}(undef, lh[1]), Vector{Cint}(undef, lh[1])
    csgrshp(Float64, status, Cint[n], nnzj, lj, j_var, j_fun, nnzh, lh, h_row, h_col)
  end
end
