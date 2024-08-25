# CUTEst.jl: [Julia](http://julialang.org)'s [CUTEst](https://github.com/ralna/CUTEst/wiki) Interface

This package provides an interface to CUTEst, a repository of
constrained and unconstrained nonlinear programming problems for testing and
comparing optimization algorithms, derived from the abstract model on
[NLPModels](https://github.com/JuliaSmoothOptimizers/NLPModels.jl).

### Stable release [![Github release](https://img.shields.io/github/release/JuliaSmoothOptimizers/CUTEst.jl.svg)](https://github.com/JuliaSmoothOptimizers/CUTEst.jl/releases/latest) [![DOI](https://zenodo.org/badge/30661559.svg)](https://zenodo.org/badge/latestdoi/30661559)

- Documentation: [![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://jso.dev/CUTEst.jl/stable)
- Chat: [![Gitter](https://img.shields.io/gitter/room/JuliaSmoothOptimizers/JuliaSmoothOptimizers.svg)](https://gitter.im/JuliaSmoothOptimizers/JuliaSmoothOptimizers)

### Development version

- Documentation: [![Documentation](https://img.shields.io/badge/docs-latest-blue.svg)](https://jso.dev/CUTEst.jl/latest)
- Tests:
[![Build Status](https://travis-ci.org/JuliaSmoothOptimizers/CUTEst.jl.svg?branch=main)](https://travis-ci.org/JuliaSmoothOptimizers/CUTEst.jl)
[![Coverage Status](https://coveralls.io/repos/JuliaSmoothOptimizers/CUTEst.jl/badge.svg?branch=main)](https://coveralls.io/r/JuliaSmoothOptimizers/CUTEst.jl?branch=main)

## How to Cite

If you use CUTEst.jl in your work, please cite using the format given in [CITATION.cff](https://github.com/JuliaSmoothOptimizers/CUTEst.jl/blob/main/CITATION.cff).

## Installing

This package will automatically install the CUTEst binaries for your platform.
The `gfortran` compiler is required to compile decoded SIF problems, except on Windows.
No other Fortran compiler is supported.

The following command installs the CUTEst binaries and the Julia interface:

```julia
pkg> add CUTEst
```

## Usage

After installation, you can create instances of
[NLPModels](https://github.com/JuliaSmoothOptimizers/NLPModels.jl) models using
the `CUTEstModel` constructor:

```julia
using CUTEst

nlp = CUTEstModel{Float64}("BYRDSPHR")
```

This model supports the same functions as other NLPModels, for example:

```julia
using NLPModels

fx = obj(nlp, nlp.meta.x0)
gx = grad(nlp, nlp.meta.x0)
Hx = hess(nlp, nlp.meta.x0)

cx = cons(nlp, nlp.meta.x0)
Jx = jac(nlp, nlp.meta.x0)
```

Problems can also be instantiated in single and quadruple precision:

```julia
using CUTEst, Quadmath

nlp_single = CUTEstModel{Float32}("BYRDSPHR")
nlp_quadruple = CUTEstModel{Float128}("BYRDSPHR")
```

## SIF problems

A large collection of SIF files can be found [here](https://bitbucket.org/optrove/workspace/repositories/).
If the environment variable `MASTSIF` is not set, `CUTEst.jl` will automatically download the CUTEst
NLP test set the first time you use `using CUTEst`.
Thanks to the function `set_mastsif`, you can easily switch to the Maros-Meszaros QP test set
or the Netlib LP test set.

```julia
set_mastsif("sifcollection")  # default set
set_mastsif("maros-meszaros")
set_mastsif("netlib-lp")
```

The constructor `CUTEstModel{Float64}(name)` will try to find the SIF file associated with the problem `name` in the current set.

### Run multiple models in parallel

First, decode each of the problems in serial.

```julia
function decodemodel(name)
    finalize(CUTEstModel(name))
end

probs = ["AKIVA", "ALLINITU", "ARGLINA", "ARGLINB", "ARGLINC", "ARGTRIGLS", "ARWHEAD"]
broadcast(decodemodel, probs)
```

Then, call functions handling models in parallel. It is important to pass `decode=false` to `CUTEstModel`.

```julia
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
- [OptimizationProblems.jl](https://github.com/JuliaSmoothOptimizers/OptimizationProblems.jl) provides a collection of optimization problems using the [NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl) and [JuMP.jl](https://github.com/jump-dev/JuMP.jl) syntaxes.

[![GPLv3](http://www.gnu.org/graphics/lgplv3-88x31.png)](http://www.gnu.org/licenses/lgpl.html "LGPLv3")
