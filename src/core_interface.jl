"""
    usetup(T, status, input, out, io_buffer, n, x, x_l, x_u)

The usetup subroutine sets up the correct data structures for
subsequent computations in the case where the only possible
constraints are bound constraints. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

  - status:    [OUT] Vector{Cint}
  - input:     [IN]  Vector{Cint}
  - out:       [IN]  Vector{Cint}
  - io_buffer: [IN]  Vector{Cint}
  - n:         [IN]  Vector{Cint}
  - x:         [OUT] Vector{T}
  - x_l:       [OUT] Vector{T}
  - x_u:       [OUT] Vector{T}
"""
function usetup end

for (cutest_usetup, T) in ((:cutest_usetup_s_, :Float32), (:cutest_usetup_, :Float64), (:cutest_usetup_q_, :Float128))
  @eval begin
    function usetup(
      ::Type{$T},
      status::StrideOneVector{Cint},
      input::StrideOneVector{Cint},
      out::StrideOneVector{Cint},
      io_buffer::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      x_l::StrideOneVector{$T},
      x_u::StrideOneVector{$T},
    )
      $cutest_usetup(status, input, out, io_buffer, n, x, x_l, x_u)
    end
  end
end

"""
    csetup(status, input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn, linear, e_order, l_order, v_order)

The csetup subroutine sets up the correct data structures for
subsequent computations on the problem decoded from a SIF file by the
script sifdecoder. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:    [OUT] Vector{Cint}
  - input:     [IN]  Vector{Cint}
  - out:       [IN]  Vector{Cint}
  - io_buffer: [IN]  Vector{Cint}
  - n:         [IN]  Vector{Cint}
  - m:         [IN]  Vector{Cint}
  - x:         [OUT] Vector{T}
  - x_l:       [OUT] Vector{T}
  - x_u:       [OUT] Vector{T}
  - y:         [OUT] Vector{T}
  - c_l:       [OUT] Vector{T}
  - c_u:       [OUT] Vector{T}
  - equatn:    [OUT] Vector{Bool}
  - linear:    [OUT] Vector{Bool}
  - e_order:   [IN]  Vector{Cint}
  - l_order:   [IN]  Vector{Cint}
  - v_order:   [IN]  Vector{Cint}
"""
function csetup end

for (cutest_cint_csetup, T) in
    ((:cutest_cint_csetup_s_, :Float32), (:cutest_cint_csetup_, :Float64), (:cutest_cint_csetup_q_, :Float128))
  @eval begin
    function csetup(
      ::Type{$T},
      status::StrideOneVector{Cint},
      input::StrideOneVector{Cint},
      out::StrideOneVector{Cint},
      io_buffer::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      x_l::StrideOneVector{$T},
      x_u::StrideOneVector{$T},
      y::StrideOneVector{$T},
      c_l::StrideOneVector{$T},
      c_u::StrideOneVector{$T},
      equatn::StrideOneVector{Bool},
      linear::StrideOneVector{Bool},
      e_order::StrideOneVector{Cint},
      l_order::StrideOneVector{Cint},
      v_order::StrideOneVector{Cint},
    )
      $cutest_cint_csetup(
        status,
        input,
        out,
        io_buffer,
        n,
        m,
        x,
        x_l,
        x_u,
        y,
        c_l,
        c_u,
        equatn,
        linear,
        e_order,
        l_order,
        v_order,
      )
    end
  end
end

"""
    udimen(T, status, input, n)

The udimen subroutine discovers how many variables are involved in the
problem decoded from a SIF file by the script sifdecoder. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The
objective function is group-partially separable.

  - status:  [OUT] Vector{Cint}
  - input:   [IN]  Vector{Cint}
  - n:       [OUT] Vector{Cint}
"""
function udimen end

for (cutest_udimen, T) in ((:cutest_udimen_s_, :Float32), (:cutest_udimen_, :Float64), (:cutest_udimen_q_, :Float128))
  @eval begin
    function udimen(
      ::Type{$T},
      status::StrideOneVector{Cint},
      input::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
    )
      $cutest_udimen(status, input, n)
    end
  end
end

"""
    udimsh(T, status, nnzh)

The udimsh subroutine determine the number of nonzeros required to
store the Hessian matrix of the objective function of the problem
decoded from a SIF file by the script sifdecoder at the point X. This
Hessian matrix is stored as a sparse matrix in coordinate format. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu.
The objective function is group-partially separable.

  - status:  [OUT] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
"""
function udimsh end

for (cutest_udimsh, T) in ((:cutest_udimsh_s_, :Float32), (:cutest_udimsh_, :Float64), (:cutest_udimsh_q_, :Float128))
  @eval begin
    function udimsh(::Type{$T}, status::StrideOneVector{Cint}, nnzh::StrideOneVector{Cint})
      $cutest_udimsh(status, nnzh)
    end
  end
end

"""
    udimse(T, status, ne, he_val_ne, he_row_ne)

The udimse subroutine determine the number of nonzeros required to
store the Hessian matrix of the objective function of the problem
decoded from a SIF file by the script sifdecoder at the point X. This
Hessian matrix is stored as a sparse matrix in finite element format
H=eΣ1He, where each square symmetric element H_i involves a small
subset of the rows of the Hessian matrix. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

  - status:    [OUT] Vector{Cint}
  - ne:        [OUT] Vector{Cint}
  - he_val_ne: [OUT] Vector{Cint}
  - he_row_ne: [OUT] Vector{Cint}
"""
function udimse end

for (cutest_udimse, T) in ((:cutest_udimse_s_, :Float32), (:cutest_udimse_, :Float64), (:cutest_udimse_q_, :Float128))
  @eval begin
    function udimse(
      ::Type{$T},
      status::StrideOneVector{Cint},
      ne::StrideOneVector{Cint},
      he_val_ne::StrideOneVector{Cint},
      he_row_ne::StrideOneVector{Cint},
    )
      $cutest_udimse(status, ne, he_val_ne, he_row_ne)
    end
  end
end

"""
    uvartype(T, status, n, x_type)

The uvartype subroutine determines the type (continuous, 0-1, integer)
of each variable involved in the problem decoded from a SIF file by
the script sifdecoder. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x_type:  [OUT] Vector{Cint}
"""
function uvartype end

for (cutest_uvartype, T) in ((:cutest_uvartype_s_, :Float32), (:cutest_uvartype_, :Float64), (:cutest_uvartype_q_, :Float128))
  @eval begin
    function uvartype(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x_type::StrideOneVector{Cint},
    )
      $cutest_uvartype(status, n, x_type)
    end
  end
end

"""
    unames(T, status, n, pname, vname)

The unames subroutine obtains the names of the problem and its
variables. The problem under consideration is to minimize or maximize
an objective function f(x) over all x ∈ Rn subject to the simple
bounds xl≤x≤xu. The objective function is group-partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - pname:   [OUT] Vector{Cchar}
  - vname:   [OUT] Vector{Cchar}

To get useful names, use `String(x)` where `x` can be `pname` or `vname[:,i]`.
"""
function unames end

for (cutest_unames, T) in ((:cutest_unames_s_, :Float32), (:cutest_unames_, :Float64), (:cutest_unames_q_, :Float128))
  @eval begin
    function unames(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      pname::StrideOneVector{Cchar},
      vname::Matrix{Cchar},
    )
      $cutest_unames(status, n, pname, vname)
    end
  end
end

"""
    ureport(T, status, calls, time)

The ureport subroutine obtains statistics concerning function
evaluation and CPU time used for unconstrained or bound-constrained
optimization in a standardized format. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

  - status:  [OUT] Vector{Cint}
  - calls:   [OUT] Vector{T}
  - time:    [OUT] Vector{T}
"""
function ureport end

for (cutest_ureport, T) in ((:cutest_ureport_s_, :Float32), (:cutest_ureport_, :Float64), (:cutest_ureport_q_, :Float128))
  @eval begin
    function ureport(
      ::Type{$T},
      status::StrideOneVector{Cint},
      calls::StrideOneVector{$T},
      time::StrideOneVector{$T},
    )
      $cutest_ureport(status, calls, time)
    end
  end
end

"""
    cdimen(T, status, input, n, m)

The cdimen subroutine discovers how many variables and constraints are
involved in the problem decoded from a SIF file by the script
sifdecoder. The problem under consideration is to minimize or maximize
an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - input:   [IN]  Vector{Cint}
  - n:       [OUT] Vector{Cint}
  - m:       [OUT] Vector{Cint}
"""
function cdimen end

for (cutest_cdimen, T) in ((:cutest_cdimen_s_, :Float32), (:cutest_cdimen_, :Float64), (:cutest_cdimen_q_, :Float128))
  @eval begin
    function cdimen(
      ::Type{$T},
      status::StrideOneVector{Cint},
      input::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
    )
      $cutest_cdimen(status, input, n, m)
    end
  end
end

