# Working with CUTEst directly

When working with CUTEst, we created a **core** interface, which is essentially
a wrapper for the CUTEst functions.
You probably don't want to use that, because the NLPModels interface is much
more friendlier, as just as useful. See its [tutorial](tutorial).

CUTEst in Fortran defines functions called with `cutest_u*` or `cutest_c*`,
for the unconstrained and constrained cases, respectively.
For each of those, we dropped the `cutest_`, so the functions `cutest_ufn` and
`cutest_cfn` are available as `ufn` and `cfn`.
To use then you have to convert the types using `Cint` and `Cdouble`, and
pass arrays because of the underlying pointers in Fortran.
In practice, there isn't much improvement in calling these or `ccall`s.

**Only use these functions if you really know what you're doing.**

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
