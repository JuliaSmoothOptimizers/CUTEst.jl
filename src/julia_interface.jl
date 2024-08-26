export cons_coord, cons_coord!, consjac

using NLPModels, SparseArrays

function NLPModels.obj(nlp::CUTEstModel{T}, x::StrideOneVector{T}) where {T}
  @lencheck nlp.meta.nvar x
  if nlp.meta.ncon > 0
    iprob = nlp.index
    iprob[] = 0
    cifn(T, nlp.libsif, nlp.status, nlp.nvar, iprob, x, nlp.f)
  else
    ufn(T, nlp.libsif, nlp.status, nlp.nvar, x, nlp.f)
  end
  increment!(nlp, :neval_obj)
  return nlp.f[]
end

function NLPModels.obj(nlp::CUTEstModel{T}, x::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  x_ = Vector{T}(x)
  obj(nlp, x_)
end

function NLPModels.grad!(nlp::CUTEstModel{T}, x::StrideOneVector{T}, g::StrideOneVector{T}) where {T}
  @lencheck nlp.meta.nvar x g
  if nlp.meta.ncon > 0
    iprob = nlp.index
    iprob[] = 0
    cigr(T, nlp.libsif, nlp.status, nlp.nvar, iprob, x, g)
  else
    ugr(T, nlp.libsif, nlp.status, nlp.nvar, x, g)
  end
  increment!(nlp, :neval_grad)
  return g
end

function NLPModels.grad!(nlp::CUTEstModel{T}, x::AbstractVector, g::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x g
  x_ = Vector{T}(x)
  g_ = Vector{T}(g)
  grad!(nlp, x_, g_)
  g .= g_
end

function NLPModels.objcons!(
  nlp::CUTEstModel{T},
  x::StrideOneVector{T},
  c::StrideOneVector{T},
) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  if nlp.meta.ncon > 0
    cfn(T, nlp.libsif, nlp.status, nlp.nvar, nlp.ncon, x, nlp.f, c)
    increment!(nlp, :neval_cons)
  else
    ufn(T, nlp.libsif, nlp.status, nlp.nvar, x, nlp.f)
  end
  increment!(nlp, :neval_obj)
  cutest_error(nlp.status[])

  return nlp.f[], c
end

function NLPModels.objcons!(nlp::CUTEstModel{T}, x::AbstractVector, c::StrideOneVector{T}) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  objcons!(nlp, Vector{T}(x), c)
end

function NLPModels.objcons!(nlp::CUTEstModel{T}, x::AbstractVector, c::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  if nlp.meta.ncon > 0
    cc = nlp.workspace_ncon
    f, _ = objcons!(nlp, Vector{T}(x), cc)
    c .= cc
    return f, c
  else
    return objcons!(nlp, Vector{T}(x), T[])
  end
end

function NLPModels.objgrad!(
  nlp::CUTEstModel{T},
  x::StrideOneVector{T},
  g::StrideOneVector{T},
) where {T}
  @lencheck nlp.meta.nvar x g
  get_grad = cutest_true
  if nlp.meta.ncon > 0
    cofg(T, nlp.libsif, nlp.status, nlp.nvar, x, nlp.f, g, get_grad)
  else
    uofg(T, nlp.libsif, nlp.status, nlp.nvar, x, nlp.f, g, get_grad)
  end
  increment!(nlp, :neval_obj)
  increment!(nlp, :neval_grad)
  cutest_error(nlp.status[])

  return nlp.f[], g
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
  jsize = nlp.index
  jsize[] = nlp.meta.nnzj
  get_j = cutest_true

  ccfsg(T, nlp.libsif, nlp.status, nlp.nvar, nlp.ncon, x, c, nlp.nnzj, jsize, vals, cols, rows, get_j)
  cutest_error(nlp.status[])
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

function NLPModels.cons!(nlp::CUTEstModel{T}, x::StrideOneVector{T}, c::StrideOneVector{T}) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  cconst(T, nlp.libsif, nlp.status, nlp.ncon, c)
  increment!(nlp, :neval_cons)
  return c
end

function NLPModels.cons!(nlp::CUTEstModel{T}, x::AbstractVector, c::AbstractVector) where {T}
  @lencheck nlp.meta.nvar x
  @lencheck nlp.meta.ncon c
  x_ = Vector{T}(x)
  c_ = Vector{T}(c)
  cons!(nlp, x_, c_)
  c .= c_
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
  k = 1
  ref_j = nlp.index
  for j in nlp.meta.nln
    ref_j[] = j
    cifn(T, nlp.libsif, nlp.status, nlp.nvar, ref_j, x, view(c, k:k))
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
  ci = nlp.f
  ci[] = zero(T)
  bool = cutest_true
  i = 1
  ref_j = nlp.index
  for j in nlp.meta.nln
    ref_j[] = j
    ccifsg(T, nlp.libsif, nlp.status, nlp.nvar, ref_j, x, ci, nlp.nnzj, nlp.nvar, nlp.Jval, nlp.Jvar, bool)
    for k = 1:nlp.nnzj[]
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
  got_j = cutest_false
  jtrans = cutest_false
  cjprod(T, nlp.libsif, nlp.status, nlp.nvar, nlp.ncon, got_j, jtrans, x, v, nlp.nvar, jv, nlp.ncon)
  cutest_error(nlp.status[])
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
  got_j = cutest_false
  jtrans = cutest_true
  cjprod(T, nlp.libsif, nlp.status, nlp.nvar, nlp.ncon, got_j, jtrans, x, v, nlp.ncon, jtv, nlp.nvar)
  cutest_error(nlp.status[])
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
  this_nnzh = nlp.index
  this_nnzh[] = 0

  if obj_weight == zero(T) && (nlp.meta.ncon > 0)
    cshc(T, nlp.libsif, nlp.status, nlp.nvar, nlp.ncon, x, y, this_nnzh, nlp.nnzh, vals, nlp.hcols, nlp.hrows)
    cutest_error(nlp.status[])
    increment!(nlp, :neval_hess)
    return vals
  end

  if nlp.meta.ncon > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    z = obj_weight == one(T) ? y : y / obj_weight
    csh(T, nlp.libsif, nlp.status, nlp.nvar, nlp.ncon, x, z, this_nnzh, nlp.nnzh, vals, nlp.hcols, nlp.hrows)
  else
    ush(T, nlp.libsif, nlp.status, nlp.nvar, x, this_nnzh, nlp.nnzh, vals, nlp.hcols, nlp.hrows)
  end
  cutest_error(nlp.status[])

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
  goth = cutest_false
  if obj_weight == zero(T) && (nlp.meta.ncon > 0)
    chcprod(T, nlp.libsif, nlp.status, nlp.nvar, nlp.ncon, goth, x, y, v, hv)
    cutest_error(nlp.status[])
    increment!(nlp, :neval_hprod)
    return hv
  end

  if nlp.meta.ncon > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    if obj_weight == one(T)
      z = y
    else
      z = nlp.workspace_ncon
      z .= y ./ obj_weight
    end
    chprod(T, nlp.libsif, nlp.status, nlp.nvar, nlp.ncon, goth, x, z, v, hv)
  else
    uhprod(T, nlp.libsif, nlp.status, nlp.nvar, goth, x, v, hv)
  end
  cutest_error(nlp.status[])

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
  x::StrideOneVector{T},
  v::StrideOneVector{T},
  hv::StrideOneVector{T};
  obj_weight::T = one(T),
) where {T}
  @lencheck nlp.meta.nvar x v hv
  λ = nlp.workspace_ncon
  λ .= zero(T)  # Lagrange multipliers
  hprod!(nlp, x, λ, v, hv, obj_weight = obj_weight)
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
  ref_j = nlp.index
  ref_j[] = j
  cish(T, nlp.libsif, nlp.status, nlp.nvar, x, ref_j, nlp.nnzh, nlp.nnzh, vals, nlp.hrows, nlp.hcols)
  return vals
end
