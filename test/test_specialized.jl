println("\nTesting the Specialized interface\n")

fx, cx = jl_cfn(nlp.meta.nvar, nlp.meta.ncon, x0, nlp.libname)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

fx, cx = jl_cfn(nlp, x0)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

cx = zeros(nlp.meta.ncon)
fx = jl_cfn!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, nlp.libname)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

cx = zeros(nlp.meta.ncon)
fx = jl_cfn!(nlp, x0, cx)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

println("fx = ", fx)
println("cx = ", cx)
