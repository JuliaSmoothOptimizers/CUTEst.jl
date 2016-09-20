# CUTEst.jl documentation

This package provides access interfaces to
[CUTEst](http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki),
the Constrained and Unconstrained Test Environment with safe threads
for nonlinear optimization.

This package uses
[NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl), but it
also gives a different interface for accessing the problems.

## Installing

Currently, this package builds its own version of CUTEst, if you have your own
version of CUTEst, this will conflict with it. Check the issues for a fix, or
open one for help.

The following commands should automatically download NLPModels.jl and CUTEst,
and install them.
````julia
Pkg.clone("https://github.com/JuliaSmoothOptimizers/NLPModels.jl.git")
Pkg.checkout("NLPModels", "develop")
Pkg.clone("https://github.com/JuliaSmoothOptimizers/CUTEst.jl.git")
Pkg.checkout("CUTEst", "develop")
Pkg.build("CUTEst")
````

## Usage

The simples use of CUTEst is using the interface of NLPModels.jl

```@example
using CUTEst

nlp = CUTEstModel("ROSENBR")
println("x0 = $(nlp.meta.x0)")
println("fx = $( obj(nlp, nlp.meta.x0) )")
println("gx = $( grad(nlp, nlp.meta.x0) )")
println("Hx = $( hess(nlp, nlp.meta.x0) )")
cutest_finalize(nlp)
```

Check the [API](api/#nlpmodels-api)

There is also a specialized API which provides a more CUTEst-like interface, and
a core API which is only a wrapper for CUTEst.
The documentation of these is under construction.
