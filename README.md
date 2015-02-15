# CUTEst.jl

[![Build Status](https://travis-ci.org/abelsiqueira/CUTEst.jl.svg?branch=master)](https://travis-ci.org/abelsiqueira/CUTEst.jl)
[![Coverage Status](https://coveralls.io/repos/abelsiqueira/CUTEst.jl/badge.svg?branch=master)](https://coveralls.io/r/abelsiqueira/CUTEst.jl?branch=master)

**CUTEst.jl** is a
[Julia](http://julialang.org)
interface for
[CUTEst](http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki).
This package enables the easy use of the CUTEst functions in a Julia
environment.

This work provides three types of interface
  - The **Core**, or raw, interface, which is equivalent to making a direct call
    to the CUTEst functions, including the needs to pass pointers.
    The naming is the same as those of CUTEst.
  - An **Intermediate** interface, which uses the naming `jl_foo`
    for each `foo` function in CUTEst. In this interface, the output arguments
    are returned by the function, and non-pointer arguments can be passed when
    the argument is not an array (e.g. number of variables and constraints).
  - A **Julia-like** interface, which has no naming convention with
    CUTEst, but uses [NLP.jl](https://github.com/optimizers/NLP.jl),
    which makes it much easier to call functions, since you can create an
    object for your problem and pass this object instead of passing every
    single constant argument (e.g. number of variables and constraints).

Note: This is work in progress.

## Installing

You need `CUTEst` installed as a shared library.
We highly suggest installing
[Homebrew](https://github.com/Homebrew/homebrew) or
[Linuxbrew](https://github.com/Homebrew/linuxbrew)
and then using
[CUTEst tap](https://github.com/dpo/homebrew-cutest),
which will build a shared library.
For OSX, this is probably the best alternative,
for Linux, if you don't want to install Linuxbrew,
the package
[cutest-julia-installer](https://github.com/abelsiqueira/cutest-julia-installer)
aims to provide the same thing. Note, however, that it
did not work on the latest build.

Now, you need to install NLP. If you don't need to configure it, just
enter
````JULIA
julia> Pkg.clone("https://github.com/optimizers/NLP.jl.git")
````
Finally, you can install this package by entering
````JULIA
julia> Pkg.clone("https://github.com/optimizers/CUTEst.jl.git")
````
Test the package with
````JULIA
julia> Pkg.test("CUTEst")
````

## Example

Here is a simple example of using the Julia-like interface:
````JULIA
using CUTEst

nlp = CUTEstModel("BYRDSPHR.SIF");
print(nlp);

(f, c) = objcons(nlp, nlp.meta.x0);
(f, g) = objgrad(nlp, nlp.meta.x0, true);
nlp.meta.ncon > 0 && (c, J) = cons(nlp, nlp.meta.x0, true);
H = hess(nlp, nlp.meta.x0));
````

For examples of using the other interfaces, see the files on `test`.

## Todo

See [TODO.md](TODO.md).

## License

This work is licensed under The GNU LGPLv3. See [LICENSE.md](LICENSE.md).

[![GPLv3](http://www.gnu.org/graphics/lgplv3-88x31.png)](http://www.gnu.org/licenses/lgpl.html "LGPLv3")