"""
    cdimsj(T, status, nnzj)

The cdimsj subroutine determines the number of nonzero elements
required to store the matrix of gradients of the objective function
and constraint functions for the problem decoded into OUTSDIF.d in the
constrained minimization case. The matrix is stored in sparse format.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separable and all constraint functions are partially
separable.

  - status:  [OUT] Vector{Cint}
  - nnzj:    [OUT] Vector{Cint}
"""
function cdimsj end

for (cutest_cdimsj, T) in ((:cutest_cdimsj_s_, :Float32), (:cutest_cdimsj_, :Float64), (:cutest_cdimsj_q_, :Float128))
  @eval begin
    function cdimsj(::Type{$T}, status::StrideOneVector{Cint}, nnzj::StrideOneVector{Cint})
      $cutest_cdimsj(status, nnzj)
    end
  end
end

"""
    cdimsh(T, status, nnzh)

The cdimsh subroutine determines the number of nonzero elements
required to store the Hessian matrix of the Lagrangian function for
the problem decoded into OUTSDIF.d in the constrained minimization
case. The matrix is stored in sparse "coordinate" format. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
"""
function cdimsh end

for (cutest_cdimsh, T) in ((:cutest_cdimsh_s_, :Float32), (:cutest_cdimsh_, :Float64), (:cutest_cdimsh_q_, :Float128))
  @eval begin
    function cdimsh(::Type{$T}, status::StrideOneVector{Cint}, nnzh::StrideOneVector{Cint})
      $cutest_cdimsh(status, nnzh)
    end
  end
end

"""
    cdimchp(T, status, nnzchp)

The cdimchp subroutine determines the number of nonzero elements
required to store the products of the Hessian matrices of the
constraint functions with a specified vector for the problem decoded
into OUTSDIF.d in the constrained minimization case. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - nnzchp:  [OUT] Vector{Cint}
"""
function cdimchp end

for (cutest_cdimchp, T) in ((:cutest_cdimchp_s_, :Float32), (:cutest_cdimchp_, :Float64), (:cutest_cdimchp_q_, :Float128))
  @eval begin
    function cdimchp(::Type{$T}, status::StrideOneVector{Cint}, nnzchp::StrideOneVector{Cint})
      $cutest_cdimchp(status, nnzchp)
    end
  end
end

"""
    cdimse(T, status, ne, he_val_ne, he_row_ne)

The cdimse subroutine determines the number of nonzero elements
required to store the Hessian matrix of the Lagrangian function for
the problem decoded from a SIF file by the script sifdecoder. The
matrix is stored in sparse "finite element" format H=eΣ1He, where each
square symmetric element He involves a small subset of the rows of the
Hessian matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:    [OUT] Vector{Cint}
  - ne:        [OUT] Vector{Cint}
  - he_val_ne: [OUT] Vector{Cint}
  - he_row_ne: [OUT] Vector{Cint}
"""
function cdimse end

for (cutest_cdimse, T) in ((:cutest_cdimse_s_, :Float32), (:cutest_cdimse_, :Float64), (:cutest_cdimse_q_, :Float128))
  @eval begin
    function cdimse(
      ::Type{$T},
      status::StrideOneVector{Cint},
      ne::StrideOneVector{Cint},
      he_val_ne::StrideOneVector{Cint},
      he_row_ne::StrideOneVector{Cint},
    )
      $cutest_cdimse(status, ne, he_val_ne, he_row_ne)
    end
  end
end

"""
    cstats(T, status, nonlinear_variables_objective, nonlinear_variables_constraints, equality_constraints, linear_constraints)

  - status:                          [OUT] Vector{Cint}
  - nonlinear_variables_objective:   [OUT] Vector{Cint}
  - nonlinear_variables_constraints: [OUT] Vector{Cint}
  - equality_constraints:            [OUT] Vector{Cint}
  - linear_constraints:              [OUT] Vector{Cint}
"""
function cstats end

for (cutest_cstats, T) in ((:cutest_cstats_s_, :Float32), (:cutest_cstats_, :Float64), (:cutest_cstats_q_, :Float128))
  @eval begin
    function cstats(
      ::Type{$T},
      status::StrideOneVector{Cint},
      nonlinear_variables_objective::StrideOneVector{Cint},
      nonlinear_variables_constraints::StrideOneVector{Cint},
      equality_constraints::StrideOneVector{Cint},
      linear_constraints::StrideOneVector{Cint},
    )
      $cutest_cstats(
        status,
        nonlinear_variables_objective,
        nonlinear_variables_constraints,
        equality_constraints,
        linear_constraints,
      )
    end
  end
end

"""
    cvartype(T, status, n, x_type)

The cvartype subroutine determines the type (continuous, 0-1, integer)
of each variable involved in the problem decoded from a SIF file by
the script sifdecoder. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to
general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x_type:  [OUT] Vector{Cint}
"""
function cvartype end

for (cutest_cvartype, T) in ((:cutest_cvartype_s_, :Float32), (:cutest_cvartype_, :Float64), (:cutest_cvartype_q_, :Float128))
  @eval begin
    function cvartype(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x_type::StrideOneVector{Cint},
    )
      $cutest_cvartype(status, n, x_type)
    end
  end
end

"""
    cnames(T, status, n, m, pname, vname, cname)

The cnames subroutine obtains the names of the problem, its variables
and general constraints. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - pname:   [OUT] Vector{Cchar}
  - vname:   [OUT] Vector{Cchar}
  - cname:   [OUT] Vector{Cchar}

To get useful names, use `String(x)` where `x` can be `pname`, `vname[:,i]`,
or `cname[:,i]`.
"""
function cnames end

for (cutest_cnames, T) in ((:cutest_cnames_s_, :Float32), (:cutest_cnames_, :Float64), (:cutest_cnames_q_, :Float128))
  @eval begin
    function cnames(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      pname::StrideOneVector{Cchar},
      vname::Matrix{Cchar},
      cname::Matrix{Cchar},
    )
      $cutest_cnames(status, n, m, pname, vname, cname)
    end
  end
end

"""
    creport(T, status, calls, time)

The creport subroutine obtains statistics concerning function
evaluation and CPU time used for constrained optimization in a
standardized format. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - calls:   [OUT] Vector{T}
  - time:    [OUT] Vector{T}
"""
function creport end

for (cutest_creport, T) in ((:cutest_creport_s_, :Float32), (:cutest_creport_, :Float64), (:cutest_creport_q_, :Float128))
  @eval begin
    function creport(
      ::Type{$T},
      status::StrideOneVector{Cint},
      calls::StrideOneVector{$T},
      time::StrideOneVector{$T},
    )
      $cutest_creport(status, calls, time)
    end
  end
end

"""
    connames(T, status, m, cname)

The connames subroutine obtains the names of the general constraints
of the problem. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - cname:   [OUT] Vector{Cchar}

To get useful names, use `String(cname[:,i])`.
"""
function connames end

for (cutest_connames, T) in ((:cutest_connames_s_, :Float32), (:cutest_connames_, :Float64), (:cutest_connames_q_, :Float128))
  @eval begin
    function connames(
      ::Type{$T},
      status::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      cname::Matrix{Cchar},
    )
      $cutest_connames(status, m, cname)
    end
  end
end

"""
    pname(T, status, input, pname)

The pname subroutine obtains the name of the problem directly from the
datafile OUTSDIF.d that was created by the script sifdecoder when
decoding a SIF file. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - input:   [IN]  Vector{Cint}
  - pname:   [OUT] Vector{Cchar}
"""
function pname end

for (cutest_pname, T) in ((:cutest_pname_s_, :Float32), (:cutest_pname_, :Float64), (:cutest_pname_q_, :Float128))
  @eval begin
    function pname(
      ::Type{$T},
      status::StrideOneVector{Cint},
      input::StrideOneVector{Cint},
      pname::StrideOneVector{Cchar},
    )
      $cutest_pname(status, input, pname)
    end
  end
end

"""
    probname(T, status, pname)

The probname subroutine obtains the name of the problem. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - pname:   [OUT] Vector{Cchar}

To get a useful name, use `String(pname)`.
"""
function probname end

for (cutest_probname, T) in ((:cutest_probname_s_, :Float32), (:cutest_probname_, :Float64), (:cutest_probname_q_, :Float128))
  @eval begin
    function probname(::Type{$T}, status::StrideOneVector{Cint}, pname::StrideOneVector{Cchar})
      $cutest_probname(status, pname)
    end
  end
end

"""
    varnames(T, status, n, vname)

The varnames subroutine obtains the names of the problem variables.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separable and all constraint functions are partially
separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - vname:   [OUT] Vector{Cchar}

To get useful names, use `String(vname[:, i])`.
"""
function varnames end

for (cutest_varnames, T) in ((:cutest_varnames_s_, :Float32), (:cutest_varnames_, :Float64), (:cutest_varnames_q_, :Float128))
  @eval begin
    function varnames(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      vname::Matrix{Cchar},
    )
      $cutest_varnames(status, n, vname)
    end
  end
end

"""
    ufn(T, status, n, x, f)

The ufn subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - f:       [OUT] Vector{T}
"""
function ufn end

