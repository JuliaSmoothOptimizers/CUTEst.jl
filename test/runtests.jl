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
dict_precision = Dict(Float32 => :single, Float64 => :double, Float128 => :quadruple)

# test sifdecoder
for pb in problems
  println("--- sifdecoder -- $pb ---")
  for precision in (:single, :double, :quadruple)
    print("$precision ")
    sifdecoder(pb, precision = precision)
    println("✓")
  end
  println()
end

# test build_libsif
for pb in problems
  println("--- build_libsif -- $pb ---")
  for precision in (:single, :double, :quadruple)
    (precision == :quadruple) && (Sys.ARCH == :aarch64) && Sys.islinux() && continue
    print("$precision ")
    build_libsif(pb, precision = precision)
    println("✓")
  end
  println()
end

for pb in problems
  println("--- build_libsif -- $pb --- standalone")
  for precision in (:single, :double, :quadruple)
    (precision == :quadruple) && (Sys.ARCH == :aarch64) && Sys.islinux() && continue
    print("$precision ")
    sifdecoder(pb, precision = precision)
    build_libsif(pb, precision = precision, standalone = true)
    println("✓")
  end
  println()
end

for precision in (:single, :double, :quadruple)
  (precision == :quadruple) && (Sys.ARCH == :aarch64) && Sys.islinux() && continue
  @testset "Multiple instances of CUTEstModel -- $precision precision" begin
    nlps = [CUTEstModel(problem, precision = precision) for problem in problems]
    for nlp in nlps
      finalize(nlp)
    end
  end
end

include("test_core.jl")
include("test_julia.jl")
include("coverage.jl")
include("multiple_precision.jl")
include("test_allocations.jl")
include("test_counters.jl")

for problem in problems
  for T in (Float32, Float64, Float128)
    (T == Float128) && (Sys.ARCH == :aarch64) && Sys.islinux() && continue
    println("Testing interfaces on problem $problem in $(dict_precision[T]) precision")
    nlp = CUTEstModel{T}(problem)
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
# include("test_select.jl")

problems = select_sif_problems(max_var = 2, max_con = 2)
problems = randsubseq(problems, 0.1)

for p in problems
  for T in (Float32, Float64, Float128)
    (T == Float128) && (Sys.ARCH == :aarch64) && Sys.islinux() && continue
    nlp = CUTEstModel{T}(p)
    x0 = nlp.meta.x0
    nvar, ncon = nlp.meta.nvar, nlp.meta.ncon
    println("$p: julia interface: f(x₀) = $(obj(nlp, x0))")

    fval = Ref{T}()
    if ncon > 0
      cx = zeros(T, ncon)
      CUTEst.cfn(T, nlp.libsif, nlp.status, nlp.nvar, nlp.ncon, x0, fval, cx)
    else
      CUTEst.ufn(T, nlp.libsif, nlp.status, nlp.nvar, x0, fval)
    end
    println("$p: core interface: f(x₀) = $(fval[])")
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
  for T in (Float32, Float64, Float128)
    (T == Float128) && (Sys.ARCH == :aarch64) && Sys.islinux() && continue
    # Decoding
    for p in problems
      nlp = CUTEstModel{T}(p)
      finalize(nlp)
    end
    # No decode
    for p in problems
      nlp = CUTEstModel{T}(p, decode = false)
      @test nlp.meta.nvar == 2
      finalize(nlp)
    end
  end
end

@testset "set_mastsif / list_sif_problems" begin
  for (set, nsif) in [("sifcollection", 1539), ("maros-meszaros", 138), ("netlib-lp", 114)]
    set_mastsif(set)
    sif_problems = list_sif_problems()
    @test length(sif_problems) == nsif
  end
end

clear_libsif()
