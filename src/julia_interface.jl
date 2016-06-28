export objcons, objgrad, obj, grad, grad!,
       cons_coord, cons, cons!,
       jac_coord, jac, jprod, jprod!, jtprod, jtprod!,
       hess_coord, hess, hprod, hprod!

import NLPModels.obj
import NLPModels.grad
import NLPModels.grad!
import NLPModels.hess
import NLPModels.hprod
import NLPModels.hprod!
import NLPModels.cons
import NLPModels.cons!
import NLPModels.jac
import NLPModels.jprod
import NLPModels.jprod!
import NLPModels.jtprod
import NLPModels.jtprod!

"""    objcons(nlp, x)

Computes the objective function and constraint vector values at x.
Usage:

    f, c = objcons(nlp, x) # If the problem is constrained
    f = objcons(nlp, x)    # If the problem is unconstrained

  - nlp: [IN] CUTEstModel
  - x:   [IN] Array{Float64, 1}
  - f:   [OUT] Float64
  - c:   [OUT] Array{Float64, 1}
"""
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
  else
    ccall(dlsym(cutest_lib, :cutest_ufn_), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}),
                 io_err,  &nvar,    x,         f);
  end
  @cutest_error

  return ncon > 0 ? (f[1], c) : f[1];
end

"""    objgrad(nlp, x, grad)

Computes the objective function value and, if grad is `true`, gradient at x.
Usage:

    f, g = objgrad(nlp, x, true)
    f = objgrad(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - grad: [IN] Bool
  - f:    [OUT] Float64
  - g:    [OUT] Array{Float64, 1}
"""
function objgrad(nlp :: CUTEstModel, x :: Array{Float64,1}, grad :: Bool)
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
  @cutest_error

  return grad ? (f[1], g) : f[1];
end

"""    obj(nlp, x)

Computes the objective function value at x.
Usage:

    f = obj(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - f:    [OUT] Float64
"""
obj(nlp :: CUTEstModel, x :: Array{Float64,1}) = objgrad(nlp, x, false);

"""    grad(nlp, x)

Computes the objective gradient at x.
Usage:

    g = grad(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - g:    [OUT] Array{Float64, 1}
"""
function grad(nlp :: CUTEstModel, x :: Array{Float64,1})
  f, g = objgrad(nlp, x, true)
  return g
end

"""    grad!(nlp, x, g)

Computes the objective function gradient at x in place.
Usage:

    grad!(nlp, x, g)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - g:    [OUT] Array{Float64, 1}
"""
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

  return g
end

"""    cons_coord(nlp, x, jac)

Computes the constraint vector and, if jac is `true`, the Jacobian in
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

  return jac ? (c, jrow, jcol, jval) : c;
end

"""    cons(nlp, x, jac)

Computes the constraint vector and, if jac is `true`, the Jacobian using the
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

"""    cons(nlp, x)

Computes the constraint vector value.
Usage:

    c = cons(nlp, x)

  - nlp: [IN] CUTEstModel
  - x:   [IN] Array{Float64, 1}
  - c:   [OUT] Array{Float64, 1}
"""
cons(nlp :: CUTEstModel, x :: Array{Float64,1}) = cons_coord(nlp, x, false);

"""    cons!(nlp, x, c)

Computes the constraint vector value in place.
Usage:

    c = cons!(nlp, x, c)

  - nlp: [IN] CUTEstModel
  - x:   [IN] Array{Float64, 1}
  - c:   [OUT] Array{Float64, 1}
"""
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

  return c;
end

"""    jac_coord(nlp, x)

Computes the constraint Jacobian in coordinate format.
Usage:

    jrow, jcol, jval = cons_coord(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - jrow: [OUT] Array{Int32, 1}
  - jcol: [OUT] Array{Int32, 1}
  - jval: [OUT] Array{Float64, 1}
"""
function jac_coord(nlp :: CUTEstModel, x :: Array{Float64,1})
  c, jrow, jcol, jval = cons_coord(nlp, x, true)
  return (jrow, jcol, jval)
end

"""    jac(nlp, x)

Computes the constraint Jacobian using the internal sparse format.
Usage:

    J = jac (nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - J:    [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64,Int32}
"""
function jac(nlp :: CUTEstModel, x :: Array{Float64,1})
  c, J = cons(nlp, x, true)
  return J
end

"""    jprod(nlp, x, v)

Computes the product of the constraint Jacobian with a vector.
Usage:

    jv = jprod(nlp, x, v)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - v:    [IN] Array{Float64, 1}
  - jv:   [OUT] Array{Float64, 1}
"""
function jprod(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1})
  jv = zeros(nlp.meta.ncon)
  jprod!(nlp, x, v, jv)
end

"""    jprod!(nlp, x, v, jv)

Computes the product of the constraint Jacobian with a vector.
Usage:

    jprod!(nlp, x, v, jv)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - v:    [IN] Array{Float64, 1}
  - jv:   [OUT] Array{Float64, 1}
"""
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
  return jv
end

"""    jtprod(nlp, x, v)

Computes the product of the transposed constraint Jacobian with a vector.
Usage:

    jtv = jtprod(nlp, x, v)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - v:    [IN] Array{Float64, 1}
  - jtv:  [OUT] Array{Float64, 1}
"""
function jtprod(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1})
  jtv = zeros(nlp.meta.nvar)
  jtprod!(nlp, x, v, jtv)
