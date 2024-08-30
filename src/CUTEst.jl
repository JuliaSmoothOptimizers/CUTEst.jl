# Using CUTEst from Julia.
module CUTEst

using CUTEst_jll
import SIFDecode_jll
using Pkg.Artifacts
using Libdl
using Quadmath
using NLPModels
using JSON

import Libdl.dlsym
import REPL.TerminalMenus
import Base.format_bytes
import Printf.@sprintf
import DataStructures: OrderedDict

export CUTEstModel,
  sifdecoder,
  build_libsif,
  set_mastsif,
  clear_libsif,
  manage_libsif,
  list_sif_problems,
  select_sif_problems

const cutest_false = Ref{Bool}(false)
const cutest_true = Ref{Bool}(true)
const libsif_path = joinpath(@__DIR__, "..", "deps", "files") |> normpath
isdir(libsif_path) || mkpath(libsif_path)

function __init__()
  if !Sys.iswindows()
    # gfortran is installed with an artifact on Windows
    if !success(`bash -c "type gfortran"`)
      error("gfortran is not installed. Please install it and try again.")
    end
  end

  # set default MASTSIF location if the user hasn't set it already
  if !haskey(ENV, "MASTSIF")
    set_mastsif()
  else
    @info "Using local problem directory: $(ENV["MASTSIF"])"
    @info "Call set_mastsif() if you want to use the full SIF collection."
  end

  global libcutest_path = joinpath(CUTEst_jll.artifact_dir, "lib")
  push!(Libdl.DL_LOAD_PATH, libsif_path)
end

# to allow view inputs with stride one
StrideOneVector{T} = Union{
  Ref{T},
  Vector{T},
  SubArray{T, 1, Vector{T}, Tuple{UnitRange{U}}, true} where {U <: Integer},
}

include("libcutest.jl")
include("model.jl")
include("sifdecoder.jl")
include("core_interface.jl")
include("julia_interface.jl")
include("classification.jl")

end  # module CUTEst.
