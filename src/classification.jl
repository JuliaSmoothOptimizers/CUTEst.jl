import JSON

# Some enumerations and correspondance dicts
# Dict comprehension isn't defined in 0.4 and isn't handled by Compat
# See https://github.com/JuliaLang/Compat.jl/issues/231
const objtypes = ["none", "constant", "linear", "quadratic", "sum_of_squares", "other"]
const classdb_objtype = Dict(
  "N" => objtypes[1],
  "C" => objtypes[2],
  "L" => objtypes[3],
  "Q" => objtypes[4],
  "S" => objtypes[5],
  "O" => objtypes[6],
)

const contypes = ["unc", "fixed_vars", "bounds", "network", "linear", "quadratic", "general"]
const classdb_contype = Dict(
  "U" => contypes[1],
  "X" => contypes[2],
  "B" => contypes[3],
  "N" => contypes[4],
  "L" => contypes[5],
  "Q" => contypes[6],
  "O" => contypes[7],
)

const origins = ["academic", "modelling", "real"]
const classdb_origin = Dict("A" => origins[1], "M" => origins[2], "R" => origins[3])

"""
    select_sif_problems(; min_var=1, max_var=Inf, min_con=0, max_con=Inf,
                          objtype=*, contype=*, only_free_var=false,
                          only_bnd_var=false, only_linear_con=false,
                          only_nonlinear_con=false, only_equ_con=false,
                          only_ineq_con=false, custom_filter=*)

Returns a subset of the CUTEst problems using the classification file `classf.json`.

## Keyword arguments

- `min_var` and `max_var` set the number of variables in the problem;

- `min_con` and `max_con` set the number of constraints in the problem (use `max_con=0` for unconstrained or `min_con=1` for constrained);

- `only_*` flags are self-explaining. Note that they appear in conflicting pairs. Both can be false, but only one can be true.

- `objtype` is the classification of the objective function according to the [MASTSIF classification](https://www.cuter.rl.ac.uk/Problems/classification.shtml). It can be a number, a symbol, a string, or an array of those.
  - `1`, `:none` or `"none"` means there is no objective function;
  - `2`, `:constant` or `"constant"` means the objective function is a constant;
  - `3`, `:linear` or `"linear"` means the objective function is a linear functional;
  - `4`, `:quadratic` or `"quadratic"` means the objective function is quadratic;
  - `5`, `:sum_of_squares` or `"sum_of_squares"` means the objective function is a sum of squares;
  - `6`, `:other` or `"other"` means the objective function is none of the above.

- `contype` is the classification of the constraints according to the same MASTSIF classification file.
  - `1`, `:unc` or `"unc"` means there are no constraints at all;
  - `2`, `:fixed_vars` or `"fixed_vars"` means the only constraints are fixed variables;
  - `3`, `:bounds` or `"bounds"` means the only constraints are bounded variables;
  - `4`, `:network` or `"network"` means the constraints represent the adjacency matrix of a (linear) network;
  - `5`, `:linear` or `"linear"` means the constraints are linear;
  - `6`, `:quadratic` or `"quadratic"` means the constraints are quadratic;
  - `7`, `:other` or `"other"` means the constraints are more general.

- `custom_filter`: A function to apply additional filtering to the problem data. This data is provided as a dictionary with the following fields:
  - `"objtype"`: String representing the objective function type. It can be one of the following:
    - `"none"`, `"constant"`, `"linear"`, `"quadratic"`, `"sum_of_squares"`, `"other"`

  - `"contype"`: String representing the constraint type. It can be one of the following:
    - `"unc"`, `"fixed_vars"`, `"bounds"`, `"network"`, `"linear"`, `"quadratic"`, `"other"`

  - `"regular"`: Boolean indicating whether the problem is regular or not.
    - `"derivative_order"`: Integer representing the order of the highest derivative available.

  - `"origin"`: String indicating the origin of the problem. Possible values are `"academic"`, `"modelling"`, or `"real"`.

  - `"has_interval_var"`: Boolean indicating whether the problem includes interval variables.

  - `"variables"`: Dictionary with fields related to variables:
    - `"can_choose"`: Boolean indicating whether you can change the number of variables via parameters.
    - `"number"`: Integer representing the number of variables (default if `"can_choose"` is true).
    - `"fixed"`: Integer representing the number of fixed variables.
    - `"free"`: Integer representing the number of free variables.
    - `"bounded_below"`: Integer representing the number of variables bounded only from below.
    - `"bounded_above"`: Integer representing the number of variables bounded only from above.
    - `"bounded_both"`: Integer representing the number of variables bounded from both below and above.

  - `"constraints"`: Dictionary with fields related to constraints:
    - `"can_choose"`: Boolean indicating whether you can change the number of constraints via parameters.
    - `"number"`: Integer representing the number of constraints (default if `"can_choose"` is true).
    - `"equality"`: Integer representing the number of equality constraints.
    - `"ineq_below"`: Integer representing the number of inequalities of the form `c(x) ≥ cl`.
    - `"ineq_above"`: Integer representing the number of inequalities of the form `c(x) ≤ cu`.
    - `"ineq_both"`: Integer representing the number of inequalities of the form `cl ≤ c(x) ≤ cu`.
    - `"linear"`: Integer representing the number of linear constraints.
    - `"nonlinear"`: Integer representing the number of nonlinear constraints.

```julia
filtered_problems1 = select_sif_problems(; min_var=10, max_var=100, only_linear_con=true)
filtered_problems2 = select_sif_problems(; max_con=0)
filtered_problems3 = select_sif_problems(; min_con=1)
```
"""
function select_sif_problems(;
  min_var = 1,
  max_var = Inf,
  min_con = 0,
  max_con = Inf,
  objtype = objtypes,
  contype = contypes,
  only_free_var::Bool = false,
  only_bnd_var::Bool = false,
  only_linear_con::Bool = false,
  only_nonlinear_con::Bool = false,
  only_equ_con::Bool = false,
  only_ineq_con::Bool = false,
  custom_filter::Function = x -> true,
)
  # Checks for conflicting option
  @assert !only_free_var || !only_bnd_var
  @assert !only_linear_con || !only_nonlinear_con
  @assert !only_equ_con || !only_ineq_con

  objtype = canonicalize_ftype(objtype, objtypes)
  contype = canonicalize_ftype(contype, contypes)

  if !(objtype ⊆ objtypes)
    error("objtypes $objtype not supported")
  end
  if !(contype ⊆ contypes)
    error("contypes $contype not supported")
  end

  data = JSON.parsefile(joinpath(@__DIR__, "classf.json"))
  problems = keys(data)
  selection = String[]
  for p in problems
    pv = data[p]["variables"]
    pc = data[p]["constraints"]
    nvar, ncon = pv["number"], pc["number"]
    if nvar < min_var ||
       nvar > max_var ||
       ncon < min_con ||
       ncon > max_con ||
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

