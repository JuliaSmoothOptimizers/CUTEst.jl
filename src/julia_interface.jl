export cons_coord, cons_coord!, consjac

using NLPModels, SparseArrays

function NLPModels.objcons(nlp :: CUTEstModel, x :: AbstractVector)
  c = Vector{Float64}(undef, nlp.meta.ncon)
  objcons!(nlp, Vector{Float64}(x), c)
end

function NLPModels.objcons!(nlp :: CUTEstModel, x :: Vector{Float64}, c :: Vector{Float64})
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  io_err = Cint[0]
  f = Cdouble[0]
  if ncon > 0
    ccall(dlsym(cutest_lib, :cutest_cfn_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  nvar,   ncon,   x,         f,         c)
    nlp.counters.neval_cons += 1
  else
    ccall(dlsym(cutest_lib, :cutest_ufn_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  nvar,    x,         f)
  end
  nlp.counters.neval_obj += 1
  @cutest_error

  return f[1], c
end

function NLPModels.objcons!(nlp :: CUTEstModel, x :: AbstractVector, c :: Vector{Float64})
  objcons!(nlp, Vector{Float64}(x), c)
end

function NLPModels.objcons!(nlp :: CUTEstModel, x :: AbstractVector, c :: AbstractVector)
  m = nlp.meta.ncon
  if m > 0
    cc = zeros(m)
    f, _ = objcons!(nlp, Vector{Float64}(x), cc)
    c .= cc
    return f, c
  else
    return objcons!(nlp, Vector{Float64}(x), zeros(0))
  end
end

function NLPModels.objgrad(nlp :: CUTEstModel, x :: AbstractVector)
  g = Vector{Float64}(undef, nlp.meta.nvar)
  objgrad!(nlp, Vector{Float64}(x), g)
end

function NLPModels.objgrad!(nlp :: CUTEstModel, x :: Vector{Float64}, g :: Vector{Float64})
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  f = Cdouble[0]
  io_err = Cint[0]
  get_grad = 1
  if ncon > 0
    ccall(dlsym(cutest_lib, "cutest_cofg_"), Nothing,
        (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}),
             io_err,       nvar,            x,            f,            g,   get_grad)
  else
    ccall(dlsym(cutest_lib, "cutest_uofg_"), Nothing,
        (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}),
             io_err,       nvar,            x,            f,            g,   get_grad)
  end
  nlp.counters.neval_obj += 1
  nlp.counters.neval_grad += 1
  @cutest_error

  return f[1], g
end

function NLPModels.objgrad!(nlp :: CUTEstModel, x :: AbstractVector, g :: Vector{Float64})
  objgrad!(nlp, Vector{Float64}(x), g)
end

function NLPModels.objgrad!(nlp :: CUTEstModel, x :: AbstractVector, g :: AbstractVector)
  gc = zeros(nlp.meta.nvar)
  f, _ = objgrad!(nlp, Vector{Float64}(x), gc)
  g[1 : nlp.meta.nvar] .= gc
  return f, g
end

function NLPModels.obj(nlp :: CUTEstModel, x :: AbstractVector)
  f = objcons(nlp, x)[1]
  if nlp.meta.ncon > 0
    nlp.counters.neval_cons -= 1  # does not really count as a constraint eval
  end
  return f
end

function NLPModels.grad!(nlp :: CUTEstModel, x :: AbstractVector, g :: AbstractVector)
  objgrad!(nlp, x, g)
  nlp.counters.neval_obj -= 1  # does not really count as a objective eval
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
function cons_coord!(nlp :: CUTEstModel, x :: Vector{Float64}, c :: Vector{Float64}, rows :: Vector{Int32}, cols :: Vector{Int32}, vals :: Vector{Float64})
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  nnzj = nlp.meta.nnzj
  io_err = Cint[0]
  jsize = nlp.meta.nnzj
  get_j = 1

  ccall(dlsym(cutest_lib, :cutest_ccfsg_), Nothing,
              (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ref{Int32}),
               io_err,     nvar,       ncon,       x,            c,            nnzj,       jsize,      vals,         cols,       rows,       get_j)
  @cutest_error
  nlp.counters.neval_cons += 1
  nlp.counters.neval_jac += 1
  return c, rows, cols, vals
end

function cons_coord!(nlp :: CUTEstModel, x :: AbstractVector, c :: AbstractVector, rows :: AbstractVector{<:Integer}, cols :: AbstractVector{<:Integer}, vals :: AbstractVector)
  rows_ = Vector{Int32}(undef, nlp.meta.nnzj)
  cols_ = Vector{Int32}(undef, nlp.meta.nnzj)
  vals_ = Vector{Float64}(undef, nlp.meta.nnzj)
  c_ = Vector{Float64}(undef, nlp.meta.ncon)
  cons_coord!(nlp, Vector{Float64}(x), c_, rows_, cols_, vals_)
  rows[1 : nlp.meta.nnzj] .= rows_
  cols[1 : nlp.meta.nnzj] .= cols_
  vals[1 : nlp.meta.nnzj] .= vals_
  c[1 : nlp.meta.ncon] .= c_
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
function cons_coord(nlp :: CUTEstModel, x :: Vector{Float64})
  c = Vector{Float64}(undef, nlp.meta.ncon)
  rows = Vector{Int32}(undef, nlp.meta.nnzj)
  cols = Vector{Int32}(undef, nlp.meta.nnzj)
  vals = Vector{Float64}(undef, nlp.meta.nnzj)
  cons_coord!(nlp, x, c, rows, cols, vals)
