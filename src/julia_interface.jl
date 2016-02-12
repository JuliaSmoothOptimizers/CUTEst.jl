export objcons, objgrad, obj, grad, grad!,
       cons_coord, cons, cons!, jac_coord, jac,
       hess_coord, hess, hprod, hprod!

"""    objcons(x)

Computes the objective function and constraint vector values at x.
Usage:

    f, c = objcons(x) # If the problem is constrained
    f = objcons(x)    # If the problem is unconstrained

  - x:   [IN] Array{Float64, 1}
  - f:   [OUT] Float64
  - c:   [OUT] Array{Float64, 1}
"""
function objcons(x :: Array{Float64,1})
  nvar = nlp.nvar;
  ncon = nlp.ncon;
  io_err = Cint[0];
  f = Cdouble[0];
  c = Array(Float64, ncon);
  if ncon > 0
    ccall(dlsym(cutest_lib, :cutest_cfn_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,   &ncon,   x,         f,         c);
  else
    ccall(dlsym(cutest_lib, :cutest_ufn_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,    x,         f);
  end
  @cutest_error

  return ncon > 0 ? (f[1], c) : f[1];
end

"""    objgrad(x, grad)

Computes the objective function value and, if grad is `true`, gradient at x.
Usage:

    f, g = objgrad(x, true)
    f = objgrad(x)

  - x:    [IN] Array{Float64, 1}
  - grad: [IN] Bool
  - f:    [OUT] Float64
  - g:    [OUT] Array{Float64, 1}
"""
function objgrad(x :: Array{Float64,1}, grad :: Bool)
  nvar = nlp.nvar;
  ncon = nlp.ncon;
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
  @cutest_error

  return grad ? (f[1], g) : f[1];
end

"""    obj(x)

Computes the objective function value at x.
Usage:

    f = obj(x)

  - x:    [IN] Array{Float64, 1}
  - f:    [OUT] Float64
"""
obj(x :: Array{Float64,1}) = objgrad(x, false);

"""    grad(x)

Computes the objective gradient at x.
Usage:

    g = grad(x)

  - x:    [IN] Array{Float64, 1}
  - g:    [OUT] Array{Float64, 1}
"""
function grad(x :: Array{Float64,1})
  f, g = objgrad(x, true)
  return g
end

"""    grad!(x, g)

Computes the objective function gradient at x in place.
Usage:

    grad!(x, g)

  - x:    [IN] Array{Float64, 1}
  - g:    [OUT] Array{Float64, 1}
"""
function grad!(x :: Array{Float64,1}, g :: Array{Float64,1})
  nvar = nlp.nvar;
  ncon = nlp.ncon;
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

  return g
end

"""    cons_coord(x, jac)

Computes the constraint vector and, if jac is `true`, the Jacobian in
coordinate format.
Usage:

    c, jrow, jcol, jval = cons_coord(x, true)
    c = cons_coord(x, false)

  - x:    [IN] Array{Float64, 1}
  - jac:  [IN] Bool
  - c:    [OUT] Array{Float64, 1}
  - jrow: [OUT] Array{Int32, 1}
  - jcol: [OUT] Array{Int32, 1}
  - jval: [OUT] Array{Float64, 1}
"""
function cons_coord(x :: Array{Float64,1}, jac :: Bool)
  nvar = nlp.nvar;
  ncon = nlp.ncon;
  nnzj = nlp.nnzj;
  io_err = Cint[0];
  c = Array(Float64, ncon);
  jsize = jac ? nlp.nnzj : 0;
  get_j = jac ? 1 : 0;
  jval = Array(Float64, jsize);
  jrow = Array(Int32, jsize);
  jcol = Array(Int32, jsize);

  ccall(dlsym(cutest_lib, :cutest_ccfsg_), Void,
              (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
               io_err,  &nvar,   &ncon,   x,         c,         &nnzj,   &jsize,  jval,      jcol,    jrow,    &get_j);
  @cutest_error

  return jac ? (c, jrow, jcol, jval) : c;
end

"""    cons(x, jac)

Computes the constraint vector and, if jac is `true`, the Jacobian using the
internal sparse format.
Usage:

    c, J = cons(x, true)
    c = cons(x, false)

  - x:    [IN] Array{Float64, 1}
  - jac:  [IN] Bool
  - c:    [OUT] Array{Float64, 1}
  - J:    [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64,Int32}
"""
function cons(x :: Array{Float64,1}, jac :: Bool)
  if jac
    (c, jrow, jcol, jval) = cons_coord(x, jac);
    return (c, sparse(jrow, jcol, jval, nlp.ncon, nlp.nvar))
  else
    return cons_coord(x, jac);
  end
end

"""    cons(x)

Computes the constraint vector value.
Usage:

    c = cons(x)

  - x:   [IN] Array{Float64, 1}
  - c:   [OUT] Array{Float64, 1}
"""
cons(x :: Array{Float64,1}) = cons_coord(x, false);

"""    cons!(x, c)

Computes the constraint vector value in place.
Usage:

    c = cons!(x, c)

  - x:   [IN] Array{Float64, 1}
  - c:   [OUT] Array{Float64, 1}
"""
function cons!(x :: Array{Float64,1}, c :: Array{Float64,1})
  nvar = nlp.nvar;
  ncon = nlp.ncon;
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

  return c;
end

"""    jac_coord(x)

Computes the constraint Jacobian in coordinate format.
Usage:

    jrow, jcol, jval = cons_coord(x)

  - x:    [IN] Array{Float64, 1}
  - jrow: [OUT] Array{Int32, 1}
  - jcol: [OUT] Array{Int32, 1}
  - jval: [OUT] Array{Float64, 1}
"""
function jac_coord(x :: Array{Float64,1})
  c, jrow, jcol, jval = cons_coord(x, true)
  return (jrow, jcol, jval)
end

"""    jac(x)

Computes the constraint Jacobian using the internal sparse format.
Usage:

    J = jac (x)

  - x:    [IN] Array{Float64, 1}
  - J:    [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64,Int32}
"""
function jac(x :: Array{Float64,1})
  c, J = cons(x, true)
  return J
end

"""    hess_coord(x, y)

Computes the Hessian matrix in coordinate format of the Lagrangian function at
x with Lagrange multipliers y for a constrained problem, or the
objective function at x for an unconstrained problem.
Usage:

    hrow, hcol, hval = hess_coord(x, y)

  - x:    [IN] Array{Float64, 1}
  - y:    [IN] Array{Float64, 1}
  - hrow: [OUT] Array{Int32, 1}
  - hcol: [OUT] Array{Int32, 1}
  - hval: [OUT] Array{Float64, 1}
"""
function hess_coord(x :: Array{Float64,1}, y :: Array{Float64,1})
  nvar = nlp.nvar;
  ncon = nlp.ncon;
  nnzh = nlp.nnzh;
  io_err = Cint[0];
  hval = Array(Float64, nnzh);
  hrow = Array(Int32, nnzh);
  hcol = Array(Int32, nnzh);
  this_nnzh = Cint[0];
  if ncon > 0
    ccall(dlsym(cutest_lib, :cutest_csh_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32},   Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,  &nvar,   &ncon,   x,         y,         this_nnzh, &nnzh,   hval,      hrow,    hcol);
  else
    ccall(dlsym(cutest_lib, :cutest_ush_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32},   Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 io_err,  &nvar,   x,         this_nnzh,   &nnzh, hval,      hrow,    hcol);
  end
  @cutest_error

  return (hrow, hcol, hval);
end

"""    hess_coord(x)

Computes the Hessian of the objective function at x in coordinate format.
Usage:

    hrow, hcol, hval = hess_coord(x)

  - x:    [IN] Array{Float64, 1}
  - hrow: [OUT] Array{Int32, 1}
  - hcol: [OUT] Array{Int32, 1}
  - hval: [OUT] Array{Float64, 1}
"""
function hess_coord(x :: Array{Float64,1})
  hess_coord(x, zeros(nlp.ncon))
end

"""    hess(x, y)

Computes the Hessian of the Lagrangian function at x with Lagrange
multipliers y for a constrained problem or the Hessian of the objective
function at x for an unconstrained problem.
Usage:

    H = hess(x, y)

  - x:   [IN] Array{Float64, 1}
  - y:   [IN] Array{Float64, 1}
  - H:   [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64, Int64}
"""
function hess(x :: Array{Float64,1}, y :: Array{Float64,1})
  (hrow, hcol, hval) = hess_coord(x, y);
  H = spzeros(nlp.nvar, nlp.nvar)
  for k = 1:length(hval)
    i = hrow[k]
    j = hcol[k]
    H[i,j] = hval[k]
    if i != j
      H[j,i] = hval[k]
    end
  end
  return H
end

"""    hess(x)

Computes the Hessian of the objective function.
Usage:

    H = hess(x)

  - x:   [IN] Array{Float64, 1}
  - H:   [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64, Int64}
"""
function hess(x :: Array{Float64,1})
  hess(x, zeros(nlp.ncon))
end

"""    hprod(x, y, v)

Computes the matrix-vector product between the Hessian matrix and the vector v.
If the problem is constrained, the Hessian is of the Lagrangian function at
x with Lagrange multipliers y, otherwise the Hessian is of the objective
function at x.
Usage:

    Hv = hprod(x, y, v)

  - x:   [IN] Array{Float64, 1}
  - y:   [IN] Array{Float64, 1}
  - v:   [IN] Array{Float64, 1}
  - Hv:  [OUT] Array{Float64, 1}
"""
function hprod(x :: Array{Float64,1}, y :: Array{Float64,1}, v :: Array{Float64,1})
  nvar = nlp.nvar;
  ncon = nlp.ncon;
  io_err = Cint[0];
  hv = Array(Float64, nvar);
  goth = Cint[0];
  if ncon > 0
    ccall(dlsym(cutest_lib, :cutest_chprod_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,   &ncon,   goth,    x,         y,         v,         hv);
  else
    ccall(dlsym(cutest_lib, :cutest_uhprod_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,   goth,    x,         v,         hv);
  end
  @cutest_error

  return hv;
end

"""    hprod!(x, y, v, Hv)

Computes the matrix-vector product between the Hessian matrix and the vector
v and write the result to vector Hv.
If the problem is constrained, the Hessian is of the Lagrangian function at
x with Lagrange multipliers y, otherwise the Hessian is of the objective
function at x.
Usage:

    hprod!(x, y, v, Hv)

  - x:   [IN] Array{Float64, 1}
  - y:   [IN] Array{Float64, 1}
  - v:   [IN] Array{Float64, 1}
  - Hv:  [OUT] Array{Float64, 1}
"""
function hprod!(x :: Array{Float64,1}, y :: Array{Float64,1}, v :: Array{Float64,1}, hv :: Array{Float64,1})
  nvar = nlp.nvar;
  ncon = nlp.ncon;
  io_err = Cint[0];
  goth = Cint[0];
  if ncon > 0
    ccall(dlsym(cutest_lib, :cutest_chprod_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,   &ncon,   goth,    x,         y,         v,         hv);
  else
    ccall(dlsym(cutest_lib, :cutest_uhprod_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,   goth,    x,         v,         hv);
  end
  @cutest_error

  return hv;
end

"""    hprod(x, v)

Computes the matrix-vector product between the Hessian matrix of the objective
function at x and the vector v.
Usage:

    Hv = hprod(x, v)

  - x:   [IN] Array{Float64, 1}
  - v:   [IN] Array{Float64, 1}
  - Hv:  [OUT] Array{Float64, 1}
"""
hprod(x :: Array{Float64,1}, v :: Array{Float64,1}) = hprod(x, zeros(nlp.ncon), v)

"""    hprod!(x, v, Hv)

Computes the matrix-vector product between the Hessian matrix of the objective
function at x and the vector v and writes the result to vector Hv.
Usage:

    hprod!(x, v, Hv)

  - x:   [IN] Array{Float64, 1}
  - v:   [IN] Array{Float64, 1}
  - Hv:  [OUT] Array{Float64, 1}
"""
hprod!(x :: Array{Float64,1}, v :: Array{Float64,1}, hv :: Array{Float64,1}) = hprod!(x, zeros(nlp.ncon), v, hv)
