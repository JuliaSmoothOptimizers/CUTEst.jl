`CUTEst.jl` relies on SIF files to create a `CUTEstModel`.
Three sets of SIF files are available on [Bitbucket](https://bitbucket.org/optrove/workspace/repositories/).
We can easily switch between these sets using the function `set_mastsif`.

```@docs
set_mastsif
```

!!! note
    If the environment variable `MASTSIF` is not set, `using CUTEst` will automatically load the set `"sifcollection"`.

To have the list of SIF problems available in the current set, use the function `list_sif_problems`.

```@docs
list_sif_problems
```

Given a problem `name` in the defined set, we need to decode the SIF files, which will generate corresponding Fortran files.

```@docs
sifdecoder
```

Next, we need to compile these Fortran files and create a shared library linked with a CUTEst library for a given precision (single, double, or quadruple).
The CUTEst library provides generic routines to evaluate objectives, constraints, gradients, Jacobians, Hessians, etc.

```@docs
build_libsif
```

!!! note
    When creating a `CUTEstModel`, the functions `sifdecoder` and `build_libsif` are called automatically.

These additional files are generated in the folder `deps/files` at the root of the installation directory of `CUTEst.jl` .
The path to this folder is available via `CUTEst.libsif_path`.
We provide two functions to delete these files:

```@docs
manage_libsif
clear_libsif
```
