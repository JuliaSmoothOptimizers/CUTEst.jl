export cons_coord, cons_coord!, consjac

using NLPModels, SparseArrays

function NLPModels.objcons(nlp::CUTEstModel, x::AbstractVector)
  @lencheck nlp.meta.nvar x
  c = Vector{Float64}(undef, nlp.meta.ncon)
  objcons!(nlp, convert(Vector{Float64}, x), c)
end

function NLPModels.objcons!(
  nlp::CUTEstModel,
  x::StrideOneVector{Float64},
  c::StrideOneVector{Float64},
)
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  @lencheck nvar x
  @lencheck ncon c
  io_err = Cint[0]
  f = Cdouble[0]
  if ncon > 0
    ccall(
      dlsym(cutest_lib, :cutest_cfn_),
      Nothing,
      (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
      io_err,
      nvar,
      ncon,
      x,
      f,
      c,
    )
    increment!(nlp, :neval_cons)
  else
    ccall(
      dlsym(cutest_lib, :cutest_ufn_),
      Nothing,
      (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}),
      io_err,
      nvar,
      x,
      f,
    )
  end
  increment!(nlp, :neval_obj)
  @cutest_error

  return f[1], c
end

function NLPModels.objcons!(nlp::CUTEstModel, x::AbstractVector, c::StrideOneVector{Float64})
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  objcons!(nlp, convert(Vector{Float64}, x), c)
end

function NLPModels.objcons!(nlp::CUTEstModel, x::AbstractVector, c::AbstractVector)
  ncon = nlp.meta.ncon
  @lencheck nlp.meta.nvar x
  @lencheck ncon c
  if ncon > 0
    cc = zeros(ncon)
    f, _ = objcons!(nlp, convert(Vector{Float64}, x), cc)
    c .= cc
    return f, c
  else
    return objcons!(nlp, convert(Vector{Float64}, x), zeros(0))
  end
end

function NLPModels.objgrad(nlp::CUTEstModel, x::AbstractVector)
  @lencheck nlp.meta.nvar x
  g = Vector{Float64}(undef, nlp.meta.nvar)
  objgrad!(nlp, convert(Vector{Float64}, x), g)
end

function NLPModels.objgrad!(
  nlp::CUTEstModel,
  x::StrideOneVector{Float64},
  g::StrideOneVector{Float64},
)
  nvar = nlp.meta.nvar
  @lencheck nvar x g
  f = Cdouble[0]
  io_err = Cint[0]
  get_grad = 1
  if nlp.meta.ncon > 0
    ccall(
      dlsym(cutest_lib, "cutest_cofg_"),
      Nothing,
      (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}),
      io_err,
      nvar,
      x,
      f,
      g,
      get_grad,
    )
  else
    ccall(
      dlsym(cutest_lib, "cutest_uofg_"),
      Nothing,
      (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}),
      io_err,
      nvar,
      x,
      f,
      g,
      get_grad,
    )
  end
  increment!(nlp, :neval_obj)
  increment!(nlp, :neval_grad)
  @cutest_error

  return f[1], g
end

function NLPModels.objgrad!(nlp::CUTEstModel, x::AbstractVector, g::StrideOneVector{Float64})
  @lencheck nlp.meta.nvar x g
  objgrad!(nlp, convert(Vector{Float64}, x), g)
end

function NLPModels.objgrad!(nlp::CUTEstModel, x::AbstractVector, g::AbstractVector)
  @lencheck nlp.meta.nvar x g
  gc = Vector{Float64}(undef, nlp.meta.nvar)
  f, _ = objgrad!(nlp, convert(Vector{Float64}, x), gc)
  g .= gc
  return f, g
end

function NLPModels.obj(nlp::CUTEstModel, x::AbstractVector)
  @lencheck nlp.meta.nvar x
  f = objcons!(nlp, x, nlp.work)[1]
  if nlp.meta.ncon > 0
    decrement!(nlp, :neval_cons) # does not really count as a constraint eval
  end
  return f
end

function NLPModels.grad!(nlp::CUTEstModel, x::AbstractVector, g::AbstractVector)
  @lencheck nlp.meta.nvar x g
  objgrad!(nlp, x, g)
  decrement!(nlp, :neval_obj) # does not really count as a objective eval
  return g
