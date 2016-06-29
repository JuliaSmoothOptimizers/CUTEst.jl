# An interface to pass a CUTEstModel to a MathProgBase solver
# Modeled after Miles Lubin's AmplMathProgInterface

import MathProgBase
import MathProgBase.SolverInterface

export NLPtoMPB


type CUTEstNLPEvaluator <: SolverInterface.AbstractNLPEvaluator
  nlp :: CUTEstModel
end

MathProgBase.initialize(::CUTEstNLPEvaluator, requested_features) = nothing
MathProgBase.features_available(::CUTEstNLPEvaluator) = [:Grad, :Jac, :JacVec, :HessVec, :Hess]

MathProgBase.eval_f(d::CUTEstNLPEvaluator, x) = obj(d.nlp, x)

MathProgBase.eval_g(d::CUTEstNLPEvaluator, g, x) = copy!(g, cons(d.nlp, x))

MathProgBase.eval_grad_f(d::CUTEstNLPEvaluator, g, x) = copy!(g, grad(d.nlp, x))

function MathProgBase.jac_structure(d::CUTEstNLPEvaluator)
  rows, cols, vals = jac_coord(d.nlp, d.nlp.meta.x0)
  return rows, cols
end

function MathProgBase.hesslag_structure(d::CUTEstNLPEvaluator)
  rows, cols, vals = hess_coord(d.nlp, d.nlp.meta.x0, y=ones(d.nlp.meta.ncon))
  return rows, cols
end

function MathProgBase.eval_jac_g(d::CUTEstNLPEvaluator, J, x)
  rows, cols, vals = jac_coord(d.nlp, x)
  copy!(J, vals)
end

function MathProgBase.eval_jac_prod(d::CUTEstNLPEvaluator, y, x, w)
  y = jprod(d.nlp, x, w)
end

function MathProgBase.eval_jac_prod_t(d::CUTEstNLPEvaluator, y, x, w)
  y = jtprod(d.nlp, x, w)
end

function MathProgBase.eval_hesslag_prod(d::CUTEstNLPEvaluator, h, x, v, σ, μ)
  result = hprod(d.nlp, x, v, μ, obj_weight=σ)
  copy!(h, result)
end

function MathProgBase.eval_hesslag(d::CUTEstNLPEvaluator, H, x, σ, μ)
  rows, cols, vals = hess_coord(d.nlp, x, y=μ, obj_weight=σ)
  copy!(H, vals)
end

MathProgBase.isobjlinear(d::CUTEstNLPEvaluator) = d.nlp.meta.nlo == 0

MathProgBase.isobjquadratic(d::CUTEstNLPEvaluator) = false

# MathProgBase.isconstrlinear(d::CUTEstNLPEvaluator, i) = i in d.nlp.meta.lin

function loadcutestproblem!(m::MathProgBase.AbstractMathProgModel, nlp::CUTEstModel)
  sense = nlp.meta.minimize ? :Min : :Max
  MathProgBase.loadproblem!(m, nlp.meta.nvar, nlp.meta.ncon, nlp.meta.lvar,
    nlp.meta.uvar, nlp.meta.lcon, nlp.meta.ucon, sense, CUTEstNLPEvaluator(nlp))
  MathProgBase.setwarmstart!(m, nlp.meta.x0)

  nnlvar = max(nlp.meta.nlvc, nlp.meta.nlvo)
  narcvar = nlp.meta.nwv
  nlinvar = nlp.meta.nvar - (nnlvar + narcvar + nlp.meta.nbv + nlp.meta.niv)
  nbinvar = nlp.meta.nbv
  nintvar = nlp.meta.niv

  v = fill(:Cont, nlp.meta.nvar)
  # First populate Table 4
  varidx = 1
  for i = 1:(nlp.meta.nlvb - nlp.meta.nlvbi)
    varidx += 1
  end
  for i = 1:nlp.meta.nlvbi
    v[varidx] = :Int
    varidx += 1
  end
  for i = 1:(nlp.meta.nlvc - (nlp.meta.nlvb + nlp.meta.nlvci))
    varidx += 1
  end
  for i = 1:nlp.meta.nlvci
    v[varidx] = :Int
    varidx += 1
  end
  for i = 1:(nlp.meta.nlvo - (nlp.meta.nlvc + nlp.meta.nlvoi))
    varidx += 1
  end
  for i = 1:nlp.meta.nlvoi
    v[varidx] = :Int
    varidx += 1
  end
  # Now populate Table 3
  varidx += narcvar + nlinvar
  for i = 1:nbinvar
    v[varidx] = :Bin
    varidx += 1
  end
  for i = 1:nintvar
    v[varidx] = :Int
    varidx += 1
  end
  @assert varidx == nlp.meta.nvar + 1
  # Set variable types
  if any(vtype -> vtype == :Int || vtype == :Bin, v)
      MathProgBase.setvartype!(m, v)
  end
end

"""Return a `MathProgBase` model corresponding to a `CUTEstModel`.
The second argument should be a solver instance, e.g., `IpoptSolver()`.
Currently, all models are treated as nonlinear models.
"""
function NLPtoMPB(nlp :: CUTEstModel, solver :: MathProgBase.AbstractMathProgSolver)
  model = MathProgBase.NonlinearModel(solver)
  loadcutestproblem!(model, nlp)
  return model
end
