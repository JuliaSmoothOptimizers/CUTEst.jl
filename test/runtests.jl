for problem in ["HS32", "HS4"]
  global problem
  include("$(lowercase(problem)).jl")
  include("build_test.jl")
  include("test_core.jl")
  include("test_specialized.jl")
  include("test_julia.jl")
  include("finalize_test.jl")
end

problems = readdir(get(ENV, "MASTSIF", "") )

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
    println("$p: specialized interface: f(x₀) = $(cfn(nlp, x0)[1])")
    println("$p: specialized interface: f(x₀) = $(cfn!(nlp, x0, cx)[1])")
  else
    println("$p: specialized interface: f(x₀) = $(ufn(nvar, x0))")
    println("$p: specialized interface: f(x₀) = $(ufn(nlp, x0))")
  end
  cutest_finalize(nlp)
end
