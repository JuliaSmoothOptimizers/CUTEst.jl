# using CUTEst, NLPModelsTest, NLPModels, Quadmath

@testset "allocations -- $pb" for pb in ("BROWNDEN", "HS5", "HS6", "HS10", "HS11", "HS13", "HS14")
    @testset "precision -- $T" for T in (Float32, Float64, Float128)
        (T == Float128) && (Sys.ARCH == :aarch64) && Sys.islinux() && continue
        nlp = CUTEstModel{T}(pb)
        NLPModelsTest.test_zero_allocations(nlp; linear_api=true, exclude=[jac_op])
        # mems = NLPModelsTest.test_allocs_nlpmodels(nlp; linear_api=true, exclude=[jac_op])
        # display(mems)
        finalize(nlp)
    end
end
