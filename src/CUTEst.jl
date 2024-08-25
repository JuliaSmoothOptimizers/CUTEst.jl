# Using CUTEst from Julia.
module CUTEst

using CUTEst_jll
import SIFDecode_jll
using Pkg.Artifacts
using Libdl
using Quadmath
using NLPModels
import Libdl.dlsym

export CUTEstModel, sifdecoder, build_libsif, set_mastsif

const cutest_problems_path = joinpath(dirname(@__FILE__), "..", "deps", "files")
isdir(cutest_problems_path) || mkpath(cutest_problems_path)

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
    @info "call set_mastsif() to use the full SIF collection"
  end
  @info "using problem repository" ENV["MASTSIF"]

  global libpath = joinpath(CUTEst_jll.artifact_dir, "lib")
  push!(Libdl.DL_LOAD_PATH, cutest_problems_path)
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
