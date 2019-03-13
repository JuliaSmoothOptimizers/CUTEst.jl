export cons_coord, consjac

using NLPModels, SparseArrays

@doc (@doc NLPModels.objcons)
function NLPModels.objcons(nlp :: CUTEstModel, x :: AbstractVector)
  c = Vector{eltype(x)}(undef, nlp.meta.ncon)
  objcons!(nlp, x, c)
end

@doc (@doc NLPModels.objgrad)
function NLPModels.objgrad(nlp :: CUTEstModel, x :: AbstractVector)
  g = Vector{eltype(x)}(undef, nlp.meta.nvar)
  objgrad!(nlp, x, g)
end

# generate single and double-precision variants
for (typ, ctyp, cutest_lib) in ((Float64, Cdouble, :cutest_lib_double),
                                (Float32, Cfloat, :cutest_lib_single))

  @eval begin
    @doc (@doc NLPModels.objcons!)
    function NLPModels.objcons!(nlp :: CUTEstModel, x :: Vector{$typ}, c :: Vector{$typ})
      nvar = nlp.meta.nvar
      ncon = nlp.meta.ncon
      io_err = Cint[0]
      f = $(ctyp)[0]
      if ncon > 0
        ccall(dlsym(eval($cutest_lib), :cutest_cfn_), Nothing,
                    (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ}),
                     io_err,     nvar,       ncon,       x,         f,         c)
        nlp.counters.neval_cons += 1
      else
        ccall(dlsym(eval($cutest_lib), :cutest_ufn_), Nothing,
                    (Ptr{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{$typ}),
                     io_err,     nvar,       x,         f)
      end
      nlp.counters.neval_obj += 1
      @cutest_error

      return f[1], c
    end

    function NLPModels.objcons!(nlp :: CUTEstModel, x :: AbstractVector{$typ}, c :: AbstractVector{$typ})
      m = nlp.meta.ncon
      if m > 0
        cc = zeros($typ, m)
        f, _ = objcons!(nlp, Vector(x), cc)
        c .= cc
        return f, c
      else
        return objcons!(nlp, Vector(x), zeros($typ, 0))
      end
    end

    @doc (@doc NLPModels.objgrad!)
    function NLPModels.objgrad!(nlp :: CUTEstModel, x :: Vector{$typ}, g :: Vector{$typ})
      nvar = nlp.meta.nvar
      ncon = nlp.meta.ncon
      f = $ctyp[0]
      io_err = Cint[0]
      get_grad = 1
      if ncon > 0
        ccall(dlsym($cutest_lib, "cutest_cofg_"), Nothing,
            (Ptr{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ}, Ref{Int32}),
                 io_err,       nvar,         x,         f,         g,   get_grad)
      else
        ccall(dlsym($cutest_lib, "cutest_uofg_"), Nothing,
            (Ptr{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ}, Ref{Int32}),
                 io_err,       nvar,         x,         f,         g,   get_grad)
      end
      nlp.counters.neval_obj += 1
      nlp.counters.neval_grad += 1
      @cutest_error

      return f[1], g
    end

    function NLPModels.objgrad!(nlp :: CUTEstModel, x :: AbstractVector{$typ}, g :: Vector{$typ})
      objgrad!(nlp, Vector{$typ}(x), g)
    end
  end

end

function NLPModels.objgrad!(nlp :: CUTEstModel, x :: AbstractVector, g :: AbstractVector)
  gc = Vector{eltype(x)}(undef, nlp.meta.nvar)
  f, _ = objgrad!(nlp, Vector(x), gc)
  g .= gc
  return f, g
end

@doc (@doc NLPModels.obj)
function NLPModels.obj(nlp :: CUTEstModel, x :: AbstractVector)
  f = objcons(nlp, x)[1]
  if nlp.meta.ncon > 0
    nlp.counters.neval_cons -= 1  # does not really count as a constraint eval
  end
  return f
end

@doc (@doc NLPModels.grad)
function NLPModels.grad(nlp :: CUTEstModel, x :: AbstractVector)
  g = Vector{eltype(x)}(undef, nlp.meta.nvar)
  return grad!(nlp, x, g)
end

@doc (@doc NLPModels.grad!)
function NLPModels.grad!(nlp :: CUTEstModel, x :: AbstractVector, g :: AbstractVector)
  objgrad!(nlp, x, g)
  nlp.counters.neval_obj -= 1  # does not really count as a objective eval
  return g
end

"""
    cons_coord(nlp, x)

Computes the constraint vector and the Jacobian in
coordinate format.
Usage:

    c, jrow, jcol, jval = cons_coord(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - c:    [OUT] Array{Float64, 1}
  - jrow: [OUT] Array{Int32, 1}
  - jcol: [OUT] Array{Int32, 1}
  - jval: [OUT] Array{Float64, 1}
"""
cons_coord

for (typ, cutest_lib) in ((Float64, :cutest_lib_double),
                          (Float32, :cutest_lib_single))

  @eval begin
    function cons_coord(nlp :: CUTEstModel, x :: Vector{$typ})
      nvar = nlp.meta.nvar
      ncon = nlp.meta.ncon
      nnzj = nlp.meta.nnzj
      io_err = Cint[0]
      c = Vector{$typ}(undef, ncon)
      jsize = nlp.meta.nnzj
      get_j = 1
      jval = Vector{$typ}(undef, jsize)
      jrow = Array{Int32}(undef, jsize)
      jcol = Array{Int32}(undef, jsize)

      ccall(dlsym(eval($cutest_lib), :cutest_ccfsg_), Nothing,
                  (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{$typ}, Ref{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{Int32}, Ptr{Int32}, Ref{Int32}),
                   io_err,     nvar,       ncon,       x,         c,         nnzj,       jsize,      jval,      jcol,       jrow,       get_j)
      @cutest_error
      nlp.counters.neval_cons += 1
      nlp.counters.neval_jac += 1
      return c, Int.(jrow), Int.(jcol), jval
    end
  end
end

function cons_coord(nlp :: CUTEstModel, x :: AbstractVector)
  cons_coord(nlp, Vector(x))
end


"""
    consjac(nlp, x)

Computes the constraint vector and the Jacobian in
internal sparse format.
Usage:

    c, J = consjac(nlp, x)

  - nlp:  [IN] CUTEstModel
  - x:    [IN] Array{Float64, 1}
  - c:    [OUT] Array{Float64, 1}
  - J:    [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64,Int32}
"""
function consjac(nlp :: CUTEstModel, x :: AbstractVector)
  c, jrow, jcol, jval = cons_coord(nlp, x)
  return c, sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar)
end

@doc (@doc NLPModels.cons)
function NLPModels.cons(nlp :: CUTEstModel, x :: AbstractVector)
  c = Vector{eltype(x)}(undef, nlp.meta.ncon)
  cons!(nlp, x, c)
end

@doc (@doc NLPModels.cons!)
function NLPModels.cons!(nlp :: CUTEstModel, x :: AbstractVector, c :: AbstractVector)
  objcons!(nlp, x, c)
  nlp.counters.neval_obj -= 1  # does not really count as a objective eval
  return c
end

@doc (@doc NLPModels.jac_coord!)
function NLPModels.jac_coord(nlp :: CUTEstModel, x :: AbstractVector)
  c, jrow, jcol, jval = cons_coord(nlp, x)
  nlp.counters.neval_cons -= 1  # does not really count as a constraint eval
  return (jrow, jcol, jval)
end

@doc (@doc NLPModels.jac)
function NLPModels.jac(nlp :: CUTEstModel, x :: AbstractVector)
  c, J = consjac(nlp, x)
  nlp.counters.neval_cons -= 1  # does not really count as a constraint eval
  return J
end

@doc (@doc NLPModels.jprod)
function NLPModels.jprod(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector)
  jv = zeros(nlp.meta.ncon)
  jprod!(nlp, x, v, jv)
end

for (typ, cutest_lib) in ((Float64, :cutest_lib_double),
                          (Float32, :cutest_lib_single))

  @eval begin
    function NLPModels.jprod!(nlp :: CUTEstModel, x :: Vector{$typ}, v :: Vector{$typ}, jv :: Vector{$typ})
      nvar = nlp.meta.nvar
      ncon = nlp.meta.ncon
      got_j = 0
      jtrans = 0
      io_err = Cint[0]
      ccall(dlsym(eval($cutest_lib), :cutest_cjprod_), Nothing,
                  (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{$typ}, Ref{Int32}, Ptr{$typ}, Ref{Int32}),
                   io_err,     nvar,       ncon,       got_j,      jtrans,     x,         v,         nvar,       jv,        ncon)
      @cutest_error
      nlp.counters.neval_jprod += 1
      return jv
    end

    @doc (@doc NLPModels.jprod!)
    function NLPModels.jtprod!(nlp :: CUTEstModel, x :: Vector{$typ}, v :: Vector{$typ}, jtv :: Vector{$typ})
      nvar = nlp.meta.nvar
      ncon = nlp.meta.ncon
      got_j = 0
      jtrans = 1
      io_err = Cint[0]
      ccall(dlsym(eval($cutest_lib), :cutest_cjprod_), Nothing,
                  (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{$typ}, Ref{Int32}, Ptr{$typ}, Ref{Int32}),
                   io_err,     nvar,       ncon,       got_j,      jtrans,     x,         v,         ncon,       jtv,       nvar)
      @cutest_error
      nlp.counters.neval_jtprod += 1
      return jtv
    end
  end

end

@doc (@doc NLPModels.jprod!)
function NLPModels.jprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jv :: Vector)
  jprod!(nlp, Vector{eltype(jv)}(x), Vector{eltype(jv)}(v), jv)
