# CUTEst.jl: [Julia](http://julialang.org)'s [CUTEst](http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki) Interface

[![Build Status](https://travis-ci.org/optimizers/CUTEst.jl.svg?branch=develop)](https://travis-ci.org/optimizers/CUTEst.jl)
[![Coverage Status](https://coveralls.io/repos/optimizers/CUTEst.jl/badge.svg?branch=develop)](https://coveralls.io/r/optimizers/CUTEst.jl?branch=develop)


This is work in progress to create an interface to CUTEst based on
[NLP.jl](https://github.com/JuliaOpt/MathProgBase.jl/tree/master/src/NLP).

## Installing

To install CUTEst, we suggest using the [Homebrew](https://github.com/Homebrew)
[CUTEst tap](https://github.com/dpo/homebrew-cutest), which will build a
shared library.

````JULIA
julia> Pkg.clone("https://github.com/optimizers/CUTEst.jl.git")
````

## Example

````JULIA
using CUTEst

nlp = CUTEstModel("BYRDSPHR.SIF");
print(nlp);

(f, c) = objcons(nlp, nlp.meta.x0);
(f, g) = objgrad(nlp, nlp.meta.x0, true);
nlp.meta.ncon > 0 && (c, J) = cons(nlp, nlp.meta.x0, true);
H = hess(nlp, nlp.meta.x0));
````

## Related Packages

[AmplNLReader.jl](https://github.com/dpo/AmplNLReader.jl) provides an interface to
[AMPL](http://www.ampl.com) models based on
[NLP.jl](https://github.com/JuliaOpt/MathProgBase.jl/tree/master/src/NLP).

[![GPLv3](http://www.gnu.org/graphics/lgplv3-88x31.png)](http://www.gnu.org/licenses/lgpl.html "LGPLv3")
