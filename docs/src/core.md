# Working with CUTEst directly

When working with CUTEst, we created a **core** interface, which is essentially an interface for the core CUTEst functions.
The core interface is implemented in [core_interface.jl](https://github.com/JuliaSmoothOptimizers/CUTEst.jl/blob/main/src/core_interface.jl).
However, you probably won't want to use this directly because the NLPModels interface is much more user-friendly and just as effective.
For more information, see its tutorial.

CUTEst.jl calls Fortran routines from [CUTEst](https://github.com/ralna/CUTEst) via Julia wrappers in [libcutest.jl](https://github.com/JuliaSmoothOptimizers/CUTEst.jl/blob/main/src/libcutest.jl).

For each of these routines, we dropped the `cutest_` prefix and the `_s_`, `_`, and `_q_` suffixes.
For example, the functions `cutest_ufn_s_`, `cutest_ufn_`, and `cutest_ufn_q_` are all available as `ufn`.
The `ufn` function takes an additional argument `T` in the first position, where `T` can be `Float32`, `Float64`, or `Float128`.
This allows for a unified interface to the routines in single, double, and quadruple precision.

**Only use these functions if you really know what you're doing.**

If you want to use these functions, you should still decode the problem as an NLP by doing the following:
```julia
using CUTEst, Quadmath

# Float32, Float64 and Float128 are supported
T = Float64
nlp = CUTEstModel{T}("PROBLEM")
x = rand(T, nlp.meta.nvar)
f = Ref{T}()
CUTEst.ufn(T, nlp.libsif, nlp.status, nlp.nvar, x, f)
println(f[])
```