for (cutest_ufn, T) in ((:cutest_ufn_s_, :Float32), (:cutest_ufn_, :Float64), (:cutest_ufn_q_, :Float128))
  @eval begin
    function ufn(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      f::StrideOneVector{$T},
    )
      $cutest_ufn(status, n, x, f)
    end
  end
end

"""
    ugr(T, status, n, x, g)

The ugr subroutine evaluates the gradient of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - g:       [OUT] Vector{T}
"""
function ugr end

for (cutest_ugr, T) in ((:cutest_ugr_s_, :Float32), (:cutest_ugr_, :Float64), (:cutest_ugr_q_, :Float128))
  @eval begin
    function ugr(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      g::StrideOneVector{$T},
    )
      $cutest_ugr(status, n, x, g)
    end
  end
end

"""
    uofg(T, status, n, x, f, g, grad)

The uofg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - f:       [OUT] Vector{T}
  - g:       [OUT] Vector{T}
  - grad:    [IN]  Vector{Bool}
"""
function uofg end

for (cutest_cint_uofg, T) in ((:cutest_cint_uofg_s_, :Float32), (:cutest_cint_uofg_, :Float64), (:cutest_cint_uofg_q_, :Float128))
  @eval begin
    function uofg(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      f::StrideOneVector{$T},
      g::StrideOneVector{$T},
      grad::StrideOneVector{Bool},
    )
      $cutest_cint_uofg(status, n, x, f, g, grad)
    end
  end
end

"""
    udh(T, status, n, x, lh1, h)

The udh subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a dense
matrix. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - lh1:     [IN]  Vector{Cint}
  - h:       [OUT] Matrix{T}
"""
function udh end

for (cutest_udh, T) in ((:cutest_udh_s_, :Float32), (:cutest_udh_, :Float64), (:cutest_udh_q_, :Float128))
  @eval begin
    function udh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      lh1::StrideOneVector{Cint},
      h::Matrix{$T},
    )
      $cutest_udh(status, n, x, lh1, h)
    end
  end
end

"""
    ushp(T, status, n, nnzh, lh, h_row, h_col)

The ushp subroutine evaluates the sparsity pattern of the Hessian
matrix of the objective function of the problem, decoded from a SIF
file by the script sifdecoder, in coordinate format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN]  Vector{Cint}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function ushp end

for (cutest_ushp, T) in ((:cutest_ushp_s_, :Float32), (:cutest_ushp_, :Float64), (:cutest_ushp_q_, :Float128))
  @eval begin
    function ushp(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      nnzh::StrideOneVector{Cint},
      lh::StrideOneVector{Cint},
      h_row::StrideOneVector{Cint},
      h_col::StrideOneVector{Cint},
    )
      $cutest_ushp(status, n, nnzh, lh, h_row, h_col)
    end
  end
end

"""
    ush(T, status, n, x, nnzh, lh, h_val, h_row, h_col)

The ush subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a sparse
matrix in coordinate format. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN]  Vector{Cint}
  - h_val:   [OUT] Vector{T}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function ush end

for (cutest_ush, T) in ((:cutest_ush_s_, :Float32), (:cutest_ush_, :Float64), (:cutest_ush_q_, :Float128))
  @eval begin
    function ush(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      nnzh::StrideOneVector{Cint},
      lh::StrideOneVector{Cint},
      h_val::StrideOneVector{$T},
      h_row::StrideOneVector{Cint},
      h_col::StrideOneVector{Cint},
    )
      $cutest_ush(status, n, x, nnzh, lh, h_val, h_row, h_col)
    end
  end
end

"""
    ueh(T, status, n, x, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

The ueh subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a sparse
matrix in finite element format H=eΣ1He, where each square symmetric
element He involves a small subset of the rows of the Hessian matrix.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

  - status:     [OUT] Vector{Cint}
  - n:          [IN]  Vector{Cint}
  - x:          [IN]  Vector{T}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN]  Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN]  Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN]  Vector{Cint}
  - he_val:     [OUT] Vector{T}
  - byrows:     [IN]  Vector{Bool}
"""
function ueh end

for (cutest_cint_ueh, T) in ((:cutest_cint_ueh_s_, :Float32), (:cutest_cint_ueh_, :Float64), (:cutest_cint_ueh_q_, :Float128))
  @eval begin
    function ueh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      ne::StrideOneVector{Cint},
      lhe_ptr::StrideOneVector{Cint},
      he_row_ptr::StrideOneVector{Cint},
      he_val_ptr::StrideOneVector{Cint},
      lhe_row::StrideOneVector{Cint},
      he_row::StrideOneVector{Cint},
      lhe_val::StrideOneVector{Cint},
      he_val::StrideOneVector{$T},
      byrows::StrideOneVector{Bool},
    )
      $cutest_cint_ueh(
        status,
        n,
        x,
        ne,
        lhe_ptr,
        he_row_ptr,
        he_val_ptr,
        lhe_row,
        he_row,
        lhe_val,
        he_val,
        byrows,
      )
    end
  end
end

"""
    ugrdh(T, status, n, x, g, lh1, h)

The ugrdh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
dense matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - g:       [OUT] Vector{T}
  - lh1:     [IN]  Vector{Cint}
  - h:       [OUT] Matrix{T}
"""
function ugrdh end

for (cutest_ugrdh, T) in ((:cutest_ugrdh_s_, :Float32), (:cutest_ugrdh_, :Float64), (:cutest_ugrdh_q_, :Float128))
  @eval begin
    function ugrdh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      g::StrideOneVector{$T},
      lh1::StrideOneVector{Cint},
      h::Matrix{$T},
    )
      $cutest_ugrdh(status, n, x, g, lh1, h)
    end
  end
end

"""
    ugrsh(T, status, n, x, g, nnzh, lh, h_val, h_row, h_col)

The ugrsh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
sparse matrix in coordinate format. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - g:       [OUT] Vector{T}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN]  Vector{Cint}
  - h_val:   [OUT] Vector{T}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function ugrsh end

for (cutest_ugrsh, T) in ((:cutest_ugrsh_s_, :Float32), (:cutest_ugrsh_, :Float64), (:cutest_ugrsh_q_, :Float128))
  @eval begin
    function ugrsh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      g::StrideOneVector{$T},
      nnzh::StrideOneVector{Cint},
      lh::StrideOneVector{Cint},
      h_val::StrideOneVector{$T},
      h_row::StrideOneVector{Cint},
      h_col::StrideOneVector{Cint},
    )
      $cutest_ugrsh(status, n, x, g, nnzh, lh, h_val, h_row, h_col)
    end
  end
end

"""
    ugreh(T, status, n, x, g, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

The ugreh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
sparse matrix in finite element format H=eΣ1He, where each square
symmetric element H sub e involves a small subset of the rows of the
Hessian matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

  - status:     [OUT] Vector{Cint}
  - n:          [IN]  Vector{Cint}
  - x:          [IN]  Vector{T}
  - g:          [OUT] Vector{T}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN]  Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN]  Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN]  Vector{Cint}
  - he_val:     [OUT] Vector{T}
  - byrows:     [IN]  Vector{Bool}
"""
function ugreh end

for (cutest_cint_ugreh, T) in ((:cutest_cint_ugreh_s_, :Float32), (:cutest_cint_ugreh_, :Float64), (:cutest_cint_ugreh_q_, :Float128))
  @eval begin
    function ugreh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      g::StrideOneVector{$T},
      ne::StrideOneVector{Cint},
      lhe_ptr::StrideOneVector{Cint},
      he_row_ptr::StrideOneVector{Cint},
      he_val_ptr::StrideOneVector{Cint},
      lhe_row::StrideOneVector{Cint},
      he_row::StrideOneVector{Cint},
      lhe_val::StrideOneVector{Cint},
      he_val::StrideOneVector{$T},
      byrows::StrideOneVector{Bool},
    )
      $cutest_cint_ugreh(
        status,
        n,
        x,
        g,
        ne,
        lhe_ptr,
        he_row_ptr,
        he_val_ptr,
        lhe_row,
        he_row,
        lhe_val,
        he_val,
        byrows,
      )
    end
  end
end

"""
    uhprod(T, status, n, goth, x, vector, result)

The uhprod subroutine forms the product of a vector with the Hessian
matrix of the objective function of the problem decoded from a SIF
file by the script sifdecoder at the point X. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - goth:    [IN]  Vector{Bool}
  - x:       [IN]  Vector{T}
  - vector:  [IN]  Vector{T}
  - result:  [OUT] Vector{T}
"""
function uhprod end

for (cutest_cint_uhprod, T) in
    ((:cutest_cint_uhprod_s_, :Float32), (:cutest_cint_uhprod_, :Float64), (:cutest_cint_uhprod_q_, :Float128))
  @eval begin
    function uhprod(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      goth::StrideOneVector{Bool},
      x::StrideOneVector{$T},
      vector::StrideOneVector{$T},
      result::StrideOneVector{$T},
    )
      $cutest_cint_uhprod(status, n, goth, x, vector, result)
    end
  end
end

"""
    ushprod(T, status, n, goth, x, nnz_vector, index_nz_vector, vector, nnz_result, index_nz_result, result)

