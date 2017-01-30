# CUTEst.jl: [Julia](http://julialang.org)'s [CUTEst](http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki) Interface

This package provides an interface to CUTEst, a repository of
constrained and unconstrained nonlinear programming problems for testing and
comparing optimization algorithms, derived from the abstract model on
[NLPModels](https://github.com/JuliaSmoothOptimizers/NLPModels.jl).

### Stable release [![Github release](https://img.shields.io/github/release/JuliaSmoothOptimizers/CUTEst.jl.svg)](https://github.com/JuliaSmoothOptimizers/CUTEst.jl/releases/latest)

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

This package should detect your existing CUTEst installation, and will install its private version of CUTEst otherwise.
The gfortran compiler is required.
We currently do not support other Fortran compilers.

On OSX, Homebrew.jl will install gfortran if gfortran is not detected on your system.
You may either use standard Homebrew to install gfortran yourself from precompiled bottled using `brew install gcc` or let Homebrew.jl install its private version.
In the latter scenario, gcc and gfortran need to be compiled from source.

On Linux, you'll need to install `wget` and `gfortran`, and also make `libgfortran.so` visible by `julia`. See [this
page](https://github.com/abelsiqueira/linux-cutest#requirements) for how to
install the requirements on some linux distributions.

The following commands download CUTEst, change to the specific
branch, and build CUTEst.
````JULIA
julia> Pkg.add("CUTEst")
````

## Usage

After installing, you can create instances of
[NLPModels](https://github.com/JuliaSmoothOptimizers/NLPModels.jl) models, with
the name `CUTEstModel`:

````JULIA
using CUTEst

nlp = CUTEstModel("BYRDSPHR");
print(nlp);
````

This model accepts the same functions as the other NLPModels, for instance

````
fx = obj(nlp, nlp.meta.x0)
gx = grad(nlp, nlp.meta.x0)
Hx = hess(nlp, nlp.meta.x0)
````

## Related Packages

- [NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl) provides an
  AbstractModel from which CUTEst.jl derives, and other models deriving from it,
  such as MathProgNLPModel, which uses
  [MathProgBase.jl](https://github.com/JuliaOpt/MathProgBase.jl),
  SimpleNLPModel, for user created functions, ADNLPModel with automatic
  differentiation, and SlackModel, which creates an
  equality constrained model with bounds on the variables from a given
  AbstractModel.
- [AmplNLReader.jl](https://github.com/JuliaSmoothOptimizers/AmplNLReader.jl)
  provides an interface to [AMPL](http://www.ampl.com) models based on
  [NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl).
- [OptimizationProblems.jl](https://github.com/JuliaSmoothOptimizers/OptimizationProblems.jl)
  provides a collection of optimization problems in
  [JuMP.jl](https://github.com/JuliaOpt/JuMP.jl) syntax.

[![GPLv3](http://www.gnu.org/graphics/lgplv3-88x31.png)](http://www.gnu.org/licenses/lgpl.html "LGPLv3")
