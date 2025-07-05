using NLPModels

"""
    generator_sif_problems(; libsif_folder=libsif_path, filter=name -> true)

Return a generator of problem names in the `libsif_folder` satisfying the `filter` predicate.

# Arguments
- `libsif_folder`: Directory to look for SIF files (default: `libsif_path`).
- `filter`: Function to filter problem names (default: include all, `name -> true`).

# Returns
- A generator of problem names (without `.SIF` extension) that satisfy the `filter`.

# Example
```julia
for name in generator_sif_problems()
    println(name)
end
```
"""
function generator_sif_problems(; libsif_folder::AbstractString=libsif_path, filter::Function=name->true)
    return (replace(basename(file), r".SIF$" => "") for file in readdir(libsif_folder, join=true)
    if endswith(file, ".SIF") && filter(replace(basename(file), r".SIF$" => "")))
end