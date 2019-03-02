export usetup, csetup, udimen, udimsh, udimse, uvartype, unames,
    ureport, cdimen, cdimsj, cdimsh, cdimchp, cdimse, cstats, cvartype,
    cnames, creport, connames, pname, probname, varnames, ufn, ugr, uofg,
    udh, ushp, ush, ueh, ugrdh, ugrsh, ugreh, uhprod, ushprod, ubandh,
    cfn, cofg, cofsg, ccfg, clfg, cgr, csgr, ccfsg, ccifg, ccifsg, cgrdh,
    cdh, cdhc, cshp, csh, cshc, ceh, cidh, cish, csgrsh, csgreh, chprod,
    cshprod, chcprod, cshcprod, cjprod, csjprod, cchprods, cchprodsp,
    uterminate, cterminate, cifn, cisgr, csgrp, cigr, csgrshp

include("precision_dependent.jl")


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
  - x:         [OUT] Vector{Cdouble or Cfloat}
  - x_l:       [OUT] Vector{Cdouble or Cfloat}
  - x_u:       [OUT] Vector{Cdouble or Cfloat}
"""
usetup

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
  - x:         [OUT] Vector{Cdouble or Cfloat}
  - x_l:       [OUT] Vector{Cdouble or Cfloat}
  - x_u:       [OUT] Vector{Cdouble or Cfloat}
  - y:         [OUT] Vector{Cdouble or Cfloat}
  - c_l:       [OUT] Vector{Cdouble or Cfloat}
  - c_u:       [OUT] Vector{Cdouble or Cfloat}
  - equatn:    [OUT] Vector{Cint}
  - linear:    [OUT] Vector{Cint}
  - e_order:   [IN] Vector{Cint}
  - l_order:   [IN] Vector{Cint}
  - v_order:   [IN] Vector{Cint}
"""
csetup

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
function udimen(io_err::Vector{Cint}, input::Vector{Cint}, n::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_udimen_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, input, n)
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
function udimsh(io_err::Vector{Cint}, nnzh::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_udimsh_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}),
    io_err, nnzh)
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
function udimse(io_err::Vector{Cint}, ne::Vector{Cint}, he_val_ne::Vector{Cint},
    he_row_ne::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_udimse_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, ne, he_val_ne, he_row_ne)
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
function uvartype(io_err::Vector{Cint}, n::Vector{Cint}, x_type::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_uvartype_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x_type)
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
  - vname:   [OUT] Array{UInt8, 2}

To get useful names, use `String(x)` where `x` can be `pname` or `vname[:,i]`.
"""
function unames(io_err::Vector{Cint}, n::Vector{Cint}, pname::Vector{UInt8},
    vname::Array{UInt8, 2})
  ccall(dlsym(cutest_lib_double, "cutest_unames_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{UInt8}, Ptr{UInt8}),
    io_err, n, pname, vname)
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
function ureport(io_err::Vector{Cint}, calls::Vector{Cdouble}, time::Vector{Cdouble})
  ccall(dlsym(cutest_lib_double, "cutest_ureport_"), Nothing,
    (Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, calls, time)
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
function cdimen(io_err::Vector{Cint}, input::Vector{Cint}, n::Vector{Cint},
    m::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_cdimen_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, input, n, m)
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
function cdimsj(io_err::Vector{Cint}, nnzj::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_cdimsj_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}),
    io_err, nnzj)
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
function cdimsh(io_err::Vector{Cint}, nnzh::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_cdimsh_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}),
    io_err, nnzh)
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
function cdimchp(io_err::Vector{Cint}, nnzchp::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_cdimchp_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}),
    io_err, nnzchp)
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
function cdimse(io_err::Vector{Cint}, ne::Vector{Cint}, he_val_ne::Vector{Cint},
    he_row_ne::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_cdimse_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, ne, he_val_ne, he_row_ne)
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
function cstats(io_err::Vector{Cint}, nonlinear_variables_objective::Vector{Cint},
    nonlinear_variables_constraints::Vector{Cint},
    equality_constraints::Vector{Cint}, linear_constraints::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_cstats_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, nonlinear_variables_objective,
    nonlinear_variables_constraints, equality_constraints,
    linear_constraints)
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
function cvartype(io_err::Vector{Cint}, n::Vector{Cint}, x_type::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_cvartype_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x_type)
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
function cnames(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
    pname::Vector{UInt8}, vname::Array{UInt8, 2}, cname::Array{UInt8, 2})
  ccall(dlsym(cutest_lib_double, "cutest_cnames_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{UInt8}, Ptr{UInt8}, Ptr{UInt8}),
    io_err, n, m, pname, vname, cname)
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
function creport(io_err::Vector{Cint}, calls::Vector{Cdouble}, time::Vector{Cdouble})
  ccall(dlsym(cutest_lib_double, "cutest_creport_"), Nothing,
    (Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, calls, time)
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
function connames(io_err::Vector{Cint}, m::Vector{Cint}, cname::Array{UInt8, 2})
  ccall(dlsym(cutest_lib_double, "cutest_connames_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{UInt8}),
    io_err, m, cname)
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
function pname(io_err::Vector{Cint}, input::Vector{Cint}, pname::Vector{UInt8})
  ccall(dlsym(cutest_lib_double, "cutest_pname_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{UInt8}),
    io_err, input, pname)
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
function probname(io_err::Vector{Cint}, pname::Vector{UInt8})
  ccall(dlsym(cutest_lib_double, "cutest_probname_"), Nothing,
    (Ptr{Cint}, Ptr{UInt8}),
    io_err, pname)
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
function varnames(io_err::Vector{Cint}, n::Vector{Cint}, vname::Array{UInt8, 2})
  ccall(dlsym(cutest_lib_double, "cutest_varnames_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{UInt8}),
    io_err, n, vname)
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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - f:       [OUT] Vector{Cdouble or Cfloat}
"""
ufn

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - g:       [OUT] Vector{Cdouble or Cfloat}
"""
ugr

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - f:       [OUT] Vector{Cdouble or Cfloat}
  - g:       [OUT] Vector{Cdouble or Cfloat}
  - grad:    [IN] Vector{Cint}
"""
uofg

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - lh1:     [IN] Vector{Cint}
  - h:       [OUT] Aray{Cdouble or Cfloat, 2}