end

function cons_coord(nlp :: CUTEstModel, x :: AbstractVector)
  cons_coord(nlp, Vector{Float64}(x))
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
function consjac(nlp :: CUTEstModel, x :: AbstractVector)
  c, jrow, jcol, jval = cons_coord(nlp, x)
  return c, sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
end

function NLPModels.cons!(nlp :: CUTEstModel, x :: AbstractVector, c :: AbstractVector)
  objcons!(nlp, x, c)
  nlp.counters.neval_obj -= 1  # does not really count as a objective eval
  return c
end

function NLPModels.jac_structure!(nlp :: CUTEstModel, rows :: Vector{Int32}, cols :: Vector{Int32})
  nnzj = nlp.meta.nnzj
  io_err = Cint[0]
  this_nnzj = Cint[0]

  ccall(dlsym(cutest_lib, :cutest_csjp_), Nothing,
              (Ptr{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
              io_err, this_nnzj, nnzj, cols, rows)
  @cutest_error

  nlp.jrows .= rows
  nlp.jcols .= cols

  return rows, cols
end

function NLPModels.jac_structure!(nlp :: CUTEstModel)
  nnzj = nlp.meta.nnzj
  io_err = Cint[0]
  this_nnzj = Cint[0]

  ccall(dlsym(cutest_lib, :cutest_csjp_), Nothing,
              (Ptr{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
              io_err, this_nnzj, nnzj, nlp.jcols, nlp.jrows)
  @cutest_error

  return nlp
end

function NLPModels.jac_structure!(nlp :: CUTEstModel, rows :: AbstractVector{<:Integer}, cols :: AbstractVector{<:Integer})
  jrows = Vector{Int32}(undef, nlp.meta.nnzj)
  jcols = Vector{Int32}(undef, nlp.meta.nnzj)
  jac_structure!(nlp, jrows, jcols)
  rows[1 : nlp.meta.nnzj] .= jrows
  cols[1 : nlp.meta.nnzj] .= jcols
  return rows, cols
end

function NLPModels.jac_coord!(nlp :: CUTEstModel, x :: AbstractVector, rows :: AbstractVector{<: Integer}, cols :: AbstractVector{<: Integer}, vals :: AbstractVector)
  c = Vector{Float64}(undef, nlp.meta.ncon)
  cons_coord!(nlp, x, c, nlp.jrows, nlp.jcols, vals)
  nlp.counters.neval_cons -= 1  # does not really count as a constraint eval
  return (rows, cols, vals)
end

function NLPModels.jprod!(nlp :: CUTEstModel, x :: Vector{Float64}, v :: Vector{Float64}, jv :: Vector{Float64})
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  got_j = 0
  jtrans = 0
  io_err = Cint[0]
  ccall(dlsym(cutest_lib, :cutest_cjprod_), Nothing,
              (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}, Ptr{Float64}, Ref{Int32}),
               io_err,     nvar,       ncon,       got_j,      jtrans,    x,            v,             nvar,      jv,            ncon)
  @cutest_error
  nlp.counters.neval_jprod += 1
  return jv
end

function NLPModels.jprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jv :: Vector{Float64})
  jprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), jv)
end

function NLPModels.jprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jv :: AbstractVector)
  jvc = zeros(nlp.meta.ncon)
  jprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), jvc)
  jv[1 : nlp.meta.ncon] .= jvc
end

function NLPModels.jtprod!(nlp :: CUTEstModel, x :: Vector{Float64}, v :: Vector{Float64}, jtv :: Vector{Float64})
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  got_j = 0
  jtrans = 1
  io_err = Cint[0]
  ccall(dlsym(cutest_lib, :cutest_cjprod_), Nothing,
              (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}, Ptr{Float64}, Ref{Int32}),
               io_err,     nvar,       ncon,       got_j,      jtrans,    x,            v,             ncon,      jtv,           nvar)
  @cutest_error
  nlp.counters.neval_jtprod += 1
  return jtv
end

function NLPModels.jtprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jtv :: Vector{Float64})
  jtprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), jtv)
end

function NLPModels.jtprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jtv :: AbstractVector)
  jtvc = zeros(nlp.meta.nvar)
  jtprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), jtvc)
  jtv[1 : nlp.meta.nvar] .= jtvc
end

