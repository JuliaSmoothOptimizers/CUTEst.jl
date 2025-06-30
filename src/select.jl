module CUTEstSelection

export select, select_generator
using Glob

"""
    select(; sifdir=nothing, filter=name -> true)

Return a **vector** of CUTEst problem names matching an optional filter.

# Arguments
- `sifdir::AbstractString`: Directory where SIF files are located.
  Defaults to `ENV["SIFDIR"]` if not provided.
- `filter::Function`: Predicate applied to each problem name (without `.SIF`).
  By default includes all names.

# Returns
- `Vector{String}`: Sorted list of problem names matching the filter.
"""
function select(; sifdir::Union{Nothing,AbstractString}=nothing, filter::Function = name -> true)
    sifdir = sifdir === nothing ? get(ENV, "SIFDIR", "") : sifdir
    isempty(sifdir) && error("SIF directory not specified and ENV[\"SIFDIR\"] is empty.")

    files = Glob.glob("*.SIF", sifdir)
    names = sort(basename(f)[1:end-4] for f in files)  # strip .SIF extension
    return filter(filter, names)
end

"""
    select_generator(; sifdir=nothing, filter=name -> true)

Return a **lazy generator expression** over CUTEst problem names matching an optional filter.

# Arguments
- `sifdir::AbstractString`: Directory where SIF files are located.
  Defaults to `ENV["SIFDIR"]` if not provided.
- `filter::Function`: Predicate applied to each problem name (without `.SIF`).

# Returns
- `Base.Generator`: Generator of problem names matching the filter.
"""
function select_generator(; sifdir::Union{Nothing,AbstractString}=nothing, filter::Function = name -> true)
    sifdir = sifdir === nothing ? get(ENV, "SIFDIR", "") : sifdir
    isempty(sifdir) && error("SIF directory not specified and ENV[\"SIFDIR\"] is empty.")

    files = sort(Glob.glob("*.SIF", sifdir))
    return (name for name in (basename(f)[1:end-4] for f in files) if filter(name))
end
end # module
