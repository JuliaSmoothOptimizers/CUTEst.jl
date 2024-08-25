export cons_coord, cons_coord!, consjac

using NLPModels, SparseArrays

function NLPModels.objcons(nlp::CUTEstModel{T}, x::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  c = Vector{T}(undef, nlp.meta.ncon)
  objcons!(nlp, Vector{T}(x), c)
end

function NLPModels.objcons!(
  nlp::CUTEstModel{T},
  x::StrideOneVector{T},
  c::StrideOneVector{T},
) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  status = Ref{Cint}(0)
  f = Ref{T}(0)
  if ncon[] > 0
    cfn(T, nlp.libsif, status, nvar, ncon, x, f, c)
    increment!(nlp, :neval_cons)
  else
    ufn(T, nlp.libsif, status, nvar, x, f)
  end
  increment!(nlp, :neval_obj)
  cutest_error(status[])

  return f[], c
end

function NLPModels.objcons!(nlp::CUTEstModel{T}, x::AbstractVector, c::StrideOneVector{T}) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  objcons!(nlp, Vector{T}(x), c)
end

function NLPModels.objcons!(nlp::CUTEstModel{T}, x::AbstractVector, c::AbstractVector) where {T}
  ncon = nlp.meta.ncon
  @lencheck nlp.meta.nvar x
  @lencheck ncon c
  if ncon > 0
    cc = nlp.workspace_ncon
    f, _ = objcons!(nlp, Vector{T}(x), cc)
    c .= cc
    return f, c
  else
    return objcons!(nlp, Vector{T}(x), T[])
  end
end

function NLPModels.objgrad(nlp::CUTEstModel{T}, x::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  g = Vector{T}(undef, nlp.meta.nvar)
  objgrad!(nlp, Vector{T}(x), g)
end

function NLPModels.objgrad!(
  nlp::CUTEstModel{T},
  x::StrideOneVector{T},
  g::StrideOneVector{T},
) where {T}
  @lencheck nlp.meta.nvar x g
  nvar = Ref{Cint}(nlp.meta.nvar)
  f = Ref{T}(0)
  status = Ref{Cint}(0)
  get_grad = Ref{Bool}(true)
  if nlp.meta.ncon > 0
    cofg(T, nlp.libsif, status, nvar, x, f, g, get_grad)
  else
    uofg(T, nlp.libsif, status, nvar, x, f, g, get_grad)
  end
  increment!(nlp, :neval_obj)
  increment!(nlp, :neval_grad)
  cutest_error(status[])

  return f[], g
end

function NLPModels.objgrad!(nlp::CUTEstModel{T}, x::AbstractVector, g::StrideOneVector{T}) where {T}
  @lencheck nlp.meta.nvar x g
  objgrad!(nlp, Vector{T}(x), g)
end

function NLPModels.objgrad!(nlp::CUTEstModel{T}, x::AbstractVector, g::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x g
  gc = nlp.workspace_nvar
  f, _ = objgrad!(nlp, Vector{T}(x), gc)
  g .= gc
  return f, g
end

function NLPModels.obj(nlp::CUTEstModel{T}, x::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  f, _ = objcons!(nlp, x, nlp.workspace_ncon)
  if nlp.meta.ncon > 0
    decrement!(nlp, :neval_cons) # does not really count as a constraint eval
  end
  return f
end

function NLPModels.grad!(nlp::CUTEstModel{T}, x::AbstractVector, g::AbstractVector) where {T}
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
  - x:    [IN] Vector{T}
  - c:    [OUT] Vector{T}
  - jrow: [OUT] Vector{Cint}
  - jcol: [OUT] Vector{Cint}
  - jval: [OUT] Vector{T}
"""
function cons_coord!(
  nlp::CUTEstModel{T},
  x::StrideOneVector{T},
  c::StrideOneVector{T},
  rows::StrideOneVector{Cint},
  cols::StrideOneVector{Cint},
  vals::StrideOneVector{T},
) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  @lencheck nlp.meta.nnzj rows cols vals
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  status = Ref{Cint}(0)
  nnzj = Ref{Cint}(nlp.meta.nnzj)
  jsize = Ref{Cint}(nlp.meta.nnzj)
  get_j = Ref{Bool}(true)

  ccfsg(T, nlp.libsif, status, nvar, ncon, x, c, nnzj, jsize, vals, cols, rows, get_j)
  cutest_error(status[])
  increment!(nlp, :neval_cons)
  increment!(nlp, :neval_jac)
  return c, rows, cols, vals
end

function cons_coord!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  c::AbstractVector,
  rows::AbstractVector{<:Integer},
  cols::AbstractVector{<:Integer},
  vals::AbstractVector,
) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  @lencheck nlp.meta.nnzj rows cols vals
  rows_ = Vector{Cint}(undef, nlp.meta.nnzj)
  cols_ = Vector{Cint}(undef, nlp.meta.nnzj)
  vals_ = Vector{T}(undef, nlp.meta.nnzj)
  c_ = Vector{T}(undef, nlp.meta.ncon)
  cons_coord!(nlp, Vector{T}(x), c_, rows_, cols_, vals_)
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
  - x:    [IN] Vector{T}
  - c:    [OUT] Vector{T}
  - jrow: [OUT] Vector{Cint}
  - jcol: [OUT] Vector{Cint}
  - jval: [OUT] Vector{T}
"""
function cons_coord(nlp::CUTEstModel{T}, x::StrideOneVector{T}) where {T}
  @lencheck nlp.meta.nvar x
  c = Vector{T}(undef, nlp.meta.ncon)
  rows = Vector{Cint}(undef, nlp.meta.nnzj)
  cols = Vector{Cint}(undef, nlp.meta.nnzj)
  vals = Vector{T}(undef, nlp.meta.nnzj)
  cons_coord!(nlp, x, c, rows, cols, vals)
end

function cons_coord(nlp::CUTEstModel{T}, x::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  cons_coord(nlp, Vector{T}(x))
end

"""
    consjac(nlp, x)

Computes the constraint vector and the Jacobian in
internal sparse format.
Usage:

    c, J = consjac(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Vector{T}
  - c:    [OUT] Vector{T}
  - J:    [OUT] Base.SparseMatrix.SparseMatrixCSC{T,Cint}
"""
function consjac(nlp::CUTEstModel{T}, x::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  c, jrow, jcol, jval = cons_coord(nlp, x)
  return c, sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
end

function NLPModels.cons!(nlp::CUTEstModel{T}, x::AbstractVector, c::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  objcons!(nlp, x, c)
  decrement!(nlp, :neval_obj)  # does not really count as a objective eval
  return c
end

function NLPModels.cons_lin!(nlp::CUTEstModel{T}, x::AbstractVector, c::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nlin c
  coo_prod!(nlp.clinrows, nlp.clincols, nlp.clinvals, x, c)
  c .+= nlp.blin
  increment!(nlp, :neval_cons_lin)
  return c
end

function NLPModels.cons_nln!(nlp::CUTEstModel{T}, x::AbstractVector, c::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nnln c
  _cx = Vector{T}(undef, nlp.meta.nnln)
  cons_nln!(nlp, x, _cx)
  c .= _cx
  return c
end

function NLPModels.cons_nln!(nlp::CUTEstModel{T}, x::AbstractVector, c::StrideOneVector) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nnln c
  nvar = Ref{Cint}(nlp.meta.nvar)
  k = 1
  for j in nlp.meta.nln
    cifn(T, nlp.libsif, Ref{Cint}(0), nvar, Ref{Cint}(j), x, view(c, k:k))
    k += 1
  end
  increment!(nlp, :neval_cons_nln)
  return c
end

function NLPModels.jac_structure!(
  nlp::CUTEstModel{T},
  rows::AbstractVector{<:Integer},
  cols::AbstractVector{<:Integer},
) where {T}
  @lencheck nlp.meta.nnzj rows cols
  rows .= nlp.jrows
  cols .= nlp.jcols
  return rows, cols
end

function NLPModels.jac_lin_structure!(
  nlp::CUTEstModel{T},
  rows::AbstractVector{<:Integer},
  cols::AbstractVector{<:Integer},
) where {T}
  @lencheck nlp.meta.lin_nnzj rows cols
  rows .= nlp.clinrows
  cols .= nlp.clincols
  return rows, cols
end

function NLPModels.jac_nln_structure!(
  nlp::CUTEstModel{T},
  rows::AbstractVector{<:Integer},
  cols::AbstractVector{<:Integer},
) where {T}
  @lencheck nlp.meta.nln_nnzj rows cols
  k = 1
  for i in findall(j -> j in nlp.meta.nln, nlp.jrows)
    rows[k] = nlp.jrows[i] - count(x < nlp.jrows[i] for x in nlp.meta.lin)
    cols[k] = nlp.jcols[i]
    k += 1
  end
  return rows, cols
end

function NLPModels.jac_coord!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  vals::AbstractVector,
) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nnzj vals
  cons_coord!(nlp, x, nlp.workspace_ncon, nlp.jrows, nlp.jcols, vals)
  decrement!(nlp, :neval_cons)  # does not really count as a constraint eval
  return vals
end

function NLPModels.jac_lin_coord!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  vals::AbstractVector,
) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.lin_nnzj vals
  increment!(nlp, :neval_jac_lin)
  vals .= nlp.clinvals
  return vals
end

function NLPModels.jac_nln_coord!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  vals::AbstractVector,
) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nln_nnzj vals
  nvar = Ref{Cint}(nlp.meta.nvar)
  ci = Ref{T}(zero(T))
  nnzj = Ref{Cint}(0)
  bool = Ref{Bool}(true)
  i = 1
  for j in nlp.meta.nln
    ccifsg(T, nlp.libsif, Ref{Cint}(0), nvar, Ref{Cint}(j), x, ci, nnzj, nvar, nlp.Jval, nlp.Jvar, bool)
    for k = 1:nnzj[]
      vals[i] = nlp.Jval[k]
      i += 1
    end
  end
  vals[i:end] .= zero(T)
  increment!(nlp, :neval_jac_nln)
  return vals
end

function NLPModels.jprod!(
  nlp::CUTEstModel{T},
  x::StrideOneVector{T},
  v::StrideOneVector{T},
  jv::StrideOneVector{T},
) where {T}
  @lencheck nlp.meta.nvar x v
  @lencheck nlp.meta.ncon jv
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  got_j = Ref{Bool}(false)
  jtrans = Ref{Bool}(false)
  status = Ref{Cint}(0)
  cjprod(T, nlp.libsif, status, nvar, ncon, got_j, jtrans, x, v, nvar, jv, ncon)
  cutest_error(status[])
  increment!(nlp, :neval_jprod)
  return jv
end

function NLPModels.jprod!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  v::AbstractVector,
  jv::StrideOneVector{T},
) where {T}
  @lencheck nlp.meta.nvar x v
  @lencheck nlp.meta.ncon jv
  jprod!(nlp, Vector{T}(x), Vector{T}(v), jv)
end

function NLPModels.jprod!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  v::AbstractVector,
  jv::AbstractVector,
) where {T}
  @lencheck nlp.meta.nvar x v
  @lencheck nlp.meta.ncon jv
  jvc = nlp.workspace_ncon
  jprod!(nlp, Vector{T}(x), Vector{T}(v), jvc)
  jv .= jvc
end

function NLPModels.jprod_nln!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  v::AbstractVector,
  jv::AbstractVector,
) where {T}
  @lencheck nlp.meta.nvar x v
  @lencheck nlp.meta.nnln jv
  jvc = nlp.workspace_ncon
  jprod!(nlp, x, v, jvc)
  decrement!(nlp, :neval_jprod)
  increment!(nlp, :neval_jprod_nln)
  jv .= view(jvc, nlp.meta.nln)
end

function NLPModels.jprod_lin!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  v::AbstractVector,
  jv::AbstractVector,
) where {T}
  @lencheck nlp.meta.nvar x v
  @lencheck nlp.meta.nlin jv
  increment!(nlp, :neval_jprod_lin)
  jprod_lin!(nlp, nlp.clinrows, nlp.clincols, nlp.clinvals, v, jv)
  return jv
end

function NLPModels.jtprod!(
  nlp::CUTEstModel{T},
  x::StrideOneVector{T},
  v::StrideOneVector{T},
  jtv::StrideOneVector{T},
) where {T}
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.ncon v
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  got_j = Ref{Bool}(false)
  jtrans = Ref{Bool}(true)
  status = Ref{Cint}(0)
  cjprod(T, nlp.libsif, status, nvar, ncon, got_j, jtrans, x, v, ncon, jtv, nvar)
  cutest_error(status[])
  increment!(nlp, :neval_jtprod)
  return jtv
end

function NLPModels.jtprod!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  v::AbstractVector,
  jtv::StrideOneVector{T},
) where {T}
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.ncon v
  jtprod!(nlp, Vector{T}(x), Vector{T}(v), jtv)
end

function NLPModels.jtprod!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  v::AbstractVector,
  jtv::AbstractVector,
) where {T}
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.ncon v
  jtvc = nlp.workspace_nvar
  jtprod!(nlp, Vector{T}(x), Vector{T}(v), jtvc)
  jtv .= jtvc