The ushprod subroutine forms the product of a sparse vector with the
Hessian matrix of the objective function of the problem decoded from a
SIF file by the script sifdecoder at the point X. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

  - status:          [OUT] Vector{Cint}
  - n:               [IN]  Vector{Cint}
  - goth:            [IN]  Vector{Bool}
  - x:               [IN]  Vector{T}
  - nnz_vector:      [IN]  Vector{Cint}
  - index_nz_vector: [IN]  Vector{Cint}
  - vector:          [IN]  Vector{T}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{T}

Notice that `vector` and `result` should have allocated dimension of `n`.
"""
function ushprod end

for (cutest_cint_ushprod, T) in
    ((:cutest_cint_ushprod_s_, :Float32), (:cutest_cint_ushprod_, :Float64), (:cutest_cint_ushprod_q_, :Float128))
  @eval begin
    function ushprod(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      goth::StrideOneVector{Bool},
      x::StrideOneVector{$T},
      nnz_vector::StrideOneVector{Cint},
      index_nz_vector::StrideOneVector{Cint},
      vector::StrideOneVector{$T},
      nnz_result::StrideOneVector{Cint},
      index_nz_result::StrideOneVector{Cint},
      result::StrideOneVector{$T},
    )
      $cutest_cint_ushprod(
        status,
        n,
        goth,
        x,
        nnz_vector,
        index_nz_vector,
        vector,
        nnz_result,
        index_nz_result,
        result,
      )
    end
  end
end

"""
    ubandh(T, status, n, x, semibandwidth, h_band, lbandh, max_semibandwidth)

The ubandh subroutine extracts the elements which lie within a band of
given semi-bandwidth out of the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

  - status:            [OUT] Vector{Cint}
  - n:                 [IN]  Vector{Cint}
  - x:                 [IN]  Vector{T}
  - semibandwidth:     [IN]  Vector{Cint}
  - h_band:            [OUT] Matrix{T}
  - lbandh:            [IN]  Vector{Cint}
  - max_semibandwidth: [OUT] Vector{Cint}
"""
function ubandh end

for (cutest_ubandh, T) in ((:cutest_ubandh_s_, :Float32), (:cutest_ubandh_, :Float64), (:cutest_ubandh_q_, :Float128))
  @eval begin
    function ubandh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      semibandwidth::StrideOneVector{Cint},
      h_band::Matrix{$T},
      lbandh::StrideOneVector{Cint},
      max_semibandwidth::StrideOneVector{Cint},
    )
      $cutest_ubandh(status, n, x, semibandwidth, h_band, lbandh, max_semibandwidth)
    end
  end
end

"""
    cfn(T, status, n, m, x, f, c)

The cfn subroutine evaluates the value of the objective function and
general constraint functions of the problem decoded from a SIF file by
the script sifdecoder at the point X. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - f:       [OUT] Vector{T}
  - c:       [OUT] Vector{T}
"""
function cfn end

for (cutest_cfn, T) in ((:cutest_cfn_s_, :Float32), (:cutest_cfn_, :Float64), (:cutest_cfn_q_, :Float128))
  @eval begin
    function cfn(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      f::StrideOneVector{$T},
      c::StrideOneVector{$T},
    )
      $cutest_cfn(status, n, m, x, f, c)
    end
  end
end

"""
    cofg(T, status, n, x, f, g, grad)

The cofg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - f:       [OUT] Vector{T}
  - g:       [OUT] Vector{T}
  - grad:    [IN]  Vector{Bool}
"""
function cofg end

for (cutest_cint_cofg, T) in ((:cutest_cint_cofg_s_, :Float32), (:cutest_cint_cofg_, :Float64), (:cutest_cint_cofg_q_, :Float128))
  @eval begin
    function cofg(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      f::StrideOneVector{$T},
      g::StrideOneVector{$T},
      grad::StrideOneVector{Bool},
    )
      $cutest_cint_cofg(status, n, x, f, g, grad)
    end
  end
end

"""
    cofsg(T, status, n, x, f, nnzg, lg, g_val, g_var, grad)

The cofsg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient in sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - f:       [OUT] Vector{T}
  - nnzg:    [OUT] Vector{Cint}
  - lg:      [IN]  Vector{Cint}
  - g_val:   [OUT] Vector{T}
  - g_var:   [OUT] Vector{Cint}
  - grad:    [IN]  Vector{Bool}
"""
function cofsg end

for (cutest_cint_cofsg, T) in ((:cutest_cint_cofsg_s_, :Float32), (:cutest_cint_cofsg_, :Float64), (:cutest_cint_cofsg_q_, :Float128))
  @eval begin
    function cofsg(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      f::StrideOneVector{$T},
      nnzg::StrideOneVector{Cint},
      lg::StrideOneVector{Cint},
      g_val::StrideOneVector{$T},
      g_var::StrideOneVector{Cint},
      grad::StrideOneVector{Bool},
    )
      $cutest_cint_cofsg(status, n, x, f, nnzg, lg, g_val, g_var, grad)
    end
  end
end

"""
    ccfg(T, status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)

The ccfg subroutine evaluates the values of the constraint functions
of the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly their gradients. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - c:       [OUT] Vector{T}
  - jtrans:  [IN]  Vector{Bool}
  - lcjac1:  [IN]  Vector{Cint}
  - lcjac2:  [IN]  Vector{Cint}
  - cjac:    [OUT] Matrix{T}
  - grad:    [IN]  Vector{Bool}
"""
function ccfg end

for (cutest_cint_ccfg, T) in ((:cutest_cint_ccfg_s_, :Float32), (:cutest_cint_ccfg_, :Float64), (:cutest_cint_ccfg_q_, :Float128))
  @eval begin
    function ccfg(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      c::StrideOneVector{$T},
      jtrans::StrideOneVector{Bool},
      lcjac1::StrideOneVector{Cint},
      lcjac2::StrideOneVector{Cint},
      cjac::Matrix{$T},
      grad::StrideOneVector{Bool},
    )
      $cutest_cint_ccfg(status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
    end
  end
end

"""
    clfg(T, status, n, m, x, y, f, g, grad)

The clfg subroutine evaluates the value of the Lagrangian function
l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the
script sifdecoder at the point (X,Y), and possibly its gradient. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - f:       [OUT] Vector{T}
  - g:       [OUT] Vector{T}
  - grad:    [IN]  Vector{Bool}
"""
function clfg end

for (cutest_cint_clfg, T) in ((:cutest_cint_clfg_s_, :Float32), (:cutest_cint_clfg_, :Float64), (:cutest_cint_clfg_q_, :Float128))
  @eval begin
    function clfg(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      f::StrideOneVector{$T},
      g::StrideOneVector{$T},
      grad::StrideOneVector{Bool},
    )
      $cutest_cint_clfg(status, n, m, x, y, f, g, grad)
    end
  end
end

"""
    cgr(T, status, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)

The cgr subroutine evaluates the gradients of the general constraints
and of either the objective function f(x) or the Lagrangian function
l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from a SIF
file by the script sifdecoder at the point (x,y)= (X,Y). The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - grlagf:  [IN]  Vector{Bool}
  - g:       [OUT] Vector{T}
  - jtrans:  [IN]  Vector{Bool}
  - lj1:     [IN]  Vector{Cint}
  - lj2:     [IN]  Vector{Cint}
  - j_val:   [OUT] Matrix{T}
"""
function cgr end

for (cutest_cint_cgr, T) in ((:cutest_cint_cgr_s_, :Float32), (:cutest_cint_cgr_, :Float64), (:cutest_cint_cgr_q_, :Float128))
  @eval begin
    function cgr(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      grlagf::StrideOneVector{Bool},
      g::StrideOneVector{$T},
      jtrans::StrideOneVector{Bool},
      lj1::StrideOneVector{Cint},
      lj2::StrideOneVector{Cint},
      j_val::Matrix{$T},
    )
      $cutest_cint_cgr(status, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)
    end
  end
end

"""
    csgr(T, status, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun)

The csgr subroutine evaluates the gradients of the general constraints
and of either the objective function or the Lagrangian function
l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from a SIF
file by the script sifdecoder at the point (x,y)= (X,Y). It also
evaluates the Hessian matrix of the Lagrangian function at (x,y). The
gradients are stored in a sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - grlagf:  [IN]  Vector{Bool}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN]  Vector{Cint}
  - j_val:   [OUT] Vector{T}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
"""
function csgr end

for (cutest_cint_csgr, T) in ((:cutest_cint_csgr_s_, :Float32), (:cutest_cint_csgr_, :Float64), (:cutest_cint_csgr_q_, :Float128))
  @eval begin
    function csgr(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      grlagf::StrideOneVector{Bool},
      nnzj::StrideOneVector{Cint},
      lj::StrideOneVector{Cint},
      j_val::StrideOneVector{$T},
      j_var::StrideOneVector{Cint},
      j_fun::StrideOneVector{Cint},
    )
      $cutest_cint_csgr(status, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun)
    end
  end
end

"""
    ccfsg(T, status, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad)

