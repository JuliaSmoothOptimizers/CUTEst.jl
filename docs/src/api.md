# API

## NLPModels API

CUTEst accepts the API of [NLPModels](https://juliasmoothoptimizers.github.io/NLPModels.jl/).

## Additional NLPModels-like API

```@docs
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