# Keep an unexported function `select` to not break the tutorial
select(; kwargs...) = select_sif_problems(; kwargs...)

canonicalize_ftype(reqtype::Integer, allowedtypes) = [allowedtypes[reqtype]]
canonicalize_ftype(reqtype::Symbol, allowedtypes) = [string(reqtype)]
canonicalize_ftype(reqtype::AbstractString, allowedtypes) = [reqtype]
canonicalize_ftype(reqtype::AbstractVector{T}, allowedtypes) where {T <: Integer} =
  allowedtypes[reqtype]
canonicalize_ftype(reqtype::AbstractVector{Symbol}, allowedtypes) = map(string, reqtype)
canonicalize_ftype(reqtype, allowedtypes) = reqtype

"""
    build_classification()

Creates the file `classf.json`, running each problem in `CLASSF.DB` and extracting the necessary information.
It should be left alone, unless you think it is not updated.
If you do, please open an issue.
"""
function build_classification()
  classdb = open(readlines, joinpath(ENV["MASTSIF"], "CLASSF.DB"))
  problems = OrderedDict()
  nlp = 0
  for line in classdb
    sline = split(line)
    p = String(sline[1])
    cl = split(sline[2], "")

    print("Problem $p... ")
    try
      nlp = CUTEstModel(p)
      problems[p] = Dict(
        :objtype => classdb_objtype[cl[1]],
        :contype => classdb_contype[cl[2]],
        :regular => cl[3] == "R",
        :derivative_order => Int(cl[4][1] - '0'),
        :origin => classdb_origin[cl[6]],
        :has_internal_var => cl[7] == "Y",
        :variables => Dict(
          :can_choose => sline[3][1] == "V",
          :number => nlp.meta.nvar,
          :fixed => length(nlp.meta.ifix),
          :free => length(nlp.meta.ifree),
          :bounded_below => length(nlp.meta.ilow),
          :bounded_above => length(nlp.meta.iupp),
          :bounded_both => length(nlp.meta.irng),
        ),
        :constraints => Dict(
          :can_choose => sline[4][1] == "V",
          :number => nlp.meta.ncon,
          :equality => length(nlp.meta.jfix),
          :ineq_below => length(nlp.meta.jlow),
          :ineq_above => length(nlp.meta.jupp),
          :ineq_both => length(nlp.meta.jrng),
          :linear => nlp.meta.nlin,
          :nonlinear => nlp.meta.nnln,
        ),
      )
      println("done")
    catch ex
      println("errored: $ex")
    finally
      finalize(nlp)
    end
  end
  open(joinpath(dirname(@__FILE__), "classf.json"), "w") do jsonfile
    JSON.print(jsonfile, problems, 2)
  end
end
