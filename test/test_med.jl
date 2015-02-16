println("\nTesting the intermediate interface\n")

nvar = nlp.meta.nvar
ncon = nlp.meta.ncon

(fx, cx) = CUTEst.jl_cfn(nvar, ncon, x0, nlp.libname)
@test_small(fx-f(x0))
@test_small(cx-c(x0))
(fx, gx) = CUTEst.jl_cofg(nvar, x0, true, nlp.libname)
@test_small(fx-f(x0))
@test_small(gx-g(x0))
(cx, nnzj, Jval, Jvar, Jfun) = CUTEst.jl_ccfsg(nvar, ncon, x0,
  nlp.meta.nnzj, true, nlp.libname)
Jx = zeros(ncon, nvar)
for k = 1:nnzj
  Jx[Jfun[k],Jvar[k]] = Jval[k]
end
@test_small(cx-c(x0))
@test_small(Jx-J(x0))

println("f(x0) = ", fx)
println("c(x0) = ", cx)
println("∇f(x0) = ", gx)
println("Jval = ", Jval)
println("Jvar = ", Jvar)
println("Jfun = ", Jfun)
