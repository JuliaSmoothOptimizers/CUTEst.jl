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
  options["general"]["output_ignorelist"] =
    ["integer", "real", "doublereal", "logical", "rp_", "rpc_", "ip_", "ipc_"]

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
  code = replace(code, "Ptr{logical}" => "Ptr{Bool}")
  code = replace(code, "Ptr{rp_}" => "Ptr{Float64}")
  code = replace(code, "Ptr{rpc_}" => "Ptr{Float64}")
  code = replace(code, "Ptr{ip_}" => "Ptr{Cint}")
  code = replace(code, "Ptr{ipc_}" => "Ptr{Cint}")

  # errors in cutest.h
  code = replace(code, "cutest_cint_csgrp_" => "cutest_csgrp_")
  code = replace(code, "cutest_cint_csjp_" => "cutest_csjp_")
  code = replace(code, "cutest_cint_csgrshp_" => "cutest_csgrshp_")
  code = replace(code, "cutest_cint_cchprodsp_" => "cutest_cchprodsp_")

  blocks = split(code, "end\n")
  nblocks = length(blocks)
  code = ""
  for (index, block) in enumerate(blocks)
    if contains(block, "function")
      fname = split(split(block, "function ")[2], "(")[1]
      if contains(block, "_s(") || contains(block, "_s_(")
        ptr = "ptr_$(fname) = Libdl.dlsym(cutest_lib_single, :$(fname))"
      elseif contains(block, "_q(") || contains(block, "_q_(")
        ptr = "ptr_$(fname) = Libdl.dlsym(cutest_lib_quadruple, :$(fname))"
      else
        ptr = "ptr_$(fname) = Libdl.dlsym(cutest_lib_double, :$(fname))"
      end
      block = replace(block, "    @ccall libcutest.$fname" => "    $ptr\n    @ccall \$ptr_$(fname)")
    end
    code = code * block
    (index < nblocks) && (code = code * "end\n")
  end

  # Add wrappers of "fortran_open" and "fortran_close" for single and quadruple precisison
  blocks = split(code, "end\n")
  nblocks = length(blocks)
  code = ""
  for (index, block) in enumerate(blocks)
    code = code * block
    (index < nblocks) && (code = code * "end\n")
    for routine in ("fortran_open_", "fortran_close_")
      # add the routines `fortran_open_s_` and `fortran_close_s_`
      if contains(block, routine)
        block_single = block
        block_single = replace(block_single, "double" => "single")
        block_single = replace(block_single, routine => "$(routine)s_")
        block_single = replace(block_single, ":$(routine)s_"  => ":$(routine)")
        code = code * block_single
        (index < nblocks) && (code = code * "end\n")
      end
      # Add the routines `fortran_open_q_` and `fortran_close_q_`
      if contains(block, routine)
        block_quadruple = block
        block_quadruple = replace(block_quadruple, "double" => "quadruple")
        block_quadruple = replace(block_quadruple, routine => "$(routine)q_")
        block_quadruple = replace(block_quadruple, ":$(routine)q_"  => ":$(routine)")
        code = code * block_quadruple
        (index < nblocks) && (code = code * "end\n")
      end
    end
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