end

"""
    cons_coord!(nlp, x, c, rows, cols, vals)

Computes the constraint vector and the Jacobian in
coordinate format.
Usage:

    cons_coord!(nlp, x, c, rows, cols, vals)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Vector{Float64}
  - c:    [OUT] Vector{Float64}
  - jrow: [OUT] Vector{Int32}
  - jcol: [OUT] Vector{Int32}
  - jval: [OUT] Vector{Float64}
"""
function cons_coord!(
  nlp::CUTEstModel,
  x::StrideOneVector{Float64},
  c::StrideOneVector{Float64},
  rows::StrideOneVector{Int32},
  cols::StrideOneVector{Int32},
  vals::StrideOneVector{Float64},
)
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  nnzj = nlp.meta.nnzj
  @lencheck nvar x
  @lencheck ncon c
  @lencheck nnzj rows cols vals
  io_err = Cint[0]
  jsize = nlp.meta.nnzj
  get_j = 1

  ccall(
    dlsym(cutest_lib, :cutest_ccfsg_),
    Nothing,
    (
      Ptr{Int32},
      Ref{Int32},
      Ref{Int32},
      Ptr{Float64},
      Ptr{Float64},
      Ref{Int32},
      Ref{Int32},
      Ptr{Float64},
      Ptr{Int32},
      Ptr{Int32},
      Ref{Int32},
    ),
    io_err,
    nvar,
    ncon,
    x,
    c,
    nnzj,
    jsize,
    vals,
    cols,
    rows,
    get_j,
  )
  @cutest_error
  increment!(nlp, :neval_cons)
  increment!(nlp, :neval_jac)
  return c, rows, cols, vals
end

function cons_coord!(
  nlp::CUTEstModel,
  x::AbstractVector,
  c::AbstractVector,
  rows::AbstractVector{<:Integer},
  cols::AbstractVector{<:Integer},
  vals::AbstractVector,
)
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  @lencheck nlp.meta.nnzj rows cols vals
  rows_ = Vector{Int32}(undef, nlp.meta.nnzj)
  cols_ = Vector{Int32}(undef, nlp.meta.nnzj)
  vals_ = Vector{Float64}(undef, nlp.meta.nnzj)
  c_ = Vector{Float64}(undef, nlp.meta.ncon)
  cons_coord!(nlp, convert(Vector{Float64}, x), c_, rows_, cols_, vals_)
  rows .= rows_
  cols .= cols_
  vals .= vals_
  c .= c_
  return c, rows, cols, vals
end

"""
    cons_coord(nlp, x)

Computes the constraint vector and the Jacobian in
coordinate format.
Usage:

    c, jrow, jcol, jval = cons_coord(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Vector{Float64}
  - c:    [OUT] Vector{Float64}
  - jrow: [OUT] Vector{Int32}
  - jcol: [OUT] Vector{Int32}
  - jval: [OUT] Vector{Float64}
"""
function cons_coord(nlp::CUTEstModel, x::StrideOneVector{Float64})
  @lencheck nlp.meta.nvar x
  c = Vector{Float64}(undef, nlp.meta.ncon)
  rows = Vector{Int32}(undef, nlp.meta.nnzj)
  cols = Vector{Int32}(undef, nlp.meta.nnzj)
  vals = Vector{Float64}(undef, nlp.meta.nnzj)
  cons_coord!(nlp, x, c, rows, cols, vals)
end

function cons_coord(nlp::CUTEstModel, x::AbstractVector)
  @lencheck nlp.meta.nvar x
  cons_coord(nlp, convert(Vector{Float64}, x))
end

"""
    consjac(nlp, x)

Computes the constraint vector and the Jacobian in
internal sparse format.
Usage:

    c, J = consjac(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Vector{Float64}
  - c:    [OUT] Vector{Float64}
  - J:    [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64,Int32}
"""
function consjac(nlp::CUTEstModel, x::AbstractVector)
  @lencheck nlp.meta.nvar x
  c, jrow, jcol, jval = cons_coord(nlp, x)
  return c, sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
end

