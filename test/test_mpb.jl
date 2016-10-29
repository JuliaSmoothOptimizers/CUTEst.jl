using Ipopt
using MathProgBase
using NLPModels
using CUTEst

# pass a CUTEstModel to IPOPT
nlp = CUTEstModel("HS6")
show(nlp.meta)
print(nlp.meta)
model = NLPtoMPB(nlp, IpoptSolver())
@assert isa(model, Ipopt.IpoptMathProgModel)
MathProgBase.optimize!(model)
@assert MathProgBase.getobjval(model) ≈ 0.0
finalize(nlp)
