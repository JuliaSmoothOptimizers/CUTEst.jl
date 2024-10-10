# Tests made to increase the coverage.
function coverage_increase(nlp::CUTEstModel{T}) where {T}
  status = Cint[0]
  n, m = nlp.meta.nvar, nlp.meta.ncon
  # class = Vector{Cchar}(undef, 30)
  # CUTEst.classification(T, nlp.libsif, nlp.status, nlp.funit, class)
  pname = Vector{Cchar}(undef, 10)
  CUTEst.probname(T, nlp.libsif, status, pname)
  vname = Matrix{Cchar}(undef, 10, n)
  CUTEst.varnames(T, nlp.libsif, status, Cint[n], vname)
  if m == 0
    CUTEst.unames(T, nlp.libsif, status, Cint[n], pname, vname)
    calls = Vector{T}(undef, 4)
    time = Vector{T}(undef, 4)
    CUTEst.ureport(T, nlp.libsif, status, calls, time)
  else
    cname = Matrix{Cchar}(undef, 10, m)
    CUTEst.connames(T, nlp.libsif, status, Cint[m], cname)
    CUTEst.cnames(T, nlp.libsif, status, Cint[n], Cint[m], pname, vname, cname)
    calls = Vector{T}(undef, 7)
    time = Vector{T}(undef, 4)
    CUTEst.creport(T, nlp.libsif, status, calls, time)
    nvo, nvc, ec, lc = Cint[0], Cint[0], Cint[0], Cint[0]
    CUTEst.cstats(T, nlp.libsif, status, nvo, nvc, ec, lc)

    lchp = Cint[0]
    CUTEst.cdimchp(T, nlp.libsif, status, lchp)
    chp_ind, chp_ptr = Vector{Cint}(undef, lchp[1]), Vector{Cint}(undef, m + 1)
    CUTEst.cchprodsp(T, nlp.libsif, status, Cint[m], lchp, chp_ind, chp_ptr)
    lj, nnzj = Cint[0], Cint[0]
    CUTEst.cdimsj(T, nlp.libsif, status, lj)
    j_var, j_fun = Vector{Cint}(undef, lj[1]), Vector{Cint}(undef, lj[1])
    CUTEst.csgrp(T, nlp.libsif, status, Cint[n], nnzj, lj, j_var, j_fun)
    lh, nnzh = Cint[0], Cint[0]
    CUTEst.cdimsh(T, nlp.libsif, status, lh)
    h_row, h_col = Vector{Cint}(undef, lh[1]), Vector{Cint}(undef, lh[1])
    CUTEst.csgrshp(T, nlp.libsif, status, Cint[n], nnzj, lj, j_var, j_fun, nnzh, lh, h_row, h_col)
  end
end