end

function NLPModels.jprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jv :: AbstractVector)
  jvc = zeros(eltype(x), nlp.meta.ncon)
  jprod!(nlp, Vector(x), Vector{eltype(x)}(v), jvc)
  jv .= jvc
end

@doc (@doc NLPModels.jtprod)
function NLPModels.jtprod(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector)
  jtv = zeros(eltype(x), nlp.meta.nvar)
  jtprod!(nlp, x, v, jtv)
end

function NLPModels.jtprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jtv :: Vector)
  jtprod!(nlp, Vector{eltype(jtv)}(x), Vector{eltype(jtv)}(v), jtv)
end

function NLPModels.jtprod!(nlp :: CUTEstModel, x :: AbstractVector, v :: AbstractVector, jtv :: AbstractVector)
  jtvc = zeros(eltype(x), nlp.meta.nvar)
  jtprod!(nlp, Vector(x), Vector{eltype(x)}(v), jtvc)
  jtv .= jtvc
end

for (typ, cutest_lib) in ((Float64, :cutest_lib_double),
                          (Float32, :cutest_lib_single))

  @eval begin
    function NLPModels.hess_coord(nlp :: CUTEstModel, x :: Vector{$typ}; y :: Vector{$typ}=zeros($typ, nlp.meta.ncon), obj_weight :: $typ=$typ(1))
      nvar = nlp.meta.nvar
      ncon = nlp.meta.ncon
      nnzh = nlp.meta.nnzh
      io_err = Cint[0]
      hval = Vector{$typ}(undef, nnzh)
      hrow = Array{Int32}(undef, nnzh)
      hcol = Array{Int32}(undef, nnzh)
      this_nnzh = Cint[0]

      if obj_weight == 0.0 && ncon > 0
        ccall(dlsym(eval($cutest_lib), :cutest_cshc_), Nothing,
                    (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{$typ}, Ptr{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{Int32}, Ptr{Int32}),
                     io_err,     nvar,       ncon,       x,         y,         this_nnzh,  nnzh,       hval,      hrow,       hcol)
        @cutest_error
        nlp.counters.neval_hess += 1
        return (Int.(hcol), Int.(hrow), hval)
      end

      if ncon > 0
        # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
        obj_weight != 1 && (y /= obj_weight)

        ccall(dlsym(eval($cutest_lib), :cutest_csh_), Nothing,
                    (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{$typ}, Ptr{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{Int32}, Ptr{Int32}),
                     io_err,     nvar,       ncon,       x,         y,         this_nnzh,  nnzh,       hval,      hrow,       hcol)
      else
        ccall(dlsym(eval($cutest_lib), :cutest_ush_), Nothing,
                    (Ptr{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{Int32}, Ref{Int32}, Ptr{$typ}, Ptr{Int32}, Ptr{Int32}),
                     io_err,     nvar,       x,         this_nnzh,  nnzh,       hval,      hrow,       hcol)
      end
      @cutest_error

      obj_weight != 1 && (hval[:] *= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
      nlp.counters.neval_hess += 1
      return (Int.(hcol), Int.(hrow), hval);  # swap rows and column
    end

    @doc (@doc NLPModels.hess_coord)
    function NLPModels.hess_coord(nlp :: CUTEstModel, x :: AbstractVector{$typ}; y :: AbstractVector=zeros($typ, nlp.meta.ncon), obj_weight :: $typ=$typ(1))
      hess_coord(nlp, Vector(x), y=Vector{$typ}(y), obj_weight=obj_weight)
    end

    @doc (@doc NLPModels.hess)
    function NLPModels.hess(nlp :: CUTEstModel, x :: AbstractVector{$typ}; y :: AbstractVector = zeros($typ, nlp.meta.ncon), obj_weight :: $typ=$typ(1))
      (hrow, hcol, hval) = hess_coord(nlp, x, y=y, obj_weight=obj_weight)
      return sparse(hrow, hcol, hval, nlp.meta.nvar, nlp.meta.nvar)
    end

    @doc (@doc NLPModels.hprod)
    function NLPModels.hprod(nlp :: CUTEstModel, x :: AbstractVector{$typ}, v :: AbstractVector; y :: AbstractVector = zeros($typ, nlp.meta.ncon), obj_weight :: $typ=$typ(1))
      hv = Vector{$typ}(undef, nlp.meta.nvar)
      return hprod!(nlp, x, v, hv, y=y, obj_weight=obj_weight)
    end

    function NLPModels.hprod!(nlp :: CUTEstModel, x :: Vector{$typ}, v :: Vector{$typ}, hv :: Vector{$typ}; y :: Vector{$typ}=zeros($typ, nlp.meta.ncon), obj_weight :: $typ=$typ(1))
      nvar = nlp.meta.nvar
      ncon = nlp.meta.ncon
      io_err = Cint[0]
      goth = Cint[0]

      if obj_weight == 0 && ncon > 0
        ccall(dlsym(eval($cutest_lib), :cutest_chcprod_), Nothing,
                    (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ}),
                     io_err,     nvar,       ncon,       goth,       x,         y,         v,         hv)
        @cutest_error
        nlp.counters.neval_hprod += 1
        return hv
      end

      if ncon > 0
        # σ H₀ + ∑ᵢ yᵢ Hᵢ = σ (H₀ + ∑ᵢ (yᵢ/σ) Hᵢ)
        obj_weight != 1 && (y /= obj_weight)

        ccall(dlsym(eval($cutest_lib), :cutest_chprod_), Nothing,
                    (Ptr{Int32}, Ref{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ}),
                     io_err,     nvar,       ncon,       goth,       x,         y,         v,         hv)
      else
        ccall(dlsym(eval($cutest_lib), :cutest_uhprod_), Nothing,
                    (Ptr{Int32}, Ref{Int32}, Ptr{Int32}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ}),
                     io_err,     nvar,       goth,       x,         v,         hv)
      end
      @cutest_error

      obj_weight != 1 && (hv[:] *= obj_weight)  # also ok if obj_weight == 0 and ncon == 0
      nlp.counters.neval_hprod += 1
      return hv
    end

    function NLPModels.hprod!(nlp :: CUTEstModel, x :: AbstractVector{$typ}, v :: AbstractVector{$typ}, hv :: Vector{$typ}; y :: AbstractVector=zeros($typ, nlp.meta.ncon), obj_weight :: $typ=$typ(1))
      hprod!(nlp, Vector(x), Vector{$typ}(v), hv, y=Vector{$typ}(y), obj_weight=obj_weight)
    end

    function NLPModels.hprod!(nlp :: CUTEstModel, x :: AbstractVector{$typ}, v :: AbstractVector{$typ}, hv :: AbstractVector{$typ}; y :: AbstractVector=zeros($typ, nlp.meta.ncon), obj_weight :: $typ=$typ(1))
      hvc = Vector{$typ}(undef, nlp.meta.nvar)
      hprod!(nlp, Vector(x), Vector(v), hvc, y=Vector(y), obj_weight=obj_weight)
      hv .= hvc
    end
  end

end

@doc (@doc NLPModels.hprod!)
hprod!
