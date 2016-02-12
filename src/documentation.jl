"""# usetup
The usetup subroutine sets up the correct data structures for
subsequent computations in the case where the only possible
constraints are bound constraints. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    x, x_l, x_u = usetup(input, out, io_buffer, n)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}

    usetup!(input, out, io_buffer, n, x, x_l, x_u)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}

"""
usetup

"""# usetup
The usetup subroutine sets up the correct data structures for
subsequent computations in the case where the only possible
constraints are bound constraints. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    x, x_l, x_u = usetup(input, out, io_buffer, n)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}

    usetup!(input, out, io_buffer, n, x, x_l, x_u)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}

"""
usetup!

"""# csetup
The csetup subroutine sets up the correct data structures for
subsequent computations on the problem decoded from a SIF file by the
script sifdecoder. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    x, x_l, x_u, y, c_l, c_u, equatn, linear = csetup(input, out, io_buffer, n, m, e_order, l_order, v_order)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - m:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
  - y:         [OUT] Array{Float64, 1}
  - c_l:       [OUT] Array{Float64, 1}
  - c_u:       [OUT] Array{Float64, 1}
  - equatn:    [OUT] Array{Bool, 1}
  - linear:    [OUT] Array{Bool, 1}
  - e_order:   [IN] Int
  - l_order:   [IN] Int
  - v_order:   [IN] Int

    csetup!(input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn, linear, e_order, l_order, v_order)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - m:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
  - y:         [OUT] Array{Float64, 1}
  - c_l:       [OUT] Array{Float64, 1}
  - c_u:       [OUT] Array{Float64, 1}
  - equatn:    [OUT] Array{Bool, 1}
  - linear:    [OUT] Array{Bool, 1}
  - e_order:   [IN] Int
  - l_order:   [IN] Int
  - v_order:   [IN] Int

"""
csetup

"""# csetup
The csetup subroutine sets up the correct data structures for
subsequent computations on the problem decoded from a SIF file by the
script sifdecoder. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    x, x_l, x_u, y, c_l, c_u, equatn, linear = csetup(input, out, io_buffer, n, m, e_order, l_order, v_order)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - m:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
  - y:         [OUT] Array{Float64, 1}
  - c_l:       [OUT] Array{Float64, 1}
  - c_u:       [OUT] Array{Float64, 1}
  - equatn:    [OUT] Array{Bool, 1}
  - linear:    [OUT] Array{Bool, 1}
  - e_order:   [IN] Int
  - l_order:   [IN] Int
  - v_order:   [IN] Int

    csetup!(input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn, linear, e_order, l_order, v_order)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - m:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
  - y:         [OUT] Array{Float64, 1}
  - c_l:       [OUT] Array{Float64, 1}
  - c_u:       [OUT] Array{Float64, 1}
  - equatn:    [OUT] Array{Bool, 1}
  - linear:    [OUT] Array{Bool, 1}
  - e_order:   [IN] Int
  - l_order:   [IN] Int
  - v_order:   [IN] Int

"""
csetup!

"""# udimen
The udimen subroutine discovers how many variables are involved in the
problem decoded from a SIF file by the script sifdecoder. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The
objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_udimen

Usage:

    udimen(io_err, input, n)

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - n:       [OUT] Array{Cint, 1}


    n = udimen(input)

  - input:   [IN] Int
  - n:       [OUT] Int

"""
udimen

"""# udimsh
The udimsh subroutine determine the number of nonzeros required to
store the Hessian matrix of the objective function of the problem
decoded from a SIF file by the script sifdecoder at the point X. This
Hessian matrix is stored as a sparse matrix in coordinate format. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu.
The objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_udimsh

Usage:

    udimsh(io_err, nnzh)

  - io_err:  [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}


    nnzh = udimsh()

  - nnzh:    [OUT] Int

"""
udimsh

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

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_udimse

Usage:

    udimse(io_err, ne, he_val_ne, he_row_ne)

  - io_err:    [OUT] Array{Cint, 1}
  - ne:        [OUT] Array{Cint, 1}
  - he_val_ne: [OUT] Array{Cint, 1}
  - he_row_ne: [OUT] Array{Cint, 1}


    ne, he_val_ne, he_row_ne = udimse()

  - ne:        [OUT] Int
  - he_val_ne: [OUT] Int
  - he_row_ne: [OUT] Int

"""
udimse

"""# uvartype
The uvartype subroutine determines the type (continuous, 0-1, integer)
of each variable involved in the problem decoded from a SIF file by
the script sifdecoder. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uvartype

Usage:

    uvartype(io_err, n, x_type)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}


    x_type = uvartype(n)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}

    uvartype!(n, x_type)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}

"""
uvartype

"""# uvartype
The uvartype subroutine determines the type (continuous, 0-1, integer)
of each variable involved in the problem decoded from a SIF file by
the script sifdecoder. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uvartype

Usage:

    uvartype(io_err, n, x_type)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}


    x_type = uvartype(n)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}

    uvartype!(n, x_type)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}

"""
uvartype!

"""# unames
The unames subroutine obtains the names of the problem and its
variables. The problem under consideration is to minimize or maximize
an objective function f(x) over all x ∈ Rn subject to the simple
bounds xl≤x≤xu. The objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_unames

Usage:

    unames(io_err, n, pname, vname)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}


    pname, vname = unames(n)

  - n:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}

    pname = unames!(n, vname)

  - n:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}

"""
unames

"""# unames
The unames subroutine obtains the names of the problem and its
variables. The problem under consideration is to minimize or maximize
an objective function f(x) over all x ∈ Rn subject to the simple
bounds xl≤x≤xu. The objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_unames

Usage:

    unames(io_err, n, pname, vname)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}


    pname, vname = unames(n)

  - n:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}

    pname = unames!(n, vname)

  - n:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}

"""
unames!

"""# ureport
The ureport subroutine obtains statistics concerning function
evaluation and CPU time used for unconstrained or bound-constrained
optimization in a standardized format. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ureport

Usage:

    ureport(io_err, calls, time)

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}


    calls, time = ureport()

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    ureport!(calls, time)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    calls, time = ureport()

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    ureport!(calls, time)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

