export objcons, objgrad, obj, grad, grad!,
       cons_coord, cons, cons!,
       jac_coord, jac, jprod, jprod!, jtprod, jtprod!,
       hess_coord, hess, hess_op, hprod, hprod!

importall NLPModels

@doc (@doc NLPModels.objcons)
function objcons(nlp :: CUTEstModel, x :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  io_err = Cint[0];
  f = Cdouble[0];
  c = Array(Float64, ncon);
  if ncon > 0
    ccall(dlsym(cutest_lib, :cutest_cfn_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,   &ncon,   x,         f,         c);
    nlp.counters.neval_cons += 1
  else
    ccall(dlsym(cutest_lib, :cutest_ufn_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,    x,         f);
  end
  nlp.counters.neval_obj += 1
  @cutest_error

  return f[1], c
end

@doc (@doc NLPModels.objcons!)
function objcons!(nlp :: CUTEstModel, x :: Array{Float64,1}, c :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  io_err = Cint[0];
  f = Cdouble[0];
  if ncon > 0
    ccall(dlsym(cutest_lib, :cutest_cfn_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,   &ncon,   x,         f,         c);
    nlp.counters.neval_cons += 1
  else
    ccall(dlsym(cutest_lib, :cutest_ufn_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,    x,         f);
  end
  nlp.counters.neval_obj += 1
  @cutest_error

  return f[1], c
end

@doc (@doc NLPModels.objgrad)
function objgrad(nlp :: CUTEstModel, x :: Array{Float64,1}, grad :: Bool = true)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  f = Cdouble[0];
  io_err = Cint[0];
  if grad
    g = Array(Float64, nvar);
    get_grad = 1;
  else
    g = Array(Float64, 0);
    get_grad = 0;
  end
  if ncon > 0
    ccall(dlsym(cutest_lib, "cutest_cofg_"), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
             io_err,      &nvar,            x,            f,            g,  &get_grad);
  else
    ccall(dlsym(cutest_lib, "cutest_uofg_"), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
             io_err,      &nvar,            x,            f,            g,  &get_grad);
  end
  nlp.counters.neval_obj += 1
  grad && (nlp.counters.neval_grad += 1)
  @cutest_error

  return grad ? (f[1], g) : f[1];
end

@doc (@doc NLPModels.objgrad!)
function objgrad!(nlp :: CUTEstModel, x :: Array{Float64,1}, g :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  f = Cdouble[0];
  io_err = Cint[0];
  get_grad = 1;
  if ncon > 0
    ccall(dlsym(cutest_lib, "cutest_cofg_"), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
             io_err,      &nvar,            x,            f,            g,  &get_grad);
  else
    ccall(dlsym(cutest_lib, "cutest_uofg_"), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
             io_err,      &nvar,            x,            f,            g,  &get_grad);
  end
  nlp.counters.neval_obj += 1
  nlp.counters.neval_grad += 1
  @cutest_error

  return f[1], g
end

@doc (@doc NLPModels.obj)
obj(nlp :: CUTEstModel, x :: Array{Float64,1}) = objgrad(nlp, x, false);

@doc (@doc NLPModels.grad)
function grad(nlp :: CUTEstModel, x :: Array{Float64,1})
  g = Array(Float64, nlp.meta.nvar)
  return grad!(nlp, x, g)
end

@doc (@doc NLPModels.grad!)
function grad!(nlp :: CUTEstModel, x :: Array{Float64,1}, g :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  f = Cdouble[0];
  io_err = Cint[0];
  get_grad = 1;
  if ncon > 0
    ccall(dlsym(cutest_lib, "cutest_cofg_"), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
             io_err,      &nvar,            x,            f,            g,  &get_grad);
  else
    ccall(dlsym(cutest_lib, "cutest_uofg_"), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
             io_err,      &nvar,            x,            f,            g,  &get_grad);
  end
  @cutest_error
  nlp.counters.neval_grad += 1
  return g
end

"""
    cons_coord(nlp, x, jac)

Computes the constraint vector and, if `jac` is `true`, the Jacobian in
coordinate format.
Usage:

    c, jrow, jcol, jval = cons_coord(nlp, x, true)
    c = cons_coord(nlp, x, false)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - jac:  [IN] Bool
  - c:    [OUT] Array{Float64, 1}
  - jrow: [OUT] Array{Int32, 1}
  - jcol: [OUT] Array{Int32, 1}
  - jval: [OUT] Array{Float64, 1}
"""
function cons_coord(nlp :: CUTEstModel, x :: Array{Float64,1}, jac :: Bool)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzj = nlp.meta.nnzj;
  io_err = Cint[0];
  c = Array(Float64, ncon);
  jsize = jac ? nlp.meta.nnzj : 0;
  get_j = jac ? 1 : 0;
  jval = Array(Float64, jsize);
  jrow = Array(Int32, jsize);
  jcol = Array(Int32, jsize);

  ccall(dlsym(cutest_lib, :cutest_ccfsg_), Void,
              (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
               io_err,  &nvar,   &ncon,   x,         c,         &nnzj,   &jsize,  jval,      jcol,    jrow,    &get_j);
  @cutest_error
  nlp.counters.neval_cons += 1
  jac && (nlp.counters.neval_jac += 1)
  return jac ? (c, jrow, jcol, jval) : c;
end

"""
    cons(nlp, x, jac)

Computes the constraint vector and, if `jac` is `true`, the Jacobian in
internal sparse format.
Usage:

    c, J = cons(nlp, x, true)
    c = cons(nlp, x, false)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - jac:  [IN] Bool
  - c:    [OUT] Array{Float64, 1}
  - J:    [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64,Int32}
"""
function cons(nlp :: CUTEstModel, x :: Array{Float64,1}, jac :: Bool)
  if jac
    (c, jrow, jcol, jval) = cons_coord(nlp, x, jac);
    return (c, sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar))
  else
    return cons_coord(nlp, x, jac);
  end
end

@doc (@doc NLPModels.cons)
cons(nlp :: CUTEstModel, x :: Array{Float64,1}) = cons_coord(nlp, x, false);

@doc (@doc NLPModels.cons!)
function cons!(nlp :: CUTEstModel, x :: Array{Float64,1}, c :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  ncon > 0 || return c
  io_err = Cint[0];
  nnzj = 0;
  jsize = 0;
  get_j = 0;
  jval = Array(Float64, jsize);
  jrow = Array(Int32, jsize);
  jcol = Array(Int32, jsize);

  ccall(dlsym(cutest_lib, :cutest_ccfsg_), Void,
              (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
               io_err,  &nvar,   &ncon,   x,         c,         &nnzj,   &jsize,  jval,      jcol,    jrow,    &get_j);
  @cutest_error
  nlp.counters.neval_cons += 1
  return c;
end

@doc (@doc NLPModels.jac_coord!)
function jac_coord(nlp :: CUTEstModel, x :: Array{Float64,1})
  c, jrow, jcol, jval = cons_coord(nlp, x, true)
  nlp.counters.neval_cons -= 1  # does not really count as a constraint eval
  return (jrow, jcol, jval)
end

@doc (@doc NLPModels.jac)
function jac(nlp :: CUTEstModel, x :: Array{Float64,1})
  c, J = cons(nlp, x, true)
  nlp.counters.neval_cons -= 1  # does not really count as a constraint eval
  return J
end

@doc (@doc NLPModels.jprod)
function jprod(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1})
  jv = zeros(nlp.meta.ncon)
  jprod!(nlp, x, v, jv)
end

@doc (@doc NLPModels.jprod!)
function jprod!(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}, jv :: Array{Float64,1})
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  got_j = 0
  jtrans = 0
  io_err = Cint[0];
  ccall(dlsym(cutest_lib, :cutest_cjprod_), Void,
              (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}),
               io_err,     &nvar,      &ncon,      &got_j,     &jtrans,    x,            v,            &nvar,      jv,           &ncon);
  @cutest_error
  nlp.counters.neval_jprod += 1
  return jv
end

@doc (@doc NLPModels.jtprod)
function jtprod(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1})
  jtv = zeros(nlp.meta.nvar)
  jtprod!(nlp, x, v, jtv)
end

@doc (@doc NLPModels.jtprod!)
function jtprod!(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}, jtv :: Array{Float64,1})
  nvar = nlp.meta.nvar
  ncon = nlp.meta.ncon
  got_j = 0
  jtrans = 1
  io_err = Cint[0];
  ccall(dlsym(cutest_lib, :cutest_cjprod_), Void,
              (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}),
               io_err,     &nvar,      &ncon,      &got_j,     &jtrans,    x,            v,            &ncon,      jtv,          &nvar);
  @cutest_error
  nlp.counters.neval_jtprod += 1
  return jtv
end

@doc (@doc NLPModels.hess_coord)
function hess_coord(nlp :: CUTEstModel, x :: Array{Float64,1}; y :: Array{Float64,1}=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzh = nlp.meta.nnzh;
  io_err = Cint[0];
  hval = Array(Float64, nnzh);
  hrow = Array(Int32, nnzh);
  hcol = Array(Int32, nnzh);
  this_nnzh = Cint[0];

  if obj_weight == 0.0 && ncon > 0
    ccall(dlsym(cutest_lib, :cutest_cshc_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,     &nvar,      &ncon,      x,            y,            this_nnzh,  &nnzh,      hval,         hrow,       hcol);
    @cutest_error
    nlp.counters.neval_hess += 1
    return (hcol, hrow, hval)
  end

  if ncon > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    obj_weight != 1.0 && (y /= obj_weight)

    ccall(dlsym(cutest_lib, :cutest_csh_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32},   Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,  &nvar,   &ncon,   x,         y,         this_nnzh, &nnzh,   hval,      hrow,    hcol);
  else
    ccall(dlsym(cutest_lib, :cutest_ush_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32},   Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,  &nvar,   x,         this_nnzh,   &nnzh, hval,      hrow,    hcol);
  end
  @cutest_error

  obj_weight != 1.0 && (hval[:] *= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
  nlp.counters.neval_hess += 1
  return (hcol, hrow, hval);  # swap rows and column
end

@doc (@doc NLPModels.hess)
function hess(nlp :: CUTEstModel, x :: Array{Float64,1}; y :: Array{Float64,1} = zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  (hrow, hcol, hval) = hess_coord(nlp, x, y=y, obj_weight=obj_weight)
  return sparse(hrow, hcol, hval, nlp.meta.nvar, nlp.meta.nvar)
end

@doc (@doc NLPModels.hprod)
function hprod(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}; y :: Array{Float64,1} = zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  hv = Array(Float64, nlp.meta.nvar);
  return hprod!(nlp, x, v, hv, y=y, obj_weight=obj_weight)
end

@doc (@doc NLPModels.hprod!)
function hprod!(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}, hv :: Array{Float64,1}; y :: Array{Float64,1}=zeros(nlp.meta.ncon), obj_weight :: Float64=1.0)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  io_err = Cint[0];
  goth = Cint[0];

  if obj_weight == 0.0 && ncon > 0
    ccall(dlsym(cutest_lib, :cutest_chcprod_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,     &nvar,      &ncon,      goth,       x,            y,            v,            hv);
    @cutest_error
    nlp.counters.neval_hprod += 1
    return hv
  end

  if ncon > 0
    # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
    obj_weight != 1.0 && (y /= obj_weight)

    ccall(dlsym(cutest_lib, :cutest_chprod_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,   &ncon,   goth,    x,         y,         v,         hv);
  else
    ccall(dlsym(cutest_lib, :cutest_uhprod_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,   goth,    x,         v,         hv);
  end
  @cutest_error

  obj_weight != 1.0 && (hv[:] *= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
  nlp.counters.neval_hprod += 1
  return hv
end
