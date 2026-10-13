# using CUTEst, NLPModelsTest, NLPModels, Quadmath

@testset "allocations -- $pb" for pb in ("BROWNDEN", "HS5", "HS6", "HS10", "HS11", "HS13", "HS14")
  @testset "precision -- $T" for T in (Float32, Float64, Float128)
    (T == Float128) && (Sys.ARCH == :aarch64) && Sys.islinux() && continue
    nlp = CUTEstModel{T}(pb)
    NLPModelsTest.test_zero_allocations(nlp; linear_api = true, exclude = [jac_op])
    # mems = NLPModelsTest.test_allocs_nlpmodels(nlp; linear_api=true, exclude=[jac_op])
    # display(mems)
    finalize(nlp)
  end
end

@testset "allocations of the conversion paths -- $pb" for pb in ("BROWNDEN", "HS6", "HS10", "HS14")
  nlp = CUTEstModel{Float64}(pb)
  nvar, ncon, nnzj, nnzh = nlp.meta.nvar, nlp.meta.ncon, nlp.meta.nnzj, nlp.meta.nnzh
  x64 = nlp.meta.x0
  x = Float32.(x64)
  v = ones(Float32, nvar)
  y = ones(Float32, ncon)
  g = zeros(Float32, nvar)
  hv = zeros(Float32, nvar)
  c = zeros(Float32, ncon)
  jv = zeros(Float32, ncon)
  jtv = zeros(Float32, nvar)
  cnln = zeros(Float32, nlp.meta.nnln)
  rows = zeros(Int, nnzj)
  cols = zeros(Int, nnzj)
  jvals = zeros(Float32, nnzj)
  hvals = zeros(Float32, nnzh)

  # first calls size the lazily allocated workspaces
  obj(nlp, x)
  grad!(nlp, x, g)
  objgrad!(nlp, x, g)
  hprod!(nlp, x, v, hv)
  hess_coord!(nlp, x, hvals)
  @test @allocated(obj(nlp, x)) == 0
  @test @allocated(grad!(nlp, x, g)) == 0
  @test @allocated(objgrad!(nlp, x, g)) == 0
  @test @allocated(hprod!(nlp, x, v, hv)) == 0
  @test @allocated(hess_coord!(nlp, x, hvals)) == 0
  @test g ≈ grad(nlp, x64)
  @test hvals ≈ hess_coord(nlp, x64)
  @test hv ≈ hprod(nlp, x64, ones(nvar))

  if ncon > 0
    cons!(nlp, x, c)
    objcons!(nlp, x, c)
    cons_coord!(nlp, x, c, rows, cols, jvals)
    jac_coord!(nlp, x, jvals)
    jprod!(nlp, x, v, jv)
    jtprod!(nlp, x, y, jtv)
    hess_coord!(nlp, x, y, hvals)
    hprod!(nlp, x, y, v, hv)
    cons_nln!(nlp, x, cnln)
    @test @allocated(cons!(nlp, x, c)) == 0
    @test @allocated(objcons!(nlp, x, c)) == 0
    @test @allocated(cons_coord!(nlp, x, c, rows, cols, jvals)) == 0
    @test @allocated(jac_coord!(nlp, x, jvals)) == 0
    @test @allocated(jprod!(nlp, x, v, jv)) == 0
    @test @allocated(jtprod!(nlp, x, y, jtv)) == 0
    @test @allocated(hess_coord!(nlp, x, y, hvals)) == 0
    @test @allocated(hprod!(nlp, x, y, v, hv)) == 0
    @test @allocated(cons_nln!(nlp, x, cnln)) == 0

    c64, rows64, cols64, jvals64 = cons_coord(nlp, x64)
    cons_coord!(nlp, x, c, rows, cols, jvals)
    @test c ≈ c64
    @test rows == rows64
    @test cols == cols64
    @test jvals ≈ jvals64
    @test cnln ≈ cons_nln(nlp, x64)
    @test jv ≈ jprod(nlp, x64, ones(nvar))
    @test jtv ≈ jtprod(nlp, x64, ones(ncon))
  end
  finalize(nlp)
end
