# An interface to pass a CUTEstModel to a MathProgBase solver
# Modeled after Miles Lubin's AmplMathProgInterface

import MathProgBase

MathProgBase.features_available(::NLPModelEvaluator{CUTEstModel}) =
  [:Grad, :Jac, :JacVec, :HessVec, :Hess]