function NLPModels.cons!(nlp::CUTEstModel, x::AbstractVector, c::AbstractVector)
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  objcons!(nlp, x, c)
  decrement!(nlp, :neval_obj)  # does not really count as a objective eval
  return c
end

function NLPModels.cons_lin!(nlp::CUTEstModel, x::AbstractVector, c::AbstractVector)
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nlin c
  eval_lin_structure!(nlp)
  coo_prod!(nlp.clinrows, nlp.clincols, nlp.clinvals, x, c)
  c .+= nlp.blin
  increment!(nlp, :neval_cons_lin)
  return c
end

function NLPModels.cons_nln!(nlp::CUTEstModel, x::AbstractVector, c::AbstractVector)
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nnln c
  _cx = Vector{Float64}(undef, nlp.meta.nnln)
  cons_nln!(nlp, x, _cx)
  c .= _cx
  return c
end

function NLPModels.cons_nln!(nlp::CUTEstModel, x::AbstractVector, c::StrideOneVector)
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nnln c
  k = 1
  for j in nlp.meta.nln
    cifn(Cint[0], Cint[nlp.meta.nvar], Cint[j], x, view(c, k:k))
    k += 1
  end
  increment!(nlp, :neval_cons_nln)
  return c
end

function NLPModels.jac_structure!(
  nlp::CUTEstModel,
  rows::StrideOneVector{Int32},
  cols::StrideOneVector{Int32},
)
  @lencheck nlp.meta.nnzj rows cols
  nnzj = nlp.meta.nnzj
  io_err = Cint[0]
  this_nnzj = Cint[0]

  ccall(
    dlsym(cutest_lib, :cutest_csjp_),
    Nothing,
    (Ptr{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
    io_err,
    this_nnzj,
    nnzj,
    cols,
    rows,
  )
  @cutest_error

  nlp.jrows .= rows[1:nnzj]
  nlp.jcols .= cols[1:nnzj]

  return rows, cols
end

function NLPModels.jac_structure!(nlp::CUTEstModel)
  if !nlp.jac_structure_reliable
    nnzj = nlp.meta.nnzj
    io_err = Cint[0]
    this_nnzj = Cint[0]

    ccall(
      dlsym(cutest_lib, :cutest_csjp_),
      Nothing,
      (Ptr{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
      io_err,
      this_nnzj,
      nnzj,
      nlp.jcols,
      nlp.jrows,
    )
    @cutest_error

    nlp.jac_structure_reliable = true
  end
  return nlp
end

function NLPModels.jac_structure!(
  nlp::CUTEstModel,
  rows::AbstractVector{<:Integer},
  cols::AbstractVector{<:Integer},
)
  @lencheck nlp.meta.nnzj rows cols
  jrows = Vector{Int32}(undef, nlp.meta.nnzj)
  jcols = Vector{Int32}(undef, nlp.meta.nnzj)
  jac_structure!(nlp, jrows, jcols)
  rows .= jrows
  cols .= jcols
  return rows, cols
end

function eval_lin_structure!(nlp::CUTEstModel)
  if !nlp.lin_structure_reliable
    nvar = Cint[nlp.meta.nvar]
    nnzj = Cint[0]
    i = 1
    for j in nlp.meta.lin
      x0 = zeros(nlp.meta.nvar)
      ccifsg(
        Cint[0],
        nvar,
        Cint[j],
        x0,
        view(nlp.blin, j:j),
        nnzj,
        nvar,
        nlp.Jval,
        nlp.Jvar,
        Cint[true],
      )
      for k = 1:nnzj[1]
        nlp.clinrows[i] = findfirst(x -> x == j, nlp.meta.lin)
        nlp.clincols[i] = nlp.Jvar[k]
        nlp.clinvals[i] = nlp.Jval[k]
        i += 1
      end
    end
    nlp.clinrows[i:end] .= Int32(1)
    nlp.clincols[i:end] .= Int32(1)
    nlp.clinvals[i:end] .= 0.0
    nlp.lin_structure_reliable = true
  end
  return nlp
end

function NLPModels.jac_lin_structure!(
  nlp::CUTEstModel,
  rows::AbstractVector{<:Integer},
  cols::AbstractVector{<:Integer},
)
  @lencheck nlp.meta.lin_nnzj rows cols
  eval_lin_structure!(nlp)
  rows .= nlp.clinrows
  cols .= nlp.clincols
  return rows, cols
end

function NLPModels.jac_nln_structure!(
  nlp::CUTEstModel,
  rows::AbstractVector{<:Integer},
  cols::AbstractVector{<:Integer},
)
  @lencheck nlp.meta.nln_nnzj rows cols
  jac_structure!(nlp)
  k = 1
  for i in findall(j -> j in nlp.meta.nln, nlp.jrows)
    rows[k] = nlp.jrows[i] - count(x < nlp.jrows[i] for x in nlp.meta.lin)
    cols[k] = nlp.jcols[i]
    k += 1
  end
  rows[k:end] .= zero(Int32)
  cols[k:end] .= zero(Int32)

  return rows, cols
end

function NLPModels.jac_coord!(nlp::CUTEstModel, x::AbstractVector, vals::AbstractVector)
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nnzj vals
  cons_coord!(nlp, x, nlp.work, nlp.jrows, nlp.jcols, vals)
  decrement!(nlp, :neval_cons) # does not really count as a constraint eval
  return vals
end

function NLPModels.jac_lin_coord!(nlp::CUTEstModel, x::AbstractVector, vals::AbstractVector)
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.lin_nnzj vals
  increment!(nlp, :neval_jac_lin)
  eval_lin_structure!(nlp)
  vals .= nlp.clinvals
  return vals
end

function NLPModels.jac_nln_coord!(nlp::CUTEstModel, x::AbstractVector, vals::AbstractVector)
  nvar = Cint[nlp.meta.nvar]
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nln_nnzj vals
  ci = [0.0]
  nnzj = Cint[0]
  i = 1
  for j in nlp.meta.nln
    ccifsg(Cint[0], nvar, Cint[j], x, ci, nnzj, nvar, nlp.Jval, nlp.Jvar, Cint[true])
    for k = 1:nnzj[1]
      vals[i] = nlp.Jval[k]
      i += 1
    end
  end
  vals[i:end] .= 0.0
  increment!(nlp, :neval_jac_nln)
  return vals
end

function NLPModels.jprod!(
  nlp::CUTEstModel,
  x::StrideOneVector{Float64},
  v::StrideOneVector{Float64},
  jv::StrideOneVector{Float64},
)
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  @lencheck nvar x v
  @lencheck ncon jv
  got_j = 0
  jtrans = 0
  io_err = Cint[0]
  ccall(
    dlsym(cutest_lib, :cutest_cjprod_),
    Nothing,
    (
      Ptr{Int32},
      Ref{Int32},
      Ref{Int32},
      Ref{Int32},
      Ref{Int32},
      Ptr{Float64},
      Ptr{Float64},
      Ref{Int32},
      Ptr{Float64},
      Ref{Int32},
    ),
    io_err,
    nvar,
    ncon,
    got_j,
    jtrans,
    x,
    v,
    nvar,
    jv,
    ncon,
  )
  @cutest_error
  increment!(nlp, :neval_jprod)
  return jv
end

function NLPModels.jprod!(
  nlp::CUTEstModel,
  x::AbstractVector,
  v::AbstractVector,
  jv::StrideOneVector{Float64},
)
  @lencheck nlp.meta.nvar x v
  @lencheck nlp.meta.ncon jv
  jprod!(nlp, convert(Vector{Float64}, x), convert(Vector{Float64}, v), jv)
end

function NLPModels.jprod!(
  nlp::CUTEstModel,
  x::AbstractVector,
  v::AbstractVector,
  jv::AbstractVector,
)
  @lencheck nlp.meta.nvar x v
  @lencheck nlp.meta.ncon jv
  jvc = nlp.work
  jprod!(nlp, convert(Vector{Float64}, x), convert(Vector{Float64}, v), jvc)
  jv .= jvc
end

function NLPModels.jprod_nln!(
  nlp::CUTEstModel,
  x::AbstractVector,
  v::AbstractVector,
  jv::AbstractVector,
)
  @lencheck nlp.meta.nvar x v
  @lencheck nlp.meta.nnln jv
  jvc = nlp.work
  jprod!(nlp, x, v, jvc)
  decrement!(nlp, :neval_jprod)
  increment!(nlp, :neval_jprod_nln)
  jv .= jvc[nlp.meta.nln]
end

function NLPModels.jprod_lin!(
  nlp::CUTEstModel,
  x::AbstractVector,
  v::AbstractVector,
  jv::AbstractVector,
)
  @lencheck nlp.meta.nvar x v
  @lencheck nlp.meta.nlin jv
  increment!(nlp, :neval_jprod_lin)
  eval_lin_structure!(nlp)
  jprod_lin!(nlp, nlp.clinrows, nlp.clincols, nlp.clinvals, v, jv)
  return jv
end

function NLPModels.jtprod!(
  nlp::CUTEstModel,
  x::StrideOneVector{Float64},
  v::StrideOneVector{Float64},
  jtv::StrideOneVector{Float64},
)
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.ncon v
  got_j = 0
  jtrans = 1
  io_err = Cint[0]
  ccall(
    dlsym(cutest_lib, :cutest_cjprod_),
    Nothing,
    (
      Ptr{Int32},
      Ref{Int32},
      Ref{Int32},
      Ref{Int32},
      Ref{Int32},
      Ptr{Float64},
      Ptr{Float64},
      Ref{Int32},
      Ptr{Float64},
      Ref{Int32},
    ),
    io_err,
    nvar,
    ncon,
    got_j,
    jtrans,
    x,
    v,
    ncon,
    jtv,
    nvar,
  )
  @cutest_error
  increment!(nlp, :neval_jtprod)
  return jtv
end

function NLPModels.jtprod!(
  nlp::CUTEstModel,
  x::AbstractVector,
  v::AbstractVector,
  jtv::StrideOneVector{Float64},
)
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.ncon v
  jtprod!(nlp, convert(Vector{Float64}, x), convert(Vector{Float64}, v), jtv)
end

function NLPModels.jtprod!(
  nlp::CUTEstModel,
  x::AbstractVector,
  v::AbstractVector,
  jtv::AbstractVector,
)
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.ncon v
  jtvc = zeros(nlp.meta.nvar)
  jtprod!(nlp, convert(Vector{Float64}, x), convert(Vector{Float64}, v), jtvc)
  jtv .= jtvc
end

function NLPModels.jtprod_nln!(
  nlp::CUTEstModel,
  x::AbstractVector,
  v::AbstractVector,
  jtv::AbstractVector,
)
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.nnln v
  _v = nlp.work
  _v[nlp.meta.lin] .= 0.0
  _v[nlp.meta.nln] = v
  jtprod!(nlp, x, _v, jtv)
  decrement!(nlp, :neval_jtprod)
  increment!(nlp, :neval_jtprod_nln)
  return jtv
end

function NLPModels.jtprod_lin!(
  nlp::CUTEstModel,
  x::AbstractVector,
  v::AbstractVector,
  jtv::AbstractVector,
)
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.nlin v
  increment!(nlp, :neval_jtprod_lin)
  eval_lin_structure!(nlp)
  jtprod_lin!(nlp, nlp.clinrows, nlp.clincols, nlp.clinvals, v, jtv)
  return jtv
end

function NLPModels.hess_structure!(
  nlp::CUTEstModel,
  rows::StrideOneVector{Int32},
  cols::StrideOneVector{Int32},
)
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  nnzh = nlp.meta.nnzh
  @lencheck nnzh rows cols
  io_err = Cint[0]
  this_nnzh = Cint[0]

  if ncon > 0
    ccall(
      dlsym(cutest_lib, :cutest_cshp_),
      Nothing,
      (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
      io_err,
      nvar,
      this_nnzh,
      nnzh,
      cols,
      rows,
    )
    @cutest_error
  else
    ccall(
      dlsym(cutest_lib, :cutest_ushp_),
      Nothing,
      (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
      io_err,
      nvar,
      this_nnzh,
      nnzh,
      cols,
      rows,
    )
    @cutest_error
  end

  nlp.hrows .= rows
  nlp.hcols .= cols

  return rows, cols
end

function NLPModels.hess_structure!(nlp::CUTEstModel)
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  nnzh = nlp.meta.nnzh
  io_err = Cint[0]
  this_nnzh = Cint[0]

  if ncon > 0
    ccall(
      dlsym(cutest_lib, :cutest_cshp_),
      Nothing,
      (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
      io_err,
      nvar,
      this_nnzh,
      nnzh,
      nlp.hcols,
      nlp.hrows,
    )
    @cutest_error
  else
    ccall(
      dlsym(cutest_lib, :cutest_ushp_),
      Nothing,
      (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
      io_err,
      nvar,
      this_nnzh,
      nnzh,
      nlp.hcols,
      nlp.hrows,
    )
    @cutest_error
  end

  return nlp
end

function NLPModels.hess_structure!(
  nlp::CUTEstModel,
  rows::AbstractVector{<:Integer},
  cols::AbstractVector{<:Integer},
)
  @lencheck nlp.meta.nnzh rows cols
  hrows = Vector{Int32}(undef, nlp.meta.nnzh)
  hcols = Vector{Int32}(undef, nlp.meta.nnzh)
  hess_structure!(nlp, hrows, hcols)
  rows .= hrows
  cols .= hcols
  return rows, cols
end

function NLPModels.hess_coord!(
  nlp::CUTEstModel,
  x::StrideOneVector{Float64},
  y::StrideOneVector{Float64},
  vals::StrideOneVector{Float64};
  obj_weight::Float64 = 1.0,
)
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon y
  @lencheck nlp.meta.nnzh vals
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  nnzh = nlp.meta.nnzh
  io_err = Cint[0]
  this_nnzh = Cint[0]

  if obj_weight == 0.0 && ncon > 0
    ccall(
      dlsym(cutest_lib, :cutest_cshc_),
      Nothing,
      (
        Ptr{Int32},
        Ref{Int32},
        Ref{Int32},
        Ptr{Float64},
        Ptr{Float64},
        Ptr{Int32},
        Ref{Int32},
        Ptr{Float64},
        Ptr{Int32},
        Ptr{Int32},
      ),
      io_err,
      nvar,
      ncon,
      x,
      y,
      this_nnzh,
      nnzh,
      vals,
      nlp.hcols,
      nlp.hrows,
    )
    @cutest_error
    increment!(nlp, :neval_hess)
    return vals
  end

  if ncon > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    z = obj_weight == 1.0 ? y : y / obj_weight

    ccall(
      dlsym(cutest_lib, :cutest_csh_),
      Nothing,
      (
        Ptr{Int32},
        Ref{Int32},
        Ref{Int32},
        Ptr{Float64},
        Ptr{Float64},
        Ptr{Int32},
        Ref{Int32},
        Ptr{Float64},
        Ptr{Int32},
        Ptr{Int32},
      ),
      io_err,
      nvar,
      ncon,
      x,
      z,
      this_nnzh,
      nnzh,
      vals,
      nlp.hcols,
      nlp.hrows,
    )
  else
    ccall(
      dlsym(cutest_lib, :cutest_ush_),
      Nothing,
      (
        Ptr{Int32},
        Ref{Int32},
        Ptr{Float64},
        Ptr{Int32},
        Ref{Int32},
        Ptr{Float64},
        Ptr{Int32},
        Ptr{Int32},
      ),
      io_err,
      nvar,
      x,
      this_nnzh,
      nnzh,
      vals,
      nlp.hcols,
      nlp.hrows,
    )
  end
  @cutest_error

  obj_weight != 1.0 && (vals[:] *= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
  increment!(nlp, :neval_hess)
  return vals
end

function NLPModels.hess_coord!(
  nlp::CUTEstModel,
  x::AbstractVector,
  y::AbstractVector,
  vals::AbstractVector;
  obj_weight::Float64 = 1.0,
)
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon y
  @lencheck nlp.meta.nnzh vals
  vals_ = Vector{Float64}(undef, nlp.meta.nnzh)
  NLPModels.hess_coord!(
    nlp,
    convert(Vector{Float64}, x),
    convert(Vector{Float64}, y),
    vals_,
    obj_weight = obj_weight,
  )
  vals .= vals_
  return vals
end

function NLPModels.hess_coord!(
  nlp::CUTEstModel,
  x::AbstractVector,
  vals::AbstractVector;
  obj_weight::Float64 = 1.0,
)
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nnzh vals
  hess_coord!(nlp, x, zeros(nlp.meta.ncon), vals; obj_weight = obj_weight)
end

function NLPModels.hprod!(
  nlp::CUTEstModel,
  x::StrideOneVector{Float64},
  y::StrideOneVector{Float64},
  v::StrideOneVector{Float64},
  hv::StrideOneVector{Float64};
  obj_weight::Float64 = 1.0,
)
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  @lencheck nvar x v hv
  @lencheck ncon y
  io_err = Cint[0]
  goth = Cint[0]
  if obj_weight == 0.0 && ncon > 0
    ccall(
      dlsym(cutest_lib, :cutest_chcprod_),
      Nothing,
      (
        Ptr{Int32},
        Ref{Int32},
        Ref{Int32},
        Ptr{Int32},
        Ptr{Float64},
        Ptr{Float64},
        Ptr{Float64},
        Ptr{Float64},
      ),
      io_err,
      nvar,
      ncon,
      goth,
      x,
      y,
      v,
      hv,
    )
    @cutest_error
    increment!(nlp, :neval_hprod)
    return hv
  end

  if ncon > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    z = obj_weight == 1 ? y : y / obj_weight

    ccall(
      dlsym(cutest_lib, :cutest_chprod_),
      Nothing,
      (
        Ptr{Int32},
        Ref{Int32},
        Ref{Int32},
        Ptr{Int32},
        Ptr{Float64},
        Ptr{Float64},
        Ptr{Float64},
        Ptr{Float64},
      ),
      io_err,
      nvar,
      ncon,
      goth,
      x,
      z,
      v,
      hv,
    )
  else
    ccall(
      dlsym(cutest_lib, :cutest_uhprod_),
      Nothing,
      (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
      io_err,
      nvar,
      goth,
      x,
      v,
      hv,
    )
  end
  @cutest_error

  obj_weight != 1.0 && (hv[:] *= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
  increment!(nlp, :neval_hprod)
  return hv
end

function NLPModels.hprod!(
  nlp::CUTEstModel,
  x::AbstractVector,
  y::AbstractVector,
  v::AbstractVector,
  hv::StrideOneVector{Float64};
  obj_weight::Float64 = 1.0,
)
  @lencheck nlp.meta.nvar x v hv
  @lencheck nlp.meta.ncon y
  hprod!(
    nlp,
    convert(Vector{Float64}, x),
    convert(Vector{Float64}, y),
    convert(Vector{Float64}, v),
    hv,
    obj_weight = obj_weight,
  )
end

function NLPModels.hprod!(
  nlp::CUTEstModel,
  x::AbstractVector,
  y::AbstractVector,
  v::AbstractVector,
  hv::AbstractVector;
  obj_weight::Float64 = 1.0,
)
  @lencheck nlp.meta.nvar x v hv
  @lencheck nlp.meta.ncon y
  hvc = zeros(nlp.meta.nvar)
  hprod!(
    nlp,
    convert(Vector{Float64}, x),
    convert(Vector{Float64}, y),
    convert(Vector{Float64}, v),
    hvc,
    obj_weight = obj_weight,
  )
  hv .= hvc
end

function NLPModels.hprod!(
  nlp::CUTEstModel,
  x::AbstractVector,
  v::AbstractVector,
  hv::StrideOneVector{Float64};
  obj_weight::Float64 = 1.0,
)
  @lencheck nlp.meta.nvar x v hv
  hprod!(
    nlp,
    convert(Vector{Float64}, x),
    zeros(nlp.meta.ncon),
    convert(Vector{Float64}, v),
    hv,
    obj_weight = obj_weight,
  )
end

function NLPModels.hprod!(
  nlp::CUTEstModel,
  x::AbstractVector,
  v::AbstractVector,
  hv::AbstractVector;
  obj_weight::Float64 = 1.0,
)
  @lencheck nlp.meta.nvar x v hv
  hvc = zeros(nlp.meta.nvar)
  hprod!(
    nlp,
    convert(Vector{Float64}, x),
    convert(Vector{Float64}, v),
    hvc,
    obj_weight = obj_weight,
  )
  hv .= hvc
end