end

function NLPModels.jtprod_nln!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  v::AbstractVector,
  jtv::AbstractVector,
) where {T}
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.nnln v
  _v = nlp.workspace_ncon
  _v[nlp.meta.lin] .= zero(T)
  _v[nlp.meta.nln] = v
  jtprod!(nlp, x, _v, jtv)
  decrement!(nlp, :neval_jtprod)
  increment!(nlp, :neval_jtprod_nln)
  return jtv
end

function NLPModels.jtprod_lin!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  v::AbstractVector,
  jtv::AbstractVector,
) where {T}
  @lencheck nlp.meta.nvar x jtv
  @lencheck nlp.meta.nlin v
  increment!(nlp, :neval_jtprod_lin)
  jtprod_lin!(nlp, nlp.clinrows, nlp.clincols, nlp.clinvals, v, jtv)
  return jtv
end

function NLPModels.hess_structure!(
  nlp::CUTEstModel{T},
  rows::AbstractVector{<:Integer},
  cols::AbstractVector{<:Integer},
) where {T}
  @lencheck nlp.meta.nnzh rows cols
  rows .= nlp.hrows
  cols .= nlp.hcols
  return rows, cols
end

function NLPModels.hess_coord!(
  nlp::CUTEstModel{T},
  x::StrideOneVector{T},
  y::StrideOneVector{T},
  vals::StrideOneVector{T};
  obj_weight::T = one(T),
) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon y
  @lencheck nlp.meta.nnzh vals
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  nnzh = Ref{Cint}(nlp.meta.nnzh)
  status = Ref{Cint}(0)
  this_nnzh = Ref{Cint}(0)

  if obj_weight == zero(T) && (ncon[] > 0)
    cshc(T, nlp.libsif, status, nvar, ncon, x, y, this_nnzh, nnzh, vals, nlp.hcols, nlp.hrows)
    cutest_error(status[])
    increment!(nlp, :neval_hess)
    return vals
  end

  if ncon[] > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    z = obj_weight == one(T) ? y : y / obj_weight

    csh(T, nlp.libsif, status, nvar, ncon, x, z, this_nnzh, nnzh, vals, nlp.hcols, nlp.hrows)
  else
    ush(T, nlp.libsif, status, nvar, x, this_nnzh, nnzh, vals, nlp.hcols, nlp.hrows)
  end
  cutest_error(status[])

  (obj_weight != one(T)) && (vals .*= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
  increment!(nlp, :neval_hess)
  return vals
end

function NLPModels.hess_coord!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  y::AbstractVector,
  vals::AbstractVector;
  obj_weight::T = one(T),
) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon y
  @lencheck nlp.meta.nnzh vals
  vals_ = Vector{T}(undef, nlp.meta.nnzh)
  NLPModels.hess_coord!(nlp, Vector{T}(x), convert(Vector{T}, y), vals_, obj_weight = obj_weight)
  vals .= vals_
  return vals
