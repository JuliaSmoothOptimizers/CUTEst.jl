# CUTEst.jl documentation

This package provides an interface to [CUTEst](https://github.com/ralna/CUTEst), the *Constrained and Unconstrained Testing Environment with safe threads* for nonlinear optimization.

This package uses [NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl), but it also provides direct access to the CUTEst functions.

## CUTEst brief history

CUTEst has been around for a while. It started as CUTE, then evolved into CUTEr, CUTEr2, and finally CUTEst.
The [original project](https://github.com/ralna/CUTEst/wiki) can be used independently of Julia.

CUTEst works by decoding a `.SIF` file into other files and objects so that a user can compile and link them to their code.
It also offers the option to perform these steps for you, in which case you need to send some code to its folder and request the compilation.

CUTEst provides about 100 methods to access the objective and constraint functions, as well as their derivatives in many different formats.
It also offers access to the problem's information, such as the number of variables, constraints, the initial point, bounds, and so on.

## Prerequisites

On all platforms except Windows, you'll need to install `gfortran`.
On Windows, everything is installed for you thanks to Julia artifacts.

On Ubuntu, you can do this with:
```shell
sudo apt-get install gfortran
```

On Arch Linux, use:
```shell
sudo pacman -S gfortran
```

On macOS, use Homebrew:
```shell
brew install gfortran
```

## Installation

The following command should automatically download and install CUTEst and its dependencies.
```julia
julia> ]
pkg> add CUTEst
```

## Usage

Check the tutorial for complete usage instructions.

The simplest way to use CUTEst is through the interface provided by NLPModels.jl.

```@example
using CUTEst, NLPModels

nlp = CUTEstModel{Float64}("ROSENBR")
println("x0 = $(nlp.meta.x0)")
println("fx = $( obj(nlp, nlp.meta.x0) )")
println("gx = $( grad(nlp, nlp.meta.x0) )")
println("Hx = $( hess(nlp, nlp.meta.x0) )")
```

Check the [NLPModels API](https://jso.dev/NLPModels.jl/stable/api/) for details.

You can pass parameters to `sifdecoder` by providing additional arguments to `CUTEstModel`. For instance, to change `NH` for the model `CHAIN`, use:

```@example
using CUTEst

for nh in 50:50:200
  CUTEstModel{Float64}("CHAIN", "-param", "NH=$nh") do nlp
    println("nh = $nh, nnzh = $(nlp.meta.nnzh)")
    finalize(nlp)
  end
end
```

`finalize(nlp)` is automatically handled by the garbage collector; however, you may need to call it manually if you want to recreate a model with the same problem but of a different size.

## Working with CUTEst directly

We have also implemented functions to allow direct access to CUTEst functions through a core API, which serves as a wrapper for CUTEst.
For more information, see the section on the core interface.
