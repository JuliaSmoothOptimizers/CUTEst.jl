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
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  status = Ref{Cint}(0)
  f = Ref{Float64}(0)
  if ncon[] > 0
    cfn(
      status,
      nvar,
      ncon,
      x,
      f,
      c,
    )
    increment!(nlp, :neval_cons)
  else
    ufn(
      status,
      nvar,
      x,
      f,
    )
  end
  increment!(nlp, :neval_obj)
  cutest_error(status[])

  return f[], c
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
    cc = zeros(Float64, ncon)
    f, _ = objcons!(nlp, convert(Vector{Float64}, x), cc)
    c .= cc
    return f, c
  else
    return objcons!(nlp, convert(Vector{Float64}, x), Float64[])  # dispatch too complex for a Ref
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
  @lencheck nlp.meta.nvar x g
  nvar = Ref{Cint}(nlp.meta.nvar)
  f = Ref{Float64}(0)
  status = Ref{Cint}(0)
  get_grad = Ref{Bool}(1)
  if nlp.meta.ncon > 0
    cofg(
      status,
      nvar,
      x,
      f,
      g,
      get_grad,
    )
  else
    uofg(
      status,
      nvar,
      x,
      f,
      g,
      get_grad,
    )
  end
  increment!(nlp, :neval_obj)
  increment!(nlp, :neval_grad)
  cutest_error(status[])

  return f[], g
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
  f, _ = objcons!(nlp, x, nlp.work)
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
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  @lencheck nlp.meta.nnzj rows cols vals
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  status = Ref{Cint}(0)
  nnzj = Ref{Cint}(nlp.meta.nnzj)
  jsize = Ref{Cint}(nlp.meta.nnzj)
  get_j = Ref{Bool}(true)

  ccfsg(
    status,
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
  cutest_error(status[])
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
  nvar = Ref{Cint}(nlp.meta.nvar)
  k = 1
  for j in nlp.meta.nln
    cifn(Ref{Cint}(0), nvar, Ref{Cint}(j), x, view(c, k:k))
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
  nnzj = Ref{Cint}(nlp.meta.nnzj)
  status = Ref{Cint}(0)
  this_nnzj = Ref{Cint}(0)

  csjp(
    status,
    this_nnzj,
    nnzj,
    cols,
    rows,
  )
  cutest_error(status[])

  nlp.jrows .= rows[1:nnzj[]]
  nlp.jcols .= cols[1:nnzj[]]

  return rows, cols
end

function NLPModels.jac_structure!(nlp::CUTEstModel)
  if !nlp.jac_structure_reliable
    nnzj = Ref{Cint}(nlp.meta.nnzj)
    status = Ref{Cint}(0)
    this_nnzj = Ref{Cint}(0)

    csjp(
      status,
      this_nnzj,
      nnzj,
      nlp.jcols,
      nlp.jrows,
    )
    cutest_error(status[])

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
    nvar = Ref{Cint}(nlp.meta.nvar)
    nnzj = Ref{Cint}(0)
    i = 1
    for j in nlp.meta.lin
      x0 = zeros(Float64, nlp.meta.nvar)
      ccifsg(
        Ref{Cint}(0),
        nvar,
        Ref{Cint}(j),
        x0,
        view(nlp.blin, j:j),
        nnzj,
        nvar,
        nlp.Jval,
        nlp.Jvar,
        Ref{Bool}(true),
      )
      for k = 1:nnzj[]
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
  decrement!(nlp, :neval_cons)  # does not really count as a constraint eval
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
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nln_nnzj vals
  nvar = Ref{Cint}(nlp.meta.nvar)
  ci = Ref{Float64}(0.0)
  nnzj = Ref{Cint}(0)
  bool = Ref{Bool}(true)
  i = 1
  for j in nlp.meta.nln
    ccifsg(Ref{Cint}(0), nvar, Ref{Cint}(j), x, ci, nnzj, nvar, nlp.Jval, nlp.Jvar, bool)
    for k = 1:nnzj[]
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
  @lencheck nlp.meta.nvar x v
  @lencheck nlp.meta.ncon jv
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  got_j = Ref{Bool}(false)
  jtrans = Ref{Bool}(false)
  status = Ref{Cint}(0)
  cjprod(
    status,
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
  cutest_error(status[])
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
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.ncon v
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  got_j = Ref{Bool}(false)
  jtrans = Ref{Bool}(true)
  status = Ref{Cint}(0)
  cjprod(
    status,
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
  cutest_error(status[])
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
  jtvc = zeros(Float64, nlp.meta.nvar)
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
  @lencheck nlp.meta.nnzh rows cols
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  nnzh = Ref{Cint}(nlp.meta.nnzh)
  status = Ref{Cint}(0)
  this_nnzh = Ref{Cint}(0)

  if ncon[] > 0
    cshp(
      status,
      nvar,
      this_nnzh,
      nnzh,
      cols,
      rows,
    )
    cutest_error(status[])
  else
    ushp(
      status,
      nvar,
      this_nnzh,
      nnzh,
      cols,
      rows,
    )
    cutest_error(status[])
  end

  nlp.hrows .= rows
  nlp.hcols .= cols

  return rows, cols
end

function NLPModels.hess_structure!(nlp::CUTEstModel)
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  nnzh = Ref{Cint}(nlp.meta.nnzh)
  status = Ref{Cint}(0)
  this_nnzh = Ref{Cint}(0)

  if ncon[] > 0
    cshp(
      status,
      nvar,
      this_nnzh,
      nnzh,
      nlp.hcols,
      nlp.hrows,
    )
    cutest_error(status[])
  else
    ushp(
      status,
      nvar,
      this_nnzh,
      nnzh,
      nlp.hcols,
      nlp.hrows,
    )
    cutest_error(status[])
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
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  nnzh = Ref{Cint}(nlp.meta.nnzh)
  status = Ref{Cint}(0)
  this_nnzh = Ref{Cint}(0)

  if obj_weight == 0.0 && ncon[] > 0
    cshc(
      status,
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
    cutest_error(status[])
    increment!(nlp, :neval_hess)
    return vals
  end

  if ncon[] > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    z = obj_weight == 1.0 ? y : y / obj_weight

    csh(
      status,
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
    ush(
      status,
      nvar,
      x,
      this_nnzh,
      nnzh,
      vals,
      nlp.hcols,
      nlp.hrows,
    )
  end
  cutest_error(status[])

  obj_weight != 1.0 && (vals .*= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
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
  hess_coord!(nlp, x, zeros(Float64, nlp.meta.ncon), vals; obj_weight = obj_weight)
end

function NLPModels.hprod!(
  nlp::CUTEstModel,
  x::StrideOneVector{Float64},
  y::StrideOneVector{Float64},
  v::StrideOneVector{Float64},
  hv::StrideOneVector{Float64};
  obj_weight::Float64 = 1.0,
)
  @lencheck nlp.meta.nvar x v hv
  @lencheck nlp.meta.ncon y
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  status = Ref{Cint}(0)
  goth = Ref{Bool}(0)
  if obj_weight == 0.0 && ncon[] > 0
    chcprod(
      status,
      nvar,
      ncon,
      goth,
      x,
      y,
      v,
      hv,
    )
    cutest_error(status[])
    increment!(nlp, :neval_hprod)
    return hv
  end

  if ncon[] > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    z = obj_weight == 1 ? y : y / obj_weight

    chprod(
      status,
      nvar,
      ncon,
      goth,
      x,
      z,
      v,
      hv,
    )
  else
    uhprod(
      status,
      nvar,
      goth,
      x,
      v,
      hv,
    )
  end
  cutest_error(status[])

  obj_weight != 1.0 && (hv .*= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
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
  hvc = zeros(Float64, nlp.meta.nvar)
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
    zeros(Float64, nlp.meta.ncon),
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
  hvc = zeros(Float64, nlp.meta.nvar)
  hprod!(
    nlp,
    convert(Vector{Float64}, x),
    convert(Vector{Float64}, v),
    hvc,
    obj_weight = obj_weight,
  )
  hv .= hvc
end