The ccfsg subroutine evaluates the values of the constraint functions
of the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly their gradients in the constrained minimization
case. The gradients are stored in sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - c:       [OUT] Vector{T}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN]  Vector{Cint}
  - j_val:   [OUT] Vector{T}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
  - grad:    [IN]  Vector{Bool}
"""
function ccfsg end

for (cutest_cint_ccfsg, T) in ((:cutest_cint_ccfsg_s_, :Float32), (:cutest_cint_ccfsg_, :Float64), (:cutest_cint_ccfsg_q_, :Float128))
  @eval begin
    function ccfsg(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      c::StrideOneVector{$T},
      nnzj::StrideOneVector{Cint},
      lj::StrideOneVector{Cint},
      j_val::StrideOneVector{$T},
      j_var::StrideOneVector{Cint},
      j_fun::StrideOneVector{Cint},
      grad::StrideOneVector{Bool},
    )
      $cutest_cint_ccfsg(status, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad)
    end
  end
end

"""
    ccifg(T, status, n, icon, x, ci, gci, grad)

The ccifg subroutine evaluates the value of a particular constraint
function of the problem decoded from a SIF file by the script
sifdecoder at the point X, and possibly its gradient in the
constrained minimization case. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - icon:    [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - ci:      [OUT] Vector{T}
  - gci:     [OUT] Vector{T}
  - grad:    [IN]  Vector{Bool}
"""
function ccifg end

for (cutest_cint_ccifg, T) in ((:cutest_cint_ccifg_s_, :Float32), (:cutest_cint_ccifg_, :Float64), (:cutest_cint_ccifg_q_, :Float128))
  @eval begin
    function ccifg(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      icon::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      ci::StrideOneVector{$T},
      gci::StrideOneVector{$T},
      grad::StrideOneVector{Bool},
    )
      $cutest_cint_ccifg(status, n, icon, x, ci, gci, grad)
    end
  end
end

"""
    ccifsg(T, status, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad)

The ccifsg subroutine evaluates the value of a particular constraint
function of the problem decoded from a SIF file by the script
sifdecoder at the point X, and possibly its gradient in the
constrained minimization case. The gradient is stored in sparse
format. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separable and all constraint functions are partially
separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - icon:    [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - ci:      [OUT] Vector{T}
  - nnzgci:  [OUT] Vector{Cint}
  - lgci:    [IN]  Vector{Cint}
  - gci_val: [OUT] Vector{T}
  - gci_var: [OUT] Vector{Cint}
  - grad:    [IN]  Vector{Bool}
"""
function ccifsg end

for (cutest_cint_ccifsg, T) in
    ((:cutest_cint_ccifsg_s_, :Float32), (:cutest_cint_ccifsg_, :Float64), (:cutest_cint_ccifsg_q_, :Float128))
  @eval begin
    function ccifsg(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      icon::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      ci::StrideOneVector{$T},
      nnzgci::StrideOneVector{Cint},
      lgci::StrideOneVector{Cint},
      gci_val::StrideOneVector{$T},
      gci_var::StrideOneVector{Cint},
      grad::StrideOneVector{Bool},
    )
      $cutest_cint_ccifsg(status, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad)
    end
  end
end

"""
    cgrdh(T, status, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)

The cgrdh subroutine evaluates the gradients of the general
constraints and of either the objective function f(x) or the
Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to the problem
decoded from a SIF file by the script sifdecoder at the point (x,y)=
(X,Y). It also evaluates the Hessian matrix of the Lagrangian function
at (x,y). The gradients and matrices are stored in a dense format. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - grlagf:  [IN]  Vector{Bool}
  - g:       [OUT] Vector{T}
  - jtrans:  [IN]  Vector{Bool}
  - lj1:     [IN]  Vector{Cint}
  - lj2:     [IN]  Vector{Cint}
  - j_val:   [OUT] Matrix{T}
  - lh1:     [IN]  Vector{Cint}
  - h_val:   [OUT] Matrix{T}
"""
function cgrdh end

for (cutest_cint_cgrdh, T) in ((:cutest_cint_cgrdh_s_, :Float32), (:cutest_cint_cgrdh_, :Float64), (:cutest_cint_cgrdh_q_, :Float128))
  @eval begin
    function cgrdh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      grlagf::StrideOneVector{Bool},
      g::StrideOneVector{$T},
      jtrans::StrideOneVector{Bool},
      lj1::StrideOneVector{Cint},
      lj2::StrideOneVector{Cint},
      j_val::Matrix{$T},
      lh1::StrideOneVector{Cint},
      h_val::Matrix{$T},
    )
      $cutest_cint_cgrdh(status, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)
    end
  end
end

"""
    cdh(T, status, n, m, x, y, lh1, h_val)

The cdh subroutine evaluates the Hessian matrix of the Lagrangian
function l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by
the script sifdecoder at the point (x,y)= (X,Y). The matrix is stored
as a dense matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - lh1:     [IN]  Vector{Cint}
  - h_val:   [OUT] Matrix{T}
"""
function cdh end

for (cutest_cdh, T) in ((:cutest_cdh_s_, :Float32), (:cutest_cdh_, :Float64), (:cutest_cdh_q_, :Float128))
  @eval begin
    function cdh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      lh1::StrideOneVector{Cint},
      h_val::Matrix{$T},
    )
      $cutest_cdh(status, n, m, x, y, lh1, h_val)
    end
  end
end

"""
    cdhc(T, status, n, m, x, y, lh1, h_val)

The cdhc subroutine evaluates the Hessian matrix of the constraint
part of the Lagrangian function yTc(x) for the problem decoded from a
SIF file by the script sifdecoder at the point (x,y)= (X,Y). The
matrix is stored as a dense matrix. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - lh1:     [IN]  Vector{Cint}
  - h_val:   [OUT] Matrix{T}
"""
function cdhc end

for (cutest_cdhc, T) in ((:cutest_cdhc_s_, :Float32), (:cutest_cdhc_, :Float64), (:cutest_cdhc_q_, :Float128))
  @eval begin
    function cdhc(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      lh1::StrideOneVector{Cint},
      h_val::Matrix{$T},
    )
      $cutest_cdhc(status, n, m, x, y, lh1, h_val)
    end
  end
end

"""
    cshp(T, status, n, nnzh, lh, h_row, h_col)

The cshp subroutine evaluates the sparsity pattern of the Hessian of
the Lagrangian function l(x,y)=f(x)+yTc(x) for the problem, decoded
from a SIF file by the script sifdecoder, in coordinate format. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN]  Vector{Cint}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function cshp end

for (cutest_cshp, T) in ((:cutest_cshp_s_, :Float32), (:cutest_cshp_, :Float64), (:cutest_cshp_q_, :Float128))
  @eval begin
    function cshp(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      nnzh::StrideOneVector{Cint},
      lh::StrideOneVector{Cint},
      h_row::StrideOneVector{Cint},
      h_col::StrideOneVector{Cint},
    )
      $cutest_cshp(status, n, nnzh, lh, h_row, h_col)
    end
  end
end

"""
    csh(T, status, n, m, x, y, nnzh, lh, h_val, h_row, h_col)

The csh subroutine evaluates the Hessian of the Lagrangian function
l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the
script sifdecoder at the point (x,y)= (X,Y). The matrix is stored in
sparse format. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN]  Vector{Cint}
  - h_val:   [OUT] Vector{T}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function csh end

for (cutest_csh, T) in ((:cutest_csh_s_, :Float32), (:cutest_csh_, :Float64), (:cutest_csh_q_, :Float128))
  @eval begin
    function csh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      nnzh::StrideOneVector{Cint},
      lh::StrideOneVector{Cint},
      h_val::StrideOneVector{$T},
      h_row::StrideOneVector{Cint},
      h_col::StrideOneVector{Cint},
    )
      $cutest_csh(status, n, m, x, y, nnzh, lh, h_val, h_row, h_col)
    end
  end
end

"""
    cshc(T, status, n, m, x, y, nnzh, lh, h_val, h_row, h_col)

The cshc subroutine evaluates the Hessian matrix of the constraint
part of the Lagrangian function yTc(x) for the problem decoded from a
SIF file by the script sifdecoder at the point (x,y)= (X,Y). The
matrix is stored in sparse format. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN]  Vector{Cint}
  - h_val:   [OUT] Vector{T}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function cshc end

for (cutest_cshc, T) in ((:cutest_cshc_s_, :Float32), (:cutest_cshc_, :Float64), (:cutest_cshc_q_, :Float128))
  @eval begin
    function cshc(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      nnzh::StrideOneVector{Cint},
      lh::StrideOneVector{Cint},
      h_val::StrideOneVector{$T},
      h_row::StrideOneVector{Cint},
      h_col::StrideOneVector{Cint},
    )
      $cutest_cshc(status, n, m, x, y, nnzh, lh, h_val, h_row, h_col)
    end
  end
