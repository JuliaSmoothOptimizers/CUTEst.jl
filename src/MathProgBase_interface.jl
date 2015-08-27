module MathProgBaseInterface

using CUTEst
import MathProgBase
import MathProgBase.SolverInterface

type CUTEstNLPEvaluator <: SolverInterface.AbstractNLPEvaluator
  nlp::CUTEstModel
end

# What is this?
MathProgBase.initialize(::CUTEstNLPEvaluator, request_features) = nothing
MathProgBase.features_available(::CUTEstNLPEvaluator) = [:Grad, :Jac, :HessVec,
    :Hess]

MathProgBase.eval_f(d::CUTEstNLPEvaluator, x) = obj(d.nlp, x)

MathProgBase.eval_g(d::CUTEstNLPEvaluator, g, x) = copy!(g, cons(d.nlp, x))

function MathProgBase.eval_grad_f(d::CUTEstNLPEvaluator, g, x)
  f, gx = objgrad(d.nlp, x, true)
  copy!(g, gx)
end

function MathProgBase.jac_structure(d::CUTEstNLPEvaluator)
  c, rows, cols, vals = cons_coord(d.nlp, d.nlp.meta.x0, true)
  return rows, cols
end

function MathProgBase.hesslag_structure(d::CUTEstNLPEvaluator)
  rows, cols, vals = hess_coord(d.nlp, d.nlp.meta.x0, ones(d.nlp.meta.ncon))
  return rows, cols
end

function MathProgBase.eval_jac_g(d::CUTEstNLPEvaluator, J, x)
  c, rows, cols, vals = cons_coord(d.nlp, x, true)
  copy!(J, vals)
end

function MathProgBase.eval_hesslag_prod(d::CUTEstNLPEvaluator, h, x, v, σ, μ)
  if abs(σ) < 1e-12
    error("CUTEst.jl does not handle zero scalar weight")
  end
  y = μ/σ
  result = σ*hprod(d.nlp, x, y, v)
  copy!(h, result)
end

function MathProgBase.eval_hesslag(d::CUTEstNLPEvaluator, H, x, σ, μ)
  if abs(σ) < 1e-12
    error("CUTEst.jl does not handle zero scalar weight")
  end
  y = μ/σ
  (hrow, hcol, hval) = hess_coord(d.nlp, x, y)
  return hval*σ
end

MathProgBase.isconstrlinear(d::CUTEstNLPEvaluator, i::Int) = (i in d.nlp.meta.lin)

function load_cutest_problem!(m::MathProgBase.AbstractMathProgModel,
    nlp::CUTEstModel)
  MathProgBase.loadnonlinearproblem!(m, nlp.meta.nvar, nlp.meta.ncon,
      nlp.meta.lvar, nlp.meta.uvar, nlp.meta.lcon, nlp.meta.ucon, :Min,
      CUTEstNLPEvaluator(nlp))
end

end # module
