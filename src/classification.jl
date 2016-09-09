import JSON

# Some enumerations and correspondance dicts
const objtypes = ["none", "constant", "linear", "quadratic", "sum_of_squares", "other"]
const classdb_objtype = [x=>objtypes[i] for (i,x) in enumerate("NCLQSO")]

const contypes = ["unc", "fixed_vars", "bounds", "network", "linear", "quadratic", "general"]
const classdb_contype = [x=>contypes[i] for (i,x) in enumerate("UXBNLQO")]

const origins = ["academic", "modelling", "real"]
const classdb_origin = [x=>origins[i] for (i,x) in enumerate("AMR")]

"""`create_class()`

Creates the file `classf.json`, running each problem in `\$MASTSIF/CLASSF.DB` and
extracting the necessary information. It should be left alone, unless you think
it is not updated. If you do, please open an issue at
[https://github.com/JuliaSmoothOptimizers/CUTEst.jl](https://github.com/JuliaSmoothOptimizers/CUTEst.jl)
"""
function create_class()
  classdb = open(readlines, joinpath(ENV["MASTSIF"], "CLASSF.DB"))
  problems = Dict()
  for line in classdb
    sline = split(line)
    p = sline[1]
    cl = sline[2]

    print("Problem $p... ")
    nlp = CUTEstModel(p)
    problems[p] = Dict(
        :objtype          => classdb_objtype[cl[1]],
        :contype          => classdb_contype[cl[2]],
        :regular          => cl[3] == 'R',
        :derivative_order => Int(cl[4]-'0'),
        :origin           => classdb_origin[cl[6]],
        :has_internal_var => cl[7] == 'Y',
        :variables        => Dict(
          :can_choose     => sline[3][1] == 'V',
          :number         => nlp.meta.nvar,
          :fixed          => length(nlp.meta.ifix),
          :free           => length(nlp.meta.ifree),
          :bounded_below  => length(nlp.meta.ilow),
          :bounded_above  => length(nlp.meta.iupp),
          :bounded_both   => length(nlp.meta.irng)
        ),
        :constraints      => Dict(
          :can_choose     => sline[4][1] == 'V',
          :number         => nlp.meta.ncon,
          :equality       => length(nlp.meta.jfix),
          :ineq_below     => length(nlp.meta.jlow),
          :ineq_above     => length(nlp.meta.jupp),
          :ineq_both      => length(nlp.meta.jrng),
          :linear         => nlp.meta.nlin,
          :nonlinear      => nlp.meta.nnln
        )
    )

    cutest_finalize(nlp)
    println("done")
  end
  open(joinpath(dirname(@__FILE__), "classf.json"), "w") do jsonfile
    JSON.print(jsonfile, problems)
  end
end

