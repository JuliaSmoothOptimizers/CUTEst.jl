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

  libsif::Ptr{Cvoid}
  funit::Ref{Cint}
  nvar::Ref{Cint}
  ncon::Ref{Cint}
  nnzj::Ref{Cint}
  nnzh::Ref{Cint}
  f::Ref{T}
  status::Ref{Cint}
end

"""
    nlp = CUTEstModel{T}(name, args...; kwargs...)
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

- `precision::Symbol = :double` : Precision of the CUTEstModel.
- `decode::Bool = true`: Whether to call sifdecoder.
- `verbose::Bool = false`: Passed to sifdecoder.
- `efirst`::Bool = true`: Equalities first?
- `lfirst`::Bool = true`: Linear (or affine) constraints first?
- `lvfirst::Bool = true`: Nonlinear variables should appear first?

The keyword `precision` is not supported when a constructor with a data type `T` is used.
The type `T` can be `Float32`, `Float64`, or `Float128`.
"""
function CUTEstModel end

for (T, prec) in ((:Float32, "single"), (:Float64, "double"), (:Float128, "quadruple"))
  @eval begin
    function CUTEstModel{$T}(
      name::AbstractString,
      args...;
      decode::Bool = true,
      verbose::Bool = false,
      efirst::Bool = true,
      lfirst::Bool = true,
      lvfirst::Bool = true,
    )
      precision = Symbol($prec)
      CUTEstModel(name, args...; precision, decode, verbose, efirst, lfirst, lvfirst)
    end
  end
end

function CUTEstModel(
  name::AbstractString,
  args...;
  precision::Symbol = :double,
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

  if (precision != :single) && (precision != :double) && (precision != :quadruple)
    error("The $precision precision is not supported.")
  end

  pname, sif = basename(name) |> splitext
  outsdif = "OUTSDIF_$(pname)_$precision.d"
  T = (precision == :single) ? Float32 : (precision == :double) ? Float64 : Float128
  libsif = C_NULL

  funit = rand(1000:10000) |> Ref{Cint}
  status = Ref{Cint}(0)

  cd(cutest_problems_path) do
    if !decode
      isfile(outsdif) || error("CUTEst: no decoded problem found")
      libsif_name = "lib$(pname)_$(precision)"
      isfile("$(libsif_name).$dlext") || error("CUTEst: lib not found; decode problem first")
      libsif = Libdl.dlopen(libsif_name, Libdl.RTLD_NOW | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL)
    else
      sifdecoder(path_sifname, args..., verbose = verbose, outsdif = outsdif, precision = precision)
      libsif = build_libsif(path_sifname, precision = precision)
    end
    fopen(T, libsif, funit, outsdif, status)
    cutest_error(status[])
  end

  # Obtain problem size.
  nvar = Ref{Cint}(0)
  ncon = Ref{Cint}(0)

  cdimen(T, libsif, status, funit, nvar, ncon)
  cutest_error(status[])

  x = Vector{T}(undef, nvar[])
  bl = Vector{T}(undef, nvar[])
  bu = Vector{T}(undef, nvar[])
  v = Vector{T}(undef, ncon[])
  cl = Vector{T}(undef, ncon[])
  cu = Vector{T}(undef, ncon[])
  equatn = Vector{Bool}(undef, ncon[])
  linear = Vector{Bool}(undef, ncon[])

  if ncon[] > 0
    e_order = efirst ? Ref{Cint}(1) : Ref{Cint}(0)
    l_order = lfirst ? Ref{Cint}(1) : Ref{Cint}(0)
    v_order = lvfirst ? Ref{Cint}(1) : Ref{Cint}(0)
    # Equality constraints first, linear constraints first, nonlinear variables first.
    csetup(
      T,
      libsif,
      status,
      funit,
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
    usetup(T, libsif, status, funit, Ref{Cint}(0), Ref{Cint}(6), nvar, x, bl, bu)
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
    cdimsh(T, libsif, status, nnzh)
    cdimsj(T, libsif, status, nnzj)
    nnzj[] -= nvar[]  # nnzj also counts the nonzeros in the objective gradient.
  else
    udimsh(T, libsif, status, nnzh)
  end
  cutest_error(status[])

  # Sparsity pattern of the hessian
  hrows = Vector{Cint}(undef, nnzh[])
  hcols = Vector{Cint}(undef, nnzh[])
  this_nnzh = Ref{Cint}(0)
  if ncon[] > 0
    cshp(T, libsif, status, nvar, this_nnzh, nnzh, hcols, hrows)
  else
    ushp(T, libsif, status, nvar, this_nnzh, nnzh, hcols, hrows)
  end
  cutest_error(status[])

  # sparsity pattern of the jacobian
  jrows = Vector{Cint}(undef, nnzj[])
  jcols = Vector{Cint}(undef, nnzj[])
  this_nnzj = Ref{Cint}(0)
  csjp(T, libsif, status, this_nnzj, nnzj, jcols, jrows)
  cutest_error(status[])

  # compute lin_nnzj and nln_nnzj
  lin_nnzj = 0
  for row in jrows
    if linear[row]
      lin_nnzj += 1
    end
  end
  nln_nnzj = nnzj[] - lin_nnzj

  blin = Vector{T}(undef, nlin)
  clinrows = Vector{Cint}(undef, lin_nnzj)
  clincols = Vector{Cint}(undef, lin_nnzj)
  clinvals = Vector{T}(undef, lin_nnzj)
  Jval = Vector{T}(undef, nvar[])
  Jvar = Vector{Cint}(undef, nvar[])

  # sparsity pattern of the linear constraints
  i = 0
  nnzj_tmp = Ref{Cint}(nnzj[])
  x0 = Vector{T}(undef, nvar[])
  for j in lin
    x0 .= zero(T)
    ccifsg(
      T,
      libsif,
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

  workspace_nvar = Vector{T}(undef, nvar)
  workspace_ncon = Vector{T}(undef, ncon)

  fclose(T, libsif, funit, status)
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

  nlp = CUTEstModel{T}(
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
    libsif,
    funit,
    Ref{Cint}(nvar),
    Ref{Cint}(ncon),
    Ref{Cint}(nnzj),
    Ref{Cint}(nnzh),
    Ref{T}(),
    status,
  )

  finalizer(cutest_finalize, nlp)
  return nlp
end

function cutest_finalize(nlp::CUTEstModel{T}) where {T}
  if nlp.libsif != C_NULL
    status = Ref{Cint}(0)
    if nlp.meta.ncon > 0
      cterminate(T, nlp.libsif, status)
    else
      uterminate(T, nlp.libsif, status)
    end
    Libdl.dlclose(nlp.libsif)
    nlp.libsif = C_NULL
  end
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
