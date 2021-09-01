export usetup,
  csetup,
  udimen,
  udimsh,
  udimse,
  uvartype,
  unames,
  ureport,
  cdimen,
  cdimsj,
  cdimsh,
  cdimchp,
  cdimse,
  cstats,
  cvartype,
  cnames,
  creport,
  connames,
  pname,
  probname,
  varnames,
  ufn,
  ugr,
  uofg,
  udh,
  ushp,
  ush,
  ueh,
  ugrdh,
  ugrsh,
  ugreh,
  uhprod,
  ushprod,
  ubandh,
  cfn,
  cofg,
  cofsg,
  ccfg,
  clfg,
  cgr,
  csgr,
  ccfsg,
  ccifg,
  ccifsg,
  cgrdh,
  cdh,
  cdhc,
  cshp,
  csh,
  cshc,
  ceh,
  cidh,
  cish,
  csgrsh,
  csgreh,
  chprod,
  cshprod,
  chcprod,
  cshcprod,
  cjprod,
  csjprod,
  cchprods,
  cchprodsp,
  uterminate,
  cterminate,
  cifn,
  cisgr,
  csgrp,
  cigr,
  csgrshp

"""# usetup
The usetup subroutine sets up the correct data structures for
subsequent computations in the case where the only possible
constraints are bound constraints. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

For more information, run the shell command

    man cutest_usetup

Usage:

    usetup(io_err, input, out, io_buffer, n, x, x_l, x_u)

  - io_err:    [OUT] Vector{Cint}
  - input:     [IN] Vector{Cint}
  - out:       [IN] Vector{Cint}
  - io_buffer: [IN] Vector{Cint}
  - n:         [IN] Vector{Cint}
  - x:         [OUT] Vector{Cdouble}
  - x_l:       [OUT] Vector{Cdouble}
  - x_u:       [OUT] Vector{Cdouble}
"""
function usetup(
  io_err::StrideOneVector{Cint},
  input::StrideOneVector{Cint},
  out::StrideOneVector{Cint},
  io_buffer::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  x_l::StrideOneVector{Cdouble},
  x_u::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_usetup_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
    ),
    io_err,
    input,
    out,
    io_buffer,
    n,
    x,
    x_l,
    x_u,
  )
end