"""
udh

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
function ushp(io_err::Vector{Cint}, n::Vector{Cint}, nnzh::Vector{Cint},
    lh::Vector{Cint}, h_row::Vector{Cint}, h_col::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_ushp_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, nnzh, lh, h_row, h_col)
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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble or Cfloat}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
ush

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
  - x:          [IN] Vector{Cdouble or Cfloat}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN] Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN] Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN] Vector{Cint}
  - he_val:     [OUT] Vector{Cdouble or Cfloat}
  - byrows:     [IN] Vector{Cint}
"""
ueh

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - g:       [OUT] Vector{Cdouble or Cfloat}
  - lh1:     [IN] Vector{Cint}
  - h:       [OUT] Aray{Cdouble or Cfloat, 2}
"""
ugrdh

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - g:       [OUT] Vector{Cdouble or Cfloat}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble or Cfloat}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
ugrsh

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
  - x:          [IN] Vector{Cdouble or Cfloat}
  - g:          [OUT] Vector{Cdouble or Cfloat}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN] Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN] Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN] Vector{Cint}
  - he_val:     [OUT] Vector{Cdouble or Cfloat}
  - byrows:     [IN] Vector{Cint}
"""
ugreh

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - vector:  [IN] Vector{Cdouble or Cfloat}
  - result:  [OUT] Vector{Cdouble or Cfloat}
"""
uhprod

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
  - x:               [IN] Vector{Cdouble or Cfloat}
  - nnz_vector:      [IN] Vector{Cint}
  - index_nz_vector: [IN] Vector{Cint}
  - vector:          [IN] Vector{Cdouble or Cfloat}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{Cdouble or Cfloat}

Notice that `vector` and `result` should have allocated dimension of `n`.
"""
ushprod

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
  - x:                 [IN] Vector{Cdouble or Cfloat}
  - semibandwidth:     [IN] Vector{Cint}
  - h_band:            [OUT] Aray{Cdouble or Cfloat, 2}
  - lbandh:            [IN] Vector{Cint}
  - max_semibandwidth: [OUT] Vector{Cint}
"""
ubandh

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - f:       [OUT] Vector{Cdouble or Cfloat}
  - c:       [OUT] Vector{Cdouble or Cfloat}
"""
cfn

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - f:       [OUT] Vector{Cdouble or Cfloat}
  - g:       [OUT] Vector{Cdouble or Cfloat}
  - grad:    [IN] Vector{Cint}
"""
cofg

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - f:       [OUT] Vector{Cdouble or Cfloat}
  - nnzg:    [OUT] Vector{Cint}
  - lg:      [IN] Vector{Cint}
  - g_val:   [OUT] Vector{Cdouble or Cfloat}
  - g_var:   [OUT] Vector{Cint}
  - grad:    [IN] Vector{Cint}
"""
cofsg

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - c:       [OUT] Vector{Cdouble or Cfloat}
  - jtrans:  [IN] Vector{Cint}
  - lcjac1:  [IN] Vector{Cint}
  - lcjac2:  [IN] Vector{Cint}
  - cjac:    [OUT] Aray{Cdouble or Cfloat, 2}
  - grad:    [IN] Vector{Cint}
