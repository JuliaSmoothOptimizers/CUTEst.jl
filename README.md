# CUTEst.jl: [Julia](http://julialang.org)'s [CUTEst](http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki) Interface

[![Build Status](https://travis-ci.org/JuliaSmoothOptimizers/CUTEst.jl.svg?branch=develop)](https://travis-ci.org/JuliaSmoothOptimizers/CUTEst.jl)
[![Coverage Status](https://coveralls.io/repos/JuliaSmoothOptimizers/CUTEst.jl/badge.svg?branch=develop)](https://coveralls.io/r/JuliaSmoothOptimizers/CUTEst.jl?branch=develop)


This is work in progress to create an interface to CUTEst based on
[NLPModels](https://github.com/JuliaSmoothOptimizers/NLPModels.jl).

## Installing

Currently, this package builds its own version of CUTEst. If you have a working
version of CUTEst, and is interested in using it, you can help us by
contributing to this package.

The following commands download NLPModels and CUTEst, change to the specific
branch, and build CUTEst.
````JULIA
julia> Pkg.clone("https://github.com/JuliaSmoothOptimizers/NLPModels.jl.git")
julia> Pkg.checkout("NLPModels", "develop")
julia> Pkg.clone("https://github.com/JuliaSmoothOptimizers/CUTEst.jl.git")
julia> Pkg.checkout("CUTEst", "develop")
julia> Pkg.build("CUTEst")
````

## Usage

After installing, you can use it as a
[NLPModels](https://github.com/JuliaSmoothOptimizers/NLPModels.jl) model, with
the name `CUTEstModel`.

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

It also accepts the traditional CUTEst naming, with and without the Julian touch
````
if nlp.meta.ncon > 0
  f, c = cfn(nlp, nlp.meta.x0)
  f, c = cfn(nlp.meta.nvar, nlp.meta.ncon, nlp.meta.x0)
else
  f = ufn(nlp, nlp.meta.x0)
  f = ufn(nlp.meta.nvar, nlp.meta.x0)
end
````
There is also a wrapper for the Fortran functions directly, which you probably
don't need.

## Documentation

Work in progress.

## Related Packages

- [NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl) provides an
  AbstractModel from which CUTEst.jl derives, and other models deriving from it,
  such as JuMPModel, which uses [JuMP.jl](https://github.com/JuliaOpt/JuMP.jl),
  SimpleNLPModel, for user created functions, and SlackModel, which creates an
  equality constrained model with bounds on the variables from a given
  AbstractModel.
- [AmplNLReader.jl](https://github.com/JuliaSmoothOptimizers/AmplNLReader.jl)
  provides an interface to [AMPL](http://www.ampl.com) models based on
  [NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl).
- [OptimizationProblems](https://github.com/JuliaSmoothOptimizers/OptimizationProblems.jl)
  provides a collection of optimization problems in
  [JuMP.jl](https://github.com/JuliaOpt/JuMP.jl) syntax.

[![GPLv3](http://www.gnu.org/graphics/lgplv3-88x31.png)](http://www.gnu.org/licenses/lgpl.html "LGPLv3")
