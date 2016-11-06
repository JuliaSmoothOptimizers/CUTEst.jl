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
jprod
jprod!
jtprod
jtprod!
hess_coord
hess
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

## Core and specialized API

```@autodocs
Modules = [CUTEst]
Pages   = ["core_interface.jl", "specialized_interface.jl"]
Order   = [:function]
```

## Internal

```@autodocs
Modules = [CUTEst]
Pages   = ["CUTEst.jl"]
Order   = [:function]
```