"""
ccfg

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - f:       [OUT] Vector{Cdouble or Cfloat}
  - g:       [OUT] Vector{Cdouble or Cfloat}
  - grad:    [IN] Vector{Cint}
"""
clfg

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - grlagf:  [IN] Vector{Cint}
  - g:       [OUT] Vector{Cdouble or Cfloat}
  - jtrans:  [IN] Vector{Cint}
  - lj1:     [IN] Vector{Cint}
  - lj2:     [IN] Vector{Cint}
  - j_val:   [OUT] Aray{Cdouble or Cfloat, 2}
"""
cgr

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - grlagf:  [IN] Vector{Cint}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN] Vector{Cint}
  - j_val:   [OUT] Vector{Cdouble or Cfloat}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
"""
csgr

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - c:       [OUT] Vector{Cdouble or Cfloat}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN] Vector{Cint}
  - j_val:   [OUT] Vector{Cdouble or Cfloat}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
  - grad:    [IN] Vector{Cint}
"""
ccfsg

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - ci:      [OUT] Vector{Cdouble or Cfloat}
  - gci:     [OUT] Vector{Cdouble or Cfloat}
  - grad:    [IN] Vector{Cint}
"""
ccifg

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - ci:      [OUT] Vector{Cdouble or Cfloat}
  - nnzgci:  [OUT] Vector{Cint}
  - lgci:    [IN] Vector{Cint}
  - gci_val: [OUT] Vector{Cdouble or Cfloat}
  - gci_var: [OUT] Vector{Cint}
  - grad:    [IN] Vector{Cint}
"""
ccifsg

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - grlagf:  [IN] Vector{Cint}
  - g:       [OUT] Vector{Cdouble or Cfloat}
  - jtrans:  [IN] Vector{Cint}
  - lj1:     [IN] Vector{Cint}
  - lj2:     [IN] Vector{Cint}
  - j_val:   [OUT] Aray{Cdouble or Cfloat, 2}
  - lh1:     [IN] Vector{Cint}
  - h_val:   [OUT] Aray{Cdouble or Cfloat, 2}
"""
cgrdh

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - lh1:     [IN] Vector{Cint}
  - h_val:   [OUT] Aray{Cdouble or Cfloat, 2}
"""
cdh

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - lh1:     [IN] Vector{Cint}
  - h_val:   [OUT] Aray{Cdouble or Cfloat, 2}
"""
cdhc

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
function cshp(io_err::Vector{Cint}, n::Vector{Cint}, nnzh::Vector{Cint},
    lh::Vector{Cint}, h_row::Vector{Cint}, h_col::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_cshp_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, nnzh, lh, h_row, h_col)
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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble or Cfloat}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
csh

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble or Cfloat}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
cshc

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
  - x:          [IN] Vector{Cdouble or Cfloat}
  - y:          [IN] Vector{Cdouble or Cfloat}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN] Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN] Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN] Vector{Cint}
  - he_val:     [OUT] Vector{Cdouble or Cfloat}
  - byrows:     [IN] Vector{Cint}
"""
ceh

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - iprob:   [IN] Vector{Cint}
  - lh1:     [IN] Vector{Cint}
  - h:       [OUT] Aray{Cdouble or Cfloat, 2}
"""
cidh

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - iprob:   [IN] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble or Cfloat}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
cish

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - grlagf:  [IN] Vector{Cint}
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN] Vector{Cint}
  - j_val:   [OUT] Vector{Cdouble or Cfloat}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_val:   [OUT] Vector{Cdouble or Cfloat}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint}
"""
csgrsh

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
  - x:          [IN] Vector{Cdouble or Cfloat}
  - y:          [IN] Vector{Cdouble or Cfloat}
  - grlagf:     [IN] Vector{Cint}
  - nnzj:       [OUT] Vector{Cint}
  - lj:         [IN] Vector{Cint}
  - j_val:      [OUT] Vector{Cdouble or Cfloat}
  - j_var:      [OUT] Vector{Cint}
  - j_fun:      [OUT] Vector{Cint}
  - ne:         [OUT] Vector{Cint}
  - lhe_ptr:    [IN] Vector{Cint}
  - he_row_ptr: [OUT] Vector{Cint}
  - he_val_ptr: [OUT] Vector{Cint}
  - lhe_row:    [IN] Vector{Cint}
  - he_row:     [OUT] Vector{Cint}
  - lhe_val:    [IN] Vector{Cint}
  - he_val:     [OUT] Vector{Cdouble or Cfloat}
  - byrows:     [IN] Vector{Cint}
"""
csgreh

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - vector:  [IN] Vector{Cdouble or Cfloat}
  - result:  [OUT] Vector{Cdouble or Cfloat}
