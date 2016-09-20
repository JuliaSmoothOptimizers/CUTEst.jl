# API

## NLPModels API

```@eval
using NLPModels
using Base.Markdown

s = []
mtds = [obj, grad, grad!, cons, cons!, jac_coord, jac, jprod, jprod!,
  jtprod, jtprod!, hess_coord, hess, hprod, hprod!, NLPtoMPB, reset!]

for i = 1:length(mtds)
  name = split(string(mtds[i]), ".")[2]
  push!(s, md"### $name")
  push!(s, @doc mtds[i])
  sout = []
end

s
```
