# Tutorial

CUTEst can be accessed in three ways.
- The first, easiest, and recommended for most users, is using the
  [NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl).
  This is recommended because if you develop something for this an `NLPModel`,
  then it can work with CUTEst, but also with other models.
- The second is the core interface, which is just a wrapper of the Fortran
  functions, and is not recommended unless you really need and know what you're
  doing.
- The third is something in the middle, which we called specialized interface.
  It follows the same naming as the core functions, but it is more accessible,
  from the Julia point of view.

## NLPModels interface

NLPModels defines an abstract interface to access the objective, constraints,
derivatives, etc. of the problem. A
[reference guide](https://juliasmoothoptimizers.github.io/NLPModels.jl/latest/api#reference-guide)
is available to check what you need.

Once CUTEst has been installed, open a problem with

```@example ex1
using CUTEst

nlp = CUTEstModel("ROSENBR")
```

That's it. You can use `nlp` like any other NLPModel, with one **important
exception**. You have to finalize the model after using it. To be exact, you
have to finalize it before opening a new one. There is no problem in closing
Julia before finalizing it, for instance.

```@example ex1
cutest_finalize(nlp)
```

Being a NLPModel means that everything created for an AbstractNLPModel will work
for CUTEstModel. For instance,
[Optimize.jl](https://github.com/JuliaSmoothOptimizers/Optimize.jl)
has implementations of optimization methods for AbstractNLPModels.

Let's make some demonstration of the CUTEstModel.

```@example ex1
using CUTEst

nlp = CUTEstModel("ROSENBR")
println("x0 = $( nlp.meta.x0 )")
println("fx = $( obj(nlp, nlp.meta.x0) )")
println("gx = $( grad(nlp, nlp.meta.x0) )")
println("Hx = $( hess(nlp, nlp.meta.x0) )")
```

Remember to check the
[API](https://juliasmoothoptimizers.github.io/NLPModels.jl/latest/api)
in case of doubts about these functions.

Notice how `hess` returns a lower triangle matrix.
For decompositions that should be enough.
For iterative solvers, you may want $\nabla^2 f(x) v$ instead, so only the lower
triangle won't do.
But you do have

```@example ex1
v = ones(nlp.meta.nvar)
hprod(nlp, nlp.meta.x0, v)
```

You can also use a
[LinearOperator](https://github.com/JuliaSmoothOptimizers/LinearOperators.jl),

```@example ex1
using LinearOperators
n = nlp.meta.nvar

H = hess_op(nlp, nlp.meta.x0)
H * v
```

This way, you can use a
[Krylov](https://github.com/JuliaSmoothOptimizers/Krylov.jl) method to solve the linear
system with the Hessian as matrix.
For instance, here is an example computation of a Newton trust-region step.

```@example ex1
using Krylov

Delta = 10.0
x = nlp.meta.x0
println("0: x = $x")
for i = 1:5
  print("$i: ")
  H = hess_op(nlp, x)
  d, stats = Krylov.cg(H, -grad(nlp, x), radius=Delta)
  x = x + d
  println("x = $x")
end
```

```@example ex1
cutest_finalize(nlp)
```

There is no difference in calling a constrained problem, only that some
additional functions are available.

```@example ex2
using CUTEst

nlp = CUTEstModel("HS35")
```

```@example ex2
x = nlp.meta.x0

cons(nlp, x)
```

```@example ex2
jac(nlp, x)
```

To find out whether these constraints are equalities or inequalities we can
check `nlp.meta`

```@example ex2
println("Equ  c(x) = 0:         $(nlp.meta.jfix)")
println("Ineq c(x) >= cL:       $(nlp.meta.jlow)")
println("Ineq c(x) <= cU:       $(nlp.meta.jupp)")
println("Ineq cL <= c(x) <= cU: $(nlp.meta.jrng)")
println("lcon = $(nlp.meta.lcon)")
println("ucon = $(nlp.meta.ucon)")
```

```@example ex2
cutest_finalize(nlp)
```