end

"""
    ceh(T, status, n, m, x, y, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

The ceh subroutine evaluates the Hessian matrix of the Lagrangian
function l(x,y)=f(x)+yTc(x) for the problem decoded into OUTSDIF.d at
the point (x,y)= (X,Y). This Hessian matrix is stored as a sparse
matrix in finite element format H=eΣ1He, where each square symmetric
element He involves a small subset of the rows of the Hessian matrix.
The problem under consideration consists in minimizing (or maximizing)
an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:     [OUT] Vector{Cint}
  - n:          [IN]  Vector{Cint}
  - m:          [IN]  Vector{Cint}
  - x:          [IN]  Vector{T}
  - y:          [IN]  Vector{T}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN]  Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN]  Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN]  Vector{Cint}
  - he_val:     [OUT] Vector{T}
  - byrows:     [IN]  Vector{Cint}
"""
function ceh end

for (cutest_ceh, T) in ((:cutest_ceh_s_, :Float32), (:cutest_ceh_, :Float64), (:cutest_ceh_q_, :Float128))
  @eval begin
    function ceh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      ne::StrideOneVector{Cint},
      lhe_ptr::StrideOneVector{Cint},
      he_row_ptr::StrideOneVector{Cint},
      he_val_ptr::StrideOneVector{Cint},
      lhe_row::StrideOneVector{Cint},
      he_row::StrideOneVector{Cint},
      lhe_val::StrideOneVector{Cint},
      he_val::StrideOneVector{$T},
      byrows::StrideOneVector{Cint},
    )
      $cutest_ceh(
        status,
        n,
        m,
        x,
        y,
        ne,
        lhe_ptr,
        he_row_ptr,
        he_val_ptr,
        lhe_row,
        he_row,
        lhe_val,
        he_val,
        byrows,
      )
    end
  end
end

"""
    cidh(T, status, n, x, iprob, lh1, h)

The cidh subroutine evaluates the Hessian matrix of either the
objective function or a constraint function for the problem decoded
from a SIF file by the script sifdecoder at the point X, and possibly
its gradient. The matrix is stored as a dense matrix. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - iprob:   [IN]  Vector{Cint}
  - lh1:     [IN]  Vector{Cint}
  - h:       [OUT] Matrix{T}
"""
function cidh end

for (cutest_cidh, T) in ((:cutest_cidh_s_, :Float32), (:cutest_cidh_, :Float64), (:cutest_cidh_q_, :Float128))
  @eval begin
    function cidh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      iprob::StrideOneVector{Cint},
      lh1::StrideOneVector{Cint},
      h::Matrix{$T},
    )
      $cutest_cidh(status, n, x, iprob, lh1, h)
    end
  end
end

"""
    cish(T, status, n, x, iprob, nnzh, lh, h_val, h_row, h_col)

The cish subroutine evaluates the Hessian of a particular constraint
function or the objective function for the problem decoded from a SIF
file by the script sifdecoder at the point X, and possibly its
gradient. The matrix is stored in sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - iprob:   [IN]  Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN]  Vector{Cint}
  - h_val:   [OUT] Vector{T}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function cish end

for (cutest_cish, T) in ((:cutest_cish_s_, :Float32), (:cutest_cish_, :Float64), (:cutest_cish_q_, :Float128))
  @eval begin
    function cish(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      iprob::StrideOneVector{Cint},
      nnzh::StrideOneVector{Cint},
      lh::StrideOneVector{Cint},
      h_val::StrideOneVector{$T},
      h_row::StrideOneVector{Cint},
      h_col::StrideOneVector{Cint},
    )
      $cutest_cish(status, n, x, iprob, nnzh, lh, h_val, h_row, h_col)
    end
  end
end

"""
    csgrsh(T, status, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, nnzh, lh, h_val, h_row, h_col)

The csgrsh subroutine evaluates the gradients of the general
constraints, the Hessian matrix of the Lagrangian function
l(x,y)=f(x)+yTc(x) and the gradient of either the objective function
or the Lagrangian corresponding to the problem decoded from a SIF file
by the script sifdecoder at the point (x,y)= (X,Y). The data is stored
in sparse format. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - grlagf:  [IN]  Vector{Bool}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN]  Vector{Cint}
  - j_val:   [OUT] Vector{T}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN]  Vector{Cint}
  - h_val:   [OUT] Vector{T}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function csgrsh end

for (cutest_cint_csgrsh, T) in
    ((:cutest_cint_csgrsh_s_, :Float32), (:cutest_cint_csgrsh_, :Float64), (:cutest_cint_csgrsh_q_, :Float128))
  @eval begin
    function csgrsh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      grlagf::StrideOneVector{Bool},
      nnzj::StrideOneVector{Cint},
      lj::StrideOneVector{Cint},
      j_val::StrideOneVector{$T},
      j_var::StrideOneVector{Cint},
      j_fun::StrideOneVector{Cint},
      nnzh::StrideOneVector{Cint},
      lh::StrideOneVector{Cint},
      h_val::StrideOneVector{$T},
      h_row::StrideOneVector{Cint},
      h_col::StrideOneVector{Cint},
    )
      $cutest_cint_csgrsh(
        status,
        n,
        m,
        x,
        y,
        grlagf,
        nnzj,
        lj,
        j_val,
        j_var,
        j_fun,
        nnzh,
        lh,
        h_val,
        h_row,
        h_col,
      )
    end
  end
end

"""
    csgreh(T, status, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

The csgreh subroutine evaluates both the gradients of the general
constraint functions and the Hessian matrix of the Lagrangian function
l(x,y)=f(x)+yTc(x) for the problem decoded into OUTSDIF.d at the point
(x,y)= (X,Y). This Hessian matrix is stored as a sparse matrix in
finite element format H=eΣ1He, where each square symmetric element He
involves a small subset of the rows of the Hessian matrix. The
subroutine also obtains the gradient of either the objective function
or the Lagrangian function, stored in a sparse format. The problem
under consideration consists in minimizing (or maximizing) an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separable and all constraint functions are partially
separable.

  - status:     [OUT] Vector{Cint}
  - n:          [IN]  Vector{Cint}
  - m:          [IN]  Vector{Cint}
  - x:          [IN]  Vector{T}
  - y:          [IN]  Vector{T}
  - grlagf:     [IN]  Vector{Bool}
  - nnzj:       [OUT] Vector{Cint}
  - lj:         [IN]  Vector{Cint}
  - j_val:      [OUT] Vector{T}
  - j_var:      [OUT] Vector{Cint}
  - j_fun:      [OUT] Vector{Cint}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN]  Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN]  Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN]  Vector{Cint}
  - he_val:     [OUT] Vector{T}
  - byrows:     [IN]  Vector{Bool}
"""
function csgreh end

for (cutest_cint_csgreh, T) in
    ((:cutest_cint_csgreh_s_, :Float32), (:cutest_cint_csgreh_, :Float64), (:cutest_cint_csgreh_q_, :Float128))
  @eval begin
    function csgreh(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      grlagf::StrideOneVector{Bool},
      nnzj::StrideOneVector{Cint},
      lj::StrideOneVector{Cint},
      j_val::StrideOneVector{$T},
      j_var::StrideOneVector{Cint},
      j_fun::StrideOneVector{Cint},
      ne::StrideOneVector{Cint},
      lhe_ptr::StrideOneVector{Cint},
      he_row_ptr::StrideOneVector{Cint},
      he_val_ptr::StrideOneVector{Cint},
      lhe_row::StrideOneVector{Cint},
      he_row::StrideOneVector{Cint},
      lhe_val::StrideOneVector{Cint},
      he_val::StrideOneVector{$T},
      byrows::StrideOneVector{Bool},
    )
      $cutest_cint_csgreh(
        status,
        n,
        m,
        x,
        y,
        grlagf,
        nnzj,
        lj,
        j_val,
        j_var,
        j_fun,
        ne,
        lhe_ptr,
        he_row_ptr,
        he_val_ptr,
        lhe_row,
        he_row,
        lhe_val,
        he_val,
        byrows,
      )
    end
  end
end

"""
    chprod(T, status, n, m, goth, x, y, vector, result)

The chprod subroutine forms the product of a vector with the Hessian
matrix of the Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to
the problem decoded from a SIF file by the script sifdecoder at the
point (x,y)= (X,Y). The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - goth:    [IN]  Vector{Bool}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - vector:  [IN]  Vector{T}
  - result:  [OUT] Vector{T}
"""
function chprod end

for (cutest_cint_chprod, T) in
    ((:cutest_cint_chprod_s_, :Float32), (:cutest_cint_chprod_, :Float64), (:cutest_cint_chprod_q_, :Float128))
  @eval begin
    function chprod(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      goth::StrideOneVector{Bool},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      vector::StrideOneVector{$T},
      result::StrideOneVector{$T},
    )
      $cutest_cint_chprod(status, n, m, goth, x, y, vector, result)
    end
  end
end