end

function NLPModels.hess_coord!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  vals::AbstractVector;
  obj_weight::T = one(T),
) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.nnzh vals
  λ = nlp.workspace_ncon
  λ .= zero(T)
  hess_coord!(nlp, x, λ, vals; obj_weight = obj_weight)
end

function NLPModels.hprod!(
  nlp::CUTEstModel{T},
  x::StrideOneVector{T},
  y::StrideOneVector{T},
  v::StrideOneVector{T},
  hv::StrideOneVector{T};
  obj_weight::T = one(T),
) where {T}
  @lencheck nlp.meta.nvar x v hv
  @lencheck nlp.meta.ncon y
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  status = Ref{Cint}(0)
  goth = Ref{Bool}(0)
  if obj_weight == zero(T) && (ncon[] > 0)
    chcprod(T, nlp.libsif, status, nvar, ncon, goth, x, y, v, hv)
    cutest_error(status[])
    increment!(nlp, :neval_hprod)
    return hv
  end

  if ncon[] > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    if obj_weight == one(T)
      z = y
    else
      z = nlp.workspace_ncon
      z .= y ./ obj_weight
    end
    chprod(T, nlp.libsif, status, nvar, ncon, goth, x, z, v, hv)
  else
    uhprod(T, nlp.libsif, status, nvar, goth, x, v, hv)
  end
  cutest_error(status[])

  (obj_weight != one(T)) && (hv .*= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
  increment!(nlp, :neval_hprod)
  return hv
end

function NLPModels.hprod!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  y::AbstractVector,
  v::AbstractVector,
  hv::StrideOneVector{T};
  obj_weight::T = one(T),
) where {T}
  @lencheck nlp.meta.nvar x v hv
  @lencheck nlp.meta.ncon y
  hprod!(nlp, Vector{T}(x), convert(Vector{T}, y), Vector{T}(v), hv, obj_weight = obj_weight)
