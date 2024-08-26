#stdlib
using LinearAlgebra, SparseArrays, Random, Test
# jso
using CUTEst, NLPModels, NLPModelsTest
# external
using Quadmath

set_mastsif()
@test ispath(ENV["MASTSIF"])
@test isfile(joinpath(ENV["MASTSIF"], "CYCLOOCT.SIF"))
problems = ["BROWNDEN", "HS5", "HS6", "HS10", "HS11", "HS13", "HS14"]

# test sifdecoder
for pb in problems
  println("--- $pb ---")
  for precision in (:single, :double, :quadruple)
    print("$precision ")
    sifdecoder(pb, precision = precision)
    println("✓")
  end
  println()
end

for T in (Float32, Float64, Float128)
  @testset "Multiple instances of CUTEstModel -- $T" begin
    nlps = [CUTEstModel{T}(problem) for problem in problems]
    for nlp in nlps
      finalize(nlp)
    end
  end
end

include("test_core.jl")
include("test_julia.jl")
include("coverage.jl")
include("multiple_precision.jl")

for problem in problems
  for (T, precision) in [(Float32, :single), (Float64, :double), (Float128, :quadruple)]
    println("Testing interfaces on problem $problem in $precision precision")
    nlp = CUTEstModel(problem, precision = precision)
    nlp_man = eval(Symbol(problem))(T)

    test_nlpinterface(nlp, nlp_man)
    test_coreinterface(nlp, nlp_man)
    test_coreinterface(nlp, nlp_man; test_view = true)
    coverage_increase(nlp)

    println("Finalizing")
    finalize(nlp)
  end
end

include("nlpmodelstest.jl")
# include("test_select.jl") # Tests are removed because any update to MASTSIF breaks it

problems = CUTEst.select(max_var = 2, max_con = 2)
problems = randsubseq(problems, 0.1)

for p in problems
  for (T, precision) in [(Float32, :single), (Float64, :double), (Float128, :quadruple)]
    nlp = CUTEstModel(p, precision = precision)
    x0 = nlp.meta.x0
    nvar, ncon = nlp.meta.nvar, nlp.meta.ncon

    println("$p: julia interface: f(x₀) = $(obj(nlp, x0))")

    status = Cint[0]
    fval = T[0.0]
    if ncon > 0
      cx = zeros(T, ncon)
      CUTEst.cfn(T, nlp.libsif, status, Cint[nvar], Cint[ncon], x0, fval, cx)
    else
      CUTEst.ufn(T, nlp.libsif, status, Cint[nvar], x0, fval)
    end
    println("$p: core interface: f(x₀) = $(fval[1])")

    finalize(nlp)
  end
end

# test arguments passed to decoder
nlp = CUTEstModel("DIXMAANJ", "-param", "M=5")
@assert nlp.meta.nvar == 15
finalize(nlp)

nlp = CUTEstModel("DIXMAANJ", "-param", "M=30")
@assert nlp.meta.nvar == 90
finalize(nlp)

@testset "Test decoding separately (issue #239)" begin
  problems = ["AKIVA", "ROSENBR", "ZANGWIL2"]
  for (T, precision) in [(Float32, :single), (Float64, :double), (Float128, :quadruple)]
    # Decoding
    for p in problems
      nlp = CUTEstModel(p, precision = precision)
      finalize(nlp)
    end
    # No decode
    for p in problems
      nlp = CUTEstModel(p, precision = precision, decode = false)
      @test nlp.meta.nvar == 2
      finalize(nlp)
    end
  end
end

# test set_mastsif
for set in ("sifcollection", "maros-meszaros", "netlib-lp")
  set_mastsif(set)
end