"""
ureport

"""# ureport
The ureport subroutine obtains statistics concerning function
evaluation and CPU time used for unconstrained or bound-constrained
optimization in a standardized format. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ureport

Usage:

    ureport(io_err, calls, time)

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}


    calls, time = ureport()

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    ureport!(calls, time)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    calls, time = ureport()

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    ureport!(calls, time)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

"""
ureport!

"""# cdimen
The cdimen subroutine discovers how many variables and constraints are
involved in the problem decoded from a SIF file by the script
sifdecoder. The problem under consideration is to minimize or maximize
an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cdimen

Usage:

    cdimen(io_err, input, n, m)

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - n:       [OUT] Array{Cint, 1}
  - m:       [OUT] Array{Cint, 1}


    n, m = cdimen(input)

  - input:   [IN] Int
  - n:       [OUT] Int
  - m:       [OUT] Int

"""
cdimen

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

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cdimsj

Usage:

    cdimsj(io_err, nnzj)

  - io_err:  [OUT] Array{Cint, 1}
  - nnzj:    [OUT] Array{Cint, 1}


    nnzj = cdimsj()

  - nnzj:    [OUT] Int

"""
cdimsj

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

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cdimsh

Usage:

    cdimsh(io_err, nnzh)

  - io_err:  [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}


    nnzh = cdimsh()

  - nnzh:    [OUT] Int

"""
cdimsh

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

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cdimchp

Usage:

    cdimchp(io_err, nnzchp)

  - io_err:  [OUT] Array{Cint, 1}
  - nnzchp:  [OUT] Array{Cint, 1}


    nnzchp = cdimchp()

  - nnzchp:  [OUT] Int

    nnzchp = cdimchp()

  - nnzchp:  [OUT] Int

"""
cdimchp

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

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cdimse

Usage:

    cdimse(io_err, ne, he_val_ne, he_row_ne)

  - io_err:    [OUT] Array{Cint, 1}
  - ne:        [OUT] Array{Cint, 1}
  - he_val_ne: [OUT] Array{Cint, 1}
  - he_row_ne: [OUT] Array{Cint, 1}


    ne, he_val_ne, he_row_ne = cdimse()

  - ne:        [OUT] Int
  - he_val_ne: [OUT] Int
  - he_row_ne: [OUT] Int

"""
cdimse

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
cstats

"""# cvartype
The cvartype subroutine determines the type (continuous, 0-1, integer)
of each variable involved in the problem decoded from a SIF file by
the script sifdecoder. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to
general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cvartype

Usage:

    cvartype(io_err, n, x_type)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}


    x_type = cvartype(n)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}

    cvartype!(n, x_type)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}

"""
cvartype

"""# cvartype
The cvartype subroutine determines the type (continuous, 0-1, integer)
of each variable involved in the problem decoded from a SIF file by
the script sifdecoder. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to
general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cvartype

Usage:

    cvartype(io_err, n, x_type)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}


    x_type = cvartype(n)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}

    cvartype!(n, x_type)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}

"""
cvartype!

"""# cnames
The cnames subroutine obtains the names of the problem, its variables
and general constraints. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cnames

Usage:

    cnames(io_err, n, m, pname, vname, cname)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - cname:   [OUT] Array{Cchar, 1}


    pname, vname, cname = cnames(n, m)

  - n:       [IN] Int
  - m:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}

    pname = cnames!(n, m, vname, cname)

  - n:       [IN] Int
  - m:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}

    pname, vname, cname = cnames()

  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}

    pname = cnames!(vname, cname)

  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}

"""
cnames

"""# cnames
The cnames subroutine obtains the names of the problem, its variables
and general constraints. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cnames

Usage:

    cnames(io_err, n, m, pname, vname, cname)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - cname:   [OUT] Array{Cchar, 1}


    pname, vname, cname = cnames(n, m)

  - n:       [IN] Int
  - m:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}

    pname = cnames!(n, m, vname, cname)

  - n:       [IN] Int
  - m:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}

    pname, vname, cname = cnames()

  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}

    pname = cnames!(vname, cname)

  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}

"""
cnames!

"""# creport
The creport subroutine obtains statistics concerning function
evaluation and CPU time used for constrained optimization in a
standardized format. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_creport

Usage:

    creport(io_err, calls, time)

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}


    calls, time = creport()

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    creport!(calls, time)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    calls, time = creport()

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    creport!(calls, time)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

"""
creport

"""# creport
The creport subroutine obtains statistics concerning function
evaluation and CPU time used for constrained optimization in a
standardized format. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_creport

Usage:

    creport(io_err, calls, time)

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}


    calls, time = creport()

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    creport!(calls, time)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    calls, time = creport()

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    creport!(calls, time)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

"""
creport!

"""# connames
The connames subroutine obtains the names of the general constraints
of the problem. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_connames

Usage:

    connames(io_err, m, cname)

  - io_err:  [OUT] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - cname:   [OUT] Array{Cchar, 1}


    cname = connames(m)

  - m:       [IN] Int
  - cname:   [OUT] Array{UInt8, 1}

    connames!(m, cname)

  - m:       [IN] Int
  - cname:   [OUT] Array{UInt8, 1}

    cname = connames()

  - cname:   [OUT] Array{UInt8, 1}

    connames!(cname)

  - cname:   [OUT] Array{UInt8, 1}

"""
connames

"""# connames
The connames subroutine obtains the names of the general constraints
of the problem. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_connames

Usage:

    connames(io_err, m, cname)

  - io_err:  [OUT] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - cname:   [OUT] Array{Cchar, 1}


    cname = connames(m)

  - m:       [IN] Int
  - cname:   [OUT] Array{UInt8, 1}

    connames!(m, cname)

  - m:       [IN] Int
  - cname:   [OUT] Array{UInt8, 1}

    cname = connames()

  - cname:   [OUT] Array{UInt8, 1}

    connames!(cname)

  - cname:   [OUT] Array{UInt8, 1}

"""
connames!

"""# pname
The pname subroutine obtains the name of the problem directly from the
datafile OUTSDIF.d that was created by the script sifdecoder when
decoding a SIF file. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separable and all constraint
functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_pname

