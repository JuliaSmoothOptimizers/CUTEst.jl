# API

## NLPModels API

```@docs
obj
grad
grad!
cons
cons!
jac_coord
jac
jac_op
jac_op!
jprod
jprod!
jtprod
jtprod!
hess_coord
hess
hess_op
hess_op!
hprod
hprod!
NLPModels.NLPtoMPB
NLPModels.reset!
```

## Extra Julian API

```@docs
objgrad
objcons
cons_coord
```

## Select tools

```@autodocs
Modules = [CUTEst]
Pages   = ["classification.jl"]
Order   = [:function]
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
