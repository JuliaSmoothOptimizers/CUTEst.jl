using Test
using CUTEst
using NLPModels

"""
    get_cutest_counters(nlp::CUTEstModel{T}) where T

Get the evaluation counters from CUTEst's native reporting functions.
"""
function get_cutest_counters(nlp::CUTEstModel{T}) where T
    status = [Cint(0)]
    if nlp.meta.ncon > 0
        # Constrained problem - use creport
        calls = Vector{T}(undef, 7)
        time = Vector{T}(undef, 4)
        CUTEst.creport(T, nlp.libsif, status, calls, time)
        
        return (
            neval_obj = Int(calls[1]),
            neval_grad = Int(calls[2]),
            neval_hess = Int(calls[3]),
            neval_hprod = Int(calls[4]),
            neval_cons = Int(calls[5]),
            neval_jac = Int(calls[6]),
            neval_jprod = Int(calls[7])
        )
    else
        # Unconstrained problem - use ureport
        calls = Vector{T}(undef, 4)
        time = Vector{T}(undef, 4)
        CUTEst.ureport(T, nlp.libsif, status, calls, time)
        
        return (
            neval_obj = Int(calls[1]),
            neval_grad = Int(calls[2]),
            neval_hess = Int(calls[3]),
            neval_hprod = Int(calls[4]),
            neval_cons = 0,
            neval_jac = 0,
            neval_jprod = 0
        )
    end
end