Usage:

    pname(io_err, input, pname)

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}


    pname = pname(input)

  - input:   [IN] Int
  - pname:   [OUT] UInt8

    pname = pname(input)

  - input:   [IN] Int
  - pname:   [OUT] UInt8

"""
pname

"""# probname
The probname subroutine obtains the name of the problem. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_probname

Usage:

    probname(io_err, pname)

  - io_err:  [OUT] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}


    pname = probname()

  - pname:   [OUT] UInt8

    pname = probname()

  - pname:   [OUT] UInt8

"""
probname

"""# varnames
The varnames subroutine obtains the names of the problem variables.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separable and all constraint functions are partially
separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_varnames

Usage:

    varnames(io_err, n, vname)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - vname:   [OUT] Array{Cchar, 1}


    vname = varnames(n)

  - n:       [IN] Int
  - vname:   [OUT] Array{UInt8, 1}

    varnames!(n, vname)

  - n:       [IN] Int
  - vname:   [OUT] Array{UInt8, 1}

"""
varnames

"""# varnames
The varnames subroutine obtains the names of the problem variables.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separable and all constraint functions are partially
separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_varnames

Usage:

    varnames(io_err, n, vname)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - vname:   [OUT] Array{Cchar, 1}


    vname = varnames(n)

  - n:       [IN] Int
  - vname:   [OUT] Array{UInt8, 1}

    varnames!(n, vname)

  - n:       [IN] Int
  - vname:   [OUT] Array{UInt8, 1}

"""
varnames!

"""# ufn
The ufn subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ufn

Usage:

    ufn(io_err, n, x, f)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}


    f = ufn(n, x)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64

    f = ufn(x)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64

"""
ufn

"""# ugr
The ugr subroutine evaluates the gradient of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ugr

Usage:

    ugr(io_err, n, x, g)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}


    g = ugr(n, x)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}

    ugr!(n, x, g)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}

    g = ugr(x)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}

    ugr!(x, g)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}

"""
ugr

"""# ugr
The ugr subroutine evaluates the gradient of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ugr

Usage:

    ugr(io_err, n, x, g)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}


    g = ugr(n, x)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}

    ugr!(n, x, g)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}

    g = ugr(x)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}

    ugr!(x, g)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}

"""
ugr!

"""# uofg
The uofg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uofg

