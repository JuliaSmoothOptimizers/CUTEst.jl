using Base.Test, CUTEst, FactCheck, Ipopt, JuMP, MathProgBase, NLPModels

include("test_specialized_manual.jl")

problems = [:brownden, :hs5, :hs6, :hs10, :hs11, :hs14]
path = joinpath(Pkg.dir("NLPModels"), "test")

include("test_core.jl")
include("test_specialized.jl")
include("test_julia.jl")

for problem in problems
  println("Testing interfaces on problem $problem")
  problem_s = string(problem)
  include(joinpath(path, "$problem_s.jl"))
  nlp = CUTEstModel(uppercase(problem_s))
  adnlp = eval(parse("$(problem)_autodiff"))()

  test_nlpinterface(nlp, adnlp)
  test_specinterface(nlp, adnlp)
  test_coreinterface(nlp, adnlp)

  println("Finalizing")
  finalize(nlp)
end

include("consistency.jl")
include("test_mpb.jl")

problems = randsubseq(readdir(get(ENV, "MASTSIF", "") ), 0.01)

for p in problems
  if !contains(p, "SIF")
    continue
  end
  p = p[1:end-4]

  nlp = CUTEstModel(p)
  x0 = nlp.meta.x0
  nvar, ncon = nlp.meta.nvar, nlp.meta.ncon

  println("$p: julia interface: f(x₀) = $(obj(nlp, x0))")

  io_err = Cint[0]
  fval = [0.0]
  if ncon > 0
    cx = zeros(ncon)
    cfn(io_err, Cint[nvar], Cint[ncon], x0, fval, cx)
  else
    ufn(io_err, Cint[nvar], x0, fval)
  end
  println("$p: core interface: f(x₀) = $(fval[1])")

  if ncon > 0
    cx = zeros(ncon)
    println("$p: specialized interface: f(x₀) = $(cfn(nvar, ncon, x0)[1])")
    println("$p: specialized interface: f(x₀) = $(cfn!(nvar, ncon, x0, cx)[1])")
  else
    println("$p: specialized interface: f(x₀) = $(ufn(nvar, x0))")
  end
  finalize(nlp)
end

# test arguments passed to decoder
nlp = CUTEstModel("DIXMAANJ", "-param", "M=5")
@assert nlp.meta.nvar == 15
finalize(nlp)

nlp = CUTEstModel("DIXMAANJ", "-param", "M=30")
@assert nlp.meta.nvar == 90
finalize(nlp)

# clean up the test directory
here = dirname(@__FILE__)
so_files = filter(x -> (ismatch(r".so$", x) || ismatch(r".dylib$", x)), readdir(here))

for so_file in so_files
  rm(joinpath(here, so_file))
end

rm(joinpath(here, "AUTOMAT.d"))
rm(joinpath(here, "OUTSDIF.d"))

