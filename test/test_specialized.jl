println("\nTesting the Specialized interface\n")


fx, cx = jl_cfn(nlp.meta.nvar, nlp.meta.ncon, x0, nlp.libname)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

fx = jl_cfn!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, nlp.libname)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

fx, cx = jl_cfn(nlp, x0)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

fx = jl_cfn!(nlp, x0, cx)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps cx c(x0) 1e-8

fx, gx = jl_cofg(nlp.meta.nvar, x0, true, nlp.libname)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

fx = jl_cofg!(nlp.meta.nvar, x0, gx, true, nlp.libname)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

fx, gx = jl_cofg(nlp, x0, true)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

fx = jl_cofg!(nlp, x0, gx, true)
@test_approx_eq_eps fx f(x0) 1e-8
@test_approx_eq_eps gx g(x0) 1e-8

cx, Jx = jl_ccfg(nlp.meta.nvar, nlp.meta.ncon, x0, false, nlp.meta.ncon, nlp.meta.nvar, true, nlp.libname)
@test_approx_eq_eps cx c(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

jl_ccfg!(nlp.meta.nvar, nlp.meta.ncon, x0, cx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, true, nlp.libname)
@test_approx_eq_eps cx c(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

cx, Jx = jl_ccfg(nlp, x0, false, nlp.meta.ncon, nlp.meta.nvar, true)
@test_approx_eq_eps cx c(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

jl_ccfg!(nlp, x0, cx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, true)
@test_approx_eq_eps cx c(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

gx, Jx = jl_cgr(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.libname)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

jl_cgr!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.libname)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

gx, Jx = jl_cgr(nlp, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

jl_cgr!(nlp, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8

gx, Jx, Wx = jl_cgrdh(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.meta.nvar, nlp.libname)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8
@test_approx_eq_eps Wx W(x0,y0) 1e-8

jl_cgrdh!(nlp.meta.nvar, nlp.meta.ncon, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.meta.nvar, Wx, nlp.libname)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8
@test_approx_eq_eps Wx W(x0,y0) 1e-8

gx, Jx, Wx = jl_cgrdh(nlp, x0, y0, false, false, nlp.meta.ncon, nlp.meta.nvar, nlp.meta.nvar)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8
@test_approx_eq_eps Wx W(x0,y0) 1e-8

jl_cgrdh!(nlp, x0, y0, false, gx, false, nlp.meta.ncon, nlp.meta.nvar, Jx, nlp.meta.nvar, Wx)
@test_approx_eq_eps gx g(x0) 1e-8
@test_approx_eq_eps Jx J(x0) 1e-8
@test_approx_eq_eps Wx W(x0,y0) 1e-8

