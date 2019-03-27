# API

## NLPModels API

```@docs
obj
grad
grad!
cons
cons!
jac_coord
jac_coord!
jac_structure
jac
jprod
jprod!
jtprod
jtprod!
hess_coord
hess_coord!
hess_structure
hess_structure!
hess
hprod
hprod!
```

## Extra Julian API

```@docs
objgrad
objgrad!
objcons
objcons!
cons_coord
cons_coord!
consjac
```

## Select tools

```@autodocs
Modules = [CUTEst]
Pages   = ["classification.jl"]
Order   = [:function]
```

```@docs
CUTEst.create_class
```

## Core API

```@autodocs
Modules = [CUTEst]
Pages   = ["core_interface.jl"]
Order   = [:function]
```

## Internal

```@autodocs
Modules = [CUTEst]
Pages   = ["CUTEst.jl"]
Order   = [:function]
```