"""
    cshprod(T, status, n, m, goth, x, y, nnz_vector, index_nz_vector, vector, nnz_result, index_nz_result, result)

The cshprod subroutine forms the product of a sparse vector with the
Hessian matrix of the Lagrangian function l(x,y)=f(x)+yTc(x)
corresponding to the problem decoded from a SIF file by the script
sifdecoder at the point (x,y)= (X,Y). The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

  - status:          [OUT] Vector{Cint}
  - n:               [IN]  Vector{Cint}
  - m:               [IN]  Vector{Cint}
  - goth:            [IN]  Vector{Cint}
  - x:               [IN]  Vector{T}
  - y:               [IN]  Vector{T}
  - nnz_vector:      [IN]  Vector{Cint}
  - index_nz_vector: [IN]  Vector{Cint}
  - vector:          [IN]  Vector{T}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{T}

Notice that `vector` and `result` should have allocated dimension of `n`.
"""
function cshprod end

for (cutest_cshprod, T) in ((:cutest_cshprod_s_, :Float32), (:cutest_cshprod_, :Float64), (:cutest_cshprod_q_, :Float128))
  @eval begin
    function cshprod(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      goth::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      nnz_vector::StrideOneVector{Cint},
      index_nz_vector::StrideOneVector{Cint},
      vector::StrideOneVector{$T},
      nnz_result::StrideOneVector{Cint},
      index_nz_result::StrideOneVector{Cint},
      result::StrideOneVector{$T},
    )
      $cutest_cshprod(
        status,
        n,
        m,
        goth,
        x,
        y,
        nnz_vector,
        index_nz_vector,
        vector,
        nnz_result,
        index_nz_result,
        result,
      )
    end
  end
end

"""
    chcprod(T, status, n, m, goth, x, y, vector, result)

The chcprod subroutine forms the product of a vector with the Hessian
matrix of the constraint part of the Lagrangian function yTc(x) of the
problem decoded from a SIF file by the script sifdecoder at the point
(x,y)= (X,Y). The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - goth:    [IN]  Vector{Bool}
  - x:       [IN]  Vector{T}
  - y:       [IN]  Vector{T}
  - vector:  [IN]  Vector{T}
  - result:  [OUT] Vector{T}
"""
function chcprod end

for (cutest_cint_chcprod, T) in
    ((:cutest_cint_chcprod_s_, :Float32), (:cutest_cint_chcprod_, :Float64), (:cutest_cint_chcprod_q_, :Float128))
  @eval begin
    function chcprod(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      goth::StrideOneVector{Bool},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      vector::StrideOneVector{$T},
      result::StrideOneVector{$T},
    )
      $cutest_cint_chcprod(status, n, m, goth, x, y, vector, result)
    end
  end
end

"""
    cshcprod(T, status, n, m, goth, x, y, nnz_vector, index_nz_vector, vector, nnz_result, index_nz_result, result)

The cshcprod subroutine forms the product of a sparse vector with the
Hessian matrix of the constraint part of the Lagrangian function
yTc(x) corresponding to the problem decoded from a SIF file by the
script sifdecoder at the point (x,y)= (X,Y). The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

  - status:          [OUT] Vector{Cint}
  - n:               [IN]  Vector{Cint}
  - m:               [IN]  Vector{Cint}
  - goth:            [IN]  Vector{Bool}
  - x:               [IN]  Vector{T}
  - y:               [IN]  Vector{T}
  - nnz_vector:      [IN]  Vector{Cint}
  - index_nz_vector: [IN]  Vector{Cint}
  - vector:          [IN]  Vector{T}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{T}
"""
function cshcprod end

for (cutest_cint_cshcprod, T) in
    ((:cutest_cint_cshcprod_s_, :Float32), (:cutest_cint_cshcprod_, :Float64), (:cutest_cint_cshcprod_q_, :Float128))
  @eval begin
    function cshcprod(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      goth::StrideOneVector{Bool},
      x::StrideOneVector{$T},
      y::StrideOneVector{$T},
      nnz_vector::StrideOneVector{Cint},
      index_nz_vector::StrideOneVector{Cint},
      vector::StrideOneVector{$T},
      nnz_result::StrideOneVector{Cint},
      index_nz_result::StrideOneVector{Cint},
      result::StrideOneVector{$T},
    )
      $cutest_cint_cshcprod(
        status,
        n,
        m,
        goth,
        x,
        y,
        nnz_vector,
        index_nz_vector,
        vector,
        nnz_result,
        index_nz_result,
        result,
      )
    end
  end
end

"""
    cjprod(T, status, n, m, gotj, jtrans, x, vector, lvector, result, lresult)

The cjprod subroutine forms the product of a vector with the Jacobian
matrix, or with its transpose, of the constraint functions of the
problem decoded from a SIF file by the script sifdecoder evaluated at
the point X. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - gotj:    [IN]  Vector{Bool}
  - jtrans:  [IN]  Vector{Bool}
  - x:       [IN]  Vector{T}
  - vector:  [IN]  Vector{T}
  - lvector: [IN]  Vector{Cint}
  - result:  [OUT] Vector{T}
  - lresult: [IN]  Vector{Cint}
"""
function cjprod end

for (cutest_cint_cjprod, T) in
    ((:cutest_cint_cjprod_s_, :Float32), (:cutest_cint_cjprod_, :Float64), (:cutest_cint_cjprod_q_, :Float128))
  @eval begin
    function cjprod(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      gotj::StrideOneVector{Bool},
      jtrans::StrideOneVector{Bool},
      x::StrideOneVector{$T},
      vector::StrideOneVector{$T},
      lvector::StrideOneVector{Cint},
      result::StrideOneVector{$T},
      lresult::StrideOneVector{Cint},
    )
      $cutest_cint_cjprod(status, n, m, gotj, jtrans, x, vector, lvector, result, lresult)
    end
  end
end

"""
    csjprod(T, status, n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, nnz_result, index_nz_result, result, lresult)

The csjprod subroutine forms the product of a sparse vector with the
Jacobian matrix, or with its transpose, of the constraint functions of
the problem decoded from a SIF file by the script sifdecoder evaluated
at the point X. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

  - status:          [OUT] Vector{Cint}
  - n:               [IN]  Vector{Cint}
  - m:               [IN]  Vector{Cint}
  - gotj:            [IN]  Vector{Bool}
  - jtrans:          [IN]  Vector{Bool}
  - x:               [IN]  Vector{T}
  - nnz_vector:      [IN]  Vector{Cint}
  - index_nz_vector: [IN]  Vector{Cint}
  - vector:          [IN]  Vector{T}
  - lvector:         [IN]  Vector{Cint}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{T}
  - lresult:         [IN]  Vector{Cint}
"""
function csjprod end

for (cutest_cint_csjprod, T) in
    ((:cutest_cint_csjprod_s_, :Float32), (:cutest_cint_csjprod_, :Float64), (:cutest_cint_csjprod_q_, :Float128))
  @eval begin
    function csjprod(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      gotj::StrideOneVector{Bool},
      jtrans::StrideOneVector{Bool},
      x::StrideOneVector{$T},
      nnz_vector::StrideOneVector{Cint},
      index_nz_vector::StrideOneVector{Cint},
      vector::StrideOneVector{$T},
      lvector::StrideOneVector{Cint},
      nnz_result::StrideOneVector{Cint},
      index_nz_result::StrideOneVector{Cint},
      result::StrideOneVector{$T},
      lresult::StrideOneVector{Cint},
    )
      $cutest_cint_csjprod(
        status,
        n,
        m,
        gotj,
        jtrans,
        x,
        nnz_vector,
        index_nz_vector,
        vector,
        lvector,
        nnz_result,
        index_nz_result,
        result,
        lresult,
      )
    end
  end
end

"""
    cchprods(T, status, n, m, goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)

The cchprods subroutine forms the product of a vector with each of the
Hessian matrix of the constraint functions c(x) corresponding to the
problem decoded from a SIF file by the script sifdecoder at the point
x= X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separable and all constraint functions are partially
separable.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - goth:    [IN]  Vector{Bool}
  - x:       [IN]  Vector{T}
  - vector:  [IN]  Vector{T}
  - lchp:    [IN]  Vector{Cint}
  - chp_val: [OUT] Vector{T}
  - chp_ind: [IN]  Vector{Cint}
  - chp_ptr: [IN]  Vector{Cint}
"""
function cchprods end

for (cutest_cint_cchprods, T) in
    ((:cutest_cint_cchprods_s_, :Float32), (:cutest_cint_cchprods_, :Float64), (:cutest_cint_cchprods_q_, :Float128))
  @eval begin
    function cchprods(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      goth::StrideOneVector{Bool},
      x::StrideOneVector{$T},
      vector::StrideOneVector{$T},
      lchp::StrideOneVector{Cint},
      chp_val::StrideOneVector{$T},
      chp_ind::StrideOneVector{Cint},
      chp_ptr::StrideOneVector{Cint},
    )
      $cutest_cint_cchprods(status, n, m, goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)
    end
  end
end

