# Script to parse CUTEst headers and generate Julia wrappers.
using CUTEst_jll
using Clang
using Clang.Generators
using JuliaFormatter

# Support for quadruple precision
struct JuliaCfloat128 <: Clang.Generators.AbstractJuliaSIT end
Clang.Generators.tojulia(x::CLFloat128) = JuliaCfloat128()
Clang.Generators.translate(jlty::JuliaCfloat128, options=Dict()) = :Float128

function main()
  cd(@__DIR__)
  include_dir = joinpath(CUTEst_jll.artifact_dir, "include")
  headers = map(header -> joinpath(include_dir, header), ["cutest.h"])

  options = load_options(joinpath(@__DIR__, "cutest.toml"))
  options["general"]["output_file_path"] = joinpath("..", "src", "libcutest.jl")
  options["general"]["output_ignorelist"] = [
    "integer",
    "real",
    "doublereal",
    "quadreal",
    "logical",
    "rp_",
    "rpc_",
    "ip_",
    "ipc_",
    "CUTEst_malloc",
    "CUTEst_calloc",
    "CUTEst_realloc",
    "CUTEst_free",
    "VarTypes",
  ]

  args = get_default_args()
  push!(args, "-I$include_dir")
  push!(args, "-DREAL_128")

  ctx = create_context(headers, args, options)
  build!(ctx)

  path = options["general"]["output_file_path"]
  code = read(path, String)
  code = replace(code, "Ptr{integer}" => "Ptr{Cint}")
  code = replace(code, "Ptr{doublereal}" => "Ptr{Float64}")
  code = replace(code, "Ptr{real}" => "Ptr{Float32}")
  code = replace(code, "Ptr{doubleCfloat}" => "Ptr{Float64}")
  code = replace(code, "Ptr{quadreal}" => "Ptr{Float128}")
  code = replace(code, "Ptr{logical}" => "Ptr{Bool}")
  code = replace(code, "Ptr{rp_}" => "Ptr{Float64}")
  code = replace(code, "Ptr{rpc_}" => "Ptr{Float64}")
  code = replace(code, "Ptr{ip_}" => "Ptr{Cint}")
  code = replace(code, "Ptr{ipc_}" => "Ptr{Cint}")
  for routine in ("classification", "probname", "pname", "varnames", "connames", "unames", "cnames")
    code = replace(code, "cutest_cint_$routine" => "cutest_$routine")
  end

  blocks = split(code, "end\n")
  nblocks = length(blocks)
  code = ""
  for (index, block) in enumerate(blocks)
    if contains(block, "function")
      fname = split(split(block, "function ")[2], "(")[1]
      block = replace(block, "function $fname(" => "function $fname(libsif, ")
      ptr = "ptr_$(fname) = Libdl.dlsym(libsif, :$(fname))"
      block = replace(block, "    @ccall libcutest.$fname" => "    $ptr\n    @ccall \$ptr_$(fname)")
    end
    code = code * block
    (index < nblocks) && (code = code * "end\n")
  end

  write(path, code)
  format_file(path, YASStyle())

  code = read(path, String)
  code = "#! format: off\n" * code * "#! format: on\n"
  write(path, code)

  return nothing
end

# If we want to use the file as a script with `julia wrapper.jl`
if abspath(PROGRAM_FILE) == @__FILE__
  main()
end