end

function NLPModels.hprod!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  y::AbstractVector,
  v::AbstractVector,
  hv::AbstractVector;
  obj_weight::T = one(T),
) where {T}
  @lencheck nlp.meta.nvar x v hv
  @lencheck nlp.meta.ncon y
  hvc = nlp.workspace_nvar
  hprod!(nlp, Vector{T}(x), convert(Vector{T}, y), Vector{T}(v), hvc, obj_weight = obj_weight)
  hv .= hvc
end

function NLPModels.hprod!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  v::AbstractVector,
  hv::StrideOneVector{T};
  obj_weight::T = one(T),
) where {T}
  @lencheck nlp.meta.nvar x v hv
  λ = nlp.workspace_ncon
  λ .= zero(T)  # Lagrange multipliers
  hprod!(nlp, Vector{T}(x), λ, Vector{T}(v), hv, obj_weight = obj_weight)
end

function NLPModels.hprod!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  v::AbstractVector,
  hv::AbstractVector;
  obj_weight::T = one(T),
) where {T}
  @lencheck nlp.meta.nvar x v hv
  hvc = nlp.workspace_nvar
  hprod!(nlp, Vector{T}(x), Vector{T}(v), hvc, obj_weight = obj_weight)
  hv .= hvc
end

function NLPModels.jth_hess_coord!(
  nlp::CUTEstModel{T},
  x::AbstractVector,
  j::Integer,
  vals::AbstractVector,
) where {T}
  nvar = Ref{Cint}(nlp.meta.nvar)
  ncon = Ref{Cint}(nlp.meta.ncon)
  nnzh = Ref{Cint}(nlp.meta.nnzh)
  status = Ref{Cint}(0)
  cish(T, nlp.libsif, status, nvar, x, Ref{Cint}(j), nnzh, nnzh, vals, nlp.hrows, nlp.hcols)
  return vals
end