"""select(;min_var=0, max_var=Inf, min_con=0, max_con=Inf,
    objtype=*, contype=*,
    only_free_var=false, only_bnd_var=false,
    only_linear_con=false, only_nonlinear_con=false,
    only_equ_con=false, only_ineq_con=false,
    custom_filter=*)

Returns a subset of the CUTEst problems using the classification file
`classf.json`. This file is export together with the package, so if you have an
old CUTEst installation, it can lead to inconsistencies.

- `min_var` and `max_var` set the number of variables in the problem;
- `min_con` and `max_con` set the number of constraints in the problem
(e.g., use `max_con=0` for unconstrained or `min_con=1` for constrained)
- `only_*` flags are self-explaining. Note that they appear in conflicting
pairs. Both can be false, but only one can be true.
- `objtype` is the classification of the objective function according to the
[MASTSIF classification file](http://www.cuter.rl.ac.uk//Problems/classification.shtml).
It can be a number, a symbol, a string, or an array of those.

    1, :none or "none" means there is no objective function;
    2, :constant or "constant" means the objective function is a constant;
    3, :linear or "linear" means the objective function is a linear functional;
    4, :quadratic or "quadratic" means the objective function is quadratic;
    5, :sum_of_squares or "sum_of_squares" means the objective function is a sum of squares
    6, :other or "other" means the objective function is none of the above.

- `contype` is the classification of the constraints according to the same
  MASTSIF classification file.

    1, :unc or "unc" means there are no constraints at all;
    2, :fixed_vars or "fixed_vars" means the only constraints are fixed variables;
    3, :bounds or "bounds" means the only constraints are bounded variables;
    4, :network or "network" means the constraints represent the adjacency matrix of a (linear) network;
    5, :linear or "linear" means the constraints are linear;
    6, :quadratic or "quadratic" means the constraints are quadratic;
    7, :other or "other" means the constraints are more general.

- `custom_filter` is a function to be applied to the problem data, which is a
  dict with the following fields:

    "objtype"           - String    one of the above objective function types
    "contype"           - String    one of the above constraint types
    "regular"           - Bool      whether the problem is regular or not
    "derivative_order"  - Int       order of the highest derivative available
    "origin"            - String    origin of the problem: "academic", "modelling" or "real"
    "has_interval_var"  - Bool      whether it has interval variables
    "variables"         - Dict with the following fields
      "can_choose"      - Bool      whether you can change the number of variables via parameters
      "number"          - Int       the number of variables (if `can_choose`, the default)
      "fixed"           - Int       the number of fixed variables
      "free"            - Int       the number of free variables
      "bounded_below"   - Int       the number of variables bounded only from below
      "bounded_above"   - Int       the number of variables bounded only from above
      "bounded_both"    - Int       the number of variables bounded from below and above
    "constraints"       - Dict with the following fields
      "can_choose"      - Bool      whether you can change the number of constraints via parameters
      "number"          - Int       the number of constraints (if `can_choose`, the default)
      "equality"        - Int       the number of equality constraints
      "ineq_below"      - Int       the number of inequalities of the form c(x) ≧ cl
      "ineq_above"      - Int       the number of inequalities of the form c(x) ≦ cu
      "ineq_both"       - Int       the number of inequalities of the form cl ≦ c(x) ≦ cu
      "linear"          - Int       the number of linear constraints
      "nonlinear"       - Int       the number of nonlinear constraints

For instance, if you'd like to choose only problems with fixed number of
  variables, you can pass

    custom_filter=x->x["variables"]["can_choose"]==false
"""
function select(;min_var=0, max_var=Inf, min_con=0, max_con=Inf,
    objtype=objtypes, contype=contypes,
    only_free_var=false, only_bnd_var=false,
    only_linear_con=false, only_nonlinear_con=false,
    only_equ_con=false, only_ineq_con=false,
    custom_filter::Function=x->true)
  # Checks for conflicting option
  @assert !only_free_var || !only_bnd_var
  @assert !only_linear_con || !only_nonlinear_con
  @assert !only_equ_con || !only_ineq_con

  if typeof(objtype) == Int
    objtype = [objtypes[objtype]]
  elseif typeof(objtype) == Symbol
    objtype = [string(objtype)]
  elseif typeof(objtype) <: AbstractString
    objtype = [objtype]
  elseif typeof(objtype) == Vector{Int}
    objtype = objtypes[objtype]
  elseif typeof(objtype) == Vector{Symbol}
    objtype = map(string, objtype)
  end
  if typeof(contype) == Int
    contype = [contypes[contype]]
  elseif typeof(contype) == Symbol
    contype = [string(contype)]
  elseif typeof(contype) <: AbstractString
    contype = [contype]
  elseif typeof(contype) == Vector{Int}
    contype = contypes[contype]
  elseif typeof(contype) == Vector{Symbol}
    contype = map(string, contype)
  end

  @assert objtype ⊆ objtypes
  @assert contype ⊆ contypes

  data = JSON.parsefile(joinpath(dirname(@__FILE__), "classf.json"))
  problems = keys(data)
  selection = []
  for p in problems
    pv = data[p]["variables"]
    pc = data[p]["constraints"]
    nvar, ncon = pv["number"], pc["number"]
    if nvar < min_var || nvar > max_var ||
      ncon < min_con || ncon > max_con ||
      (only_free_var && pv["free"] < nvar) ||
      (only_bnd_var && pv["free"] > 0) ||
      (only_linear_con && pc["linear"] < ncon) ||
      (only_nonlinear_con && pc["linear"] > 0) ||
      (only_equ_con && pc["equality"] < ncon) ||
      (only_ineq_con && pc["equality"] > 0) ||
      !(data[p]["objtype"] in objtype) ||
      !(data[p]["contype"] in contype) ||
      !(custom_filter(data[p]))
      continue
    end
    push!(selection, p)
  end
  return selection
end
