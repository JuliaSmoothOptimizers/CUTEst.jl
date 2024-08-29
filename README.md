# CUTEst.jl: [Julia](http://julialang.org)'s [CUTEst](https://github.com/ralna/CUTEst/wiki) Interface

This package provides an interface to CUTEst, a repository of
constrained and unconstrained nonlinear programming problems for testing and
comparing optimization algorithms, derived from the abstract model on
[NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl).

### Stable release [![Github release](https://img.shields.io/github/release/JuliaSmoothOptimizers/CUTEst.jl.svg)](https://github.com/JuliaSmoothOptimizers/CUTEst.jl/releases/latest) [![DOI][doi-img]][doi-url]

- Documentation: [![docs-stable][docs-stable-img]][docs-stable-url]
- Chat: [![Gitter](https://img.shields.io/gitter/room/JuliaSmoothOptimizers/JuliaSmoothOptimizers.svg)](https://gitter.im/JuliaSmoothOptimizers/JuliaSmoothOptimizers)

### Development version

- Documentation: [![docs-dev][docs-dev-img]][docs-dev-url]
- Tests: [![build-gh][build-gh-img]][build-gh-url] [![codecov][codecov-img]][codecov-url]
- Downloads: [![downloads][downloads-img]][downloads-url]

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://JuliaSmoothOptimizers.github.io/CUTEst.jl/stable
[docs-dev-img]: https://img.shields.io/badge/docs-dev-purple.svg
[docs-dev-url]: https://JuliaSmoothOptimizers.github.io/CUTEst.jl/dev
[build-gh-img]: https://github.com/JuliaSmoothOptimizers/CUTEst.jl/workflows/CI/badge.svg?branch=main
[build-gh-url]: https://github.com/JuliaSmoothOptimizers/CUTEst.jl/actions
[codecov-img]: https://codecov.io/gh/JuliaSmoothOptimizers/CUTEst.jl/branch/main/graph/badge.svg
[codecov-url]: https://app.codecov.io/gh/JuliaSmoothOptimizers/CUTEst.jl
[doi-img]: https://zenodo.org/badge/30661559.svg
[doi-url]: https://zenodo.org/badge/latestdoi/30661559
[downloads-img]: https://img.shields.io/badge/dynamic/json?url=http%3A%2F%2Fjuliapkgstats.com%2Fapi%2Fv1%2Fmonthly_downloads%2FCUTEst&query=total_requests&suffix=%2Fmonth&label=Downloads
[downloads-url]: https://juliapkgstats.com/pkg/CUTEst

## How to Cite

If you use CUTEst.jl in your work, please cite using the format given in [CITATION.cff](https://github.com/JuliaSmoothOptimizers/CUTEst.jl/blob/main/CITATION.cff).

## Installing

This package will automatically install the CUTEst binaries for your platform.
The `gfortran` compiler is required to compile decoded SIF problems.
Users on all platforms except Windows must install it to use `CUTEst.jl`.
For Windows users, a small artifact containing `gfortran.exe` is installed automatically.
No other Fortran compiler is supported.

The following command installs the CUTEst binaries and the Julia interface:

```julia
pkg> add CUTEst
```

## Usage

After installation, you can create instances of [NLPModels](https://github.com/JuliaSmoothOptimizers/NLPModels.jl)
models using the `CUTEstModel` constructor:

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

To retrieve the list of available SIF problems, use the function `list_sif_problems`:

```julia
using CUTEst

available_problems = list_sif_problems()
```

If you want to retrieve only problems with specific properties, you can use the function `select_sif_problems`:

```julia
using CUTEst

filtered_problems = select_sif_problems(; min_var=10, max_var=100, only_linear_con=true)
```

## Tutorial

You can check an [Introduction to CUTEst.jl](https://jso.dev/tutorials/introduction-to-cutest/) on our [site](https://jso.dev/).

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
