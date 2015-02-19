println("\nTesting the intermediate interface\n")

nvar = nlp.meta.nvar
ncon = nlp.meta.ncon

if ncon > 0
  (fx, cx) = CUTEst.jl_cfn(nvar, ncon, x0, nlp.libname)
  @test_small(cx-c(x0))
else
  fx = CUTEst.jl_ufn(nvar, x0, nlp.libname)
end
@test_small(fx-f(x0))
if ncon > 0
  (fx, gx) = CUTEst.jl_cofg(nvar, x0, true, nlp.libname)
else
  (fx, gx) = CUTEst.jl_uofg(nvar, x0, true, nlp.libname)
end
@test_small(fx-f(x0))
@test_small(gx-g(x0))
if ncon > 0
  (cx, nnzj, Jval, Jvar, Jfun) = CUTEst.jl_ccfsg(nvar, ncon, x0,
    nlp.meta.nnzj, true, nlp.libname)
  Jx = zeros(ncon, nvar)
  for k = 1:nnzj
    Jx[Jfun[k],Jvar[k]] = Jval[k]
  end
  @test_small(cx-c(x0))
  @test_small(Jx-J(x0))
end

println("f(x0) = ", fx)
println("∇f(x0) = ", gx)
if ncon > 0
  println("c(x0) = ", cx)
  println("Jval = ", Jval)
  println("Jvar = ", Jvar)
  println("Jfun = ", Jfun)
end
