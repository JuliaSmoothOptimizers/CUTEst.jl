mutable struct CUTEstModel{T} <: AbstractNLPModel{T, Vector{T}}
  meta::NLPModelMeta{T, Vector{T}}
  counters::Counters
  hrows::Vector{Cint}
  hcols::Vector{Cint}

  jrows::Vector{Cint}
  jcols::Vector{Cint}

  blin::Vector{T}
  clinrows::Vector{Cint}
  clincols::Vector{Cint}
  clinvals::Vector{T}

  workspace_nvar::Vector{T}
  workspace_ncon::Vector{T}

  Jval::Vector{T}
  Jvar::Vector{Cint}
end

"""
    nlp = CUTEstModel(name, args...; kwargs...)

Creates a CUTEst model following the NLPModels API.
This model needs to be finalized before a new one is created (e.g., calling `finalize(nlp)`).

## Optional arguments

Any extra arguments will be passed to `sifdecoder`.
You can, for instance, change parameters of the model:

```jldoctest
using CUTEst

nlp = CUTEstModel("CHAIN", "-param", "NH=50")
println(nlp.meta.nnzh)
finalize(nlp)
nlp = CUTEstModel("CHAIN", "-param", "NH=100")
println(nlp.meta.nnzh)
finalize(nlp)

# output

153
303
```

## Keyword arguments

- `decode::Bool = true`: Whether to call sifdecoder.
- `verbose::Bool = false`: Passed to sifdecoder.
- `efirst`::Bool = true`: Equalities first?
- `lfirst`::Bool = true`: Linear (or affine) constraints first?
- `lvfirst::Bool = true`: Nonlinear variables should appear first?
"""
function CUTEstModel(
  name::AbstractString,
  args...;
  decode::Bool = true,
  verbose::Bool = false,
  efirst::Bool = true,
  lfirst::Bool = true,
  lvfirst::Bool = true,
)
  sifname = (length(name) < 4 || name[(end - 3):end] != ".SIF") ? "$name.SIF" : name
  if isfile(sifname)
    # This file is local so make sure the full path is maintained for sifdecoder
    path_sifname = joinpath(pwd(), sifname)
  else
    path_sifname = joinpath(ENV["MASTSIF"], sifname)
    if !isfile(path_sifname)
      error("$name not found")
    end
  end

  pname, sif = basename(name) |> splitext
  outsdif = "OUTSDIF_$(pname)_double.d"
  global cutest_instances_double
  cutest_instances_double > 0 && error("CUTEst: call finalize on current model first")
  global cutest_lib_double
  cd(cutest_problems_path) do
    if !decode
      isfile(outsdif) || error("CUTEst: no decoded problem found")
      libsif = "lib$(pname)_double"
      isfile("$libsif.$(Libdl.dlext)") || error("CUTEst: lib not found; decode problem first")
      cutest_lib_double =
        Libdl.dlopen(libsif, Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
    else
      sifdecoder(path_sifname, args..., verbose = verbose, outsdif = outsdif, precision = :double)
      build_libsif(path_sifname, precision = :double)
    end
    status = Ref{Cint}(0)
    fopen(Float64, Ref{Cint}(funit), outsdif, status)
    cutest_error(status[])
  end

  # Obtain problem size.
  status = Ref{Cint}(0)
  nvar = Ref{Cint}(0)
  ncon = Ref{Cint}(0)

  cdimen(Float64, status, Ref{Cint}(funit), nvar, ncon)
  cutest_error(status[])

  x = Vector{Float64}(undef, nvar[])
  bl = Vector{Float64}(undef, nvar[])
  bu = Vector{Float64}(undef, nvar[])
  v = Vector{Float64}(undef, ncon[])
  cl = Vector{Float64}(undef, ncon[])
  cu = Vector{Float64}(undef, ncon[])
  equatn = Vector{Bool}(undef, ncon[])
  linear = Vector{Bool}(undef, ncon[])

  if ncon[] > 0
    e_order = efirst ? Ref{Cint}(1) : Ref{Cint}(0)
    l_order = lfirst ? Ref{Cint}(1) : Ref{Cint}(0)
    v_order = lvfirst ? Ref{Cint}(1) : Ref{Cint}(0)
    # Equality constraints first, linear constraints first, nonlinear variables first.
    csetup(
      Float64,
      status,
      Ref{Cint}(funit),
      Ref{Cint}(0),
      Ref{Cint}(6),
      nvar,
      ncon,
      x,
      bl,
      bu,
      v,
      cl,
      cu,
      equatn,
      linear,
      e_order,
      l_order,
      v_order,
    )
  else
    usetup(Float64, status, Ref{Cint}(funit), Ref{Cint}(0), Ref{Cint}(6), nvar, x, bl, bu)
  end
  cutest_error(status[])

  for lim in Any[bl, bu, cl, cu]
    I = findall(abs.(lim) .>= 1e20)
    lim[I] = Inf * lim[I]
  end

  lin = findall(linear .!= 0)
  nlin = length(lin)

  nnzh = Ref{Cint}(0)
  nnzj = Ref{Cint}(0)

  if ncon[] > 0
    cdimsh(Float64, status, nnzh)
    cdimsj(Float64, status, nnzj)
    nnzj[] -= nvar[]  # nnzj also counts the nonzeros in the objective gradient.
  else
    udimsh(Float64, status, nnzh)
  end
  cutest_error(status[])

  # Sparsity pattern of the hessian
  hrows = Vector{Cint}(undef, nnzh[])
  hcols = Vector{Cint}(undef, nnzh[])
  this_nnzh = Ref{Cint}(0)
  if ncon[] > 0
    cshp(Float64, status, nvar, this_nnzh, nnzh, hcols, hrows)
  else
    ushp(Float64, status, nvar, this_nnzh, nnzh, hcols, hrows)
  end
  cutest_error(status[])

  # sparsity pattern of the jacobian
  jrows = Vector{Cint}(undef, nnzj[])
  jcols = Vector{Cint}(undef, nnzj[])
  this_nnzj = Ref{Cint}(0)
  csjp(Float64, status, this_nnzj, nnzj, jcols, jrows)
  cutest_error(status[])

  # compute lin_nnzj and nln_nnzj
  lin_nnzj = 0
  for row in jrows
    if linear[row]
      lin_nnzj += 1
    end
  end
  nln_nnzj = nnzj[] - lin_nnzj

  blin = Vector{Float64}(undef, nlin)
  clinrows = Vector{Cint}(undef, lin_nnzj)
  clincols = Vector{Cint}(undef, lin_nnzj)
  clinvals = Vector{Float64}(undef, lin_nnzj)
  Jval = Vector{Cdouble}(undef, nvar[])
  Jvar = Vector{Cint}(undef, nvar[])

  # sparsity pattern of the linear constraints
  i = 0
  nnzj_tmp = Ref{Cint}(nnzj[])
  x0 = Vector{Float64}(undef, nvar[])
  for j in lin
    x0 .= 0.0
    ccifsg(
      Float64,
      Ref{Cint}(0),
      nvar,
      Ref{Cint}(j),
      x0,
      view(blin, j:j),
      nnzj_tmp,
      nvar,
      Jval,
      Jvar,
      Ref{Bool}(true),
    )
    for k = 1:nvar[]
      if Jval[k] != 0.0
        i += 1
        clinrows[i] = j
        clincols[i] = Jvar[k]
        clinvals[i] = Jval[k]
      end
    end
  end

  # Remove references
  nvar = nvar[] |> Int
  ncon = ncon[] |> Int
  nnzj = nnzj[] |> Int
  nnzh = nnzh[] |> Int

  workspace_nvar = Vector{Float64}(undef, nvar)
  workspace_ncon = Vector{Float64}(undef, ncon)

  fclose(Float64, Ref{Cint}(funit), status)
  cutest_error(status[])

  meta = NLPModelMeta(
    nvar,
    x0 = x,
    lvar = bl,
    uvar = bu,
    ncon = ncon,
    y0 = v,
    lcon = cl,
    ucon = cu,
    nnzj = nnzj,
    nnzh = nnzh,
    lin = lin,
    lin_nnzj = lin_nnzj,
    nln_nnzj = nln_nnzj,
    name = splitext(name)[1],
  )

  nlp = CUTEstModel{Float64}(
    meta,
    Counters(),
    hrows,
    hcols,
    jrows,
    jcols,
    blin,
    clinrows,
    clincols,
    clinvals,
    workspace_nvar,
    workspace_ncon,
    Jval,
    Jvar,
  )

  cutest_instances_double += 1
  finalizer(cutest_finalize, nlp)

  return nlp
end

function cutest_finalize(nlp::CUTEstModel{Float64})
  global cutest_instances_double
  cutest_instances_double == 0 && return
  global cutest_lib_double
  status = Ref{Cint}(0)
  if nlp.meta.ncon > 0
    cterminate(Float64, status)
  else
    uterminate(Float64, status)
  end
  cutest_error(status[])
  Libdl.dlclose(cutest_lib_double)
  cutest_instances_double -= 1
  cutest_lib_double = C_NULL
  return
end

struct CUTEstException <: Exception
  info::Cint
  msg::String

  function CUTEstException(info::Cint)
    if info == 1
      msg = "memory allocation error"
    elseif info == 2
      msg = "array bound error"
    elseif info == 3
      msg = "evaluation error"
    else
      msg = "unknown error"
    end
    return new(info, msg)
  end
end

CUTEstException(info::Integer) = CUTEstException(info |> Cint)

function cutest_error(status::Cint)  # Handle nonzero exit codes.
  (status > 0) && throw(CUTEstException(status))
end

# Displaying CUTEstModel instances.

import Base.show, Base.print
function show(io::IO, nlp::CUTEstModel)
  show(io, nlp.meta)
end

function print(io::IO, nlp::CUTEstModel)
  print(io, nlp.meta)
end
