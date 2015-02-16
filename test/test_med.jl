println("\nTesting the intermediate interface\n")

nvar = nlp.meta.nvar
ncon = nlp.meta.ncon
x = nlp.meta.x0

(f, c) = CUTEst.jl_cfn(nvar, ncon, x, nlp.libname)
(f, g) = CUTEst.jl_cofg(nvar, x, true, nlp.libname)
(c, nnzj, Jval, Jvar, Jfun) = CUTEst.jl_ccfsg(nvar, ncon, x,
  nlp.meta.nnzj, true, nlp.libname)

println("f(x0) = ", f)
println("c(x0) = ", c)
println("∇f(x0) = ", g)
println("Jval = ", Jval)
println("Jvar = ", Jvar)
println("Jfun = ", Jfun)