"""# csetup
The csetup subroutine sets up the correct data structures for
subsequent computations on the problem decoded from a SIF file by the
script sifdecoder. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_csetup

Usage:

    csetup(io_err, input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn,
linear, e_order, l_order, v_order)

  - io_err:    [OUT] Vector{Cint}
  - input:     [IN] Vector{Cint}
  - out:       [IN] Vector{Cint}
  - io_buffer: [IN] Vector{Cint}
  - n:         [IN] Vector{Cint}
  - m:         [IN] Vector{Cint}
  - x:         [OUT] Vector{Cdouble}
  - x_l:       [OUT] Vector{Cdouble}
  - x_u:       [OUT] Vector{Cdouble}
  - y:         [OUT] Vector{Cdouble}
  - c_l:       [OUT] Vector{Cdouble}
  - c_u:       [OUT] Vector{Cdouble}
  - equatn:    [OUT] Vector{Cint}
  - linear:    [OUT] Vector{Cint}
  - e_order:   [IN] Vector{Cint}
  - l_order:   [IN] Vector{Cint}
  - v_order:   [IN] Vector{Cint}
"""
function csetup(
  io_err::StrideOneVector{Cint},
  input::StrideOneVector{Cint},
  out::StrideOneVector{Cint},
  io_buffer::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  x_l::StrideOneVector{Cdouble},
  x_u::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  c_l::StrideOneVector{Cdouble},
  c_u::StrideOneVector{Cdouble},
  equatn::StrideOneVector{Cint},
  linear::StrideOneVector{Cint},
  e_order::StrideOneVector{Cint},
  l_order::StrideOneVector{Cint},
  v_order::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_csetup_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
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

"""# udimen
The udimen subroutine discovers how many variables are involved in the
problem decoded from a SIF file by the script sifdecoder. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The
objective function is group-partially separable.

For more information, run the shell command

    man cutest_udimen

Usage:

    udimen(io_err, input, n)

  - io_err:  [OUT] Vector{Cint}
  - input:   [IN] Vector{Cint}
  - n:       [OUT] Vector{Cint}
"""
function udimen(
  io_err::StrideOneVector{Cint},
  input::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_udimen_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    input,
    n,
  )
end

"""# udimsh
The udimsh subroutine determine the number of nonzeros required to
store the Hessian matrix of the objective function of the problem
decoded from a SIF file by the script sifdecoder at the point X. This
Hessian matrix is stored as a sparse matrix in coordinate format. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu.
The objective function is group-partially separable.

For more information, run the shell command

    man cutest_udimsh

Usage:

    udimsh(io_err, nnzh)

  - io_err:  [OUT] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
"""
function udimsh(io_err::StrideOneVector{Cint}, nnzh::StrideOneVector{Cint})
  ccall(dlsym(cutest_lib, "cutest_udimsh_"), Nothing, (Ptr{Cint}, Ptr{Cint}), io_err, nnzh)
end

"""# udimse
The udimse subroutine determine the number of nonzeros required to
store the Hessian matrix of the objective function of the problem
decoded from a SIF file by the script sifdecoder at the point X. This
Hessian matrix is stored as a sparse matrix in finite element format
H=eΣ1He, where each square symmetric element H_i involves a small
subset of the rows of the Hessian matrix. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

For more information, run the shell command

    man cutest_udimse

Usage:

    udimse(io_err, ne, he_val_ne, he_row_ne)

  - io_err:    [OUT] Vector{Cint}
  - ne:        [OUT] Vector{Cint}
  - he_val_ne: [OUT] Vector{Cint}
  - he_row_ne: [OUT] Vector{Cint}
"""
function udimse(
  io_err::StrideOneVector{Cint},
  ne::StrideOneVector{Cint},
  he_val_ne::StrideOneVector{Cint},
  he_row_ne::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_udimse_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    ne,
    he_val_ne,
    he_row_ne,
  )
end

"""# uvartype
The uvartype subroutine determines the type (continuous, 0-1, integer)
of each variable involved in the problem decoded from a SIF file by
the script sifdecoder. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

For more information, run the shell command

    man cutest_uvartype

Usage:

    uvartype(io_err, n, x_type)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x_type:  [OUT] Vector{Cint}
"""
function uvartype(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x_type::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_uvartype_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    n,
    x_type,
  )
end

"""# unames
The unames subroutine obtains the names of the problem and its
variables. The problem under consideration is to minimize or maximize
an objective function f(x) over all x ∈ Rn subject to the simple
bounds xl≤x≤xu. The objective function is group-partially separable.

For more information, run the shell command

    man cutest_unames

Usage:

    unames(io_err, n, pname, vname)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - pname:   [OUT] Vector{UInt8}
  - vname:   [OUT] Vector{UInt8}

To get useful names, use `String(x)` where `x` can be `pname` or `vname[:,i]`.
"""
function unames(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  pname::StrideOneVector{UInt8},
  vname::Array{UInt8, 2},
)
  ccall(
    dlsym(cutest_lib, "cutest_unames_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{UInt8}, Ptr{UInt8}),
    io_err,
    n,
    pname,
    vname,
  )
end

"""# ureport
The ureport subroutine obtains statistics concerning function
evaluation and CPU time used for unconstrained or bound-constrained
optimization in a standardized format. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

For more information, run the shell command

    man cutest_ureport

Usage:

    ureport(io_err, calls, time)

  - io_err:  [OUT] Vector{Cint}
  - calls:   [OUT] Vector{Cdouble}
  - time:    [OUT] Vector{Cdouble}
"""
function ureport(
  io_err::StrideOneVector{Cint},
  calls::StrideOneVector{Cdouble},
  time::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_ureport_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err,
    calls,
    time,
  )
end

"""# cdimen
The cdimen subroutine discovers how many variables and constraints are
involved in the problem decoded from a SIF file by the script
sifdecoder. The problem under consideration is to minimize or maximize
an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_cdimen

Usage:

    cdimen(io_err, input, n, m)

  - io_err:  [OUT] Vector{Cint}
  - input:   [IN] Vector{Cint}
  - n:       [OUT] Vector{Cint}
  - m:       [OUT] Vector{Cint}
"""
function cdimen(
  io_err::StrideOneVector{Cint},
  input::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cdimen_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    input,
    n,
    m,
  )
end

"""# cdimsj
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

For more information, run the shell command

    man cutest_cdimsj

Usage:

    cdimsj(io_err, nnzj)

  - io_err:  [OUT] Vector{Cint}
  - nnzj:    [OUT] Vector{Cint}
"""
function cdimsj(io_err::StrideOneVector{Cint}, nnzj::StrideOneVector{Cint})
  ccall(dlsym(cutest_lib, "cutest_cdimsj_"), Nothing, (Ptr{Cint}, Ptr{Cint}), io_err, nnzj)
end

"""# cdimsh
The cdimsh subroutine determines the number of nonzero elements
required to store the Hessian matrix of the Lagrangian function for
the problem decoded into OUTSDIF.d in the constrained minimization
case. The matrix is stored in sparse "coordinate" format. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_cdimsh

Usage:

    cdimsh(io_err, nnzh)

  - io_err:  [OUT] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
"""
function cdimsh(io_err::StrideOneVector{Cint}, nnzh::StrideOneVector{Cint})
  ccall(dlsym(cutest_lib, "cutest_cdimsh_"), Nothing, (Ptr{Cint}, Ptr{Cint}), io_err, nnzh)
end

"""# cdimchp
The cdimchp subroutine determines the number of nonzero elements
required to store the products of the Hessian matrices of the
constraint functions with a specified vector for the problem decoded
into OUTSDIF.d in the constrained minimization case. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_cdimchp

Usage:

    cdimchp(io_err, nnzchp)

  - io_err:  [OUT] Vector{Cint}
  - nnzchp:  [OUT] Vector{Cint}
"""
function cdimchp(io_err::StrideOneVector{Cint}, nnzchp::StrideOneVector{Cint})
  ccall(dlsym(cutest_lib, "cutest_cdimchp_"), Nothing, (Ptr{Cint}, Ptr{Cint}), io_err, nnzchp)
end

"""# cdimse
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

For more information, run the shell command

    man cutest_cdimse

Usage:

    cdimse(io_err, ne, he_val_ne, he_row_ne)

  - io_err:    [OUT] Vector{Cint}
  - ne:        [OUT] Vector{Cint}
  - he_val_ne: [OUT] Vector{Cint}
  - he_row_ne: [OUT] Vector{Cint}
"""
function cdimse(
  io_err::StrideOneVector{Cint},
  ne::StrideOneVector{Cint},
  he_val_ne::StrideOneVector{Cint},
  he_row_ne::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cdimse_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    ne,
    he_val_ne,
    he_row_ne,
  )
end

"""# cstats
    cstats(io_err, nonlinear_variables_objective,
nonlinear_variables_constraints, equality_constraints,
linear_constraints)

  - io_err:                          [OUT] Vector{Cint}
  - nonlinear_variables_objective:   [OUT] Vector{Cint}
  - nonlinear_variables_constraints: [OUT] Vector{Cint}
  - equality_constraints:            [OUT] Vector{Cint}
  - linear_constraints:              [OUT] Vector{Cint}
"""
function cstats(
  io_err::StrideOneVector{Cint},
  nonlinear_variables_objective::StrideOneVector{Cint},
  nonlinear_variables_constraints::StrideOneVector{Cint},
  equality_constraints::StrideOneVector{Cint},
  linear_constraints::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cstats_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    nonlinear_variables_objective,
    nonlinear_variables_constraints,
    equality_constraints,
    linear_constraints,
  )
end

"""# cvartype
The cvartype subroutine determines the type (continuous, 0-1, integer)
of each variable involved in the problem decoded from a SIF file by
the script sifdecoder. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to
general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_cvartype

Usage:

    cvartype(io_err, n, x_type)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x_type:  [OUT] Vector{Cint}
"""
function cvartype(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x_type::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cvartype_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    n,
    x_type,
  )
end

"""# cnames
The cnames subroutine obtains the names of the problem, its variables
and general constraints. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

For more information, run the shell command

    man cutest_cnames

Usage:

    cnames(io_err, n, m, pname, vname, cname)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - pname:   [OUT] Vector{UInt8}
  - vname:   [OUT] Vector{UInt8}
  - cname:   [OUT] Vector{UInt8}

To get useful names, use `String(x)` where `x` can be `pname`, `vname[:,i]`,
or `cname[:,i]`.
"""
function cnames(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  pname::StrideOneVector{UInt8},
  vname::Array{UInt8, 2},
  cname::Array{UInt8, 2},
)
  ccall(
    dlsym(cutest_lib, "cutest_cnames_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{UInt8}, Ptr{UInt8}, Ptr{UInt8}),
    io_err,
    n,
    m,
    pname,
    vname,
    cname,
  )
end

"""# creport
The creport subroutine obtains statistics concerning function
evaluation and CPU time used for constrained optimization in a
standardized format. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_creport

Usage:

    creport(io_err, calls, time)

  - io_err:  [OUT] Vector{Cint}
  - calls:   [OUT] Vector{Cdouble}
  - time:    [OUT] Vector{Cdouble}
"""
function creport(
  io_err::StrideOneVector{Cint},
  calls::StrideOneVector{Cdouble},
  time::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_creport_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err,
    calls,
    time,
  )
end

"""# connames
The connames subroutine obtains the names of the general constraints
of the problem. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_connames

Usage:

    connames(io_err, m, cname)

  - io_err:  [OUT] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - cname:   [OUT] Vector{UInt8}

To get useful names, use `String(cname[:,i])`.
"""
function connames(io_err::StrideOneVector{Cint}, m::StrideOneVector{Cint}, cname::Array{UInt8, 2})
  ccall(
    dlsym(cutest_lib, "cutest_connames_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{UInt8}),
    io_err,
    m,
    cname,
  )
end

"""# pname
The pname subroutine obtains the name of the problem directly from the
datafile OUTSDIF.d that was created by the script sifdecoder when
decoding a SIF file. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_pname

Usage:

    pname(io_err, input, pname)

  - io_err:  [OUT] Vector{Cint}
  - input:   [IN] Vector{Cint}
  - pname:   [OUT] Vector{UInt8}
"""
function pname(
  io_err::StrideOneVector{Cint},
  input::StrideOneVector{Cint},
  pname::StrideOneVector{UInt8},
)
  ccall(
    dlsym(cutest_lib, "cutest_pname_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{UInt8}),
    io_err,
    input,
    pname,
  )
end

"""# probname
The probname subroutine obtains the name of the problem. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_probname

Usage:

    probname(io_err, pname)

  - io_err:  [OUT] Vector{Cint}
  - pname:   [OUT] Vector{UInt8}

To get a useful name, use `String(pname)`.
"""
function probname(io_err::StrideOneVector{Cint}, pname::StrideOneVector{UInt8})
  ccall(dlsym(cutest_lib, "cutest_probname_"), Nothing, (Ptr{Cint}, Ptr{UInt8}), io_err, pname)
end

"""# varnames
The varnames subroutine obtains the names of the problem variables.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separable and all constraint functions are partially
separable.

For more information, run the shell command

    man cutest_varnames

Usage:

    varnames(io_err, n, vname)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - vname:   [OUT] Vector{UInt8}

To get useful names, use `String(vname[:, i])`.
"""
function varnames(io_err::StrideOneVector{Cint}, n::StrideOneVector{Cint}, vname::Array{UInt8, 2})
  ccall(
    dlsym(cutest_lib, "cutest_varnames_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{UInt8}),
    io_err,
    n,
    vname,
  )
end

"""# ufn
The ufn subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

For more information, run the shell command

    man cutest_ufn

Usage:

    ufn(io_err, n, x, f)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - f:       [OUT] Vector{Cdouble}
"""
function ufn(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  f::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_ufn_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err,
    n,
    x,
    f,
  )
end

"""# ugr
The ugr subroutine evaluates the gradient of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

For more information, run the shell command

    man cutest_ugr

Usage:

    ugr(io_err, n, x, g)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - g:       [OUT] Vector{Cdouble}
"""
function ugr(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  g::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_ugr_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err,
    n,
    x,
    g,
  )
end

"""# uofg
The uofg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

For more information, run the shell command

    man cutest_uofg

Usage:

    uofg(io_err, n, x, f, g, grad)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - f:       [OUT] Vector{Cdouble}
  - g:       [OUT] Vector{Cdouble}
  - grad:    [IN] Vector{Cint}
"""
function uofg(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  f::StrideOneVector{Cdouble},
  g::StrideOneVector{Cdouble},
  grad::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_uofg_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}),
    io_err,
    n,
    x,
    f,
    g,
    grad,
  )
end

"""# udh
The udh subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a dense
matrix. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

For more information, run the shell command

    man cutest_udh

Usage:

    udh(io_err, n, x, lh1, h)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - lh1:     [IN] Vector{Cint}
  - h:       [OUT] Array{Cdouble, 2}
"""
function udh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  lh1::StrideOneVector{Cint},
  h::Array{Cdouble, 2},
)
  ccall(
    dlsym(cutest_lib, "cutest_udh_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    io_err,
    n,
    x,
    lh1,
    h,
  )
end

"""# ushp
The ushp subroutine evaluates the sparsity pattern of the Hessian
matrix of the objective function of the problem, decoded from a SIF
file by the script sifdecoder, in coordinate format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

For more information, run the shell command

    man cutest_ushp

Usage:

    ushp(io_err, n, nnzh, lh, h_row, h_col)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function ushp(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  nnzh::StrideOneVector{Cint},
  lh::StrideOneVector{Cint},
  h_row::StrideOneVector{Cint},
  h_col::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ushp_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    n,
    nnzh,
    lh,
    h_row,
    h_col,
  )
end

"""# ush
The ush subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a sparse
matrix in coordinate format. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

For more information, run the shell command

    man cutest_ush

Usage:

    ush(io_err, n, x, nnzh, lh, h_val, h_row, h_col)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function ush(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  nnzh::StrideOneVector{Cint},
  lh::StrideOneVector{Cint},
  h_val::StrideOneVector{Cdouble},
  h_row::StrideOneVector{Cint},
  h_col::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ush_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    n,
    x,
    nnzh,
    lh,
    h_val,
    h_row,
    h_col,
  )
end

"""# ueh
The ueh subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a sparse
matrix in finite element format H=eΣ1He, where each square symmetric
element He involves a small subset of the rows of the Hessian matrix.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

For more information, run the shell command

    man cutest_ueh

Usage:

    ueh(io_err, n, x, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
lhe_val, he_val, byrows)

  - io_err:     [OUT] Vector{Cint}
  - n:          [IN] Vector{Cint}
  - x:          [IN] Vector{Cdouble}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN] Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN] Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN] Vector{Cint}
  - he_val:     [OUT] Vector{Cdouble}
  - byrows:     [IN] Vector{Cint}
"""
function ueh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  ne::StrideOneVector{Cint},
  lhe_ptr::StrideOneVector{Cint},
  he_row_ptr::StrideOneVector{Cint},
  he_val_ptr::StrideOneVector{Cint},
  lhe_row::StrideOneVector{Cint},
  he_row::StrideOneVector{Cint},
  lhe_val::StrideOneVector{Cint},
  he_val::StrideOneVector{Cdouble},
  byrows::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ueh_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
    ),
    io_err,
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

"""# ugrdh
The ugrdh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
dense matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

For more information, run the shell command

    man cutest_ugrdh

Usage:

    ugrdh(io_err, n, x, g, lh1, h)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - g:       [OUT] Vector{Cdouble}
  - lh1:     [IN] Vector{Cint}
  - h:       [OUT] Array{Cdouble, 2}
"""
function ugrdh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  g::StrideOneVector{Cdouble},
  lh1::StrideOneVector{Cint},
  h::Array{Cdouble, 2},
)
  ccall(
    dlsym(cutest_lib, "cutest_ugrdh_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    io_err,
    n,
    x,
    g,
    lh1,
    h,
  )
end

"""# ugrsh
The ugrsh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
sparse matrix in coordinate format. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

For more information, run the shell command

    man cutest_ugrsh

Usage:

    ugrsh(io_err, n, x, g, nnzh, lh, h_val, h_row, h_col)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - g:       [OUT] Vector{Cdouble}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function ugrsh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  g::StrideOneVector{Cdouble},
  nnzh::StrideOneVector{Cint},
  lh::StrideOneVector{Cint},
  h_val::StrideOneVector{Cdouble},
  h_row::StrideOneVector{Cint},
  h_col::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ugrsh_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
    n,
    x,
    g,
    nnzh,
    lh,
    h_val,
    h_row,
    h_col,
  )
end

"""# ugreh
The ugreh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
sparse matrix in finite element format H=eΣ1He, where each square
symmetric element H sub e involves a small subset of the rows of the
Hessian matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

For more information, run the shell command

    man cutest_ugreh

Usage:

    ugreh(io_err, n, x, g, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
lhe_val, he_val, byrows)

  - io_err:     [OUT] Vector{Cint}
  - n:          [IN] Vector{Cint}
  - x:          [IN] Vector{Cdouble}
  - g:          [OUT] Vector{Cdouble}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN] Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN] Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN] Vector{Cint}
  - he_val:     [OUT] Vector{Cdouble}
  - byrows:     [IN] Vector{Cint}
