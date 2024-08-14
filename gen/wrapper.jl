# Script to parse CUTEst headers and generate Julia wrappers.
using CUTEst_jll
using Clang
using Clang.Generators
using JuliaFormatter

function main()

  cd(@__DIR__)
  include_dir = joinpath(CUTEst_jll.artifact_dir, "include")
  headers = map(header -> joinpath(include_dir, header), ["cutest.h"])

  options = load_options(joinpath(@__DIR__, "cutest.toml"))
  options["general"]["output_file_path"] = joinpath("..", "src", "libcutest.jl")
  options["general"]["output_ignorelist"] = ["integer", "real", "doublereal", "logical", "rp_", "rpc_", "ip_", "ipc_"]

  args = get_default_args()
  push!(args, "-I$include_dir")

  ctx = create_context(headers, args, options)
  build!(ctx)

  path = options["general"]["output_file_path"]
  code = read(path, String)
  code = replace(code, "Ptr{integer}" => "Ptr{Cint}")
  code = replace(code, "Ptr{doublereal}" => "Ptr{Float64}")
  code = replace(code, "Ptr{real}" => "Ptr{Float32}")
  code = replace(code, "Ptr{doubleCfloat}" => "Ptr{Float64}")
  code = replace(code, "Ptr{logical}" => "Ptr{Bool}")
  code = replace(code, "Ptr{rp_}" => "Ptr{Float64}")
  code = replace(code, "Ptr{rpc_}" => "Ptr{Float64}")
  code = replace(code, "Ptr{ip_}" => "Ptr{Cint}")
  code = replace(code, "Ptr{ipc_}" => "Ptr{Cint}")
  write(path, code)

  format_file(path, YASStyle())

  return nothing
end

# If we want to use the file as a script with `julia wrapper.jl`
if abspath(PROGRAM_FILE) == @__FILE__
  main()
end
