export cons_coord, consjac

using NLPModels, SparseArrays

@doc (@doc NLPModels.objcons)
function NLPModels.objcons(nlp :: CUTEstModel, x :: AbstractVector)
  c = Array{Float64}(undef, nlp.meta.ncon);
  objcons!(nlp, x, c)
end

@doc (@doc NLPModels.objcons!)
function NLPModels.objcons!(nlp :: CUTEstModel, x :: Array{Float64,1}, c :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  io_err = Cint[0];
  f = Cdouble[0];
  if ncon > 0
    ccall(dlsym(cutest_lib, :cutest_cfn_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  nvar,   ncon,   x,         f,         c);
    nlp.counters.neval_cons += 1
  else
    ccall(dlsym(cutest_lib, :cutest_ufn_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  nvar,    x,         f);
  end
  nlp.counters.neval_obj += 1
  @cutest_error

  return f[1], c
end

function NLPModels.objcons!(nlp :: CUTEstModel, x :: AbstractVector, c :: Array{Float64,1})
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

@doc (@doc NLPModels.objgrad)
function NLPModels.objgrad(nlp :: CUTEstModel, x :: AbstractVector)
  g = Array{Float64}(undef, nlp.meta.nvar);
  objgrad!(nlp, x, g)
end

@doc (@doc NLPModels.objgrad!)
function NLPModels.objgrad!(nlp :: CUTEstModel, x :: Array{Float64,1}, g :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  f = Cdouble[0];
  io_err = Cint[0];
  get_grad = 1;
  if ncon > 0
    ccall(dlsym(cutest_lib, "cutest_cofg_"), Nothing,
        (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}),
             io_err,       nvar,            x,            f,            g,   get_grad);
  else
    ccall(dlsym(cutest_lib, "cutest_uofg_"), Nothing,
        (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}),
             io_err,       nvar,            x,            f,            g,   get_grad);
  end
  nlp.counters.neval_obj += 1
  nlp.counters.neval_grad += 1
  @cutest_error

  return f[1], g
end

function NLPModels.objgrad!(nlp :: CUTEstModel, x :: AbstractVector, g :: Array{Float64,1})
  objgrad!(nlp, Vector{Float64}(x), g)
end

function NLPModels.objgrad!(nlp :: CUTEstModel, x :: AbstractVector, g :: AbstractVector)
  gc = zeros(nlp.meta.nvar)
  f, _ = objgrad!(nlp, Vector{Float64}(x), gc)
  g .= gc
  return f, g
end

@doc (@doc NLPModels.obj)
function NLPModels.obj(nlp :: CUTEstModel, x :: AbstractVector)
  f = objcons(nlp, x)[1]
  if nlp.meta.ncon > 0
    nlp.counters.neval_cons -= 1  # does not really count as a constraint eval
  end
  return f
end

@doc (@doc NLPModels.grad)
function NLPModels.grad(nlp :: CUTEstModel, x :: AbstractVector)
  g = Array{Float64}(undef, nlp.meta.nvar)
  return grad!(nlp, x, g)
end

@doc (@doc NLPModels.grad!)
function NLPModels.grad!(nlp :: CUTEstModel, x :: AbstractVector, g :: AbstractVector)
  objgrad!(nlp, x, g)
  nlp.counters.neval_obj -= 1  # does not really count as a objective eval
  return g
end

"""
    cons_coord(nlp, x)

Computes the constraint vector and the Jacobian in
coordinate format.
Usage:

    c, jrow, jcol, jval = cons_coord(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - c:    [OUT] Array{Float64, 1}
  - jrow: [OUT] Array{Int32, 1}
  - jcol: [OUT] Array{Int32, 1}
  - jval: [OUT] Array{Float64, 1}
"""
function cons_coord(nlp :: CUTEstModel, x :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzj = nlp.meta.nnzj;
  io_err = Cint[0];
  c = Array{Float64}(undef, ncon);
  jsize = nlp.meta.nnzj
  get_j = 1
  jval = Array{Float64}(undef, jsize);
  jrow = Array{Int32}(undef, jsize);
  jcol = Array{Int32}(undef, jsize);

  ccall(dlsym(cutest_lib, :cutest_ccfsg_), Nothing,
              (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ref{Int32}),
               io_err,     nvar,       ncon,       x,            c,            nnzj,       jsize,      jval,         jcol,       jrow,       get_j);
  @cutest_error
  nlp.counters.neval_cons += 1
  nlp.counters.neval_jac += 1
  return c, Int.(jrow), Int.(jcol), jval
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
  - x:    [IN] Array{Float64, 1}
  - c:    [OUT] Array{Float64, 1}
  - J:    [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64,Int32}
"""
function consjac(nlp :: CUTEstModel, x :: AbstractVector)
  c, jrow, jcol, jval = cons_coord(nlp, x);
  return c, sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
end

@doc (@doc NLPModels.cons)
function NLPModels.cons(nlp :: CUTEstModel, x :: AbstractVector)
  c = Array{Float64}(undef, nlp.meta.ncon)
  cons!(nlp, x, c)
end

@doc (@doc NLPModels.cons!)
function NLPModels.cons!(nlp :: CUTEstModel, x :: AbstractVector, c :: AbstractVector)
  objcons!(nlp, x, c)
  nlp.counters.neval_obj -= 1  # does not really count as a objective eval
  return c;
end

@doc (@doc NLPModels.jac_coord!)
function NLPModels.jac_coord(nlp :: CUTEstModel, x :: AbstractVector)
  c, jrow, jcol, jval = cons_coord(nlp, x)
  nlp.counters.neval_cons -= 1  # does not really count as a constraint eval
  return (jrow, jcol, jval)
end

@doc (@doc NLPModels.jac)
function NLPModels.jac(nlp :: CUTEstModel, x :: AbstractVector)
  c, J = consjac(nlp, x)
  nlp.counters.neval_cons -= 1  # does not really count as a constraint eval
  return J
end

@doc (@doc NLPModels.jprod)
function NLPModels.jprod(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector)
  jv = zeros(nlp.meta.ncon)
  jprod!(nlp, x, v, jv)
end

@doc (@doc NLPModels.jprod!)
function NLPModels.jprod!(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}, jv :: Array{Float64,1})
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  got_j = 0
  jtrans = 0
  io_err = Cint[0];
  ccall(dlsym(cutest_lib, :cutest_cjprod_), Nothing,
              (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}, Ptr{Float64}, Ref{Int32}),
               io_err,     nvar,       ncon,       got_j,      jtrans,    x,            v,             nvar,      jv,            ncon);
  @cutest_error
  nlp.counters.neval_jprod += 1
  return jv
end

function NLPModels.jprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jv :: Array{Float64,1})
  jprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), jv)
end

function NLPModels.jprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jv :: AbstractVector)
  jvc = zeros(nlp.meta.ncon)
  jprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), jvc)
  jv .= jvc
end

@doc (@doc NLPModels.jtprod)
function NLPModels.jtprod(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector)
  jtv = zeros(nlp.meta.nvar)
  jtprod!(nlp, x, v, jtv)
end

@doc (@doc NLPModels.jtprod!)
function NLPModels.jtprod!(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}, jtv :: Array{Float64,1})
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  got_j = 0
  jtrans = 1
  io_err = Cint[0];
  ccall(dlsym(cutest_lib, :cutest_cjprod_), Nothing,
              (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ref{Int32}, Ptr{Float64}, Ref{Int32}),
               io_err,     nvar,       ncon,       got_j,      jtrans,    x,            v,             ncon,      jtv,           nvar);
  @cutest_error
  nlp.counters.neval_jtprod += 1
  return jtv
end

function NLPModels.jtprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jtv :: Array{Float64,1})
  jtprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), jtv)
end

function NLPModels.jtprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jtv :: AbstractVector)
  jtvc = zeros(nlp.meta.nvar)
  jtprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), jtvc)
  jtv .= jtvc
end

@doc (@doc NLPModels.hess_coord)
function NLPModels.hess_coord(nlp :: CUTEstModel, x :: Array{Float64,1}; y :: Array{Float64,1}=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzh = nlp.meta.nnzh;
  io_err = Cint[0];
  hval = Array{Float64}(undef, nnzh);
  hrow = Array{Int32}(undef, nnzh);
  hcol = Array{Int32}(undef, nnzh);
  this_nnzh = Cint[0];

  if obj_weight == 0.0 && ncon > 0
    ccall(dlsym(cutest_lib, :cutest_cshc_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,     nvar,       ncon,      x,            y,            this_nnzh,   nnzh,      hval,         hrow,       hcol);
    @cutest_error
    nlp.counters.neval_hess += 1
    return (Int.(hcol), Int.(hrow), hval)
  end

  if ncon > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    obj_weight != 1.0 && (y /= obj_weight)

    ccall(dlsym(cutest_lib, :cutest_csh_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,     nvar,       ncon,       x,            y,            this_nnzh,  nnzh,       hval,         hrow,       hcol);
  else
    ccall(dlsym(cutest_lib, :cutest_ush_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Int32}, Ref{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,     nvar,       x,            this_nnzh,  nnzh,       hval,         hrow,       hcol);
  end
  @cutest_error

  obj_weight != 1.0 && (hval[:] *= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
  nlp.counters.neval_hess += 1
  return (Int.(hcol), Int.(hrow), hval);  # swap rows and column
end

function NLPModels.hess_coord(nlp :: CUTEstModel, x :: AbstractVector; y :: AbstractVector=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  hess_coord(nlp, Vector{Float64}(x), y=Vector{Float64}(y), obj_weight=obj_weight)
end

@doc (@doc NLPModels.hess)
function NLPModels.hess(nlp :: CUTEstModel, x :: AbstractVector; y :: AbstractVector = zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  (hrow, hcol, hval) = hess_coord(nlp, x, y=y, obj_weight=obj_weight)
  return sparse(hrow, hcol, hval, nlp.meta.nvar, nlp.meta.nvar)
end

@doc (@doc NLPModels.hprod)
function NLPModels.hprod(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector; y :: AbstractVector = zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  hv = Array{Float64}(undef, nlp.meta.nvar);
  return hprod!(nlp, x, v, hv, y=y, obj_weight=obj_weight)
end

@doc (@doc NLPModels.hprod!)
function NLPModels.hprod!(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}, hv :: Array{Float64,1}; y :: Array{Float64,1}=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  io_err = Cint[0];
  goth = Cint[0];

  if obj_weight == 0.0 && ncon > 0
    ccall(dlsym(cutest_lib, :cutest_chcprod_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,     nvar,       ncon,       goth,       x,            y,            v,            hv);
    @cutest_error
    nlp.counters.neval_hprod += 1
    return hv
  end

  if ncon > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    obj_weight != 1.0 && (y /= obj_weight)

    ccall(dlsym(cutest_lib, :cutest_chprod_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,     nvar,       ncon,       goth,       x,            y,            v,            hv);
  else
    ccall(dlsym(cutest_lib, :cutest_uhprod_), Nothing,
                (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,     nvar,       goth,       x,            v,            hv);
  end
  @cutest_error

  obj_weight != 1.0 && (hv[:] *= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
  nlp.counters.neval_hprod += 1
  return hv
end

function NLPModels.hprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, hv :: Array{Float64,1}; y :: AbstractVector=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  hprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), hv, y=Vector{Float64}(y), obj_weight=obj_weight)
end

function NLPModels.hprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, hv :: AbstractVector; y :: AbstractVector=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  hvc = zeros(nlp.meta.nvar)
  hprod!(nlp, Vector{Float64}(x), Vector{Float64}(v), hvc, y=Vector{Float64}(y), obj_weight=obj_weight)
  hv .= hvc
end