@testset "NLPModels Counters validation against CUTEst native reporting" begin
    @testset "Unconstrained problem counters validation" begin
        nlp = CUTEstModel{Float64}("ROSENBR")
        
        # Get baseline CUTEst counters (initialization overhead)
        baseline_cutest = get_cutest_counters(nlp)
        baseline_julia = (
            neval_obj = nlp.counters.neval_obj,
            neval_grad = nlp.counters.neval_grad,
            neval_hess = nlp.counters.neval_hess,
            neval_hprod = nlp.counters.neval_hprod
        )
        
        x0 = nlp.meta.x0
        f0 = obj(nlp, x0)
        g0 = grad(nlp, x0)
        H0 = hess(nlp, x0)
        hv = hprod(nlp, x0, ones(length(x0)))
        
        julia_counters = nlp.counters
        cutest_counters = get_cutest_counters(nlp)
        
        # Calculate increments from baseline
        julia_increments = (
            neval_obj = julia_counters.neval_obj - baseline_julia.neval_obj,
            neval_grad = julia_counters.neval_grad - baseline_julia.neval_grad,
            neval_hess = julia_counters.neval_hess - baseline_julia.neval_hess,
            neval_hprod = julia_counters.neval_hprod - baseline_julia.neval_hprod
        )
        
        cutest_increments = (
            neval_obj = cutest_counters.neval_obj - baseline_cutest.neval_obj,
            neval_grad = cutest_counters.neval_grad - baseline_cutest.neval_grad,
            neval_hess = cutest_counters.neval_hess - baseline_cutest.neval_hess,
            neval_hprod = cutest_counters.neval_hprod - baseline_cutest.neval_hprod
        )
        
        # Test that increments match (with documented differences)
        @test julia_increments.neval_obj == cutest_increments.neval_obj
        @test julia_increments.neval_grad == cutest_increments.neval_grad
        @test julia_increments.neval_hprod == cutest_increments.neval_hprod
        
        # CUTEst's hess implementation calls internal functions, so expect 1 extra
        @test julia_increments.neval_hess == 1
        @test cutest_increments.neval_hess == 2
  
        # Test individual constraint hessian counter (should be 0 for unconstrained)
        @test nlp.counters.neval_jhess == 0
        @test nlp.counters.neval_jcon == 0
        @test nlp.counters.neval_jgrad == 0
        @test nlp.counters.neval_cons_lin == 0
        @test nlp.counters.neval_cons_nln == 0
        @test nlp.counters.neval_jac_lin == 0
        @test nlp.counters.neval_jac_nln == 0
        @test nlp.counters.neval_jprod_lin == 0
        @test nlp.counters.neval_jprod_nln == 0
        @test nlp.counters.neval_jtprod == 0
        @test nlp.counters.neval_jtprod_lin == 0
        @test nlp.counters.neval_jtprod_nln == 0
        
        finalize(nlp)
    end
    
    @testset "Constrained problem counters validation" begin
        nlp = CUTEstModel{Float64}("BT1")
        
        # Get baseline counters
        baseline_cutest = get_cutest_counters(nlp)
        baseline_julia = (
            neval_obj = nlp.counters.neval_obj,
            neval_grad = nlp.counters.neval_grad,
            neval_hess = nlp.counters.neval_hess,
            neval_hprod = nlp.counters.neval_hprod,
            neval_cons = nlp.counters.neval_cons,
            neval_jac = nlp.counters.neval_jac,
            neval_jprod = nlp.counters.neval_jprod
        )
        
        x0 = nlp.meta.x0
        f0 = obj(nlp, x0)
        g0 = grad(nlp, x0)
        c0 = cons(nlp, x0)
        J0 = jac(nlp, x0)
        H0 = hess(nlp, x0)
        hv = hprod(nlp, x0, ones(length(x0)))
        jv = jprod(nlp, x0, ones(length(x0)))
        
        julia_counters = nlp.counters
        cutest_counters = get_cutest_counters(nlp)
        
        # Calculate increments from baseline
        julia_increments = (
            neval_obj = julia_counters.neval_obj - baseline_julia.neval_obj,
            neval_grad = julia_counters.neval_grad - baseline_julia.neval_grad,
            neval_hess = julia_counters.neval_hess - baseline_julia.neval_hess,
            neval_hprod = julia_counters.neval_hprod - baseline_julia.neval_hprod,
            neval_cons = julia_counters.neval_cons - baseline_julia.neval_cons,
            neval_jac = julia_counters.neval_jac - baseline_julia.neval_jac,
            neval_jprod = julia_counters.neval_jprod - baseline_julia.neval_jprod
        )
        
        cutest_increments = (
            neval_obj = cutest_counters.neval_obj - baseline_cutest.neval_obj,
            neval_grad = cutest_counters.neval_grad - baseline_cutest.neval_grad,
            neval_hess = cutest_counters.neval_hess - baseline_cutest.neval_hess,
            neval_hprod = cutest_counters.neval_hprod - baseline_cutest.neval_hprod,
            neval_cons = cutest_counters.neval_cons - baseline_cutest.neval_cons,
            neval_jac = cutest_counters.neval_jac - baseline_cutest.neval_jac,
            neval_jprod = cutest_counters.neval_jprod - baseline_cutest.neval_jprod
        )
        
        # Test that increments match (with documented differences)
        @test julia_increments.neval_grad == cutest_increments.neval_grad
        @test julia_increments.neval_hprod == cutest_increments.neval_hprod
        
        # CUTEst's constrained problem implementation has specific counting behavior
        @test julia_increments.neval_obj == 1
        @test cutest_increments.neval_obj == 0  # CUTEst doesn't count obj in constrained setup
        
        @test julia_increments.neval_cons == 1
        @test cutest_increments.neval_cons == 2  # CUTEst counts 1 extra constraint call
        
        @test julia_increments.neval_jac == 1
        @test cutest_increments.neval_jac == 2  # CUTEst counts 1 extra jacobian call
        
        @test julia_increments.neval_hess == 1
        @test cutest_increments.neval_hess == 2  # CUTEst counts 1 extra hessian call
        
        @test julia_increments.neval_jprod == 1
        @test cutest_increments.neval_jprod == 2  # CUTEst counts 1 extra jprod call

        # Test linear/nonlinear constraint distinction counters
        if nlp.meta.nlin > 0
            c_lin = Vector{Float64}(undef, nlp.meta.nlin)
            cons_lin!(nlp, x0, c_lin)
            @test nlp.counters.neval_cons_lin == 1
        end
        
        if nlp.meta.nnln > 0
            c_nln = Vector{Float64}(undef, nlp.meta.nnln)
            cons_nln!(nlp, x0, c_nln)
            @test nlp.counters.neval_cons_nln == 1
        end
        
        # Test linear/nonlinear jacobian distinction counters
        if nlp.meta.nlin > 0
            vals_lin = Vector{Float64}(undef, nlp.meta.lin_nnzj)
            jac_lin_coord!(nlp, x0, vals_lin)
            @test nlp.counters.neval_jac_lin == 1
        end
        
        if nlp.meta.nnln > 0
            vals_nln = Vector{Float64}(undef, nlp.meta.nln_nnzj)
            jac_nln_coord!(nlp, x0, vals_nln)
            @test nlp.counters.neval_jac_nln == 1
        end
        
        # Test linear/nonlinear jacobian-vector product counters
        v = ones(nlp.meta.nvar)
        if nlp.meta.nlin > 0
            jv_lin = Vector{Float64}(undef, nlp.meta.nlin)
            jprod_lin!(nlp, x0, v, jv_lin)
            @test nlp.counters.neval_jprod_lin == 1
        end
        
        if nlp.meta.nnln > 0
            jv_nln = Vector{Float64}(undef, nlp.meta.nnln)
            jprod_nln!(nlp, x0, v, jv_nln)
            @test nlp.counters.neval_jprod_nln == 1
        end
        
        # Test transposed jacobian-vector product counters
        cv = ones(nlp.meta.ncon)
        jtv = Vector{Float64}(undef, nlp.meta.nvar)
        jtprod!(nlp, x0, cv, jtv)
        @test nlp.counters.neval_jtprod == 1
        
        if nlp.meta.nlin > 0
            cv_lin = ones(nlp.meta.nlin)
            jtv_lin = Vector{Float64}(undef, nlp.meta.nvar)
            jtprod_lin!(nlp, x0, cv_lin, jtv_lin)
            @test nlp.counters.neval_jtprod_lin == 1
        end
        
        if nlp.meta.nnln > 0
            cv_nln = ones(nlp.meta.nnln)
            jtv_nln = Vector{Float64}(undef, nlp.meta.nvar)
            jtprod_nln!(nlp, x0, cv_nln, jtv_nln)
            @test nlp.counters.neval_jtprod_nln == 1
        end
        
        finalize(nlp)
    end
end
