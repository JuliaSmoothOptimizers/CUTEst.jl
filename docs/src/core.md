# Working with CUTEst directly

When working with CUTEst, we created a **core** interface, which is essentially an interface for the core CUTEst functions.
The core interface is implemented in [core_interface.jl](https://github.com/JuliaSmoothOptimizers/CUTEst.jl/blob/main/src/core_interface.jl).
However, you probably won't want to use this directly because the NLPModels interface is much more user-friendly and just as effective.
For more information, see its tutorial.

CUTEst.jl calls Fortran routines from [CUTEst](https://github.com/ralna/CUTEst) via Julia wrappers in [libcutest.jl](https://github.com/JuliaSmoothOptimizers/CUTEst.jl/blob/main/src/libcutest.jl).

For each of these routines, we dropped the prefix `cutest_` and the suffixes `_s_`, `_`, and `_q_`.
For example, the functions `cutest_ufn_s_`, `cutest_ufn_`, and `cutest_ufn_q_` are all available as `ufn`.
The `ufn` function takes an additional argument `T` in the first position, where `T` can be `Float32`, `Float64`, or `Float128`.
This allows for a unified interface to the routines in single, double, and quadruple precision.

**Only use these functions if you really know what you're doing.**

If you want to use these functions, you should still decode the problem as an NLP by doing the following:

```julia
using CUTEst, Quadmath

# Float32, Float64 and Float128 are supported
T = Float64
nlp = CUTEstModel{T}("CHAIN")
x = rand(T, nlp.meta.nvar)
f = Ref{T}()
CUTEst.ufn(T, nlp.libsif, nlp.status, nlp.nvar, x, f)
println(f[])
```

```@docs
CUTEst.cjprod
CUTEst.ccfg
CUTEst.ccf
CUTEst.cish
CUTEst.cishp
CUTEst.ushprod
CUTEst.cdimchp
CUTEst.ureport
CUTEst.chcprod
CUTEst.udimse
CUTEst.ubandh
CUTEst.csjp
CUTEst.cgr
CUTEst.ufn
CUTEst.csgrp
CUTEst.cshc
CUTEst.cdimsj
CUTEst.cfn
CUTEst.cofg
CUTEst.cofsg
CUTEst.ceh
CUTEst.cdimsh
CUTEst.ugr
CUTEst.cshcprod
CUTEst.uhprod
CUTEst.csgreh
CUTEst.uterminate
CUTEst.ugreh
CUTEst.cigr
CUTEst.clfg
CUTEst.ugrdh
CUTEst.cdhc
CUTEst.fclose
CUTEst.csetup
CUTEst.ccifg
CUTEst.cvartype
CUTEst.udimsh
CUTEst.csjprod
CUTEst.cgrdh
CUTEst.cdh
CUTEst.ush
CUTEst.csh
CUTEst.ueh
CUTEst.cchprods
CUTEst.ccifsg
CUTEst.uofg
CUTEst.connames
CUTEst.cisgr
CUTEst.udh
CUTEst.cdimse
CUTEst.ushp
CUTEst.creport
CUTEst.cshp
CUTEst.probname
CUTEst.unames
CUTEst.cidh
CUTEst.csgr
CUTEst.usetup
CUTEst.csgrsh
CUTEst.cdimen
CUTEst.cshprod
CUTEst.cchprodsp
CUTEst.cconst
CUTEst.udimen
CUTEst.pname
CUTEst.chjprod
CUTEst.cohprods
CUTEst.chsprod
CUTEst.chprod
CUTEst.cterminate
CUTEst.cifn
CUTEst.cstats
CUTEst.cnames
CUTEst.ugrsh
CUTEst.varnames
CUTEst.uvartype
CUTEst.fopen
CUTEst.csgrshp
CUTEst.ccfsg
CUTEst.classification
```
