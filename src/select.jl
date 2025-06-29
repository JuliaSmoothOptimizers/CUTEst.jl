module CUTEstSelection

export select, select_generator
using Glob
using Printf

"""
    select(; sifdir=nothing, filter=identity)

Return a list of CUTEst problem names matching the optional filtering criteria.

## Arguments
- `sifdir::AbstractString`: Directory where SIF files are located. Defaults to `ENV["SIFDIR"]` if not provided.
- `filter::Function`: A predicate function that takes a problem name and returns a boolean. Defaults to `identity`.

## Returns
- `Vector{String}`: List of problem names matching the filter.

## Example
```julia
problems = select(sifdir="/path/to/sif", filter=name -> startswith(name, "A"))
```
"""
function select(; sifdir::Union{Nothing,AbstractString}=nothing, filter::Function=identity)
sifdir = sifdir === nothing ? get(ENV, "SIFDIR", "") : sifdir
isempty(sifdir) && error("SIF directory not specified and ENV\["SIFDIR"] is empty.")

files = Glob.glob("*.SIF", sifdir)
names = sort([basename(f)[1:end-4] for f in files])  # Strip .SIF
return filter.(names)
end

"""
    select\_generator(; sifdir=nothing, filter=identity)

Return a lazy generator expression over CUTEst problem names matching the optional filter.

## Arguments

* `sifdir::AbstractString`: Directory where SIF files are located. Defaults to `ENV["SIFDIR"]` if not provided.
* `filter::Function`: A predicate function that takes a problem name and returns a boolean. Defaults to `identity`.

## Returns

* `Base.Generator`: A generator of problem names matching the filter.

## Example
```julia
for name in select_generator(sifdir="/path/to/sif", filter=name -> endswith(name, "A"))
    model = CUTEstModel(name)
    # use model
end
```
"""

function select\_generator(; sifdir::Union{Nothing,AbstractString}=nothing, filter::Function=identity)
sifdir = sifdir === nothing ? get(ENV, "SIFDIR", "") : sifdir
isempty(sifdir) && error("SIF directory not specified and ENV\["SIFDIR"] is empty.")

files = Glob.glob("*.SIF", sifdir)
return (basename(f)[1:end-4] for f in sort(files) if filter(basename(f)[1:end-4]))

end
end
