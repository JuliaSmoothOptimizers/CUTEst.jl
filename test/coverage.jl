# Tests made to increase the coverage.
function coverage_increase(nlp::CUTEstModel{T}) where T
  status = Cint[0]
  n, m = nlp.meta.nvar, nlp.meta.ncon
  pname = Vector{Cchar}(undef, 10)
  probname(T, status, pname)
  vname = Matrix{Cchar}(undef, 10, n)
  varnames(T, status, Cint[n], vname)
  if m == 0
    unames(T, status, Cint[n], pname, vname)
    calls = Vector{T}(undef, 4)
    time = Vector{T}(undef, 4)
    ureport(T, status, calls, time)
  else
    cname = Matrix{Cchar}(undef, 10, m)
    connames(T, status, Cint[m], cname)
    cnames(T, status, Cint[n], Cint[m], pname, vname, cname)
    calls = Vector{T}(undef, 7)
    time = Vector{T}(undef, 4)
    creport(T, status, calls, time)
    nvo, nvc, ec, lc = Cint[0], Cint[0], Cint[0], Cint[0]
    cstats(T, status, nvo, nvc, ec, lc)

    lchp = Cint[0]
    cdimchp(T, status, lchp)
    chp_ind, chp_ptr = Vector{Cint}(undef, lchp[1]), Vector{Cint}(undef, m + 1)
    cchprodsp(T, status, Cint[m], lchp, chp_ind, chp_ptr)
    lj, nnzj = Cint[0], Cint[0]
    cdimsj(T, status, lj)
    j_var, j_fun = Vector{Cint}(undef, lj[1]), Vector{Cint}(undef, lj[1])
    csgrp(T, status, Cint[n], nnzj, lj, j_var, j_fun)
    lh, nnzh = Cint[0], Cint[0]
    cdimsh(T, status, lh)
    h_row, h_col = Vector{Cint}(undef, lh[1]), Vector{Cint}(undef, lh[1])
    csgrshp(T, status, Cint[n], nnzj, lj, j_var, j_fun, nnzh, lh, h_row, h_col)
  end
end