"""
function ugreh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  g::StrideOneVector{Cdouble},
  ne::StrideOneVector{Cint},
  lhe_ptr::StrideOneVector{Cint},
  he_row_ptr::StrideOneVector{Cint},
  he_val_ptr::StrideOneVector{Cint},
  lhe_row::StrideOneVector{Cint},
  he_row::StrideOneVector{Cint},
  lhe_val::StrideOneVector{Cint},
  he_val::StrideOneVector{Cdouble},
  byrows::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ugreh_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
    ),
    io_err,
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

"""# uhprod
The uhprod subroutine forms the product of a vector with the Hessian
matrix of the objective function of the problem decoded from a SIF
file by the script sifdecoder at the point X. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

For more information, run the shell command

    man cutest_uhprod

Usage:

    uhprod(io_err, n, goth, x, vector, result)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - goth:    [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - vector:  [IN] Vector{Cdouble}
  - result:  [OUT] Vector{Cdouble}
"""
function uhprod(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  goth::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  vector::StrideOneVector{Cdouble},
  result::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_uhprod_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err,
    n,
    goth,
    x,
    vector,
    result,
  )
end

"""# ushprod
The ushprod subroutine forms the product of a sparse vector with the
Hessian matrix of the objective function of the problem decoded from a
SIF file by the script sifdecoder at the point X. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

For more information, run the shell command

    man cutest_ushprod

Usage:

    ushprod(io_err, n, goth, x, nnz_vector, index_nz_vector, vector, nnz_result,
index_nz_result, result)

  - io_err:          [OUT] Vector{Cint}
  - n:               [IN] Vector{Cint}
  - goth:            [IN] Vector{Cint}
  - x:               [IN] Vector{Cdouble}
  - nnz_vector:      [IN] Vector{Cint}
  - index_nz_vector: [IN] Vector{Cint}
  - vector:          [IN] Vector{Cdouble}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{Cdouble}

Notice that `vector` and `result` should have allocated dimension of `n`.
"""
function ushprod(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  goth::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  nnz_vector::StrideOneVector{Cint},
  index_nz_vector::StrideOneVector{Cint},
  vector::StrideOneVector{Cdouble},
  nnz_result::StrideOneVector{Cint},
  index_nz_result::StrideOneVector{Cint},
  result::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_ushprod_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
    ),
    io_err,
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

"""# ubandh
The ubandh subroutine extracts the elements which lie within a band of
given semi-bandwidth out of the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

For more information, run the shell command

    man cutest_ubandh

Usage:

    ubandh(io_err, n, x, semibandwidth, h_band, lbandh, max_semibandwidth)

  - io_err:            [OUT] Vector{Cint}
  - n:                 [IN] Vector{Cint}
  - x:                 [IN] Vector{Cdouble}
  - semibandwidth:     [IN] Vector{Cint}
  - h_band:            [OUT] Array{Cdouble, 2}
  - lbandh:            [IN] Vector{Cint}
  - max_semibandwidth: [OUT] Vector{Cint}
"""
function ubandh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  semibandwidth::StrideOneVector{Cint},
  h_band::Array{Cdouble, 2},
  lbandh::StrideOneVector{Cint},
  max_semibandwidth::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ubandh_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    n,
    x,
    semibandwidth,
    h_band,
    lbandh,
    max_semibandwidth,
  )
end

"""# cfn
The cfn subroutine evaluates the value of the objective function and
general constraint functions of the problem decoded from a SIF file by
the script sifdecoder at the point X. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

For more information, run the shell command

    man cutest_cfn

Usage:

    cfn(io_err, n, m, x, f, c)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - f:       [OUT] Vector{Cdouble}
  - c:       [OUT] Vector{Cdouble}
"""
function cfn(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  f::StrideOneVector{Cdouble},
  c::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_cfn_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err,
    n,
    m,
    x,
    f,
    c,
  )
end

"""# cofg
The cofg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

For more information, run the shell command

    man cutest_cofg

Usage:

    cofg(io_err, n, x, f, g, grad)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - f:       [OUT] Vector{Cdouble}
  - g:       [OUT] Vector{Cdouble}
  - grad:    [IN] Vector{Cint}
"""
function cofg(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  f::StrideOneVector{Cdouble},
  g::StrideOneVector{Cdouble},
  grad::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cofg_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}),
    io_err,
    n,
    x,
    f,
    g,
    grad,
  )
end

"""# cofsg
The cofsg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient in sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_cofsg

Usage:

    cofsg(io_err, n, x, f, nnzg, lg, g_val, g_var, grad)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - f:       [OUT] Vector{Cdouble}
  - nnzg:    [OUT] Vector{Cint}
  - lg:      [IN] Vector{Cint}
  - g_val:   [OUT] Vector{Cdouble}
  - g_var:   [OUT] Vector{Cint}
  - grad:    [IN] Vector{Cint}
"""
function cofsg(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  f::StrideOneVector{Cdouble},
  nnzg::StrideOneVector{Cint},
  lg::StrideOneVector{Cint},
  g_val::StrideOneVector{Cdouble},
  g_var::StrideOneVector{Cint},
  grad::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cofsg_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
    n,
    x,
    f,
    nnzg,
    lg,
    g_val,
    g_var,
    grad,
  )
end

"""# ccfg
The ccfg subroutine evaluates the values of the constraint functions
of the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly their gradients. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

For more information, run the shell command

    man cutest_ccfg

Usage:

    ccfg(io_err, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - c:       [OUT] Vector{Cdouble}
  - jtrans:  [IN] Vector{Cint}
  - lcjac1:  [IN] Vector{Cint}
  - lcjac2:  [IN] Vector{Cint}
  - cjac:    [OUT] Array{Cdouble, 2}
  - grad:    [IN] Vector{Cint}
"""
function ccfg(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  c::StrideOneVector{Cdouble},
  jtrans::StrideOneVector{Cint},
  lcjac1::StrideOneVector{Cint},
  lcjac2::StrideOneVector{Cint},
  cjac::Array{Cdouble, 2},
  grad::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ccfg_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
    ),
    io_err,
    n,
    m,
    x,
    c,
    jtrans,
    lcjac1,
    lcjac2,
    cjac,
    grad,
  )
end

"""# clfg
The clfg subroutine evaluates the value of the Lagrangian function
l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the
script sifdecoder at the point (X,Y), and possibly its gradient. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_clfg

Usage:

    clfg(io_err, n, m, x, y, f, g, grad)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - f:       [OUT] Vector{Cdouble}
  - g:       [OUT] Vector{Cdouble}
  - grad:    [IN] Vector{Cint}
"""
function clfg(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  f::StrideOneVector{Cdouble},
  g::StrideOneVector{Cdouble},
  grad::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_clfg_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
    ),
    io_err,
    n,
    m,
    x,
    y,
    f,
    g,
    grad,
  )
end

"""# cgr
The cgr subroutine evaluates the gradients of the general constraints
and of either the objective function f(x) or the Lagrangian function
l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from a SIF
file by the script sifdecoder at the point (x,y)= (X,Y). The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_cgr

Usage:

    cgr(io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - grlagf:  [IN] Vector{Cint}
  - g:       [OUT] Vector{Cdouble}
  - jtrans:  [IN] Vector{Cint}
  - lj1:     [IN] Vector{Cint}
  - lj2:     [IN] Vector{Cint}
  - j_val:   [OUT] Array{Cdouble, 2}
"""
function cgr(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  grlagf::StrideOneVector{Cint},
  g::StrideOneVector{Cdouble},
  jtrans::StrideOneVector{Cint},
  lj1::StrideOneVector{Cint},
  lj2::StrideOneVector{Cint},
  j_val::Array{Cdouble, 2},
)
  ccall(
    dlsym(cutest_lib, "cutest_cgr_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
    ),
    io_err,
    n,
    m,
    x,
    y,
    grlagf,
    g,
    jtrans,
    lj1,
    lj2,
    j_val,
  )
end

"""# csgr
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

For more information, run the shell command

    man cutest_csgr

Usage:

    csgr(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - grlagf:  [IN] Vector{Cint}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN] Vector{Cint}
  - j_val:   [OUT] Vector{Cdouble}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
"""
function csgr(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  grlagf::StrideOneVector{Cint},
  nnzj::StrideOneVector{Cint},
  lj::StrideOneVector{Cint},
  j_val::StrideOneVector{Cdouble},
  j_var::StrideOneVector{Cint},
  j_fun::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_csgr_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
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
  )
end

"""# ccfsg
The ccfsg subroutine evaluates the values of the constraint functions
of the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly their gradients in the constrained minimization
case. The gradients are stored in sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_ccfsg

Usage:

    ccfsg(io_err, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - c:       [OUT] Vector{Cdouble}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN] Vector{Cint}
  - j_val:   [OUT] Vector{Cdouble}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
  - grad:    [IN] Vector{Cint}
"""
function ccfsg(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  c::StrideOneVector{Cdouble},
  nnzj::StrideOneVector{Cint},
  lj::StrideOneVector{Cint},
  j_val::StrideOneVector{Cdouble},
  j_var::StrideOneVector{Cint},
  j_fun::StrideOneVector{Cint},
  grad::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ccfsg_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
    n,
    m,
    x,
    c,
    nnzj,
    lj,
    j_val,
    j_var,
    j_fun,
    grad,
  )
end

"""# ccifg
The ccifg subroutine evaluates the value of a particular constraint
function of the problem decoded from a SIF file by the script
sifdecoder at the point X, and possibly its gradient in the
constrained minimization case. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

For more information, run the shell command

    man cutest_ccifg

Usage:

    ccifg(io_err, n, icon, x, ci, gci, grad)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - icon:    [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - ci:      [OUT] Vector{Cdouble}
  - gci:     [OUT] Vector{Cdouble}
  - grad:    [IN] Vector{Cint}
"""
function ccifg(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  icon::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  ci::StrideOneVector{Cdouble},
  gci::StrideOneVector{Cdouble},
  grad::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ccifg_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}),
    io_err,
    n,
    icon,
    x,
    ci,
    gci,
    grad,
  )
end

"""# ccifsg
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

For more information, run the shell command

    man cutest_ccifsg

Usage:

    ccifsg(io_err, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - icon:    [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - ci:      [OUT] Vector{Cdouble}
  - nnzgci:  [OUT] Vector{Cint}
  - lgci:    [IN] Vector{Cint}
  - gci_val: [OUT] Vector{Cdouble}
  - gci_var: [OUT] Vector{Cint}
  - grad:    [IN] Vector{Cint}
"""
function ccifsg(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  icon::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  ci::StrideOneVector{Cdouble},
  nnzgci::StrideOneVector{Cint},
  lgci::StrideOneVector{Cint},
  gci_val::StrideOneVector{Cdouble},
  gci_var::StrideOneVector{Cint},
  grad::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ccifsg_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
    n,
    icon,
    x,
    ci,
    nnzgci,
    lgci,
    gci_val,
    gci_var,
    grad,
  )
end

"""# cgrdh
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

For more information, run the shell command

    man cutest_cgrdh

Usage:

    cgrdh(io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - grlagf:  [IN] Vector{Cint}
  - g:       [OUT] Vector{Cdouble}
  - jtrans:  [IN] Vector{Cint}
  - lj1:     [IN] Vector{Cint}
  - lj2:     [IN] Vector{Cint}
  - j_val:   [OUT] Array{Cdouble, 2}
  - lh1:     [IN] Vector{Cint}
  - h_val:   [OUT] Array{Cdouble, 2}
"""
function cgrdh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  grlagf::StrideOneVector{Cint},
  g::StrideOneVector{Cdouble},
  jtrans::StrideOneVector{Cint},
  lj1::StrideOneVector{Cint},
  lj2::StrideOneVector{Cint},
  j_val::Array{Cdouble, 2},
  lh1::StrideOneVector{Cint},
  h_val::Array{Cdouble, 2},
)
  ccall(
    dlsym(cutest_lib, "cutest_cgrdh_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cdouble},
    ),
    io_err,
    n,
    m,
    x,
    y,
    grlagf,
    g,
    jtrans,
    lj1,
    lj2,
    j_val,
    lh1,
    h_val,
  )
end

"""# cdh
The cdh subroutine evaluates the Hessian matrix of the Lagrangian
function l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by
the script sifdecoder at the point (x,y)= (X,Y). The matrix is stored
as a dense matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_cdh

Usage:

    cdh(io_err, n, m, x, y, lh1, h_val)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - lh1:     [IN] Vector{Cint}
  - h_val:   [OUT] Array{Cdouble, 2}
"""
function cdh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  lh1::StrideOneVector{Cint},
  h_val::Array{Cdouble, 2},
)
  ccall(
    dlsym(cutest_lib, "cutest_cdh_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    io_err,
    n,
    m,
    x,
    y,
    lh1,
    h_val,
  )
end

"""# cdhc
The cdhc subroutine evaluates the Hessian matrix of the constraint
part of the Lagrangian function yTc(x) for the problem decoded from a
SIF file by the script sifdecoder at the point (x,y)= (X,Y). The
matrix is stored as a dense matrix. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

For more information, run the shell command

    man cutest_cdhc

Usage:

    cdhc(io_err, n, m, x, y, lh1, h_val)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - lh1:     [IN] Vector{Cint}
  - h_val:   [OUT] Array{Cdouble, 2}
"""
function cdhc(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  lh1::StrideOneVector{Cint},
  h_val::Array{Cdouble, 2},
)
  ccall(
    dlsym(cutest_lib, "cutest_cdhc_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    io_err,
    n,
    m,
    x,
    y,
    lh1,
    h_val,
  )
end

"""# cshp
The cshp subroutine evaluates the sparsity pattern of the Hessian of
the Lagrangian function l(x,y)=f(x)+yTc(x) for the problem, decoded
from a SIF file by the script sifdecoder, in coordinate format. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_cshp

Usage:

    cshp(io_err, n, nnzh, lh, h_row, h_col)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function cshp(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  nnzh::StrideOneVector{Cint},
  lh::StrideOneVector{Cint},
  h_row::StrideOneVector{Cint},
  h_col::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cshp_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    n,
    nnzh,
    lh,
    h_row,
    h_col,
  )
end

"""# csh
The csh subroutine evaluates the Hessian of the Lagrangian function
l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the
script sifdecoder at the point (x,y)= (X,Y). The matrix is stored in
sparse format. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_csh

Usage:

    csh(io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function csh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  nnzh::StrideOneVector{Cint},
  lh::StrideOneVector{Cint},
  h_val::StrideOneVector{Cdouble},
  h_row::StrideOneVector{Cint},
  h_col::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_csh_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
    n,
    m,
    x,
    y,
    nnzh,
    lh,
    h_val,
    h_row,
    h_col,
  )
end

"""# cshc
The cshc subroutine evaluates the Hessian matrix of the constraint
part of the Lagrangian function yTc(x) for the problem decoded from a
SIF file by the script sifdecoder at the point (x,y)= (X,Y). The
matrix is stored in sparse format. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

For more information, run the shell command

    man cutest_cshc

Usage:

    cshc(io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function cshc(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  nnzh::StrideOneVector{Cint},
  lh::StrideOneVector{Cint},
  h_val::StrideOneVector{Cdouble},
  h_row::StrideOneVector{Cint},
  h_col::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cshc_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
    n,
    m,
    x,
    y,
    nnzh,
    lh,
    h_val,
    h_row,
    h_col,
  )
end

"""# ceh
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

For more information, run the shell command

    man cutest_ceh

Usage:

    ceh(io_err, n, m, x, y, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row,
he_row, lhe_val, he_val, byrows)

  - io_err:     [OUT] Vector{Cint}
  - n:          [IN] Vector{Cint}
  - m:          [IN] Vector{Cint}
  - x:          [IN] Vector{Cdouble}
  - y:          [IN] Vector{Cdouble}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN] Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN] Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN] Vector{Cint}
  - he_val:     [OUT] Vector{Cdouble}
  - byrows:     [IN] Vector{Cint}
"""
function ceh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  ne::StrideOneVector{Cint},
  lhe_ptr::StrideOneVector{Cint},
  he_row_ptr::StrideOneVector{Cint},
  he_val_ptr::StrideOneVector{Cint},
  lhe_row::StrideOneVector{Cint},
  he_row::StrideOneVector{Cint},
  lhe_val::StrideOneVector{Cint},
  he_val::StrideOneVector{Cdouble},
  byrows::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_ceh_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
    ),
    io_err,
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

"""# cidh
The cidh subroutine evaluates the Hessian matrix of either the
objective function or a constraint function for the problem decoded
from a SIF file by the script sifdecoder at the point X, and possibly
its gradient. The matrix is stored as a dense matrix. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_cidh

Usage:

    cidh(io_err, n, x, iprob, lh1, h)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - iprob:   [IN] Vector{Cint}
  - lh1:     [IN] Vector{Cint}
  - h:       [OUT] Array{Cdouble, 2}
"""
function cidh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  iprob::StrideOneVector{Cint},
  lh1::StrideOneVector{Cint},
  h::Array{Cdouble, 2},
)
  ccall(
    dlsym(cutest_lib, "cutest_cidh_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}),
    io_err,
    n,
    x,
    iprob,
    lh1,
    h,
  )
end

"""# cish
The cish subroutine evaluates the Hessian of a particular constraint
function or the objective function for the problem decoded from a SIF
file by the script sifdecoder at the point X, and possibly its
gradient. The matrix is stored in sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_cish

Usage:

    cish(io_err, n, x, iprob, nnzh, lh, h_val, h_row, h_col)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - iprob:   [IN] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function cish(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  iprob::StrideOneVector{Cint},
  nnzh::StrideOneVector{Cint},
  lh::StrideOneVector{Cint},
  h_val::StrideOneVector{Cdouble},
  h_row::StrideOneVector{Cint},
  h_col::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cish_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
    n,
    x,
    iprob,
    nnzh,
    lh,
    h_val,
    h_row,
    h_col,
  )
end

"""# csgrsh
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

For more information, run the shell command

    man cutest_csgrsh

Usage:

    csgrsh(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, nnzh, lh,
h_val, h_row, h_col)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - grlagf:  [IN] Vector{Cint}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN] Vector{Cint}
  - j_val:   [OUT] Vector{Cdouble}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function csgrsh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  grlagf::StrideOneVector{Cint},
  nnzj::StrideOneVector{Cint},
  lj::StrideOneVector{Cint},
  j_val::StrideOneVector{Cdouble},
  j_var::StrideOneVector{Cint},
  j_fun::StrideOneVector{Cint},
  nnzh::StrideOneVector{Cint},
  lh::StrideOneVector{Cint},
  h_val::StrideOneVector{Cdouble},
  h_row::StrideOneVector{Cint},
  h_col::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_csgrsh_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
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

"""# csgreh
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

For more information, run the shell command

    man cutest_csgreh

Usage:

    csgreh(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, ne,
lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val,
byrows)

  - io_err:     [OUT] Vector{Cint}
  - n:          [IN] Vector{Cint}
  - m:          [IN] Vector{Cint}
  - x:          [IN] Vector{Cdouble}
  - y:          [IN] Vector{Cdouble}
  - grlagf:     [IN] Vector{Cint}
  - nnzj:       [OUT] Vector{Cint}
  - lj:         [IN] Vector{Cint}
  - j_val:      [OUT] Vector{Cdouble}
  - j_var:      [OUT] Vector{Cint}
  - j_fun:      [OUT] Vector{Cint}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN] Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN] Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN] Vector{Cint}
  - he_val:     [OUT] Vector{Cdouble}
  - byrows:     [IN] Vector{Cint}
"""
function csgreh(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  grlagf::StrideOneVector{Cint},
  nnzj::StrideOneVector{Cint},
  lj::StrideOneVector{Cint},
  j_val::StrideOneVector{Cdouble},
  j_var::StrideOneVector{Cint},
  j_fun::StrideOneVector{Cint},
  ne::StrideOneVector{Cint},
  lhe_ptr::StrideOneVector{Cint},
  he_row_ptr::StrideOneVector{Cint},
  he_val_ptr::StrideOneVector{Cint},
  lhe_row::StrideOneVector{Cint},
  he_row::StrideOneVector{Cint},
  lhe_val::StrideOneVector{Cint},
  he_val::StrideOneVector{Cdouble},
  byrows::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_csgreh_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
    ),
    io_err,
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

"""# chprod
The chprod subroutine forms the product of a vector with the Hessian
matrix of the Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to
the problem decoded from a SIF file by the script sifdecoder at the
point (x,y)= (X,Y). The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_chprod

Usage:

    chprod(io_err, n, m, goth, x, y, vector, result)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - goth:    [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - vector:  [IN] Vector{Cdouble}
  - result:  [OUT] Vector{Cdouble}
"""
function chprod(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  goth::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  vector::StrideOneVector{Cdouble},
  result::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_chprod_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
    ),
    io_err,
    n,
    m,
    goth,
    x,
    y,
    vector,
    result,
  )
end

"""# cshprod
The cshprod subroutine forms the product of a sparse vector with the
Hessian matrix of the Lagrangian function l(x,y)=f(x)+yTc(x)
corresponding to the problem decoded from a SIF file by the script
sifdecoder at the point (x,y)= (X,Y). The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

For more information, run the shell command

    man cutest_cshprod

Usage:

    cshprod(io_err, n, m, goth, x, y, nnz_vector, index_nz_vector, vector,
nnz_result, index_nz_result, result)

  - io_err:          [OUT] Vector{Cint}
  - n:               [IN] Vector{Cint}
  - m:               [IN] Vector{Cint}
  - goth:            [IN] Vector{Cint}
  - x:               [IN] Vector{Cdouble}
  - y:               [IN] Vector{Cdouble}
  - nnz_vector:      [IN] Vector{Cint}
  - index_nz_vector: [IN] Vector{Cint}
  - vector:          [IN] Vector{Cdouble}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{Cdouble}

Notice that `vector` and `result` should have allocated dimension of `n`.
"""
function cshprod(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  goth::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  nnz_vector::StrideOneVector{Cint},
  index_nz_vector::StrideOneVector{Cint},
  vector::StrideOneVector{Cdouble},
  nnz_result::StrideOneVector{Cint},
  index_nz_result::StrideOneVector{Cint},
  result::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_cshprod_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
    ),
    io_err,
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

"""# chcprod
The chcprod subroutine forms the product of a vector with the Hessian
matrix of the constraint part of the Lagrangian function yTc(x) of the
problem decoded from a SIF file by the script sifdecoder at the point
(x,y)= (X,Y). The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_chcprod

Usage:

    chcprod(io_err, n, m, goth, x, y, vector, result)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - goth:    [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - y:       [IN] Vector{Cdouble}
  - vector:  [IN] Vector{Cdouble}
  - result:  [OUT] Vector{Cdouble}
"""
function chcprod(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  goth::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  vector::StrideOneVector{Cdouble},
  result::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_chcprod_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cdouble},
    ),
    io_err,
    n,
    m,
    goth,
    x,
    y,
    vector,
    result,
  )
end

"""# cshcprod
The cshcprod subroutine forms the product of a sparse vector with the
Hessian matrix of the constraint part of the Lagrangian function
yTc(x) corresponding to the problem decoded from a SIF file by the
script sifdecoder at the point (x,y)= (X,Y). The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

For more information, run the shell command

    man cutest_cshcprod

Usage:

    cshcprod(io_err, n, m, goth, x, y, nnz_vector, index_nz_vector, vector,
nnz_result, index_nz_result, result)

  - io_err:          [OUT] Vector{Cint}
  - n:               [IN] Vector{Cint}
  - m:               [IN] Vector{Cint}
  - goth:            [IN] Vector{Cint}
  - x:               [IN] Vector{Cdouble}
  - y:               [IN] Vector{Cdouble}
  - nnz_vector:      [IN] Vector{Cint}
  - index_nz_vector: [IN] Vector{Cint}
  - vector:          [IN] Vector{Cdouble}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{Cdouble}
"""
function cshcprod(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  goth::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  y::StrideOneVector{Cdouble},
  nnz_vector::StrideOneVector{Cint},
  index_nz_vector::StrideOneVector{Cint},
  vector::StrideOneVector{Cdouble},
  nnz_result::StrideOneVector{Cint},
  index_nz_result::StrideOneVector{Cint},
  result::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_cshcprod_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
    ),
    io_err,
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

"""# cjprod
The cjprod subroutine forms the product of a vector with the Jacobian
matrix, or with its transpose, of the constraint functions of the
problem decoded from a SIF file by the script sifdecoder evaluated at
the point X. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_cjprod

Usage:

    cjprod(io_err, n, m, gotj, jtrans, x, vector, lvector, result, lresult)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - gotj:    [IN] Vector{Cint}
  - jtrans:  [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - vector:  [IN] Vector{Cdouble}
  - lvector: [IN] Vector{Cint}
  - result:  [OUT] Vector{Cdouble}
  - lresult: [IN] Vector{Cint}
"""
function cjprod(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  gotj::StrideOneVector{Cint},
  jtrans::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  vector::StrideOneVector{Cdouble},
  lvector::StrideOneVector{Cint},
  result::StrideOneVector{Cdouble},
  lresult::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cjprod_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
    ),
    io_err,
    n,
    m,
    gotj,
    jtrans,
    x,
    vector,
    lvector,
    result,
    lresult,
  )
end

"""# csjprod
The csjprod subroutine forms the product of a sparse vector with the
Jacobian matrix, or with its transpose, of the constraint functions of
the problem decoded from a SIF file by the script sifdecoder evaluated
at the point X. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

For more information, run the shell command

    man cutest_csjprod

Usage:

    csjprod(io_err, n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector,
lvector, nnz_result, index_nz_result, result, lresult)

  - io_err:          [OUT] Vector{Cint}
  - n:               [IN] Vector{Cint}
  - m:               [IN] Vector{Cint}
  - gotj:            [IN] Vector{Cint}
  - jtrans:          [IN] Vector{Cint}
  - x:               [IN] Vector{Cdouble}
  - nnz_vector:      [IN] Vector{Cint}
  - index_nz_vector: [IN] Vector{Cint}
  - vector:          [IN] Vector{Cdouble}
  - lvector:         [IN] Vector{Cint}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{Cdouble}
  - lresult:         [IN] Vector{Cint}
"""
function csjprod(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  gotj::StrideOneVector{Cint},
  jtrans::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  nnz_vector::StrideOneVector{Cint},
  index_nz_vector::StrideOneVector{Cint},
  vector::StrideOneVector{Cdouble},
  lvector::StrideOneVector{Cint},
  nnz_result::StrideOneVector{Cint},
  index_nz_result::StrideOneVector{Cint},
  result::StrideOneVector{Cdouble},
  lresult::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_csjprod_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
    ),
    io_err,
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

"""# cchprods
The cchprods subroutine forms the product of a vector with each of the
Hessian matrix of the constraint functions c(x) corresponding to the
problem decoded from a SIF file by the script sifdecoder at the point
x= X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separable and all constraint functions are partially
separable.

For more information, run the shell command

    man cutest_cchprods

Usage:

    cchprods(io_err, n, m, goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - goth:    [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - vector:  [IN] Vector{Cdouble}
  - lchp:    [IN] Vector{Cint}
  - chp_val: [OUT] Vector{Cdouble}
  - chp_ind: [IN] Vector{Cint}
  - chp_ptr: [IN] Vector{Cint}
"""
function cchprods(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  goth::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  vector::StrideOneVector{Cdouble},
  lchp::StrideOneVector{Cint},
  chp_val::StrideOneVector{Cdouble},
  chp_ind::StrideOneVector{Cint},
  chp_ptr::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cchprods_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cdouble},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
    n,
    m,
    goth,
    x,
    vector,
    lchp,
    chp_val,
    chp_ind,
    chp_ptr,
  )
end

"""# cchprodsp
The cchprodsp subroutine obtains the sparsity structure used when forming the
product of a vector with each of the Hessian matrices of the constraint
functions c(x) corresponding to the problem decoded from a SIF file by the
script sifdecoder at the point x= X.

Usage:

    cchprodsp(io_err, m, lchp, chp_ind, chp_ptr)

  - io_err:  [OUT] Vector{Cint}
  - m:       [IN] Vector{Cint}
  - lchp:    [IN] Vector{Cint}
  - chp_ind: [IN] Vector{Cint}
  - chp_ptr: [IN] Vector{Cint}
"""
function cchprodsp(
  io_err::StrideOneVector{Cint},
  m::StrideOneVector{Cint},
  lchp::StrideOneVector{Cint},
  chp_ind::StrideOneVector{Cint},
  chp_ptr::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cchprodsp_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    m,
    lchp,
    chp_ind,
    chp_ptr,
  )
end

"""# uterminate
The uterminate subroutine deallocates all workspace arrays created
since the last call to usetup.

For more information, run the shell command

    man cutest_uterminate

Usage:

    uterminate(io_err)

  - io_err:  [OUT] Vector{Cint}
"""
function uterminate(io_err::StrideOneVector{Cint})
  ccall(dlsym(cutest_lib, "cutest_uterminate_"), Nothing, (Ptr{Cint},), io_err)
end

"""# cterminate
The uterminate subroutine deallocates all workspace arrays created
since the last call to csetup.

For more information, run the shell command

    man cutest_cterminate

Usage:

    cterminate(io_err)

  - io_err:  [OUT] Vector{Cint}
"""
function cterminate(io_err::StrideOneVector{Cint})
  ccall(dlsym(cutest_lib, "cutest_cterminate_"), Nothing, (Ptr{Cint},), io_err)
end

"""# cifn
The cifn subroutine evaluates the value of either the objective function or a
constrainted function of the problem decoded from a SIF file by the script
sifdecoder at the point X, in the constrained minimization case.

For more information, run the shell command

    man cutest_cifn

Usage:



  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - iprob:   [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - f:       [OUT] Vector{Cdouble}
"""
function cifn(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  iprob::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  f::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_cifn_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err,
    n,
    iprob,
    x,
    f,
  )
end

"""# cisgr
The cisgr subroutine evaluates the gradient of either the objective function or
a constraint function of the problem decoded from a SIF file by the script
sifdecoder at the point X, in the constrained minimization case. The gradient
is stored in sparse format.

For more information, run the shell command

    man cutest_cisgr

Usage:

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - iprob:   [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - nnzg:    [OUT] Vector{Cint}
  - lg:      [IN] Vector{Cint}
  - g_val:   [OUT] Vector{Cdouble}
  - g_var:   [OUT] Vector{Cint}
"""
function cisgr(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  iprod::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  nnzg::StrideOneVector{Cint},
  lg::StrideOneVector{Cint},
  g_val::StrideOneVector{Cdouble},
  g_var::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_cisgr_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err,
    n,
    iprod,
    x,
    nnzg,
    lg,
    g_val,
    g_var,
  )
end

"""# csgrp
The csgrp subroutine evaluates sparsity pattern used when storing the gradients
of the general constraints and of either the objective function or the
Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded
from a SIF file by the script sifdecoder.

For more information, run the shell command

    man cutest_csgrp

Usage:

    csgrp(io_err, n, nnzj, lj, j_var, j_fun)

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - nnzj:       [OUT] Vector{Cint}
  - lj:         [IN] Vector{Cint}
  - j_var:      [OUT] Vector{Cint}
  - j_fun:      [OUT] Vector{Cint}
"""
function csgrp(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  nnzj::StrideOneVector{Cint},
  lj::StrideOneVector{Cint},
  j_var::StrideOneVector{Cint},
  j_fun::StrideOneVector{Cint},
)
  ccall(
    dlsym(cutest_lib, "cutest_csgrp_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err,
    n,
    nnzj,
    lj,
    j_var,
    j_fun,
  )
end

"""# cigr
The cigr subroutine evaluates the gradient of either the objective function or
a constraint function of the problem decoded from a SIF file by the script
sifdecoder at the point X, in the constrained minimization case.

For more information, run the shell command

    man cutest_cigr

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - iprob:   [IN] Vector{Cint}
  - x:       [IN] Vector{Cdouble}
  - g_val:   [OUT] Vector{Cdouble}
"""
function cigr(
  io_err::StrideOneVector{Cint},
  n::StrideOneVector{Cint},
  iprob::StrideOneVector{Cint},
  x::StrideOneVector{Cdouble},
  g_val::StrideOneVector{Cdouble},
)
  ccall(
    dlsym(cutest_lib, "cutest_cigr_"),
    Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err,
    n,
    iprob,
    x,
    g_val,
  )
end

"""# csgrshp
The csgrshp subroutine evaluates sparsity pattern used when storing the
gradients of the general constraints and of either the objective function or
the Lagrangian function l(x,y)=f(x)+yTc(x), as well as the Hessian of the
Lagrangian function, corresponding to the problem decoded from a SIF file by
the script sifdecoder.

For more information, run the shell command

    man cutest_csgrshp

  - io_err:  [OUT] Vector{Cint}
  - n:       [IN] Vector{Cint}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN] Vector{Cint}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
function csgrshp(
  io_err::StrideOneVector{Cint},
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
  ccall(
    dlsym(cutest_lib, "cutest_csgrshp_"),
    Nothing,
    (
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
      Ptr{Cint},
    ),
    io_err,
    n,
    nnzj,
    lj,
    j_var,
    j_fun,
    nnzh,
    lh,
    h_row,
    h_col,
  )
end