"""
    cchprodsp(T, status, m, lchp, chp_ind, chp_ptr)

The cchprodsp subroutine obtains the sparsity structure used when forming the
product of a vector with each of the Hessian matrices of the constraint
functions c(x) corresponding to the problem decoded from a SIF file by the
script sifdecoder at the point x= X.

  - status:  [OUT] Vector{Cint}
  - m:       [IN]  Vector{Cint}
  - lchp:    [IN]  Vector{Cint}
  - chp_ind: [IN]  Vector{Cint}
  - chp_ptr: [IN]  Vector{Cint}
"""
function cchprodsp end

for (cutest_cchprodsp, T) in ((:cutest_cchprodsp_s_, :Float32), (:cutest_cchprodsp_, :Float64), (:cutest_cchprodsp_q_, :Float128))
  @eval begin
    function cchprodsp(
      ::Type{$T},
      status::StrideOneVector{Cint},
      m::StrideOneVector{Cint},
      lchp::StrideOneVector{Cint},
      chp_ind::StrideOneVector{Cint},
      chp_ptr::StrideOneVector{Cint},
    )
      $cutest_cchprodsp(status, m, lchp, chp_ind, chp_ptr)
    end
  end
end

"""
    uterminate(T, status)

The uterminate subroutine deallocates all workspace arrays created
since the last call to usetup.

  - status:  [OUT] Vector{Cint}
"""
function uterminate end

for (cutest_uterminate, T) in ((:cutest_uterminate_s_, :Float32), (:cutest_uterminate_, :Float64), (:cutest_uterminate_q_, :Float128))
  @eval begin
    function uterminate(::Type{$T}, status::StrideOneVector{Cint})
      $cutest_uterminate(status)
    end
  end
end

"""
    cterminate(T, status)

The uterminate subroutine deallocates all workspace arrays created
since the last call to csetup.

  - status:  [OUT] Vector{Cint}
"""
function cterminate end

for (cutest_cterminate, T) in ((:cutest_cterminate_s_, :Float32), (:cutest_cterminate_, :Float64), (:cutest_cterminate_q_, :Float128))
  @eval begin
    function cterminate(::Type{$T}, status::StrideOneVector{Cint})
      $cutest_cterminate(status)
    end
  end
end

"""
    cifn(T, status, n, iprob, x, f)

The cifn subroutine evaluates the value of either the objective function or a
constrainted function of the problem decoded from a SIF file by the script
sifdecoder at the point X, in the constrained minimization case.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - iprob:   [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - f:       [OUT] Vector{T}
"""
function cifn end

for (cutest_cifn, T) in ((:cutest_cifn_s_, :Float32), (:cutest_cifn_, :Float64), (:cutest_cifn_q_, :Float128))
  @eval begin
    function cifn(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      iprob::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      f::StrideOneVector{$T},
    )
      $cutest_cifn(status, n, iprob, x, f)
    end
  end
end

"""
    cisgr(T, status, n, iprod, x, nnzg, lg, g_val, g_var)

The cisgr subroutine evaluates the gradient of either the objective function or
a constraint function of the problem decoded from a SIF file by the script
sifdecoder at the point X, in the constrained minimization case. The gradient
is stored in sparse format.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - iprob:   [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - nnzg:    [OUT] Vector{Cint}
  - lg:      [IN]  Vector{Cint}
  - g_val:   [OUT] Vector{T}
  - g_var:   [OUT] Vector{Cint}
"""
function cisgr end

for (cutest_cisgr, T) in ((:cutest_cisgr_s_, :Float32), (:cutest_cisgr_, :Float64), (:cutest_cisgr_q_, :Float128))
  @eval begin
    function cisgr(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      iprod::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      nnzg::StrideOneVector{Cint},
      lg::StrideOneVector{Cint},
      g_val::StrideOneVector{$T},
      g_var::StrideOneVector{Cint},
    )
      $cutest_cisgr(status, n, iprod, x, nnzg, lg, g_val, g_var)
    end
  end
end

"""
    csgrp(T, status, n, nnzj, lj, j_var, j_fun)

The csgrp subroutine evaluates sparsity pattern used when storing the gradients
of the general constraints and of either the objective function or the
Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded
from a SIF file by the script sifdecoder.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN]  Vector{Cint}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
"""
function csgrp end

for (cutest_csgrp, T) in ((:cutest_csgrp_s_, :Float32), (:cutest_csgrp_, :Float64), (:cutest_csgrp_q_, :Float128))
  @eval begin
    function csgrp(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      nnzj::StrideOneVector{Cint},
      lj::StrideOneVector{Cint},
      j_var::StrideOneVector{Cint},
      j_fun::StrideOneVector{Cint},
    )
      $cutest_csgrp(status, n, nnzj, lj, j_var, j_fun)
    end
  end
end

"""
    cigr(T, status, n, iprob, x, g_val)

The cigr subroutine evaluates the gradient of either the objective function or
a constraint function of the problem decoded from a SIF file by the script
sifdecoder at the point X, in the constrained minimization case.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - iprob:   [IN]  Vector{Cint}
  - x:       [IN]  Vector{T}
  - g_val:   [OUT] Vector{T}
"""
function cigr end

for (cutest_cigr, T) in ((:cutest_cigr_s_, :Float32), (:cutest_cigr_, :Float64), (:cutest_cigr_q_, :Float128))
  @eval begin
    function cigr(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      iprob::StrideOneVector{Cint},
      x::StrideOneVector{$T},
      g_val::StrideOneVector{$T},
    )
      $cutest_cigr(status, n, iprob, x, g_val)
    end
  end
end

"""
    csgrshp(T, status, n, nnzj, lj, j_var, j_fun, nnzh, lh, h_row, h_col)

The csgrshp subroutine evaluates sparsity pattern used when storing the
gradients of the general constraints and of either the objective function or
the Lagrangian function l(x,y)=f(x)+yTc(x), as well as the Hessian of the
Lagrangian function, corresponding to the problem decoded from a SIF file by
the script sifdecoder.

  - status:  [OUT] Vector{Cint}
  - n:       [IN]  Vector{Cint}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN]  Vector{Cint}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN]  Vector{Cint}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function csgrshp end

for (cutest_csgrshp, T) in ((:cutest_csgrshp_s_, :Float32), (:cutest_csgrshp_, :Float64), (:cutest_csgrshp_q_, :Float128))
  @eval begin
    function csgrshp(
      ::Type{$T},
      status::StrideOneVector{Cint},
      n::StrideOneVector{Cint},
      nnzj::StrideOneVector{Cint},
      lj::StrideOneVector{Cint},
      j_var::StrideOneVector{Cint},
      j_fun::StrideOneVector{Cint},
      nnzh::StrideOneVector{Cint},
      lh::StrideOneVector{Cint},
      h_row::StrideOneVector{Cint},
      h_col::StrideOneVector{Cint},
    )
      $cutest_csgrshp(status, n, nnzj, lj, j_var, j_fun, nnzh, lh, h_row, h_col)
    end
  end
end

"""
    csjp(T, status, nnzj, lj, jvar, jcon)

The csjp subroutine evaluates the sparsity pattern of the Jacobian of the
constraints for a problem decoded from a SIF file by the script sifdecoder.

  - status:  [OUT] Vector{Cint}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN]  Vector{Cint}
  - jvar:    [OUT] Vector{Cint}
  - jcon:    [OUT] Vector{Cint}
"""
function csjp end

for (cutest_csjp, T) in ((:cutest_csjp_s_, :Float32), (:cutest_csjp_, :Float64), (:cutest_csjp_q_, :Float128))
  @eval begin
    function csjp(
      ::Type{$T},
      status::StrideOneVector{Cint},
      nnzj::StrideOneVector{Cint},
      lj::StrideOneVector{Cint},
      jvar::StrideOneVector{Cint},
      jcon::StrideOneVector{Cint},
    )
      $cutest_csjp(status, nnzj, lj, jvar, jcon)
    end
  end
end

"""
    fopen(T, funit, outsdif, status)
"""
function fopen end

for (fortran_open, T) in ((:fortran_open_s_, :Float32), (:fortran_open_, :Float64), (:fortran_open_q_, :Float128))
  @eval begin
    function fopen(::Type{$T}, funit, outsdif, status)
      $fortran_open(funit, outsdif, status)
    end
  end
end

"""
    fclose(T, funit, status)
"""
function fclose end

for (fortran_close, T) in ((:fortran_close_s_, :Float32), (:fortran_close_, :Float64), (:fortran_close_q_, :Float128))
  @eval begin
    function fclose(::Type{$T}, funit, status)
      $fortran_close(funit, status)
    end
  end
end

"""
    cconst(T, status, m, c)
"""
function cconst end

for (cutest_cconst, T) in ((:cutest_cconst_s_, :Float32), (:cutest_cconst_, :Float64), (:cutest_cconst_q_, :Float128))
  @eval begin
    function cconst(::Type{$T}, status, m, c)
      $cutest_cconst(status, m, c)
    end
  end
end
