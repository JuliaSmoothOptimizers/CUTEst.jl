export usetup, csetup, udimen, udimsh, udimse, uvartype, unames,
    ureport, cdimen, cdimsj, cdimsh, cdimchp, cdimse, cstats, cvartype,
    cnames, creport, connames, pname, probname, varnames, ufn, ugr, uofg,
    udh, ushp, ush, ueh, ugrdh, ugrsh, ugreh, uhprod, ushprod, ubandh,
    cfn, cofg, cofsg, ccfg, clfg, cgr, csgr, ccfsg, ccifg, ccifsg, cgrdh,
    cdh, cdhc, cshp, csh, cshc, ceh, cidh, cish, csgrsh, csgreh, chprod,
    cshprod, chcprod, cshcprod, cjprod, csjprod, cchprods, uterminate,
    cterminate

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

  - io_err:    [OUT] Array{Cint, 1}
  - input:     [IN] Array{Cint, 1}
  - out:       [IN] Array{Cint, 1}
  - io_buffer: [IN] Array{Cint, 1}
  - n:         [IN] Array{Cint, 1}
  - x:         [OUT] Array{Cdouble, 1}
  - x_l:       [OUT] Array{Cdouble, 1}
  - x_u:       [OUT] Array{Cdouble, 1}
"""
function usetup(io_err::Array{Cint, 1}, input::Array{Cint, 1}, out::Array{Cint, 1},
    io_buffer::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    x_l::Array{Cdouble, 1}, x_u::Array{Cdouble, 1})
  ccall(dlsym(cutest_lib, "cutest_usetup_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, input, out, io_buffer, n, x, x_l, x_u)
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

  - io_err:    [OUT] Array{Cint, 1}
  - input:     [IN] Array{Cint, 1}
  - out:       [IN] Array{Cint, 1}
  - io_buffer: [IN] Array{Cint, 1}
  - n:         [IN] Array{Cint, 1}
  - m:         [IN] Array{Cint, 1}
  - x:         [OUT] Array{Cdouble, 1}
  - x_l:       [OUT] Array{Cdouble, 1}
  - x_u:       [OUT] Array{Cdouble, 1}
  - y:         [OUT] Array{Cdouble, 1}
  - c_l:       [OUT] Array{Cdouble, 1}
  - c_u:       [OUT] Array{Cdouble, 1}
  - equatn:    [OUT] Array{Cint, 1}
  - linear:    [OUT] Array{Cint, 1}
  - e_order:   [IN] Array{Cint, 1}
  - l_order:   [IN] Array{Cint, 1}
  - v_order:   [IN] Array{Cint, 1}
"""
function csetup(io_err::Array{Cint, 1}, input::Array{Cint, 1}, out::Array{Cint, 1},
    io_buffer::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, x_l::Array{Cdouble, 1}, x_u::Array{Cdouble, 1},
    y::Array{Cdouble, 1}, c_l::Array{Cdouble, 1}, c_u::Array{Cdouble, 1},
    equatn::Array{Cint, 1}, linear::Array{Cint, 1}, e_order::Array{Cint,
    1}, l_order::Array{Cint, 1}, v_order::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_csetup_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn,
    linear, e_order, l_order, v_order)
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

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - n:       [OUT] Array{Cint, 1}
"""
function udimen(io_err::Array{Cint, 1}, input::Array{Cint, 1}, n::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_udimen_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
"""
function udimsh(io_err::Array{Cint, 1}, nnzh::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_udimsh_"), Void,
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

  - io_err:    [OUT] Array{Cint, 1}
  - ne:        [OUT] Array{Cint, 1}
  - he_val_ne: [OUT] Array{Cint, 1}
  - he_row_ne: [OUT] Array{Cint, 1}
"""
function udimse(io_err::Array{Cint, 1}, ne::Array{Cint, 1}, he_val_ne::Array{Cint, 1},
    he_row_ne::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_udimse_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}
"""
function uvartype(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x_type::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_uvartype_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}
"""
function unames(io_err::Array{Cint, 1}, n::Array{Cint, 1}, pname::Array{Cchar, 1},
    vname::Array{Cchar, 1})
  ccall(dlsym(cutest_lib, "cutest_unames_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cchar}),
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

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}
"""
function ureport(io_err::Array{Cint, 1}, calls::Array{Cdouble, 1}, time::Array{Cdouble,
    1})
  ccall(dlsym(cutest_lib, "cutest_ureport_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - n:       [OUT] Array{Cint, 1}
  - m:       [OUT] Array{Cint, 1}
"""
function cdimen(io_err::Array{Cint, 1}, input::Array{Cint, 1}, n::Array{Cint, 1},
    m::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cdimen_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - nnzj:    [OUT] Array{Cint, 1}
"""
function cdimsj(io_err::Array{Cint, 1}, nnzj::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cdimsj_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
"""
function cdimsh(io_err::Array{Cint, 1}, nnzh::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cdimsh_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - nnzchp:  [OUT] Array{Cint, 1}
"""
function cdimchp(io_err::Array{Cint, 1}, nnzchp::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cdimchp_"), Void,
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

  - io_err:    [OUT] Array{Cint, 1}
  - ne:        [OUT] Array{Cint, 1}
  - he_val_ne: [OUT] Array{Cint, 1}
  - he_row_ne: [OUT] Array{Cint, 1}
"""
function cdimse(io_err::Array{Cint, 1}, ne::Array{Cint, 1}, he_val_ne::Array{Cint, 1},
    he_row_ne::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cdimse_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, ne, he_val_ne, he_row_ne)
end

"""# cstats
    cstats(io_err, nonlinear_variables_objective,
nonlinear_variables_constraints, equality_constraints,
linear_constraints)

  - io_err:                          [OUT] Array{Cint, 1}
  - nonlinear_variables_objective:   [OUT] Array{Cint, 1}
  - nonlinear_variables_constraints: [OUT] Array{Cint, 1}
  - equality_constraints:            [OUT] Array{Cint, 1}
  - linear_constraints:              [OUT] Array{Cint, 1}
"""
function cstats(io_err::Array{Cint, 1}, nonlinear_variables_objective::Array{Cint, 1},
    nonlinear_variables_constraints::Array{Cint, 1},
    equality_constraints::Array{Cint, 1}, linear_constraints::Array{Cint,
    1})
  ccall(dlsym(cutest_lib, "cutest_cstats_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}
"""
function cvartype(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x_type::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cvartype_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - cname:   [OUT] Array{Cchar, 1}
"""
function cnames(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    pname::Array{Cchar, 1}, vname::Array{Cchar, 1}, cname::Array{Cchar, 1})
  ccall(dlsym(cutest_lib, "cutest_cnames_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}),
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

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}
"""
function creport(io_err::Array{Cint, 1}, calls::Array{Cdouble, 1}, time::Array{Cdouble,
    1})
  ccall(dlsym(cutest_lib, "cutest_creport_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - cname:   [OUT] Array{Cchar, 1}
"""
function connames(io_err::Array{Cint, 1}, m::Array{Cint, 1}, cname::Array{Cchar, 1})
  ccall(dlsym(cutest_lib, "cutest_connames_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
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

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
"""
function pname(io_err::Array{Cint, 1}, input::Array{Cint, 1}, pname::Array{Cchar, 1})
  ccall(dlsym(cutest_lib, "cutest_pname_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
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

  - io_err:  [OUT] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
"""
function probname(io_err::Array{Cint, 1}, pname::Array{Cchar, 1})
  ccall(dlsym(cutest_lib, "cutest_probname_"), Void,
    (Ptr{Cint}, Ptr{Cchar}),
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - vname:   [OUT] Array{Cchar, 1}
"""
function varnames(io_err::Array{Cint, 1}, n::Array{Cint, 1}, vname::Array{Cchar, 1})
  ccall(dlsym(cutest_lib, "cutest_varnames_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cchar}),
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
"""
function ufn(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1})
  ccall(dlsym(cutest_lib, "cutest_ufn_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, x, f)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
"""
function ugr(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1})
  ccall(dlsym(cutest_lib, "cutest_ugr_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, x, g)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
"""
function uofg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, g::Array{Cdouble, 1}, grad::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_uofg_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}),
    io_err, n, x, f, g, grad)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
"""
function udh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    lh1::Array{Cint, 1}, h::Array{Cdouble, 2})
  ccall(dlsym(cutest_lib, "cutest_udh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, x, lh1, h)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function ushp(io_err::Array{Cint, 1}, n::Array{Cint, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ushp_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function ush(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    nnzh::Array{Cint, 1}, lh::Array{Cint, 1}, h_val::Array{Cdouble, 1},
    h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ush_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, nnzh, lh, h_val, h_row, h_col)
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

  - io_err:     [OUT] Array{Cint, 1}
  - n:          [IN] Array{Cint, 1}
  - x:          [IN] Array{Cdouble, 1}
  - ne:         [OUT] Array{Cint, 1}
  - lhe_ptr:    [IN] Array{Cint, 1}
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Array{Cint, 1}
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Array{Cint, 1}
  - he_val:     [OUT] Array{Cdouble, 1}
  - byrows:     [IN] Array{Cint, 1}
"""
function ueh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    ne::Array{Cint, 1}, lhe_ptr::Array{Cint, 1}, he_row_ptr::Array{Cint,
    1}, he_val_ptr::Array{Cint, 1}, lhe_row::Array{Cint, 1},
    he_row::Array{Cint, 1}, lhe_val::Array{Cint, 1},
    he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ueh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, x, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
    lhe_val, he_val, byrows)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
"""
function ugrdh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, lh1::Array{Cint, 1}, h::Array{Cdouble, 2})
  ccall(dlsym(cutest_lib, "cutest_ugrdh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cdouble}),
    io_err, n, x, g, lh1, h)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function ugrsh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, nnzh::Array{Cint, 1}, lh::Array{Cint, 1},
    h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ugrsh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, g, nnzh, lh, h_val, h_row, h_col)
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

  - io_err:     [OUT] Array{Cint, 1}
  - n:          [IN] Array{Cint, 1}
  - x:          [IN] Array{Cdouble, 1}
  - g:          [OUT] Array{Cdouble, 1}
  - ne:         [OUT] Array{Cint, 1}
  - lhe_ptr:    [IN] Array{Cint, 1}
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Array{Cint, 1}
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Array{Cint, 1}
  - he_val:     [OUT] Array{Cdouble, 1}
  - byrows:     [IN] Array{Cint, 1}
"""
function ugreh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, ne::Array{Cint, 1}, lhe_ptr::Array{Cint, 1},
    he_row_ptr::Array{Cint, 1}, he_val_ptr::Array{Cint, 1},
    lhe_row::Array{Cint, 1}, he_row::Array{Cint, 1}, lhe_val::Array{Cint,
    1}, he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ugreh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, x, g, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
    lhe_val, he_val, byrows)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
"""
function uhprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, goth::Array{Cint, 1},
    x::Array{Cdouble, 1}, vector::Array{Cdouble, 1},
    result::Array{Cdouble, 1})
  ccall(dlsym(cutest_lib, "cutest_uhprod_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}),
    io_err, n, goth, x, vector, result)
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

  - io_err:          [OUT] Array{Cint, 1}
  - n:               [IN] Array{Cint, 1}
  - goth:            [IN] Array{Cint, 1}
  - x:               [IN] Array{Cdouble, 1}
  - nnz_vector:      [IN] Array{Cint, 1}
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Cdouble, 1}
  - nnz_result:      [OUT] Array{Cint, 1}
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Cdouble, 1}
"""
function ushprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, goth::Array{Cint, 1},
    x::Array{Cdouble, 1}, nnz_vector::Array{Cint, 1},
    index_nz_vector::Array{Cint, 1}, vector::Array{Cdouble, 1},
    nnz_result::Array{Cint, 1}, index_nz_result::Array{Cint, 1},
    result::Array{Cdouble, 1})
  ccall(dlsym(cutest_lib, "cutest_ushprod_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, goth, x, nnz_vector, index_nz_vector, vector, nnz_result,
    index_nz_result, result)
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

  - io_err:            [OUT] Array{Cint, 1}
  - n:                 [IN] Array{Cint, 1}
  - x:                 [IN] Array{Cdouble, 1}
  - semibandwidth:     [IN] Array{Cint, 1}
  - h_band:            [OUT] Array{Cdouble, 2}
  - lbandh:            [IN] Array{Cint, 1}
  - max_semibandwidth: [OUT] Array{Cint, 1}
"""
function ubandh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    semibandwidth::Array{Cint, 1}, h_band::Array{Cdouble, 2},
    lbandh::Array{Cint, 1}, max_semibandwidth::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ubandh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, semibandwidth, h_band, lbandh, max_semibandwidth)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - c:       [OUT] Array{Cdouble, 1}
"""
function cfn(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, f::Array{Cdouble, 1}, c::Array{Cdouble, 1})
  ccall(dlsym(cutest_lib, "cutest_cfn_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}),
    io_err, n, m, x, f, c)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
"""
function cofg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, g::Array{Cdouble, 1}, grad::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cofg_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}),
    io_err, n, x, f, g, grad)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - nnzg:    [OUT] Array{Cint, 1}
  - lg:      [IN] Array{Cint, 1}
  - g_val:   [OUT] Array{Cdouble, 1}
  - g_var:   [OUT] Array{Cint, 1}
  - grad:    [IN] Array{Cint, 1}
"""
function cofsg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    f::Array{Cdouble, 1}, nnzg::Array{Cint, 1}, lg::Array{Cint, 1},
    g_val::Array{Cdouble, 1}, g_var::Array{Cint, 1}, grad::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cofsg_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, f, nnzg, lg, g_val, g_var, grad)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - c:       [OUT] Array{Cdouble, 1}
  - jtrans:  [IN] Array{Cint, 1}
  - lcjac1:  [IN] Array{Cint, 1}
  - lcjac2:  [IN] Array{Cint, 1}
  - cjac:    [OUT] Array{Cdouble, 2}
  - grad:    [IN] Array{Cint, 1}
"""
function ccfg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, c::Array{Cdouble, 1}, jtrans::Array{Cint, 1},
    lcjac1::Array{Cint, 1}, lcjac2::Array{Cint, 1}, cjac::Array{Cdouble,
    2}, grad::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ccfg_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
"""
function clfg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, f::Array{Cdouble, 1},
    g::Array{Cdouble, 1}, grad::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_clfg_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, y, f, g, grad)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - grlagf:  [IN] Array{Cint, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - jtrans:  [IN] Array{Cint, 1}
  - lj1:     [IN] Array{Cint, 1}
  - lj2:     [IN] Array{Cint, 1}
  - j_val:   [OUT] Array{Cdouble, 2}
"""
function cgr(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    g::Array{Cdouble, 1}, jtrans::Array{Cint, 1}, lj1::Array{Cint, 1},
    lj2::Array{Cint, 1}, j_val::Array{Cdouble, 2})
  ccall(dlsym(cutest_lib, "cutest_cgr_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - grlagf:  [IN] Array{Cint, 1}
  - nnzj:    [OUT] Array{Cint, 1}
  - lj:      [IN] Array{Cint, 1}
  - j_val:   [OUT] Array{Cdouble, 1}
  - j_var:   [OUT] Array{Cint, 1}
  - j_fun:   [OUT] Array{Cint, 1}
"""
function csgr(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    nnzj::Array{Cint, 1}, lj::Array{Cint, 1}, j_val::Array{Cdouble, 1},
    j_var::Array{Cint, 1}, j_fun::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_csgr_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - c:       [OUT] Array{Cdouble, 1}
  - nnzj:    [OUT] Array{Cint, 1}
  - lj:      [IN] Array{Cint, 1}
  - j_val:   [OUT] Array{Cdouble, 1}
  - j_var:   [OUT] Array{Cint, 1}
  - j_fun:   [OUT] Array{Cint, 1}
  - grad:    [IN] Array{Cint, 1}
"""
function ccfsg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, c::Array{Cdouble, 1}, nnzj::Array{Cint, 1},
    lj::Array{Cint, 1}, j_val::Array{Cdouble, 1}, j_var::Array{Cint, 1},
    j_fun::Array{Cint, 1}, grad::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ccfsg_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - icon:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - ci:      [OUT] Array{Cdouble, 1}
  - gci:     [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
"""
function ccifg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, icon::Array{Cint, 1},
    x::Array{Cdouble, 1}, ci::Array{Cdouble, 1}, gci::Array{Cdouble, 1},
    grad::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ccifg_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, icon, x, ci, gci, grad)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - icon:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - ci:      [OUT] Array{Cdouble, 1}
  - nnzgci:  [OUT] Array{Cint, 1}
  - lgci:    [IN] Array{Cint, 1}
  - gci_val: [OUT] Array{Cdouble, 1}
  - gci_var: [OUT] Array{Cint, 1}
  - grad:    [IN] Array{Cint, 1}
"""
function ccifsg(io_err::Array{Cint, 1}, n::Array{Cint, 1}, icon::Array{Cint, 1},
    x::Array{Cdouble, 1}, ci::Array{Cdouble, 1}, nnzgci::Array{Cint, 1},
    lgci::Array{Cint, 1}, gci_val::Array{Cdouble, 1}, gci_var::Array{Cint,
    1}, grad::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ccifsg_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - grlagf:  [IN] Array{Cint, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - jtrans:  [IN] Array{Cint, 1}
  - lj1:     [IN] Array{Cint, 1}
  - lj2:     [IN] Array{Cint, 1}
  - j_val:   [OUT] Array{Cdouble, 2}
  - lh1:     [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 2}
"""
function cgrdh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    g::Array{Cdouble, 1}, jtrans::Array{Cint, 1}, lj1::Array{Cint, 1},
    lj2::Array{Cint, 1}, j_val::Array{Cdouble, 2}, lh1::Array{Cint, 1},
    h_val::Array{Cdouble, 2})
  ccall(dlsym(cutest_lib, "cutest_cgrdh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 2}
"""
function cdh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, lh1::Array{Cint, 1},
    h_val::Array{Cdouble, 2})
  ccall(dlsym(cutest_lib, "cutest_cdh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, x, y, lh1, h_val)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 2}
"""
function cdhc(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, lh1::Array{Cint, 1},
    h_val::Array{Cdouble, 2})
  ccall(dlsym(cutest_lib, "cutest_cdhc_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, x, y, lh1, h_val)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function cshp(io_err::Array{Cint, 1}, n::Array{Cint, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cshp_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function csh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1},
    h_col::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_csh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function cshc(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1},
    h_col::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cshc_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)
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

  - io_err:     [OUT] Array{Cint, 1}
  - n:          [IN] Array{Cint, 1}
  - m:          [IN] Array{Cint, 1}
  - x:          [IN] Array{Cdouble, 1}
  - y:          [IN] Array{Cdouble, 1}
  - ne:         [OUT] Array{Cint, 1}
  - lhe_ptr:    [IN] Array{Cint, 1}
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Array{Cint, 1}
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Array{Cint, 1}
  - he_val:     [OUT] Array{Cdouble, 1}
  - byrows:     [IN] Array{Cint, 1}
"""
function ceh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, ne::Array{Cint, 1},
    lhe_ptr::Array{Cint, 1}, he_row_ptr::Array{Cint, 1},
    he_val_ptr::Array{Cint, 1}, lhe_row::Array{Cint, 1},
    he_row::Array{Cint, 1}, lhe_val::Array{Cint, 1},
    he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_ceh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, y, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row,
    he_row, lhe_val, he_val, byrows)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - iprob:   [IN] Array{Cint, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
"""
function cidh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    iprob::Array{Cint, 1}, lh1::Array{Cint, 1}, h::Array{Cdouble, 2})
  ccall(dlsym(cutest_lib, "cutest_cidh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, x, iprob, lh1, h)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - iprob:   [IN] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function cish(io_err::Array{Cint, 1}, n::Array{Cint, 1}, x::Array{Cdouble, 1},
    iprob::Array{Cint, 1}, nnzh::Array{Cint, 1}, lh::Array{Cint, 1},
    h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1}, h_col::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cish_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, x, iprob, nnzh, lh, h_val, h_row, h_col)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - grlagf:  [IN] Array{Cint, 1}
  - nnzj:    [OUT] Array{Cint, 1}
  - lj:      [IN] Array{Cint, 1}
  - j_val:   [OUT] Array{Cdouble, 1}
  - j_var:   [OUT] Array{Cint, 1}
  - j_fun:   [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
"""
function csgrsh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    nnzj::Array{Cint, 1}, lj::Array{Cint, 1}, j_val::Array{Cdouble, 1},
    j_var::Array{Cint, 1}, j_fun::Array{Cint, 1}, nnzh::Array{Cint, 1},
    lh::Array{Cint, 1}, h_val::Array{Cdouble, 1}, h_row::Array{Cint, 1},
    h_col::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_csgrsh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, nnzh, lh,
    h_val, h_row, h_col)
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

  - io_err:     [OUT] Array{Cint, 1}
  - n:          [IN] Array{Cint, 1}
  - m:          [IN] Array{Cint, 1}
  - x:          [IN] Array{Cdouble, 1}
  - y:          [IN] Array{Cdouble, 1}
  - grlagf:     [IN] Array{Cint, 1}
  - nnzj:       [OUT] Array{Cint, 1}
  - lj:         [IN] Array{Cint, 1}
  - j_val:      [OUT] Array{Cdouble, 1}
  - j_var:      [OUT] Array{Cint, 1}
  - j_fun:      [OUT] Array{Cint, 1}
  - ne:         [OUT] Array{Cint, 1}
  - lhe_ptr:    [IN] Array{Cint, 1}
  - he_row_ptr: [OUT] Array{Cint, 1}
  - he_val_ptr: [OUT] Array{Cint, 1}
  - lhe_row:    [IN] Array{Cint, 1}
  - he_row:     [OUT] Array{Cint, 1}
  - lhe_val:    [IN] Array{Cint, 1}
  - he_val:     [OUT] Array{Cdouble, 1}
  - byrows:     [IN] Array{Cint, 1}
"""
function csgreh(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    x::Array{Cdouble, 1}, y::Array{Cdouble, 1}, grlagf::Array{Cint, 1},
    nnzj::Array{Cint, 1}, lj::Array{Cint, 1}, j_val::Array{Cdouble, 1},
    j_var::Array{Cint, 1}, j_fun::Array{Cint, 1}, ne::Array{Cint, 1},
    lhe_ptr::Array{Cint, 1}, he_row_ptr::Array{Cint, 1},
    he_val_ptr::Array{Cint, 1}, lhe_row::Array{Cint, 1},
    he_row::Array{Cint, 1}, lhe_val::Array{Cint, 1},
    he_val::Array{Cdouble, 1}, byrows::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_csgreh_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, ne,
    lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val,
    byrows)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
"""
function chprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    goth::Array{Cint, 1}, x::Array{Cdouble, 1}, y::Array{Cdouble, 1},
    vector::Array{Cdouble, 1}, result::Array{Cdouble, 1})
  ccall(dlsym(cutest_lib, "cutest_chprod_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, m, goth, x, y, vector, result)
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

  - io_err:          [OUT] Array{Cint, 1}
  - n:               [IN] Array{Cint, 1}
  - m:               [IN] Array{Cint, 1}
  - goth:            [IN] Array{Cint, 1}
  - x:               [IN] Array{Cdouble, 1}
  - y:               [IN] Array{Cdouble, 1}
  - nnz_vector:      [IN] Array{Cint, 1}
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Cdouble, 1}
  - nnz_result:      [OUT] Array{Cint, 1}
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Cdouble, 1}
"""
function cshprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    goth::Array{Cint, 1}, x::Array{Cdouble, 1}, y::Array{Cdouble, 1},
    nnz_vector::Array{Cint, 1}, index_nz_vector::Array{Cint, 1},
    vector::Array{Cdouble, 1}, nnz_result::Array{Cint, 1},
    index_nz_result::Array{Cint, 1}, result::Array{Cdouble, 1})
  ccall(dlsym(cutest_lib, "cutest_cshprod_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, goth, x, y, nnz_vector, index_nz_vector, vector,
    nnz_result, index_nz_result, result)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
"""
function chcprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    goth::Array{Cint, 1}, x::Array{Cdouble, 1}, y::Array{Cdouble, 1},
    vector::Array{Cdouble, 1}, result::Array{Cdouble, 1})
  ccall(dlsym(cutest_lib, "cutest_chcprod_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}),
    io_err, n, m, goth, x, y, vector, result)
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

  - io_err:          [OUT] Array{Cint, 1}
  - n:               [IN] Array{Cint, 1}
  - m:               [IN] Array{Cint, 1}
  - goth:            [IN] Array{Cint, 1}
  - x:               [IN] Array{Cdouble, 1}
  - y:               [IN] Array{Cdouble, 1}
  - nnz_vector:      [IN] Array{Cint, 1}
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Cdouble, 1}
  - nnz_result:      [OUT] Array{Cint, 1}
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Cdouble, 1}
"""
function cshcprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    goth::Array{Cint, 1}, x::Array{Cdouble, 1}, y::Array{Cdouble, 1},
    nnz_vector::Array{Cint, 1}, index_nz_vector::Array{Cint, 1},
    vector::Array{Cdouble, 1}, nnz_result::Array{Cint, 1},
    index_nz_result::Array{Cint, 1}, result::Array{Cdouble, 1})
  ccall(dlsym(cutest_lib, "cutest_cshcprod_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint},
    Ptr{Cint}, Ptr{Cdouble}),
    io_err, n, m, goth, x, y, nnz_vector, index_nz_vector, vector,
    nnz_result, index_nz_result, result)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - gotj:    [IN] Array{Cint, 1}
  - jtrans:  [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - lvector: [IN] Array{Cint, 1}
  - result:  [OUT] Array{Cdouble, 1}
  - lresult: [IN] Array{Cint, 1}
"""
function cjprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    gotj::Array{Cint, 1}, jtrans::Array{Cint, 1}, x::Array{Cdouble, 1},
    vector::Array{Cdouble, 1}, lvector::Array{Cint, 1},
    result::Array{Cdouble, 1}, lresult::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cjprod_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, gotj, jtrans, x, vector, lvector, result, lresult)
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

  - io_err:          [OUT] Array{Cint, 1}
  - n:               [IN] Array{Cint, 1}
  - m:               [IN] Array{Cint, 1}
  - gotj:            [IN] Array{Cint, 1}
  - jtrans:          [IN] Array{Cint, 1}
  - x:               [IN] Array{Cdouble, 1}
  - nnz_vector:      [IN] Array{Cint, 1}
  - index_nz_vector: [IN] Array{Cint, 1}
  - vector:          [IN] Array{Cdouble, 1}
  - lvector:         [IN] Array{Cint, 1}
  - nnz_result:      [OUT] Array{Cint, 1}
  - index_nz_result: [OUT] Array{Cint, 1}
  - result:          [OUT] Array{Cdouble, 1}
  - lresult:         [IN] Array{Cint, 1}
"""
function csjprod(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    gotj::Array{Cint, 1}, jtrans::Array{Cint, 1}, x::Array{Cdouble, 1},
    nnz_vector::Array{Cint, 1}, index_nz_vector::Array{Cint, 1},
    vector::Array{Cdouble, 1}, lvector::Array{Cint, 1},
    nnz_result::Array{Cint, 1}, index_nz_result::Array{Cint, 1},
    result::Array{Cdouble, 1}, lresult::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_csjprod_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
    Ptr{Cdouble}, Ptr{Cint}),
    io_err, n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector,
    lvector, nnz_result, index_nz_result, result, lresult)
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

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - lchp:    [IN] Array{Cint, 1}
  - chp_val: [OUT] Array{Cdouble, 1}
  - chp_ind: [IN] Array{Cint, 1}
  - chp_ptr: [IN] Array{Cint, 1}
"""
function cchprods(io_err::Array{Cint, 1}, n::Array{Cint, 1}, m::Array{Cint, 1},
    goth::Array{Cint, 1}, x::Array{Cdouble, 1}, vector::Array{Cdouble, 1},
    lchp::Array{Cint, 1}, chp_val::Array{Cdouble, 1}, chp_ind::Array{Cint,
    1}, chp_ptr::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cchprods_"), Void,
    (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble},
    Ptr{Cdouble}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}),
    io_err, n, m, goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)
end

"""# uterminate
The uterminate subroutine deallocates all workspace arrays created
since the last call to usetup.

For more information, run the shell command

    man cutest_uterminate

Usage:

    uterminate(io_err)

  - io_err:  [OUT] Array{Cint, 1}
"""
function uterminate(io_err::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_uterminate_"), Void,
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

  - io_err:  [OUT] Array{Cint, 1}
"""
function cterminate(io_err::Array{Cint, 1})
  ccall(dlsym(cutest_lib, "cutest_cterminate_"), Void,
    (Ptr{Cint},),
    io_err)
end

