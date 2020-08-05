# CUTEst.jl: [Julia](http://julialang.org)'s [CUTEst](https://github.com/ralna/CUTEst/wiki) Interface

This package provides an interface to CUTEst, a repository of
constrained and unconstrained nonlinear programming problems for testing and
comparing optimization algorithms, derived from the abstract model on
[NLPModels](https://github.com/JuliaSmoothOptimizers/NLPModels.jl).

### Stable release [![Github release](https://img.shields.io/github/release/JuliaSmoothOptimizers/CUTEst.jl.svg)](https://github.com/JuliaSmoothOptimizers/CUTEst.jl/releases/latest) [![DOI](https://zenodo.org/badge/30661559.svg)](https://zenodo.org/badge/latestdoi/30661559)

- Documentation: [![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://JuliaSmoothOptimizers.github.io/CUTEst.jl/stable)
- Package Evaluator: [![CUTEst.jl](https://pkg.julialang.org/badges/CUTEst_0.5.svg)](https://pkg.julialang.org/?pkg=CUTEst)
[![CUTEst.jl](https://pkg.julialang.org/badges/CUTEst_0.6.svg)](https://pkg.julialang.org/?pkg=CUTEst)
- Chat: [![Gitter](https://img.shields.io/gitter/room/JuliaSmoothOptimizers/JuliaSmoothOptimizers.svg)](https://gitter.im/JuliaSmoothOptimizers/JuliaSmoothOptimizers)

### Development version

- Documentation: [![Documentation](https://img.shields.io/badge/docs-latest-blue.svg)](https://JuliaSmoothOptimizers.github.io/CUTEst.jl/latest)
- Tests:
[![Build Status](https://travis-ci.org/JuliaSmoothOptimizers/CUTEst.jl.svg?branch=master)](https://travis-ci.org/JuliaSmoothOptimizers/CUTEst.jl)
[![Coverage Status](https://coveralls.io/repos/JuliaSmoothOptimizers/CUTEst.jl/badge.svg?branch=master)](https://coveralls.io/r/JuliaSmoothOptimizers/CUTEst.jl?branch=master)

## Installing

This package will install CUTEst binaries for your platform automatically.
The gfortran compiler is still required to compile decoded SIF problems.
No other Fortran compiler is supported.

The following command installs the CUTEst binaries and Julia interface:
````JULIA
pkg> add CUTEst
````

If you already have a collection of SIF problems that you wish to use, you can simply set the `MASTSIF` environment variable to point to their location.
If not, the command
```julia
julia> fetch_sif_problems()
```
will download the most recent version of the standard SIF collection and set `MASTSIF` appropriately.
Subsequent calls to the same function will pull any updates to the SIF problems.

## Usage

After installing, you can create instances of
[NLPModels](https://github.com/JuliaSmoothOptimizers/NLPModels.jl) models, with
the name `CUTEstModel`:

```jl
using CUTEst

nlp = CUTEstModel("BYRDSPHR");
print(nlp);
```

This model accepts the same functions as the other NLPModels, for instance

```jl
fx = obj(nlp, nlp.meta.x0)
gx = grad(nlp, nlp.meta.x0)
Hx = hess(nlp, nlp.meta.x0)
```

### Run multiple models in parallel

First, decode each of the problems in serial.

```jl
function decodemodel(name)
    finalize(CUTEstModel(name))
end

probs = ["AKIVA", "ALLINITU", "ARGLINA", "ARGLINB", "ARGLINC","ARGTRIGLS", "ARWHEAD"]
broadcast(decodemodel, probs)
```

Then, call functions handling models in parallel. It is important to pass `decode=false` to `CUTEstModel`.

```jl
addprocs(2)
@everywhere using CUTEst
@everywhere function evalmodel(name)
   nlp = CUTEstModel(name; decode=false)
   retval = obj(nlp, nlp.meta.x0)
   finalize(nlp)
   retval
end

fvals = pmap(evalmodel, probs)
```

## Related Packages

- [NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl) provides an
  AbstractModel from which CUTEstModel derives.
- [AmplNLReader.jl](https://github.com/JuliaSmoothOptimizers/AmplNLReader.jl)
  provides an interface to [AMPL](http://www.ampl.com) models based on
  [NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl).
- [NLPModelsJuMP.jl](https://github.com/JuliaSmoothOptimizers/NLPModelsJuMP.jl.git)
  provides conversion from [JuMP.jl](https://github.com/jump-dev/JuMP.jl) / [MathOptInterface.jl](https://github.com/jump-dev/MathOptInterface.jl) models to NLPModels.
- [OptimizationProblems.jl](https://github.com/JuliaSmoothOptimizers/OptimizationProblems.jl)
  provides a collection of optimization problems in
  [JuMP.jl](https://github.com/jump-dev/JuMP.jl) syntax.

[![GPLv3](http://www.gnu.org/graphics/lgplv3-88x31.png)](http://www.gnu.org/licenses/lgpl.html "LGPLv3")
