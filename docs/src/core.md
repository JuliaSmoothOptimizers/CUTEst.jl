# Working with CUTEst directly

When working with CUTEst, we created a **core** interface, which is essentially
a wrapper for the CUTEst functions.
You probably don't want to use that, because the NLPModels interface is much
more friendlier, as just as useful. See its tutorial.

CUTEst in Fortran defines functions called with `cutest_u*` or `cutest_c*`,
for the unconstrained and constrained cases, respectively.
For each of those, we dropped the `cutest_`, so the functions `cutest_ufn` and
`cutest_cfn` are available as `ufn` and `cfn`.
To use then you have to convert the types using `Cint` and `Cdouble`, and
pass arrays because of the underlying pointers in Fortran.
In practice, there isn't much improvement in calling these or `ccall`s, except
for the use of the internal `cutest_lib_double`.

**Only use these functions if you really know what you're doing.**

If you want to use these functions, you should still decode the problem as an
NLP, by doing
```julia
nlp = CUTEstModel("PROBLEM")
...
finalize(nlp)
```
Otherwise you'll have to manage the CUTEst library, the decoding, the
file unit numbers, `OUTSDIF.d`, `setup`, etc.