Usage:

    uofg(io_err, n, x, f, g, grad)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}


    f, g = uofg(n, x, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = uofg!(n, x, g, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f, g = uofg(x, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = uofg!(x, g, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

"""
uofg

"""# uofg
The uofg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uofg

Usage:

    uofg(io_err, n, x, f, g, grad)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}


    f, g = uofg(n, x, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = uofg!(n, x, g, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f, g = uofg(x, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = uofg!(x, g, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

"""
uofg!

"""# udh
The udh subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a dense
matrix. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_udh

Usage:

    udh(io_err, n, x, lh1, h)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}


    h = udh(n, x, lh1)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    udh!(n, x, lh1, h)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    h = udh(x, lh1)

  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    udh!(x, lh1, h)

  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

"""
udh

"""# udh
The udh subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a dense
matrix. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_udh

Usage:

    udh(io_err, n, x, lh1, h)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}


    h = udh(n, x, lh1)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    udh!(n, x, lh1, h)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    h = udh(x, lh1)

  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    udh!(x, lh1, h)

  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

"""
udh!

"""# ushp
The ushp subroutine evaluates the sparsity pattern of the Hessian
matrix of the objective function of the problem, decoded from a SIF
file by the script sifdecoder, in coordinate format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ushp

Usage:

    ushp(io_err, n, nnzh, lh, h_row, h_col)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}


    nnzh, h_row, h_col = ushp(n, lh)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ushp!(n, lh, h_row, h_col)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_row, h_col = ushp()

  - nnzh:    [OUT] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ushp!(h_row, h_col)

  - nnzh:    [OUT] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
ushp

"""# ushp
The ushp subroutine evaluates the sparsity pattern of the Hessian
matrix of the objective function of the problem, decoded from a SIF
file by the script sifdecoder, in coordinate format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ushp

Usage:

    ushp(io_err, n, nnzh, lh, h_row, h_col)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}


    nnzh, h_row, h_col = ushp(n, lh)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ushp!(n, lh, h_row, h_col)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_row, h_col = ushp()

  - nnzh:    [OUT] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ushp!(h_row, h_col)

  - nnzh:    [OUT] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
ushp!

"""# ush
The ush subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a sparse
matrix in coordinate format. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzh, h_val, h_row, h_col = ush(n, x, lh)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ush!(n, x, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_val, h_row, h_col = ush(x)

  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ush!(x, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
ush

"""# ush
The ush subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a sparse
matrix in coordinate format. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzh, h_val, h_row, h_col = ush(n, x, lh)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ush!(n, x, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_val, h_row, h_col = ush(x)

  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ush!(x, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
ush!

"""# ueh
The ueh subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a sparse
matrix in finite element format H=eΣ1He, where each square symmetric
element He involves a small subset of the rows of the Hessian matrix.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    ne, he_row_ptr, he_val_ptr, he_row, he_val = ueh(n, x, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ueh!(n, x, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ueh(x, lhe_ptr, lhe_row, lhe_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ueh!(x, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

"""
ueh

"""# ueh
The ueh subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a sparse
matrix in finite element format H=eΣ1He, where each square symmetric
element He involves a small subset of the rows of the Hessian matrix.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    ne, he_row_ptr, he_val_ptr, he_row, he_val = ueh(n, x, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ueh!(n, x, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ueh(x, lhe_ptr, lhe_row, lhe_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ueh!(x, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

"""
ueh!

"""# ugrdh
The ugrdh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
dense matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ugrdh

Usage:

    ugrdh(io_err, n, x, g, lh1, h)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}


    g, h = ugrdh(n, x, lh1)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    ugrdh!(n, x, g, lh1, h)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    g, h = ugrdh(x, lh1)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    ugrdh!(x, g, lh1, h)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

"""
ugrdh

"""# ugrdh
The ugrdh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
dense matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ugrdh

Usage:

    ugrdh(io_err, n, x, g, lh1, h)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}


    g, h = ugrdh(n, x, lh1)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    ugrdh!(n, x, g, lh1, h)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    g, h = ugrdh(x, lh1)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    ugrdh!(x, g, lh1, h)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

"""
ugrdh!

"""# ugrsh
The ugrsh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
sparse matrix in coordinate format. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    g, nnzh, h_val, h_row, h_col = ugrsh(n, x, lh)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ugrsh!(n, x, g, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    g, nnzh, h_val, h_row, h_col = ugrsh(x)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ugrsh!(x, g, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
ugrsh

"""# ugrsh
The ugrsh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
sparse matrix in coordinate format. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    g, nnzh, h_val, h_row, h_col = ugrsh(n, x, lh)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ugrsh!(n, x, g, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    g, nnzh, h_val, h_row, h_col = ugrsh(x)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ugrsh!(x, g, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
ugrsh!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    g, ne, he_row_ptr, he_val_ptr, he_row, he_val = ugreh(n, x, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - g:          [OUT] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ugreh!(n, x, g, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - g:          [OUT] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    g, ne, he_row_ptr, he_val_ptr, he_row, he_val = ugreh(x, lhe_ptr, lhe_row, lhe_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - g:          [OUT] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ugreh!(x, g, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - g:          [OUT] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

"""
ugreh

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    g, ne, he_row_ptr, he_val_ptr, he_row, he_val = ugreh(n, x, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - g:          [OUT] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ugreh!(n, x, g, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - g:          [OUT] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    g, ne, he_row_ptr, he_val_ptr, he_row, he_val = ugreh(x, lhe_ptr, lhe_row, lhe_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - g:          [OUT] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ugreh!(x, g, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - g:          [OUT] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

"""
ugreh!

"""# uhprod
The uhprod subroutine forms the product of a vector with the Hessian
matrix of the objective function of the problem decoded from a SIF
file by the script sifdecoder at the point X. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uhprod

Usage:

    uhprod(io_err, n, goth, x, vector, result)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}


    result = uhprod(n, goth, x, vector)

  - n:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    uhprod!(n, goth, x, vector, result)

  - n:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    result = uhprod(goth, x, vector)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    uhprod!(goth, x, vector, result)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

"""
uhprod

"""# uhprod
The uhprod subroutine forms the product of a vector with the Hessian
matrix of the objective function of the problem decoded from a SIF
file by the script sifdecoder at the point X. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uhprod

Usage:

    uhprod(io_err, n, goth, x, vector, result)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}


    result = uhprod(n, goth, x, vector)

  - n:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    uhprod!(n, goth, x, vector, result)

  - n:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    result = uhprod(goth, x, vector)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    uhprod!(goth, x, vector, result)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

"""
uhprod!

"""# ushprod
The ushprod subroutine forms the product of a sparse vector with the
Hessian matrix of the objective function of the problem decoded from a
SIF file by the script sifdecoder at the point X. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnz_result, index_nz_result, result = ushprod(n, goth, x, nnz_vector, index_nz_vector, vector)

  - n:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = ushprod!(n, goth, x, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - n:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result, index_nz_result, result = ushprod(goth, x, nnz_vector, index_nz_vector, vector)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = ushprod!(goth, x, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

"""
ushprod

"""# ushprod
The ushprod subroutine forms the product of a sparse vector with the
Hessian matrix of the objective function of the problem decoded from a
SIF file by the script sifdecoder at the point X. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnz_result, index_nz_result, result = ushprod(n, goth, x, nnz_vector, index_nz_vector, vector)

  - n:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = ushprod!(n, goth, x, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - n:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result, index_nz_result, result = ushprod(goth, x, nnz_vector, index_nz_vector, vector)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = ushprod!(goth, x, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

"""
ushprod!

"""# ubandh
The ubandh subroutine extracts the elements which lie within a band of
given semi-bandwidth out of the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    h_band, max_semibandwidth = ubandh(n, x, semibandwidth, lbandh)

  - n:                 [IN] Int
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

    max_semibandwidth = ubandh!(n, x, semibandwidth, h_band, lbandh)

  - n:                 [IN] Int
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

    h_band, max_semibandwidth = ubandh(x, semibandwidth, lbandh)

  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

    max_semibandwidth = ubandh!(x, semibandwidth, h_band, lbandh)

  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

"""
ubandh

"""# ubandh
The ubandh subroutine extracts the elements which lie within a band of
given semi-bandwidth out of the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    h_band, max_semibandwidth = ubandh(n, x, semibandwidth, lbandh)

  - n:                 [IN] Int
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

    max_semibandwidth = ubandh!(n, x, semibandwidth, h_band, lbandh)

  - n:                 [IN] Int
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

    h_band, max_semibandwidth = ubandh(x, semibandwidth, lbandh)

  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

    max_semibandwidth = ubandh!(x, semibandwidth, h_band, lbandh)

  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

"""
ubandh!

"""# cfn
The cfn subroutine evaluates the value of the objective function and
general constraint functions of the problem decoded from a SIF file by
the script sifdecoder at the point X. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cfn

Usage:

    cfn(io_err, n, m, x, f, c)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - c:       [OUT] Array{Cdouble, 1}


    f, c = cfn(n, m, x)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}

    f = cfn!(n, m, x, c)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}

    f, c = cfn(x)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}

    f = cfn!(x, c)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}

"""
cfn

"""# cfn
The cfn subroutine evaluates the value of the objective function and
general constraint functions of the problem decoded from a SIF file by
the script sifdecoder at the point X. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cfn

Usage:

    cfn(io_err, n, m, x, f, c)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - c:       [OUT] Array{Cdouble, 1}


    f, c = cfn(n, m, x)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}

    f = cfn!(n, m, x, c)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}

    f, c = cfn(x)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}

    f = cfn!(x, c)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}

"""
cfn!

"""# cofg
The cofg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cofg

Usage:

    cofg(io_err, n, x, f, g, grad)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}


    f, g = cofg(n, x, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = cofg!(n, x, g, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f, g = cofg(x, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = cofg!(x, g, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

"""
cofg

"""# cofg
The cofg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cofg

Usage:

    cofg(io_err, n, x, f, g, grad)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}


    f, g = cofg(n, x, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = cofg!(n, x, g, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f, g = cofg(x, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = cofg!(x, g, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

"""
cofg!

"""# cofsg
The cofsg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient in sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    f, nnzg, g_val, g_var = cofsg(n, x, lg, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    f, nnzg = cofsg!(n, x, lg, g_val, g_var, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    f, nnzg, g_val, g_var = cofsg(x, lg, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    f, nnzg = cofsg!(x, lg, g_val, g_var, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

"""
cofsg

"""# cofsg
The cofsg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient in sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separable
and all constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    f, nnzg, g_val, g_var = cofsg(n, x, lg, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    f, nnzg = cofsg!(n, x, lg, g_val, g_var, grad)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    f, nnzg, g_val, g_var = cofsg(x, lg, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    f, nnzg = cofsg!(x, lg, g_val, g_var, grad)

  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

"""
cofsg!

"""# ccfg
The ccfg subroutine evaluates the values of the constraint functions
of the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly their gradients. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    c, cjac = ccfg(n, m, x, jtrans, lcjac1, lcjac2, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool

    ccfg!(n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool

    c, cjac = ccfg(x, jtrans, lcjac1, lcjac2, grad)

  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool

    ccfg!(x, c, jtrans, lcjac1, lcjac2, cjac, grad)

  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool

"""
ccfg

"""# ccfg
The ccfg subroutine evaluates the values of the constraint functions
of the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly their gradients. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    c, cjac = ccfg(n, m, x, jtrans, lcjac1, lcjac2, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool

    ccfg!(n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool

    c, cjac = ccfg(x, jtrans, lcjac1, lcjac2, grad)

  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool

    ccfg!(x, c, jtrans, lcjac1, lcjac2, cjac, grad)

  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool

"""
ccfg!

"""# clfg
The clfg subroutine evaluates the value of the Lagrangian function
l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the
script sifdecoder at the point (X,Y), and possibly its gradient. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    f, g = clfg(n, m, x, y, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = clfg!(n, m, x, y, g, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f, g = clfg(x, y, grad)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = clfg!(x, y, g, grad)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

"""
clfg

"""# clfg
The clfg subroutine evaluates the value of the Lagrangian function
l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the
script sifdecoder at the point (X,Y), and possibly its gradient. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    f, g = clfg(n, m, x, y, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = clfg!(n, m, x, y, g, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f, g = clfg(x, y, grad)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = clfg!(x, y, g, grad)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

"""
clfg!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    g, j_val = cgr(n, m, x, y, grlagf, jtrans, lj1, lj2)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}

    cgr!(n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}

    g, j_val = cgr(x, y, grlagf, jtrans, lj1, lj2)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}

    cgr!(x, y, grlagf, g, jtrans, lj1, lj2, j_val)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}

"""
cgr

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    g, j_val = cgr(n, m, x, y, grlagf, jtrans, lj1, lj2)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}

    cgr!(n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}

    g, j_val = cgr(x, y, grlagf, jtrans, lj1, lj2)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}

    cgr!(x, y, grlagf, g, jtrans, lj1, lj2, j_val)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}

"""
cgr!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzj, j_val, j_var, j_fun = csgr(n, m, x, y, grlagf, lj)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}

    nnzj = csgr!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}

    nnzj, j_val, j_var, j_fun = csgr(x, y, grlagf)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}

    nnzj = csgr!(x, y, grlagf, j_val, j_var, j_fun)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}

"""
csgr

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzj, j_val, j_var, j_fun = csgr(n, m, x, y, grlagf, lj)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}

    nnzj = csgr!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}

    nnzj, j_val, j_var, j_fun = csgr(x, y, grlagf)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}

    nnzj = csgr!(x, y, grlagf, j_val, j_var, j_fun)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}

"""
csgr!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    c, nnzj, j_val, j_var, j_fun = ccfsg(n, m, x, lj, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    nnzj = ccfsg!(n, m, x, c, lj, j_val, j_var, j_fun, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    c, nnzj, j_val, j_var, j_fun = ccfsg(x, grad)

  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    nnzj = ccfsg!(x, c, j_val, j_var, j_fun, grad)

  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

"""
ccfsg

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    c, nnzj, j_val, j_var, j_fun = ccfsg(n, m, x, lj, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    nnzj = ccfsg!(n, m, x, c, lj, j_val, j_var, j_fun, grad)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    c, nnzj, j_val, j_var, j_fun = ccfsg(x, grad)

  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    nnzj = ccfsg!(x, c, j_val, j_var, j_fun, grad)

  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

"""
ccfsg!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    ci, gci = ccifg(n, icon, x, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    ci = ccifg!(n, icon, x, gci, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    ci, gci = ccifg(icon, x, grad)

  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    ci = ccifg!(icon, x, gci, grad)

  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

"""
ccifg

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    ci, gci = ccifg(n, icon, x, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    ci = ccifg!(n, icon, x, gci, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    ci, gci = ccifg(icon, x, grad)

  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    ci = ccifg!(icon, x, gci, grad)

  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

"""
ccifg!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    ci, nnzgci, gci_val, gci_var = ccifsg(n, icon, x, lgci, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    ci, nnzgci = ccifsg!(n, icon, x, lgci, gci_val, gci_var, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    ci, nnzgci, gci_val, gci_var = ccifsg(icon, x, lgci, grad)

  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    ci, nnzgci = ccifsg!(icon, x, lgci, gci_val, gci_var, grad)

  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool

"""
ccifsg

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    ci, nnzgci, gci_val, gci_var = ccifsg(n, icon, x, lgci, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    ci, nnzgci = ccifsg!(n, icon, x, lgci, gci_val, gci_var, grad)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    ci, nnzgci, gci_val, gci_var = ccifsg(icon, x, lgci, grad)

  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    ci, nnzgci = ccifsg!(icon, x, lgci, gci_val, gci_var, grad)

  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool

"""
ccifsg!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    g, j_val, h_val = cgrdh(n, m, x, y, grlagf, jtrans, lj1, lj2, lh1)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cgrdh!(n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    g, j_val, h_val = cgrdh(x, y, grlagf, jtrans, lj1, lj2, lh1)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cgrdh!(x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

"""
cgrdh

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    g, j_val, h_val = cgrdh(n, m, x, y, grlagf, jtrans, lj1, lj2, lh1)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cgrdh!(n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    g, j_val, h_val = cgrdh(x, y, grlagf, jtrans, lj1, lj2, lh1)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cgrdh!(x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

"""
cgrdh!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    h_val = cdh(n, m, x, y, lh1)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cdh!(n, m, x, y, lh1, h_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    h_val = cdh(x, y, lh1)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cdh!(x, y, lh1, h_val)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

"""
cdh

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    h_val = cdh(n, m, x, y, lh1)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cdh!(n, m, x, y, lh1, h_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    h_val = cdh(x, y, lh1)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cdh!(x, y, lh1, h_val)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

"""
cdh!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    h_val = cdhc(n, m, x, y, lh1)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cdhc!(n, m, x, y, lh1, h_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    h_val = cdhc(x, y, lh1)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cdhc!(x, y, lh1, h_val)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

"""
cdhc

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    h_val = cdhc(n, m, x, y, lh1)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cdhc!(n, m, x, y, lh1, h_val)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    h_val = cdhc(x, y, lh1)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cdhc!(x, y, lh1, h_val)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

"""
cdhc!

"""# cshp
The cshp subroutine evaluates the sparsity pattern of the Hessian of
the Lagrangian function l(x,y)=f(x)+yTc(x) for the problem, decoded
from a SIF file by the script sifdecoder, in coordinate format. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cshp

Usage:

    cshp(io_err, n, nnzh, lh, h_row, h_col)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}


    nnzh, h_row, h_col = cshp(n, lh)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cshp!(n, lh, h_row, h_col)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_row, h_col = cshp()

  - nnzh:    [OUT] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cshp!(h_row, h_col)

  - nnzh:    [OUT] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
cshp

"""# cshp
The cshp subroutine evaluates the sparsity pattern of the Hessian of
the Lagrangian function l(x,y)=f(x)+yTc(x) for the problem, decoded
from a SIF file by the script sifdecoder, in coordinate format. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separable and all constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cshp

Usage:

    cshp(io_err, n, nnzh, lh, h_row, h_col)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}


    nnzh, h_row, h_col = cshp(n, lh)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cshp!(n, lh, h_row, h_col)

  - n:       [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_row, h_col = cshp()

  - nnzh:    [OUT] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cshp!(h_row, h_col)

  - nnzh:    [OUT] Int
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
cshp!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzh, h_val, h_row, h_col = csh(n, m, x, y, lh)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = csh!(n, m, x, y, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_val, h_row, h_col = csh(x, y)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = csh!(x, y, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
csh

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzh, h_val, h_row, h_col = csh(n, m, x, y, lh)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = csh!(n, m, x, y, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_val, h_row, h_col = csh(x, y)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = csh!(x, y, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
csh!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzh, h_val, h_row, h_col = cshc(n, m, x, y, lh)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cshc!(n, m, x, y, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_val, h_row, h_col = cshc(x, y)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cshc!(x, y, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
cshc

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzh, h_val, h_row, h_col = cshc(n, m, x, y, lh)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cshc!(n, m, x, y, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_val, h_row, h_col = cshc(x, y)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cshc!(x, y, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
cshc!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    ne, he_row_ptr, he_val_ptr, he_row, he_val = ceh(n, m, x, y, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ceh!(n, m, x, y, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ceh(x, y, lhe_ptr, lhe_row, lhe_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ceh!(x, y, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

"""
ceh

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    ne, he_row_ptr, he_val_ptr, he_row, he_val = ceh(n, m, x, y, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ceh!(n, m, x, y, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ceh(x, y, lhe_ptr, lhe_row, lhe_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    ne = ceh!(x, y, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

"""
ceh!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cidh

Usage:

    cidh(io_err, n, x, iprob, lh1, h)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - iprob:   [IN] Array{Cint, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}


    h = cidh(n, x, iprob, lh1)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    cidh!(n, x, iprob, lh1, h)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    h = cidh(x, iprob, lh1)

  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    cidh!(x, iprob, lh1, h)

  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

"""
cidh

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

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cidh

Usage:

    cidh(io_err, n, x, iprob, lh1, h)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - iprob:   [IN] Array{Cint, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}


    h = cidh(n, x, iprob, lh1)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    cidh!(n, x, iprob, lh1, h)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    h = cidh(x, iprob, lh1)

  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    cidh!(x, iprob, lh1, h)

  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

"""
cidh!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzh, h_val, h_row, h_col = cish(n, x, iprob, lh)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cish!(n, x, iprob, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_val, h_row, h_col = cish(x, iprob)

  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cish!(x, iprob, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
cish

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzh, h_val, h_row, h_col = cish(n, x, iprob, lh)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cish!(n, x, iprob, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh, h_val, h_row, h_col = cish(x, iprob)

  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cish!(x, iprob, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
cish!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzj, j_val, j_var, j_fun, nnzh, h_val, h_row, h_col = csgrsh(n, m, x, y, grlagf, lj, lh)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzj, nnzh = csgrsh!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzj, j_val, j_var, j_fun, nnzh, h_val, h_row, h_col = csgrsh(x, y, grlagf)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzj, nnzh = csgrsh!(x, y, grlagf, j_val, j_var, j_fun, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
csgrsh

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzj, j_val, j_var, j_fun, nnzh, h_val, h_row, h_col = csgrsh(n, m, x, y, grlagf, lj, lh)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzj, nnzh = csgrsh!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, lh, h_val, h_row, h_col)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - lj:      [IN] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzj, j_val, j_var, j_fun, nnzh, h_val, h_row, h_col = csgrsh(x, y, grlagf)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzj, nnzh = csgrsh!(x, y, grlagf, j_val, j_var, j_fun, h_val, h_row, h_col)

  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
csgrsh!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzj, j_val, j_var, j_fun, ne, he_row_ptr, he_val_ptr, he_row, he_val = csgreh(n, m, x, y, grlagf, lj, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - grlagf:     [IN] Bool
  - nnzj:       [OUT] Int
  - lj:         [IN] Int
  - j_val:      [OUT] Array{Float64, 1}
  - j_var:      [OUT] Array{Int, 1}
  - j_fun:      [OUT] Array{Int, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    nnzj, ne = csgreh!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - grlagf:     [IN] Bool
  - nnzj:       [OUT] Int
  - lj:         [IN] Int
  - j_val:      [OUT] Array{Float64, 1}
  - j_var:      [OUT] Array{Int, 1}
  - j_fun:      [OUT] Array{Int, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    nnzj, j_val, j_var, j_fun, ne, he_row_ptr, he_val_ptr, he_row, he_val = csgreh(x, y, grlagf, lhe_ptr, lhe_row, lhe_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - grlagf:     [IN] Bool
  - nnzj:       [OUT] Int
  - j_val:      [OUT] Array{Float64, 1}
  - j_var:      [OUT] Array{Int, 1}
  - j_fun:      [OUT] Array{Int, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    nnzj, ne = csgreh!(x, y, grlagf, j_val, j_var, j_fun, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - grlagf:     [IN] Bool
  - nnzj:       [OUT] Int
  - j_val:      [OUT] Array{Float64, 1}
  - j_var:      [OUT] Array{Int, 1}
  - j_fun:      [OUT] Array{Int, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

"""
csgreh

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnzj, j_val, j_var, j_fun, ne, he_row_ptr, he_val_ptr, he_row, he_val = csgreh(n, m, x, y, grlagf, lj, lhe_ptr, lhe_row, lhe_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - grlagf:     [IN] Bool
  - nnzj:       [OUT] Int
  - lj:         [IN] Int
  - j_val:      [OUT] Array{Float64, 1}
  - j_var:      [OUT] Array{Int, 1}
  - j_fun:      [OUT] Array{Int, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    nnzj, ne = csgreh!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - n:          [IN] Int
  - m:          [IN] Int
  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - grlagf:     [IN] Bool
  - nnzj:       [OUT] Int
  - lj:         [IN] Int
  - j_val:      [OUT] Array{Float64, 1}
  - j_var:      [OUT] Array{Int, 1}
  - j_fun:      [OUT] Array{Int, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    nnzj, j_val, j_var, j_fun, ne, he_row_ptr, he_val_ptr, he_row, he_val = csgreh(x, y, grlagf, lhe_ptr, lhe_row, lhe_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - grlagf:     [IN] Bool
  - nnzj:       [OUT] Int
  - j_val:      [OUT] Array{Float64, 1}
  - j_var:      [OUT] Array{Int, 1}
  - j_fun:      [OUT] Array{Int, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

    nnzj, ne = csgreh!(x, y, grlagf, j_val, j_var, j_fun, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - x:          [IN] Array{Float64, 1}
  - y:          [IN] Array{Float64, 1}
  - grlagf:     [IN] Bool
  - nnzj:       [OUT] Int
  - j_val:      [OUT] Array{Float64, 1}
  - j_var:      [OUT] Array{Int, 1}
  - j_fun:      [OUT] Array{Int, 1}
  - ne:         [OUT] Int
  - lhe_ptr:    [IN] Int
  - he_row_ptr: [OUT] Array{Int, 1}
  - he_val_ptr: [OUT] Array{Int, 1}
  - lhe_row:    [IN] Int
  - he_row:     [OUT] Array{Int, 1}
  - lhe_val:    [IN] Int
  - he_val:     [OUT] Array{Float64, 1}
  - byrows:     [IN] Bool

"""
csgreh!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    result = chprod(n, m, goth, x, y, vector)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chprod!(n, m, goth, x, y, vector, result)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    result = chprod(goth, x, y, vector)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chprod!(goth, x, y, vector, result)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

"""
chprod

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    result = chprod(n, m, goth, x, y, vector)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chprod!(n, m, goth, x, y, vector, result)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    result = chprod(goth, x, y, vector)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chprod!(goth, x, y, vector, result)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

"""
chprod!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnz_result, index_nz_result, result = cshprod(n, m, goth, x, y, nnz_vector, index_nz_vector, vector)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = cshprod!(n, m, goth, x, y, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result, index_nz_result, result = cshprod(goth, x, y, nnz_vector, index_nz_vector, vector)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = cshprod!(goth, x, y, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

"""
cshprod

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnz_result, index_nz_result, result = cshprod(n, m, goth, x, y, nnz_vector, index_nz_vector, vector)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = cshprod!(n, m, goth, x, y, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result, index_nz_result, result = cshprod(goth, x, y, nnz_vector, index_nz_vector, vector)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = cshprod!(goth, x, y, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

"""
cshprod!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    result = chcprod(n, m, goth, x, y, vector)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chcprod!(n, m, goth, x, y, vector, result)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    result = chcprod(goth, x, y, vector)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chcprod!(goth, x, y, vector, result)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

"""
chcprod

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    result = chcprod(n, m, goth, x, y, vector)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chcprod!(n, m, goth, x, y, vector, result)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    result = chcprod(goth, x, y, vector)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chcprod!(goth, x, y, vector, result)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

"""
chcprod!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnz_result, index_nz_result, result = cshcprod(n, m, goth, x, y, nnz_vector, index_nz_vector, vector)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = cshcprod!(n, m, goth, x, y, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result, index_nz_result, result = cshcprod(goth, x, y, nnz_vector, index_nz_vector, vector)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = cshcprod!(goth, x, y, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

"""
cshcprod

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnz_result, index_nz_result, result = cshcprod(n, m, goth, x, y, nnz_vector, index_nz_vector, vector)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = cshcprod!(n, m, goth, x, y, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - n:               [IN] Int
  - m:               [IN] Int
  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result, index_nz_result, result = cshcprod(goth, x, y, nnz_vector, index_nz_vector, vector)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

    nnz_result = cshcprod!(goth, x, y, nnz_vector, index_nz_vector, vector, index_nz_result, result)

  - goth:            [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - y:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}

"""
cshcprod!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    result = cjprod(n, m, gotj, jtrans, x, vector, lvector, lresult)

  - n:       [IN] Int
  - m:       [IN] Int
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

    cjprod!(n, m, gotj, jtrans, x, vector, lvector, result, lresult)

  - n:       [IN] Int
  - m:       [IN] Int
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

    result = cjprod(gotj, jtrans, x, vector, lvector, lresult)

  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

    cjprod!(gotj, jtrans, x, vector, lvector, result, lresult)

  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

"""
cjprod

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    result = cjprod(n, m, gotj, jtrans, x, vector, lvector, lresult)

  - n:       [IN] Int
  - m:       [IN] Int
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

    cjprod!(n, m, gotj, jtrans, x, vector, lvector, result, lresult)

  - n:       [IN] Int
  - m:       [IN] Int
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

    result = cjprod(gotj, jtrans, x, vector, lvector, lresult)

  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

    cjprod!(gotj, jtrans, x, vector, lvector, result, lresult)

  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

"""
cjprod!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnz_result, index_nz_result, result = csjprod(n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, lresult)

  - n:               [IN] Int
  - m:               [IN] Int
  - gotj:            [IN] Bool
  - jtrans:          [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - lvector:         [IN] Int
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}
  - lresult:         [IN] Int

    nnz_result = csjprod!(n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, index_nz_result, result, lresult)

  - n:               [IN] Int
  - m:               [IN] Int
  - gotj:            [IN] Bool
  - jtrans:          [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - lvector:         [IN] Int
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}
  - lresult:         [IN] Int

    nnz_result, index_nz_result, result = csjprod(gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, lresult)

  - gotj:            [IN] Bool
  - jtrans:          [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - lvector:         [IN] Int
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}
  - lresult:         [IN] Int

    nnz_result = csjprod!(gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, index_nz_result, result, lresult)

  - gotj:            [IN] Bool
  - jtrans:          [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - lvector:         [IN] Int
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}
  - lresult:         [IN] Int

"""
csjprod

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    nnz_result, index_nz_result, result = csjprod(n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, lresult)

  - n:               [IN] Int
  - m:               [IN] Int
  - gotj:            [IN] Bool
  - jtrans:          [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - lvector:         [IN] Int
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}
  - lresult:         [IN] Int

    nnz_result = csjprod!(n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, index_nz_result, result, lresult)

  - n:               [IN] Int
  - m:               [IN] Int
  - gotj:            [IN] Bool
  - jtrans:          [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - lvector:         [IN] Int
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}
  - lresult:         [IN] Int

    nnz_result, index_nz_result, result = csjprod(gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, lresult)

  - gotj:            [IN] Bool
  - jtrans:          [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - lvector:         [IN] Int
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}
  - lresult:         [IN] Int

    nnz_result = csjprod!(gotj, jtrans, x, nnz_vector, index_nz_vector, vector, lvector, index_nz_result, result, lresult)

  - gotj:            [IN] Bool
  - jtrans:          [IN] Bool
  - x:               [IN] Array{Float64, 1}
  - nnz_vector:      [IN] Int
  - index_nz_vector: [IN] Array{Int, 1}
  - vector:          [IN] Array{Float64, 1}
  - lvector:         [IN] Int
  - nnz_result:      [OUT] Int
  - index_nz_result: [OUT] Array{Int, 1}
  - result:          [OUT] Array{Float64, 1}
  - lresult:         [IN] Int

"""
csjprod!

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    chp_val = cchprods(n, m, goth, x, vector, lchp, chp_ind, chp_ptr)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lchp:    [IN] Int
  - chp_val: [OUT] Array{Float64, 1}
  - chp_ind: [IN] Array{Int, 1}
  - chp_ptr: [IN] Array{Int, 1}

    cchprods!(n, m, goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lchp:    [IN] Int
  - chp_val: [OUT] Array{Float64, 1}
  - chp_ind: [IN] Array{Int, 1}
  - chp_ptr: [IN] Array{Int, 1}

    chp_val = cchprods(goth, x, vector, lchp, chp_ind, chp_ptr)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lchp:    [IN] Int
  - chp_val: [OUT] Array{Float64, 1}
  - chp_ind: [IN] Array{Int, 1}
  - chp_ptr: [IN] Array{Int, 1}

    cchprods!(goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lchp:    [IN] Int
  - chp_val: [OUT] Array{Float64, 1}
  - chp_ind: [IN] Array{Int, 1}
  - chp_ptr: [IN] Array{Int, 1}

"""
cchprods

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

This help was generated automatically and may contain
errors. For more information, run the shell command

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


    chp_val = cchprods(n, m, goth, x, vector, lchp, chp_ind, chp_ptr)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lchp:    [IN] Int
  - chp_val: [OUT] Array{Float64, 1}
  - chp_ind: [IN] Array{Int, 1}
  - chp_ptr: [IN] Array{Int, 1}

    cchprods!(n, m, goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lchp:    [IN] Int
  - chp_val: [OUT] Array{Float64, 1}
  - chp_ind: [IN] Array{Int, 1}
  - chp_ptr: [IN] Array{Int, 1}

    chp_val = cchprods(goth, x, vector, lchp, chp_ind, chp_ptr)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lchp:    [IN] Int
  - chp_val: [OUT] Array{Float64, 1}
  - chp_ind: [IN] Array{Int, 1}
  - chp_ptr: [IN] Array{Int, 1}

    cchprods!(goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)

  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lchp:    [IN] Int
  - chp_val: [OUT] Array{Float64, 1}
  - chp_ind: [IN] Array{Int, 1}
  - chp_ptr: [IN] Array{Int, 1}

"""
cchprods!

"""# uterminate
The uterminate subroutine deallocates all workspace arrays created
since the last call to usetup.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uterminate

Usage:

    uterminate(io_err)

  - io_err:  [OUT] Array{Cint, 1}


    uterminate()


"""
uterminate

"""# cterminate
The uterminate subroutine deallocates all workspace arrays created
since the last call to csetup.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cterminate

Usage:

    cterminate(io_err)

  - io_err:  [OUT] Array{Cint, 1}


    cterminate()


"""
cterminate

