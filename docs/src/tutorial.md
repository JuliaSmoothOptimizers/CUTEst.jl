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

After installing CUTEst, to open problem, write

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
[LinearOperators](https://github.com/JuliaSmoothOptimizers/LinearOperators.jl),

```@example ex1
using LinearOperators
n = nlp.meta.nvar

H = hess_op(nlp, nlp.meta.x0)
H * v
```

This way, you can use
[Krylov](https://github.com/JuliaSmoothOptimizers/Krylov.jl) to solve the linear
system with the Hessian as matrix.
For instance, to show an example of Newton Method with a fixed trust region
during a classroom.

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

## Beware the core Interface

**Disclaimer:** This is here only to prepare for the next interface.

When working with CUTEst, we created a **core** interface, which is essentially
a wrapper for the CUTEst functions.
You probably don't want to use that.

CUTEst in Fortran defines functions called with `cutest_u*` or `cutest_c*`,
for the unconstrained and constrained cases, respectively.
For each of those, we dropped the `cutest_`, so the functions `cutest_ufn` and
`cutest_cfn` are available as `ufn` and `cfn`.
To use then you have to convert the types using `Cint` and `Cdouble`, and
pass arrays because of the underlying pointers in Fortran.
In practice, there isn't much improvement in calling these or `ccall`s.

Only use these functions if you really know what you're doing.

## Specialized Interface

The specialized interface takes the original CUTEst's functions and make them more
Julian.
To explain, let's look at two simple CUTEst functions: `cutest_ufn` and
`cutest_cfn`.

The original `cutest_ufn` function is defined as

```fortran
CALL CUTEST_ufn(status, n, X, f)
```

where

- `status` (output) is an integer signalling whether there was some problem with
  the CUTEst call;
- `n` (input) is number of variables in the problem, i.e., the dimension of `X`;
- `X` (input) is an array with the current estimate of the solution of the problem;
- `f` (output) is the value of the objective function evaluated at `X`.

In Julia, we have

```julia
f = ufn(n, x)
f = ufn(nlp, x)
```

In other words, a simplification of the original function, returning what is
simple to return, and reducing the parameters to only what is needed.
In addition, there is the option of using `nlp` instead of `n`, because `nlp`
includes all this information.

In both cases, the problem would have to be decoded first. Decoding the problem
manually is not advised, as you would have to keep track of the variables,
bounds, sizes, library, and closing the problem yourself.
It can be done through thorough thought, though.

Using `nlp` is better, because we can keep everything inside it.

For `cutest_cfn`, we would have

```fortran
CALL CUTEST_cfn(status, n, m, X, f, C)
```

where

- `status` (output) is an integer signalling whether there was some problem with
  the CUTEst call;
- `n` (input) is number of variables in the problem, i.e., the dimension of `X`;
- `m` (input) is number of constraints in the problem, i.e., the dimension of `C`;
- `X` (input) is an array with the current estimate of the solution of the problem;
- `f` (output) is the value of the objective function evaluated at `X`;
- `C` (output) is the value of the constraints function evaluated at `X`.

In Julia, we have

```julia
f, c = cfn(n, m, x)
f, c = cfn(nlp, x)
f = cfn!(n, m, x, c)
f = cfn!(nlp, x, c)
```

As before, we have a simplification of the original call.
Also, again, we have the use of `nlp` instead of some fixed problem values.
Notice how `nlp` substitutes more than one thing, making it easier to use
because we don't have to remeber what is needed by the function, nor where it
goes.
When present, `nlp` is always the first argument.

In addition, there are two new functions here, obtained by addind a `!` in front
of the function name. These functions modify the vector `c` storing the result
in it. This can be done to save memory, since `c` will not be recreated.
As a convention in Julia, every function that has a `!` in the end modifies some
input.

### Reference Guide

There are a lot of functions in CUTEst. To see them all, you can check the
[Technical Report](https://epubs.stfc.ac.uk/work/65540)
decribing them.

Below is a little guide to search the functions documentation.
**Only some functions are shown.**
Remember that we are looking into problems in the form
\begin{align*}
\min \quad & f(x) \\\\
& c_L \leq c(x) \leq c_U \\\\
& \ell \leq x \leq u,
\end{align*}
with Lagrangian
\begin{align*}
L(x,y) = f(x) + y^Tc(x).
\end{align*}

**Note:** `x` in the beginning of the function name means that both `u` and `c`
versions exist.

| Function             | Specialized Interface Functions |
|----------------------|---------------------------------|
| $f(x)$               | ufn, uofg, cfn, cofg            |
| $\nabla f(x)$        | ugr, uofg, cfn, cofg            |
| $\nabla^2 f(x)$      | udh, ugrdh, ush, ugrsh, uhprod  |
| $c(x)$               | cfn, ccfg, ccfsg, ccifg         |
| $J(x)$               | ccfg, ccfsg, ccifg              |
| $\nabla^2 L(x,y)$    | cdh, cgrdh, csh, cgrsh, chprod  |
| $\nabla^2 (y^Tc(x))$ | chcprod                         |

Examples

```@example spec
using CUTEst

nlp = CUTEstModel("ROSENBR")

x = nlp.meta.x0
fx = ufn(nlp, x)
```

```@example spec
nnzj, hval, hrow, hcol = ush(nlp, x)
```

```@example spec
cutest_finalize(nlp)
nlp = CUTEstModel("HS51")
x = nlp.meta.x0

# Checking documentation, in REPL use ?ccfsg
@doc ccfsg
```

```@example spec
c, nnzj, jval, jvar, jfun = ccfsg(nlp, x, true)
println("c = $c")
println("J = $(sparse(jvar, jfun, jval))")
```

Compare with the NLPModels interface
```@example spec
c = cons(nlp, x)
J = jac(nlp, x)
println("c = $c")
println("J = $J")
```

```@example spec
cutest_finalize(nlp)
```
