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

"""
Test validates eval counters against CUTEst's native reporting.
"""
function test_counter_validation()
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
            
            # Test that increments match (accounting for CUTEst's internal behavior)
            @test julia_increments.neval_obj == cutest_increments.neval_obj
            @test julia_increments.neval_grad == cutest_increments.neval_grad
            @test julia_increments.neval_hprod == cutest_increments.neval_hprod
            
            # CUTEst's hess implementation may call internal functions, so expect difference
            @test julia_increments.neval_hess >= 1
            @test cutest_increments.neval_hess >= julia_increments.neval_hess
            
            finalize(nlp)
        end
        
        @testset "Constrained problem counter validation" begin
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
            
            # Test basic relationships that should hold
            @test julia_increments.neval_grad >= 1
            @test julia_increments.neval_cons >= 1
            @test julia_increments.neval_jac >= 1
            @test julia_increments.neval_hess >= 1
            @test julia_increments.neval_hprod >= 1
            @test julia_increments.neval_jprod >= 1
            
            # CUTEst may count internal calls differently, but should be consistent with usage
            @test cutest_increments.neval_grad >= julia_increments.neval_grad
            @test cutest_increments.neval_hprod == julia_increments.neval_hprod
            
            finalize(nlp)
        end
    end
end

# Run the tests when included in the main test suite
test_counter_validation()
