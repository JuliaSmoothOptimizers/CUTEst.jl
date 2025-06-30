import JSON
using NLPModels

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

### Keyword arguments

- `min_var` and `max_var`: set lower and upper bounds on the number of variables.

- `min_con` and `max_con`: set lower and upper bounds on the number of **linear or nonlinear constraints** (excluding simple bounds on variables).  
  ⚠ `max_con=0` means: keep only problems with *no nonlinear or linear constraints*;  
  **variable bounds are *not* counted as constraints** here, so bound-constrained problems will still be included.

- `only_*` flags: mutually exclusive filters to select problems with only:
  - free variables (`only_free_var=true`)
  - bounded variables (`only_bnd_var=true`)
  - linear constraints (`only_linear_con=true`)
  - nonlinear constraints (`only_nonlinear_con=true`)
  - equality constraints (`only_equ_con=true`)
  - inequality constraints (`only_ineq_con=true`)
  
  These can all be false, but at most one can be true.

- `objtype`: filter by type of objective function, following the [MASTSIF classification](https://ralna.github.io/SIFDecode/html/classification/).  
  Accepts a number, symbol, string, or an array of these:
  - `1`, `:none` or `"none"`: no objective function
  - `2`, `:constant` or `"constant"`
  - `3`, `:linear` or `"linear"`
  - `4`, `:quadratic` or `"quadratic"`
  - `5`, `:sum_of_squares` or `"sum_of_squares"`
  - `6`, `:other` or `"other"`

- `contype`: filter by type of constraints, also from MASTSIF:
  - `1`, `:unc` or `"unc"`: **truly unconstrained** — no linear/nonlinear constraints and no variable bounds
  - `2`, `:fixed_vars` or `"fixed_vars"`: only fixed variables
  - `3`, `:bounds` or `"bounds"`: only variable bounds
  - `4`, `:network` or `"network"`
  - `5`, `:linear` or `"linear"`: linear constraints
  - `6`, `:quadratic` or `"quadratic"`
  - `7`, `:other` or `"other"`

⚠ **Important difference**:
- `max_con=0` keeps problems that may still have variable bounds (i.e., bound-constrained).
- `contype="unc"` keeps *only* problems that have no constraints at all (no nonlinear constraints, no linear constraints, and no bounds).

If you want to filter by truly unconstrained problems *after* selection, use:
```julia
filter(p -> is_truly_unconstrained(p), select_sif_problems())

    custom_filter: a function for additional filtering. Receives a dictionary with metadata, for example:

        "objtype": "none", "constant", "linear", "quadratic", "sum_of_squares", "other"

        "contype": "unc", "fixed_vars", "bounds", "network", "linear", "quadratic", "other"

        "regular": Bool

        "derivative_order": Int

        "origin": "academic", "modelling", "real"

        "has_interval_var": Bool

        "variables": number and types of variables ("number", "fixed", "free", etc.)

        "constraints": number and types of constraints ("number", "linear", "nonlinear", etc.)

Examples

# Problems with 10–100 variables and only linear constraints
filtered1 = select_sif_problems(; min_var=10, max_var=100, only_linear_con=true)

# Problems without nonlinear or linear constraints (may still have bounds)
filtered2 = select_sif_problems(; max_con=0)

# Problems that are truly unconstrained: no constraints and no variable bounds
filtered3 = filter(is_truly_unconstrained, select_sif_problems())

# Problems with at least one constraint
filtered4 = select_sif_problems(; min_con=1)

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

"""
    list_sif_problems(; sifdir=nothing, filter=name -> true)

Return a sorted `Vector{String}` of CUTEst problem names found in the directory `sifdir`
(without `.SIF` extension).  
By default, looks in `ENV["SIFDIR"]` and keeps all names.

## Keyword arguments
- `sifdir::AbstractString`: Directory where `.SIF` files are stored.
- `filter::Function`: Predicate applied to each problem name.

## Example
```julia
list_sif_problems()
list_sif_problems(; filter=name -> startswith(name, "A"))
```
"""
function list_sif_problems(; sifdir::Union{Nothing,AbstractString}=nothing, filter::Function = name -> true)
  sifdir = sifdir === nothing ? get(ENV, "SIFDIR", "") : sifdir
  isempty(sifdir) && error("SIF directory not specified and ENV["SIFDIR"] is empty.")
  
  files = readdir(sifdir)
  sif_files = sort(f[1:end-4] for f in files if endswith(f, ".SIF") && filter(f[1:end-4]))
  return sif_files
end

"""
    sif_problem_generator(; sifdir=nothing, filter=name -> true)

Return a lazy generator over CUTEst problem names (without `.SIF` extension) matching the optional filter.

## Example
```julia
for name in sif_problem_generator()
    println(name)
end
```
"""
function sif_problem_generator(; sifdir::Union{Nothing,AbstractString}=nothing, filter::Function = name -> true)
  sifdir = sifdir === nothing ? get(ENV, "SIFDIR", "") : sifdir
  isempty(sifdir) && error("SIF directory not specified and ENV["SIFDIR"] is empty.")
  
  files = readdir(sifdir)
  return (f[1:end-4] for f in sort(files) if endswith(f, ".SIF") && filter(f[1:end-4]))
end
