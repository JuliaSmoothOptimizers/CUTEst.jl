# Tutorial

CUTEst can be accessed in two ways.
- The first, easiest, and recommended for most users, is using the
  [NLPModels.jl](https://github.com/JuliaSmoothOptimizers/NLPModels.jl).
  This is recommended because if you develop something for this an `NLPModel`,
  then it can work with CUTEst, but also with other models.
- The second is the core interface, which is just a wrapper of the Fortran
  functions, and is not recommended unless you really need and know what you're
  doing.

## NLPModels interface

NLPModels defines an abstract interface to access the objective, constraints,
derivatives, etc. of the problem. A
[reference guide](https://juliasmoothoptimizers.github.io/NLPModels.jl/latest/api/)
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
finalize(nlp)
```

Being a NLPModel means that everything created for an AbstractNLPModel will work
for CUTEstModel. For instance,
[JSOSolvers.jl](https://github.com/JuliaSmoothOptimizers/JSOSolvers.jl)
has implementations of optimization methods for AbstractNLPModels.

Let's make some demonstration of the CUTEstModel.

```@example ex1
using CUTEst, NLPModels

nlp = CUTEstModel("ROSENBR")
println("x0 = $( nlp.meta.x0 )")
println("fx = $( obj(nlp, nlp.meta.x0) )")
println("gx = $( grad(nlp, nlp.meta.x0) )")
println("Hx = $( hess(nlp, nlp.meta.x0) )")
```

Remember to check the
[API](https://juliasmoothoptimizers.github.io/NLPModels.jl/latest/api/)
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
H = hess_op(nlp, nlp.meta.x0)
H * v
```

This way, you can use a
[Krylov](https://github.com/JuliaSmoothOptimizers/Krylov.jl) method to solve the linear
system with the Hessian as matrix.
For instance, here is an example computation of a Newton trust-region step.

```@example ex1
using Krylov

function newton()
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
end
```

```@example ex1
finalize(nlp)
```

There is no difference in calling a constrained problem, only that some
additional functions are available.

```@example ex2
using CUTEst, NLPModels

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
print(nlp.meta)
```

```@example ex2
finalize(nlp)
```

## Selection tool

CUTEst comes with a simple selection tool. It uses a static file generated from
the original `CLASSF.DB` and an execution of each problem.

The selection tool works like a filter on the complete set of problems. Using
the tool without arguments will return the complete set of problems.

```@example exs
using CUTEst # hide
problems = CUTEst.select()
length(problems)
```

The list of keyword arguments to filter the problems is given below, with their
default value.

| argument  | default | description |
|-----------|---------|-------------|
| `min_var` | `0`     | Minimum number of variables |
| `max_var` | `Inf`   | Maximum number of variables |
| `min_con` | `0`     | Minimum number of constraints (not bounds) |
| `max_con` | `Inf`   | Maximum number of constraints |
| `objtype` | *all types* | Type of the objective function. See below. |
| `contype` | *all types* | Type of the constraints. See below. |
| `only_free_var` | `false` | Whether to exclude problems with bounded variables. |
| `only_bnd_var` | `false` | Whether to exclude problem with any free variables. |
| `only_linear_con` | `false` | Whether to exclude problems with nonlinear constraints. |
| `only_nonlinear_con` | `false` | Whether to exclude problems with any linear constraints. |
| `only_equ_con` | `false` | Whether to exclude problems with inequality constraints |
| `only_ineq_con` | `false` | Whether to exclude problems with equality constraints |
| `custom_filter` | nothing | A custom filter to be applied to the entries. This requires knowledge of the inner structure, and is present only because we haven't implemented every useful combination yet. *We welcome pull-requests with implementations of additional queries.* |


| `objtype` | description |
|-----------|-------------|
| "none" or "N" | There is no objective function. |
| "constants" or "C" | The objective function is constant. |
| "linear" or "L" | The objective function is linear. |
| "quadratic" or "Q" | The objective function is quadratic. |
| "sum_of_squares" or "S" | The objective function is a sum of squares. |
| "other" or "O" | The objective function is none of the above. |


| `contype` | description |
|-----------|-------------|
| "unc" or "U" | There are no constraints nor bounds on the variables. |
| "fixed_vars" or "X" | The only constraints are fixed variables. |
| "bounds" or "B" | The only constraints are bounds on the variables. |
| "network" or "N" | The constraints represent the adjacency matrix of a linear network. |
| "linear" or "L" | The constraints are linear. |
| "quadratic" or "Q" | The constraints are quadratic. |
| "other" or "O" | The constraints are more general than any of the above. |

The selection tool is not as complete as we would like. Some combinations are
still hard to create. Below we create some of the simpler ones.

### Unconstrained problems

No constraints and no bounds. There are two options:

```@example exs
problems = CUTEst.select(max_con=0, only_free_var=true)
length(problems)
```

```@example exs
problems = CUTEst.select(contype="unc")
length(problems)
```

### Equality/Inequality constrainted problems with unbounded variables

```@example exs
problems = CUTEst.select(min_con=1, only_equ_con=true, only_free_var=true)
length(problems)
```

```@example exs
problems = CUTEst.select(min_con=1, only_ineq_con=true, only_free_var=true)
length(problems)
```

### Size range

```@example exs
problems = CUTEst.select(min_var=1000, max_var=2000, min_con=100, max_con=500)
length(problems)
```

### Sum-of-squares problems with bounds

```@example exs
problems = CUTEst.select(objtype="sum_of_squares", contype="bounds")
length(problems)
```

### Quadratic programming with linear constraints.

```@example exs
problems = CUTEst.select(objtype="quadratic", contype="linear")
length(problems)
```