function NLPModels.hess_structure!(nlp :: CUTEstModel, rows :: Vector{Int32}, cols :: Vector{Int32})
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  nnzh = nlp.meta.nnzh
  io_err = Cint[0]
  this_nnzh = Cint[0]

  if ncon > 0
    ccall(dlsym(cutest_lib, :cutest_cshp_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
                io_err, nvar, this_nnzh, nnzh, cols, rows)
    @cutest_error
  else
    ccall(dlsym(cutest_lib, :cutest_ushp_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
                io_err, nvar, this_nnzh, nnzh, cols, rows)
    @cutest_error
  end

  nlp.hrows .= rows
  nlp.hcols .= cols

  return rows, cols
end

function NLPModels.hess_structure!(nlp :: CUTEstModel)
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  nnzh = nlp.meta.nnzh
  io_err = Cint[0]
  this_nnzh = Cint[0]

  if ncon > 0
    ccall(dlsym(cutest_lib, :cutest_cshp_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
                io_err, nvar, this_nnzh, nnzh, nlp.hcols, nlp.hrows)
    @cutest_error
  else
    ccall(dlsym(cutest_lib, :cutest_ushp_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Int32}),
                io_err, nvar, this_nnzh, nnzh, nlp.hcols, nlp.hrows)
    @cutest_error
  end

  return nlp
end

function NLPModels.hess_structure!(nlp :: CUTEstModel, rows :: AbstractVector{<:Integer}, cols :: AbstractVector{<:Integer})
  hrows = Vector{Int32}(undef, nlp.meta.nnzh)
  hcols = Vector{Int32}(undef, nlp.meta.nnzh)
  hess_structure!(nlp, hrows, hcols)
  rows[1 : nlp.meta.nnzh] .= hrows
  cols[1 : nlp.meta.nnzh] .= hcols
  return rows, cols
end

function NLPModels.hess_coord!(nlp :: CUTEstModel, x :: Vector{Float64}, rows :: Vector{Int32}, cols :: Vector{Int32}, vals :: Vector{Float64}; y :: Vector{Float64}=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  nnzh = nlp.meta.nnzh
  io_err = Cint[0]
  this_nnzh = Cint[0]

  if obj_weight == 0.0 && ncon > 0
    ccall(dlsym(cutest_lib, :cutest_cshc_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,     nvar,       ncon,       x,            y,            this_nnzh,  nnzh,       vals,         nlp.hcols,  nlp.hrows)
    @cutest_error
    nlp.counters.neval_hess += 1
    return (cols, rows, vals)
  end

  if ncon > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    obj_weight != 1.0 && (y /= obj_weight)

    ccall(dlsym(cutest_lib, :cutest_csh_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,     nvar,       ncon,       x,            y,            this_nnzh,  nnzh,       vals,         nlp.hcols,  nlp.hrows)
  else
    ccall(dlsym(cutest_lib, :cutest_ush_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,     nvar,       x,            this_nnzh,  nnzh,       vals,         nlp.hcols,  nlp.hrows)
  end
  @cutest_error

  obj_weight != 1.0 && (vals[:] *= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
  nlp.counters.neval_hess += 1
  return (rows, cols, vals)
end

function NLPModels.hess_coord!(nlp :: CUTEstModel, x :: AbstractVector, rows :: AbstractVector{<: Integer}, cols :: AbstractVector{<: Integer}, vals :: AbstractVector; y :: AbstractVector=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  vals_ = Vector{Float64}(undef, nlp.meta.nnzh)
  NLPModels.hess_coord!(nlp, convert(Vector{Float64}, x), convert(Vector{Int32}, rows), convert(Vector{Int32}, cols), vals_, y=convert(Vector{Float64}, y), obj_weight=obj_weight)
  vals[1 : nlp.meta.nnzh] .= vals_
  return rows, cols, vals
end

function NLPModels.hprod!(nlp :: CUTEstModel, x :: Vector{Float64}, v :: Vector{Float64}, hv :: Vector{Float64}; y :: Vector{Float64}=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  io_err = Cint[0]
  goth = Cint[0]
  if obj_weight == 0.0 && ncon > 0
    ccall(dlsym(cutest_lib, :cutest_chcprod_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,     nvar,       ncon,       goth,       x,            y,            v,            hv)
    @cutest_error
    nlp.counters.neval_hprod += 1
    return hv
  end

  if ncon > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    obj_weight != 1.0 && (y /= obj_weight)

    ccall(dlsym(cutest_lib, :cutest_chprod_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,     nvar,       ncon,       goth,       x,            y,            v,            hv)
  else
    ccall(dlsym(cutest_lib, :cutest_uhprod_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,     nvar,       goth,       x,            v,            hv)
  end
  @cutest_error

  obj_weight != 1.0 && (hv[:] *= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
  nlp.counters.neval_hprod += 1
  return hv
end

function NLPModels.hprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, hv :: Vector{Float64}; y :: AbstractVector=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  hprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), hv, y=Vector{Float64}(y), obj_weight=obj_weight)
end

function NLPModels.hprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, hv :: AbstractVector; y :: AbstractVector=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  hvc = zeros(nlp.meta.nvar)
  hprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), hvc, y=Vector{Float64}(y), obj_weight=obj_weight)
  hv[1 : nlp.meta.nvar] .= hvc
end