"""
chprod

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
  - x:               [IN] Vector{Cdouble or Cfloat}
  - y:               [IN] Vector{Cdouble or Cfloat}
  - nnz_vector:      [IN] Vector{Cint}
  - index_nz_vector: [IN] Vector{Cint}
  - vector:          [IN] Vector{Cdouble or Cfloat}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{Cdouble or Cfloat}

Notice that `vector` and `result` should have allocated dimension of `n`.
"""
cshprod

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - y:       [IN] Vector{Cdouble or Cfloat}
  - vector:  [IN] Vector{Cdouble or Cfloat}
  - result:  [OUT] Vector{Cdouble or Cfloat}
"""
chcprod

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
  - x:               [IN] Vector{Cdouble or Cfloat}
  - y:               [IN] Vector{Cdouble or Cfloat}
  - nnz_vector:      [IN] Vector{Cint}
  - index_nz_vector: [IN] Vector{Cint}
  - vector:          [IN] Vector{Cdouble or Cfloat}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{Cdouble or Cfloat}
"""
cshcprod

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - vector:  [IN] Vector{Cdouble or Cfloat}
  - lvector: [IN] Vector{Cint}
  - result:  [OUT] Vector{Cdouble or Cfloat}
  - lresult: [IN] Vector{Cint}
"""
cjprod

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
  - x:               [IN] Vector{Cdouble or Cfloat}
  - nnz_vector:      [IN] Vector{Cint}
  - index_nz_vector: [IN] Vector{Cint}
  - vector:          [IN] Vector{Cdouble or Cfloat}
  - lvector:         [IN] Vector{Cint}
  - nnz_result:      [OUT] Vector{Cint}
  - index_nz_result: [OUT] Vector{Cint}
  - result:          [OUT] Vector{Cdouble or Cfloat}
  - lresult:         [IN] Vector{Cint}
"""
csjprod

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - vector:  [IN] Vector{Cdouble or Cfloat}
  - lchp:    [IN] Vector{Cint}
  - chp_val: [OUT] Vector{Cdouble or Cfloat}
  - chp_ind: [IN] Vector{Cint}
  - chp_ptr: [IN] Vector{Cint}
"""
cchprods

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
function cchprodsp(io_err::Vector{Cint}, m::Vector{Cint}, lchp::Vector{Cint},
    chp_ind::Vector{Cint}, chp_ptr::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_cchprodsp_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, m, lchp, chp_ind, chp_ptr)
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
function uterminate(io_err::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_uterminate_"), Nothing,
    (Ptr{Cint},),
    io_err)
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
function cterminate(io_err::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_cterminate_"), Nothing,
    (Ptr{Cint},),
    io_err)
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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - f:       [OUT] Vector{Cdouble or Cfloat}
"""
cifn

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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - nnzg:    [OUT] Vector{Cint}
  - lg:      [IN] Vector{Cint}
  - g_val:   [OUT] Vector{Cdouble or Cfloat}
  - g_var:   [OUT] Vector{Cint}
"""
cisgr

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
  - nnzj:    [OUT] Vector{Cint}
  - lj:      [IN] Vector{Cint}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
"""
function csgrp(io_err::Vector{Cint}, n::Vector{Cint}, nnzj::Vector{Cint},
    lj::Vector{Cint}, j_var::Vector{Cint}, j_fun::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_csgrp_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, nnzj, lj, j_var, j_fun)
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
  - x:       [IN] Vector{Cdouble or Cfloat}
  - g_val:   [OUT] Vector{Cdouble or Cfloat}
"""
cigr

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
  - nnzj:    [OUT] Vector{Cint};
  - lj:      [IN] Vector{Cint}
  - j_var:   [OUT] Vector{Cint}
  - j_fun:   [OUT] Vector{Cint}
  - nnzh:    [OUT] Vector{Cint}
  - lh:      [IN] Vector{Cint}
  - h_row:   [OUT] Vector{Cint}
  - h_col:   [OUT] Vector{Cint};
"""
function csgrshp(io_err::Vector{Cint}, n::Vector{Cint}, nnzj::Vector{Cint},
    lj::Vector{Cint}, j_var::Vector{Cint}, j_fun::Vector{Cint}, nnzh::Vector{Cint},
    lh::Vector{Cint}, h_row::Vector{Cint}, h_col::Vector{Cint})
  ccall(dlsym(cutest_lib_double, "cutest_csgrshp_"), Nothing,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
     Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, nnzj, lj, j_var, j_fun, nnzh, lh, h_row, h_col)
end