end

"""    jtprod!(nlp, x, v, jv)

Computes the product of the transposed constraint Jacobian with a vector.
Usage:

    jtprod!(nlp, x, v, jv)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - v:    [IN] Array{Float64, 1}
  - jtv:  [OUT] Array{Float64, 1}
"""
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
  return jtv
end

"""    hess_coord(nlp, x, y)

Computes the Hessian matrix in coordinate format of the Lagrangian function at
x with Lagrange multipliers y for a constrained problem, or the
objective function at x for an unconstrained problem.
Usage:

    hrow, hcol, hval = hess_coord(nlp, x, y)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - y:    [IN] Array{Float64, 1}
  - hrow: [OUT] Array{Int32, 1}
  - hcol: [OUT] Array{Int32, 1}
  - hval: [OUT] Array{Float64, 1}
"""
function hess_coord(nlp :: CUTEstModel, x :: Array{Float64,1}, y :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzh = nlp.meta.nnzh;
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

"""    hess_coord(nlp, x)

Computes the Hessian of the objective function at x in coordinate format.
Usage:

    hrow, hcol, hval = hess_coord(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - hrow: [OUT] Array{Int32, 1}
  - hcol: [OUT] Array{Int32, 1}
  - hval: [OUT] Array{Float64, 1}
"""
function hess_coord(nlp :: CUTEstModel, x :: Array{Float64,1})
  hess_coord(nlp, x, zeros(nlp.meta.ncon))
end

"""    hess(nlp, x, y)

Computes the Hessian of the Lagrangian function at x with Lagrange
multipliers y for a constrained problem or the Hessian of the objective
function at x for an unconstrained problem.
Usage:

    H = hess(nlp, x, y)

  - nlp: [IN] CUTEstModel
  - x:   [IN] Array{Float64, 1}
  - y:   [IN] Array{Float64, 1}
  - H:   [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64, Int64}
"""
function hess(nlp :: CUTEstModel, x :: Array{Float64,1}, y :: Array{Float64,1})
  (hrow, hcol, hval) = hess_coord(nlp, x, y);
  H = spzeros(nlp.meta.nvar, nlp.meta.nvar)
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

"""    hess(nlp, x)

Computes the Hessian of the objective function.
Usage:

    H = hess(nlp, x)

  - nlp: [IN] CUTEstModel
  - x:   [IN] Array{Float64, 1}
  - H:   [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64, Int64}
"""
function hess(nlp :: CUTEstModel, x :: Array{Float64,1})
  hess(nlp, x, zeros(nlp.meta.ncon))
end

"""    hprod(nlp, x, y, v)

Computes the matrix-vector product between the Hessian matrix and the vector v.
If the problem is constrained, the Hessian is of the Lagrangian function at
x with Lagrange multipliers y, otherwise the Hessian is of the objective
function at x.
Usage:

    Hv = hprod(nlp, x, y, v)

  - nlp: [IN] CUTEstModel
  - x:   [IN] Array{Float64, 1}
  - y:   [IN] Array{Float64, 1}
  - v:   [IN] Array{Float64, 1}
  - Hv:  [OUT] Array{Float64, 1}
"""
function hprod(nlp :: CUTEstModel, x :: Array{Float64,1}, y :: Array{Float64,1}, v :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
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

"""    hprod!(nlp, x, y, v, Hv)

Computes the matrix-vector product between the Hessian matrix and the vector
v and write the result to vector Hv.
If the problem is constrained, the Hessian is of the Lagrangian function at
x with Lagrange multipliers y, otherwise the Hessian is of the objective
function at x.
Usage:

    hprod!(nlp, x, y, v, Hv)

  - nlp: [IN] CUTEstModel
  - x:   [IN] Array{Float64, 1}
  - y:   [IN] Array{Float64, 1}
  - v:   [IN] Array{Float64, 1}
  - Hv:  [OUT] Array{Float64, 1}
"""
function hprod!(nlp :: CUTEstModel, x :: Array{Float64,1}, y :: Array{Float64,1}, v :: Array{Float64,1}, hv :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
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

"""    hprod(nlp, x, v)

Computes the matrix-vector product between the Hessian matrix of the objective
function at x and the vector v.
Usage:

    Hv = hprod(nlp, x, v)

  - nlp: [IN] CUTEstModel
  - x:   [IN] Array{Float64, 1}
  - v:   [IN] Array{Float64, 1}
  - Hv:  [OUT] Array{Float64, 1}
"""
hprod(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}) = hprod(nlp, x, zeros(nlp.meta.ncon), v)

"""    hprod!(nlp, x, v, Hv)

Computes the matrix-vector product between the Hessian matrix of the objective
function at x and the vector v and writes the result to vector Hv.
Usage:

    hprod!(nlp, x, v, Hv)

  - nlp: [IN] CUTEstModel
  - x:   [IN] Array{Float64, 1}
  - v:   [IN] Array{Float64, 1}
  - Hv:  [OUT] Array{Float64, 1}
"""
hprod!(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}, hv :: Array{Float64,1}) = hprod!(nlp, x, zeros(nlp.meta.ncon), v, hv)
