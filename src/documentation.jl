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

    usetup(io_err, input, out, io_buffer, n, x, x_l, x_u, cutest_lib)

  - io_err:    [OUT] Array{Cint, 1}
  - input:     [IN] Array{Cint, 1}
  - out:       [IN] Array{Cint, 1}
  - io_buffer: [IN] Array{Cint, 1}
  - n:         [IN] Array{Cint, 1}
  - x:         [OUT] Array{Cdouble, 1}
  - x_l:       [OUT] Array{Cdouble, 1}
  - x_u:       [OUT] Array{Cdouble, 1}
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    x, x_l, x_u = usetup(input, out, io_buffer, n, cutest_lib)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    usetup!(input, out, io_buffer, n, x, x_l, x_u, cutest_lib)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    usetup(io_err, input, out, io_buffer, n, x, x_l, x_u, cutest_lib)

  - io_err:    [OUT] Array{Cint, 1}
  - input:     [IN] Array{Cint, 1}
  - out:       [IN] Array{Cint, 1}
  - io_buffer: [IN] Array{Cint, 1}
  - n:         [IN] Array{Cint, 1}
  - x:         [OUT] Array{Cdouble, 1}
  - x_l:       [OUT] Array{Cdouble, 1}
  - x_u:       [OUT] Array{Cdouble, 1}
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    x, x_l, x_u = usetup(input, out, io_buffer, n, cutest_lib)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    usetup!(input, out, io_buffer, n, x, x_l, x_u, cutest_lib)

  - input:     [IN] Int
  - out:       [IN] Int
  - io_buffer: [IN] Int
  - n:         [IN] Int
  - x:         [OUT] Array{Float64, 1}
  - x_l:       [OUT] Array{Float64, 1}
  - x_u:       [OUT] Array{Float64, 1}
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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
linear, e_order, l_order, v_order, cutest_lib)

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
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    x, x_l, x_u, y, c_l, c_u, equatn, linear = csetup(input, out, io_buffer, n, m, e_order, l_order, v_order, cutest_lib)

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
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    csetup!(input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn, linear, e_order, l_order, v_order, cutest_lib)

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
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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
linear, e_order, l_order, v_order, cutest_lib)

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
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    x, x_l, x_u, y, c_l, c_u, equatn, linear = csetup(input, out, io_buffer, n, m, e_order, l_order, v_order, cutest_lib)

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
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    csetup!(input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn, linear, e_order, l_order, v_order, cutest_lib)

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
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    udimen(io_err, input, n, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - n:       [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    n = udimen(input, cutest_lib)

  - input:   [IN] Int
  - n:       [OUT] Int
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    udimsh(io_err, nnzh, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = udimsh(, cutest_lib)

  - nnzh:    [OUT] Int
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    udimse(io_err, ne, he_val_ne, he_row_ne, cutest_lib)

  - io_err:    [OUT] Array{Cint, 1}
  - ne:        [OUT] Array{Cint, 1}
  - he_val_ne: [OUT] Array{Cint, 1}
  - he_row_ne: [OUT] Array{Cint, 1}
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne, he_val_ne, he_row_ne = udimse(, cutest_lib)

  - ne:        [OUT] Int
  - he_val_ne: [OUT] Int
  - he_row_ne: [OUT] Int
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    uvartype(io_err, n, x_type, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    x_type = uvartype(n, cutest_lib)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    uvartype!(n, x_type, cutest_lib)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    uvartype(io_err, n, x_type, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    x_type = uvartype(n, cutest_lib)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    uvartype!(n, x_type, cutest_lib)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    unames(io_err, n, pname, vname, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname, vname = unames(n, cutest_lib)

  - n:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname = unames!(n, vname, cutest_lib)

  - n:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    unames(io_err, n, pname, vname, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname, vname = unames(n, cutest_lib)

  - n:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname = unames!(n, vname, cutest_lib)

  - n:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    ureport(io_err, calls, time, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    calls, time = ureport(, cutest_lib)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ureport!(calls, time, cutest_lib)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    calls, time = ureport(nlp)

  - nlp:     [IN] CUTEstModel
  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    ureport!(nlp, calls, time)

  - nlp:     [IN] CUTEstModel
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

    ureport(io_err, calls, time, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    calls, time = ureport(, cutest_lib)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ureport!(calls, time, cutest_lib)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    calls, time = ureport(nlp)

  - nlp:     [IN] CUTEstModel
  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    ureport!(nlp, calls, time)

  - nlp:     [IN] CUTEstModel
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

    cdimen(io_err, input, n, m, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - n:       [OUT] Array{Cint, 1}
  - m:       [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    n, m = cdimen(input, cutest_lib)

  - input:   [IN] Int
  - n:       [OUT] Int
  - m:       [OUT] Int
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    cdimsj(io_err, nnzj, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - nnzj:    [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj = cdimsj(, cutest_lib)

  - nnzj:    [OUT] Int
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    cdimsh(io_err, nnzh, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = cdimsh(, cutest_lib)

  - nnzh:    [OUT] Int
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

"""
cdimsh

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

    cdimse(io_err, ne, he_val_ne, he_row_ne, cutest_lib)

  - io_err:    [OUT] Array{Cint, 1}
  - ne:        [OUT] Array{Cint, 1}
  - he_val_ne: [OUT] Array{Cint, 1}
  - he_row_ne: [OUT] Array{Cint, 1}
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne, he_val_ne, he_row_ne = cdimse(, cutest_lib)

  - ne:        [OUT] Int
  - he_val_ne: [OUT] Int
  - he_row_ne: [OUT] Int
  - cutest_lib:   [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

"""
cdimse

"""# cstats
    cstats(io_err, nonlinear_variables_objective,
nonlinear_variables_constraints, equality_constraints,
linear_constraints, cutest_lib)

  - io_err:                          [OUT] Array{Cint, 1}
  - nonlinear_variables_objective:   [OUT] Array{Cint, 1}
  - nonlinear_variables_constraints: [OUT] Array{Cint, 1}
  - equality_constraints:            [OUT] Array{Cint, 1}
  - linear_constraints:              [OUT] Array{Cint, 1}
  - cutest_lib:                         [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    cvartype(io_err, n, x_type, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    x_type = cvartype(n, cutest_lib)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cvartype!(n, x_type, cutest_lib)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    cvartype(io_err, n, x_type, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    x_type = cvartype(n, cutest_lib)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cvartype!(n, x_type, cutest_lib)

  - n:       [IN] Int
  - x_type:  [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    cnames(io_err, n, m, pname, vname, cname, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - cname:   [OUT] Array{Cchar, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname, vname, cname = cnames(n, m, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname = cnames!(n, m, vname, cname, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname, vname, cname = cnames(nlp)

  - nlp:     [IN] CUTEstModel
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}

    pname = cnames!(nlp, vname, cname)

  - nlp:     [IN] CUTEstModel
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

    cnames(io_err, n, m, pname, vname, cname, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - cname:   [OUT] Array{Cchar, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname, vname, cname = cnames(n, m, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname = cnames!(n, m, vname, cname, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname, vname, cname = cnames(nlp)

  - nlp:     [IN] CUTEstModel
  - pname:   [OUT] UInt8
  - vname:   [OUT] Array{UInt8, 1}
  - cname:   [OUT] Array{UInt8, 1}

    pname = cnames!(nlp, vname, cname)

  - nlp:     [IN] CUTEstModel
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

    creport(io_err, calls, time, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    calls, time = creport(, cutest_lib)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    creport!(calls, time, cutest_lib)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    calls, time = creport(nlp)

  - nlp:     [IN] CUTEstModel
  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    creport!(nlp, calls, time)

  - nlp:     [IN] CUTEstModel
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

    creport(io_err, calls, time, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    calls, time = creport(, cutest_lib)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    creport!(calls, time, cutest_lib)

  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    calls, time = creport(nlp)

  - nlp:     [IN] CUTEstModel
  - calls:   [OUT] Array{Float64, 1}
  - time:    [OUT] Array{Float64, 1}

    creport!(nlp, calls, time)

  - nlp:     [IN] CUTEstModel
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

    connames(io_err, m, cname, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - cname:   [OUT] Array{Cchar, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cname = connames(m, cutest_lib)

  - m:       [IN] Int
  - cname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    connames!(m, cname, cutest_lib)

  - m:       [IN] Int
  - cname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cname = connames(nlp)

  - nlp:     [IN] CUTEstModel
  - cname:   [OUT] Array{UInt8, 1}

    connames!(nlp, cname)

  - nlp:     [IN] CUTEstModel
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

    connames(io_err, m, cname, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - cname:   [OUT] Array{Cchar, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cname = connames(m, cutest_lib)

  - m:       [IN] Int
  - cname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    connames!(m, cname, cutest_lib)

  - m:       [IN] Int
  - cname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cname = connames(nlp)

  - nlp:     [IN] CUTEstModel
  - cname:   [OUT] Array{UInt8, 1}

    connames!(nlp, cname)

  - nlp:     [IN] CUTEstModel
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

    pname(io_err, input, pname, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname = pname(input, cutest_lib)

  - input:   [IN] Int
  - pname:   [OUT] UInt8
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname = pname(nlp, input)

  - nlp:     [IN] CUTEstModel
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

    probname(io_err, pname, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname = probname(, cutest_lib)

  - pname:   [OUT] UInt8
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    pname = probname(nlp)

  - nlp:     [IN] CUTEstModel
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

    varnames(io_err, n, vname, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    vname = varnames(n, cutest_lib)

  - n:       [IN] Int
  - vname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    varnames!(n, vname, cutest_lib)

  - n:       [IN] Int
  - vname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    varnames(io_err, n, vname, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    vname = varnames(n, cutest_lib)

  - n:       [IN] Int
  - vname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    varnames!(n, vname, cutest_lib)

  - n:       [IN] Int
  - vname:   [OUT] Array{UInt8, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

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

    ufn(io_err, n, x, f, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f = ufn(n, x, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f = ufn(nlp, x)

  - nlp:     [IN] CUTEstModel
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

    ugr(io_err, n, x, g, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g = ugr(n, x, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ugr!(n, x, g, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g = ugr(nlp, x)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}

    ugr!(nlp, x, g)

  - nlp:     [IN] CUTEstModel
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

    ugr(io_err, n, x, g, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g = ugr(n, x, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ugr!(n, x, g, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g = ugr(nlp, x)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}

    ugr!(nlp, x, g)

  - nlp:     [IN] CUTEstModel
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

    uofg(io_err, n, x, f, g, grad, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = uofg(n, x, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f = uofg!(n, x, g, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = uofg(nlp, x, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = uofg!(nlp, x, g, grad)

  - nlp:     [IN] CUTEstModel
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

    uofg(io_err, n, x, f, g, grad, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = uofg(n, x, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f = uofg!(n, x, g, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = uofg(nlp, x, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = uofg!(nlp, x, g, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

"""
uofg!

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

    ubandh(io_err, n, x, semibandwidth, h_band, lbandh, max_semibandwidth, cutest_lib)

  - io_err:            [OUT] Array{Cint, 1}
  - n:                 [IN] Array{Cint, 1}
  - x:                 [IN] Array{Cdouble, 1}
  - semibandwidth:     [IN] Array{Cint, 1}
  - h_band:            [OUT] Array{Cdouble, 2}
  - lbandh:            [IN] Array{Cint, 1}
  - max_semibandwidth: [OUT] Array{Cint, 1}
  - cutest_lib:           [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h_band, max_semibandwidth = ubandh(n, x, semibandwidth, lbandh, cutest_lib)

  - n:                 [IN] Int
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int
  - cutest_lib:           [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    max_semibandwidth = ubandh!(n, x, semibandwidth, h_band, lbandh, cutest_lib)

  - n:                 [IN] Int
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int
  - cutest_lib:           [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h_band, max_semibandwidth = ubandh(nlp, x, semibandwidth, lbandh)

  - nlp:               [IN] CUTEstModel
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

    max_semibandwidth = ubandh!(nlp, x, semibandwidth, h_band, lbandh)

  - nlp:               [IN] CUTEstModel
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

    ubandh(io_err, n, x, semibandwidth, h_band, lbandh, max_semibandwidth, cutest_lib)

  - io_err:            [OUT] Array{Cint, 1}
  - n:                 [IN] Array{Cint, 1}
  - x:                 [IN] Array{Cdouble, 1}
  - semibandwidth:     [IN] Array{Cint, 1}
  - h_band:            [OUT] Array{Cdouble, 2}
  - lbandh:            [IN] Array{Cint, 1}
  - max_semibandwidth: [OUT] Array{Cint, 1}
  - cutest_lib:           [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h_band, max_semibandwidth = ubandh(n, x, semibandwidth, lbandh, cutest_lib)

  - n:                 [IN] Int
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int
  - cutest_lib:           [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    max_semibandwidth = ubandh!(n, x, semibandwidth, h_band, lbandh, cutest_lib)

  - n:                 [IN] Int
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int
  - cutest_lib:           [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h_band, max_semibandwidth = ubandh(nlp, x, semibandwidth, lbandh)

  - nlp:               [IN] CUTEstModel
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

    max_semibandwidth = ubandh!(nlp, x, semibandwidth, h_band, lbandh)

  - nlp:               [IN] CUTEstModel
  - x:                 [IN] Array{Float64, 1}
  - semibandwidth:     [IN] Int
  - h_band:            [OUT] Array{Float64, 2}
  - lbandh:            [IN] Int
  - max_semibandwidth: [OUT] Int

"""
ubandh!

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

    udh(io_err, n, x, lh1, h, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h = udh(n, x, lh1, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    udh!(n, x, lh1, h, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h = udh(nlp, x, lh1)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    udh!(nlp, x, lh1, h)

  - nlp:     [IN] CUTEstModel
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

    udh(io_err, n, x, lh1, h, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h = udh(n, x, lh1, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    udh!(n, x, lh1, h, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h = udh(nlp, x, lh1)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    udh!(nlp, x, lh1, h)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

"""
udh!

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

    ush(io_err, n, x, nnzh, lh, h_val, h_row, h_col, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = ush(n, x, lh, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = ush!(n, x, lh, h_val, h_row, h_col, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = ush(nlp, x)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ush!(nlp, x, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
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

    ush(io_err, n, x, nnzh, lh, h_val, h_row, h_col, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = ush(n, x, lh, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = ush!(n, x, lh, h_val, h_row, h_col, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = ush(nlp, x)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ush!(nlp, x, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
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
lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ueh(n, x, lhe_ptr, lhe_row, lhe_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne = ueh!(n, x, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ueh(nlp, x, lhe_ptr, lhe_row, lhe_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    ne = ueh!(nlp, x, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - nlp:        [IN] CUTEstModel
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
lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ueh(n, x, lhe_ptr, lhe_row, lhe_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne = ueh!(n, x, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ueh(nlp, x, lhe_ptr, lhe_row, lhe_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    ne = ueh!(nlp, x, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    ugrdh(io_err, n, x, g, lh1, h, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, h = ugrdh(n, x, lh1, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ugrdh!(n, x, g, lh1, h, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, h = ugrdh(nlp, x, lh1)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    ugrdh!(nlp, x, g, lh1, h)

  - nlp:     [IN] CUTEstModel
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

    ugrdh(io_err, n, x, g, lh1, h, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, h = ugrdh(n, x, lh1, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ugrdh!(n, x, g, lh1, h, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, h = ugrdh(nlp, x, lh1)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    ugrdh!(nlp, x, g, lh1, h)

  - nlp:     [IN] CUTEstModel
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

    ugrsh(io_err, n, x, g, nnzh, lh, h_val, h_row, h_col, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, nnzh, h_val, h_row, h_col = ugrsh(n, x, lh, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = ugrsh!(n, x, g, lh, h_val, h_row, h_col, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, nnzh, h_val, h_row, h_col = ugrsh(nlp, x)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ugrsh!(nlp, x, g, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
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

    ugrsh(io_err, n, x, g, nnzh, lh, h_val, h_row, h_col, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, nnzh, h_val, h_row, h_col = ugrsh(n, x, lh, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = ugrsh!(n, x, g, lh, h_val, h_row, h_col, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, nnzh, h_val, h_row, h_col = ugrsh(nlp, x)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - g:       [OUT] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = ugrsh!(nlp, x, g, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
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
lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, ne, he_row_ptr, he_val_ptr, he_row, he_val = ugreh(n, x, lhe_ptr, lhe_row, lhe_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne = ugreh!(n, x, g, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, ne, he_row_ptr, he_val_ptr, he_row, he_val = ugreh(nlp, x, lhe_ptr, lhe_row, lhe_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    ne = ugreh!(nlp, x, g, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - nlp:        [IN] CUTEstModel
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
lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, ne, he_row_ptr, he_val_ptr, he_row, he_val = ugreh(n, x, lhe_ptr, lhe_row, lhe_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne = ugreh!(n, x, g, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, ne, he_row_ptr, he_val_ptr, he_row, he_val = ugreh(nlp, x, lhe_ptr, lhe_row, lhe_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    ne = ugreh!(nlp, x, g, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    uhprod(io_err, n, goth, x, vector, result, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = uhprod(n, goth, x, vector, cutest_lib)

  - n:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    uhprod!(n, goth, x, vector, result, cutest_lib)

  - n:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = uhprod(nlp, goth, x, vector)

  - nlp:     [IN] CUTEstModel
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    uhprod!(nlp, goth, x, vector, result)

  - nlp:     [IN] CUTEstModel
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

    uhprod(io_err, n, goth, x, vector, result, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = uhprod(n, goth, x, vector, cutest_lib)

  - n:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    uhprod!(n, goth, x, vector, result, cutest_lib)

  - n:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = uhprod(nlp, goth, x, vector)

  - nlp:     [IN] CUTEstModel
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    uhprod!(nlp, goth, x, vector, result)

  - nlp:     [IN] CUTEstModel
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

"""
uhprod!

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

    cfn(io_err, n, m, x, f, c, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - c:       [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, c = cfn(n, m, x, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f = cfn!(n, m, x, c, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, c = cfn(nlp, x)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}

    f = cfn!(nlp, x, c)

  - nlp:     [IN] CUTEstModel
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

    cfn(io_err, n, m, x, f, c, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - c:       [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, c = cfn(n, m, x, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f = cfn!(n, m, x, c, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, c = cfn(nlp, x)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - c:       [OUT] Array{Float64, 1}

    f = cfn!(nlp, x, c)

  - nlp:     [IN] CUTEstModel
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

    cofg(io_err, n, x, f, g, grad, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = cofg(n, x, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f = cofg!(n, x, g, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = cofg(nlp, x, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = cofg!(nlp, x, g, grad)

  - nlp:     [IN] CUTEstModel
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

    cofg(io_err, n, x, f, g, grad, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = cofg(n, x, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f = cofg!(n, x, g, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = cofg(nlp, x, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = cofg!(nlp, x, g, grad)

  - nlp:     [IN] CUTEstModel
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

    cofsg(io_err, n, x, f, nnzg, lg, g_val, g_var, grad, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - nnzg:    [OUT] Array{Cint, 1}
  - lg:      [IN] Array{Cint, 1}
  - g_val:   [OUT] Array{Cdouble, 1}
  - g_var:   [OUT] Array{Cint, 1}
  - grad:    [IN] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, nnzg, g_val, g_var = cofsg(n, x, lg, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, nnzg = cofsg!(n, x, lg, g_val, g_var, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, nnzg, g_val, g_var = cofsg(nlp, x, lg, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    f, nnzg = cofsg!(nlp, x, lg, g_val, g_var, grad)

  - nlp:     [IN] CUTEstModel
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

    cofsg(io_err, n, x, f, nnzg, lg, g_val, g_var, grad, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - nnzg:    [OUT] Array{Cint, 1}
  - lg:      [IN] Array{Cint, 1}
  - g_val:   [OUT] Array{Cdouble, 1}
  - g_var:   [OUT] Array{Cint, 1}
  - grad:    [IN] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, nnzg, g_val, g_var = cofsg(n, x, lg, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, nnzg = cofsg!(n, x, lg, g_val, g_var, grad, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, nnzg, g_val, g_var = cofsg(nlp, x, lg, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - nnzg:    [OUT] Int
  - lg:      [IN] Int
  - g_val:   [OUT] Array{Float64, 1}
  - g_var:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    f, nnzg = cofsg!(nlp, x, lg, g_val, g_var, grad)

  - nlp:     [IN] CUTEstModel
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

    ccfg(io_err, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    c, cjac = ccfg(n, m, x, jtrans, lcjac1, lcjac2, grad, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ccfg!(n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    c, cjac = ccfg(nlp, x, jtrans, lcjac1, lcjac2, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool

    ccfg!(nlp, x, c, jtrans, lcjac1, lcjac2, cjac, grad)

  - nlp:     [IN] CUTEstModel
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

    ccfg(io_err, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    c, cjac = ccfg(n, m, x, jtrans, lcjac1, lcjac2, grad, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ccfg!(n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    c, cjac = ccfg(nlp, x, jtrans, lcjac1, lcjac2, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lcjac1:  [IN] Int
  - lcjac2:  [IN] Int
  - cjac:    [OUT] Array{Float64, 2}
  - grad:    [IN] Bool

    ccfg!(nlp, x, c, jtrans, lcjac1, lcjac2, cjac, grad)

  - nlp:     [IN] CUTEstModel
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

    clfg(io_err, n, m, x, y, f, g, grad, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = clfg(n, m, x, y, grad, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f = clfg!(n, m, x, y, g, grad, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = clfg(nlp, x, y, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = clfg!(nlp, x, y, g, grad)

  - nlp:     [IN] CUTEstModel
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

    clfg(io_err, n, m, x, y, f, g, grad, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = clfg(n, m, x, y, grad, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f = clfg!(n, m, x, y, g, grad, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    f, g = clfg(nlp, x, y, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - f:       [OUT] Float64
  - g:       [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    f = clfg!(nlp, x, y, g, grad)

  - nlp:     [IN] CUTEstModel
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

    cgr(io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, j_val = cgr(n, m, x, y, grlagf, jtrans, lj1, lj2, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cgr!(n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, j_val = cgr(nlp, x, y, grlagf, jtrans, lj1, lj2)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}

    cgr!(nlp, x, y, grlagf, g, jtrans, lj1, lj2, j_val)

  - nlp:     [IN] CUTEstModel
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

    cgr(io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, j_val = cgr(n, m, x, y, grlagf, jtrans, lj1, lj2, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cgr!(n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, j_val = cgr(nlp, x, y, grlagf, jtrans, lj1, lj2)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - g:       [OUT] Array{Float64, 1}
  - jtrans:  [IN] Bool
  - lj1:     [IN] Int
  - lj2:     [IN] Int
  - j_val:   [OUT] Array{Float64, 2}

    cgr!(nlp, x, y, grlagf, g, jtrans, lj1, lj2, j_val)

  - nlp:     [IN] CUTEstModel
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

    csgr(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun = csgr(n, m, x, y, grlagf, lj, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj = csgr!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun = csgr(nlp, x, y, grlagf)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}

    nnzj = csgr!(nlp, x, y, grlagf, j_val, j_var, j_fun)

  - nlp:     [IN] CUTEstModel
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

    csgr(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun = csgr(n, m, x, y, grlagf, lj, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj = csgr!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun = csgr(nlp, x, y, grlagf)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - grlagf:  [IN] Bool
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}

    nnzj = csgr!(nlp, x, y, grlagf, j_val, j_var, j_fun)

  - nlp:     [IN] CUTEstModel
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

    ccfsg(io_err, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    c, nnzj, j_val, j_var, j_fun = ccfsg(n, m, x, lj, grad, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj = ccfsg!(n, m, x, c, lj, j_val, j_var, j_fun, grad, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    c, nnzj, j_val, j_var, j_fun = ccfsg(nlp, x, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    nnzj = ccfsg!(nlp, x, c, j_val, j_var, j_fun, grad)

  - nlp:     [IN] CUTEstModel
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

    ccfsg(io_err, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    c, nnzj, j_val, j_var, j_fun = ccfsg(n, m, x, lj, grad, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj = ccfsg!(n, m, x, c, lj, j_val, j_var, j_fun, grad, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    c, nnzj, j_val, j_var, j_fun = ccfsg(nlp, x, grad)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - c:       [OUT] Array{Float64, 1}
  - nnzj:    [OUT] Int
  - j_val:   [OUT] Array{Float64, 1}
  - j_var:   [OUT] Array{Int, 1}
  - j_fun:   [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    nnzj = ccfsg!(nlp, x, c, j_val, j_var, j_fun, grad)

  - nlp:     [IN] CUTEstModel
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

    ccifg(io_err, n, icon, x, ci, gci, grad, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - icon:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - ci:      [OUT] Array{Cdouble, 1}
  - gci:     [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci, gci = ccifg(n, icon, x, grad, cutest_lib)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci = ccifg!(n, icon, x, gci, grad, cutest_lib)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci, gci = ccifg(nlp, icon, x, grad)

  - nlp:     [IN] CUTEstModel
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    ci = ccifg!(nlp, icon, x, gci, grad)

  - nlp:     [IN] CUTEstModel
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

    ccifg(io_err, n, icon, x, ci, gci, grad, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - icon:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - ci:      [OUT] Array{Cdouble, 1}
  - gci:     [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci, gci = ccifg(n, icon, x, grad, cutest_lib)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci = ccifg!(n, icon, x, gci, grad, cutest_lib)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci, gci = ccifg(nlp, icon, x, grad)

  - nlp:     [IN] CUTEstModel
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - gci:     [OUT] Array{Float64, 1}
  - grad:    [IN] Bool

    ci = ccifg!(nlp, icon, x, gci, grad)

  - nlp:     [IN] CUTEstModel
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

    ccifsg(io_err, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci, nnzgci, gci_val, gci_var = ccifsg(n, icon, x, lgci, grad, cutest_lib)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci, nnzgci = ccifsg!(n, icon, x, lgci, gci_val, gci_var, grad, cutest_lib)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci, nnzgci, gci_val, gci_var = ccifsg(nlp, icon, x, lgci, grad)

  - nlp:     [IN] CUTEstModel
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    ci, nnzgci = ccifsg!(nlp, icon, x, lgci, gci_val, gci_var, grad)

  - nlp:     [IN] CUTEstModel
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

    ccifsg(io_err, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci, nnzgci, gci_val, gci_var = ccifsg(n, icon, x, lgci, grad, cutest_lib)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci, nnzgci = ccifsg!(n, icon, x, lgci, gci_val, gci_var, grad, cutest_lib)

  - n:       [IN] Int
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ci, nnzgci, gci_val, gci_var = ccifsg(nlp, icon, x, lgci, grad)

  - nlp:     [IN] CUTEstModel
  - icon:    [IN] Int
  - x:       [IN] Array{Float64, 1}
  - ci:      [OUT] Float64
  - nnzgci:  [OUT] Int
  - lgci:    [IN] Int
  - gci_val: [OUT] Array{Float64, 1}
  - gci_var: [OUT] Array{Int, 1}
  - grad:    [IN] Bool

    ci, nnzgci = ccifsg!(nlp, icon, x, lgci, gci_val, gci_var, grad)

  - nlp:     [IN] CUTEstModel
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

    cgrdh(io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, j_val, h_val = cgrdh(n, m, x, y, grlagf, jtrans, lj1, lj2, lh1, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cgrdh!(n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, j_val, h_val = cgrdh(nlp, x, y, grlagf, jtrans, lj1, lj2, lh1)

  - nlp:     [IN] CUTEstModel
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

    cgrdh!(nlp, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)

  - nlp:     [IN] CUTEstModel
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

    cgrdh(io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, j_val, h_val = cgrdh(n, m, x, y, grlagf, jtrans, lj1, lj2, lh1, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cgrdh!(n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    g, j_val, h_val = cgrdh(nlp, x, y, grlagf, jtrans, lj1, lj2, lh1)

  - nlp:     [IN] CUTEstModel
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

    cgrdh!(nlp, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)

  - nlp:     [IN] CUTEstModel
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

    cdh(io_err, n, m, x, y, lh1, h_val, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h_val = cdh(n, m, x, y, lh1, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cdh!(n, m, x, y, lh1, h_val, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h_val = cdh(nlp, x, y, lh1)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cdh!(nlp, x, y, lh1, h_val)

  - nlp:     [IN] CUTEstModel
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

    cdh(io_err, n, m, x, y, lh1, h_val, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h_val = cdh(n, m, x, y, lh1, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cdh!(n, m, x, y, lh1, h_val, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h_val = cdh(nlp, x, y, lh1)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

    cdh!(nlp, x, y, lh1, h_val)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - lh1:     [IN] Int
  - h_val:   [OUT] Array{Float64, 2}

"""
cdh!

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

    csh(io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = csh(n, m, x, y, lh, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = csh!(n, m, x, y, lh, h_val, h_row, h_col, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = csh(nlp, x, y)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = csh!(nlp, x, y, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
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

    csh(io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = csh(n, m, x, y, lh, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = csh!(n, m, x, y, lh, h_val, h_row, h_col, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = csh(nlp, x, y)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = csh!(nlp, x, y, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
csh!

"""# cshc
The cshc subroutine evaluates the constraint part of the Hessian of
the Lagrangian function yTc(x) for the problem decoded from a SIF file
by the script sifdecoder at the point (x,y)= (X,Y). The matrix is
stored in sparse format. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cshc

Usage:

    cshc(io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = cshc(n, m, x, y, lh, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = cshc!(n, m, x, y, lh, h_val, h_row, h_col, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = cshc(nlp, x, y)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cshc!(nlp, x, y, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

"""
cshc

"""# cshc
The cshc subroutine evaluates the constraint part of the Hessian of
the Lagrangian function yTc(x) for the problem decoded from a SIF file
by the script sifdecoder at the point (x,y)= (X,Y). The matrix is
stored in sparse format. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint functions are partially separable.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cshc

Usage:

    cshc(io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = cshc(n, m, x, y, lh, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = cshc!(n, m, x, y, lh, h_val, h_row, h_col, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = cshc(nlp, x, y)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cshc!(nlp, x, y, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
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
he_row, lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ceh(n, m, x, y, lhe_ptr, lhe_row, lhe_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne = ceh!(n, m, x, y, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ceh(nlp, x, y, lhe_ptr, lhe_row, lhe_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    ne = ceh!(nlp, x, y, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - nlp:        [IN] CUTEstModel
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
he_row, lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ceh(n, m, x, y, lhe_ptr, lhe_row, lhe_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne = ceh!(n, m, x, y, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    ne, he_row_ptr, he_val_ptr, he_row, he_val = ceh(nlp, x, y, lhe_ptr, lhe_row, lhe_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    ne = ceh!(nlp, x, y, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    cidh(io_err, n, x, iprob, lh1, h, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - iprob:   [IN] Array{Cint, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h = cidh(n, x, iprob, lh1, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cidh!(n, x, iprob, lh1, h, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h = cidh(nlp, x, iprob, lh1)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    cidh!(nlp, x, iprob, lh1, h)

  - nlp:     [IN] CUTEstModel
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

    cidh(io_err, n, x, iprob, lh1, h, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - iprob:   [IN] Array{Cint, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h = cidh(n, x, iprob, lh1, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cidh!(n, x, iprob, lh1, h, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    h = cidh(nlp, x, iprob, lh1)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - lh1:     [IN] Int
  - h:       [OUT] Array{Float64, 2}

    cidh!(nlp, x, iprob, lh1, h)

  - nlp:     [IN] CUTEstModel
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

    cish(io_err, n, x, iprob, nnzh, lh, h_val, h_row, h_col, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - iprob:   [IN] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = cish(n, x, iprob, lh, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = cish!(n, x, iprob, lh, h_val, h_row, h_col, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = cish(nlp, x, iprob)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cish!(nlp, x, iprob, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
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

    cish(io_err, n, x, iprob, nnzh, lh, h_val, h_row, h_col, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - iprob:   [IN] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = cish(n, x, iprob, lh, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh = cish!(n, x, iprob, lh, h_val, h_row, h_col, cutest_lib)

  - n:       [IN] Int
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - lh:      [IN] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzh, h_val, h_row, h_col = cish(nlp, x, iprob)

  - nlp:     [IN] CUTEstModel
  - x:       [IN] Array{Float64, 1}
  - iprob:   [IN] Int
  - nnzh:    [OUT] Int
  - h_val:   [OUT] Array{Float64, 1}
  - h_row:   [OUT] Array{Int, 1}
  - h_col:   [OUT] Array{Int, 1}

    nnzh = cish!(nlp, x, iprob, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
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
h_val, h_row, h_col, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun, nnzh, h_val, h_row, h_col = csgrsh(n, m, x, y, grlagf, lj, lh, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, nnzh = csgrsh!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, lh, h_val, h_row, h_col, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun, nnzh, h_val, h_row, h_col = csgrsh(nlp, x, y, grlagf)

  - nlp:     [IN] CUTEstModel
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

    nnzj, nnzh = csgrsh!(nlp, x, y, grlagf, j_val, j_var, j_fun, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
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
h_val, h_row, h_col, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun, nnzh, h_val, h_row, h_col = csgrsh(n, m, x, y, grlagf, lj, lh, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, nnzh = csgrsh!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, lh, h_val, h_row, h_col, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun, nnzh, h_val, h_row, h_col = csgrsh(nlp, x, y, grlagf)

  - nlp:     [IN] CUTEstModel
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

    nnzj, nnzh = csgrsh!(nlp, x, y, grlagf, j_val, j_var, j_fun, h_val, h_row, h_col)

  - nlp:     [IN] CUTEstModel
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
byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun, ne, he_row_ptr, he_val_ptr, he_row, he_val = csgreh(n, m, x, y, grlagf, lj, lhe_ptr, lhe_row, lhe_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, ne = csgreh!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun, ne, he_row_ptr, he_val_ptr, he_row, he_val = csgreh(nlp, x, y, grlagf, lhe_ptr, lhe_row, lhe_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    nnzj, ne = csgreh!(nlp, x, y, grlagf, j_val, j_var, j_fun, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - nlp:        [IN] CUTEstModel
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
byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun, ne, he_row_ptr, he_val_ptr, he_row, he_val = csgreh(n, m, x, y, grlagf, lj, lhe_ptr, lhe_row, lhe_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, ne = csgreh!(n, m, x, y, grlagf, lj, j_val, j_var, j_fun, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows, cutest_lib)

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
  - cutest_lib:    [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    nnzj, j_val, j_var, j_fun, ne, he_row_ptr, he_val_ptr, he_row, he_val = csgreh(nlp, x, y, grlagf, lhe_ptr, lhe_row, lhe_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    nnzj, ne = csgreh!(nlp, x, y, grlagf, j_val, j_var, j_fun, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val, byrows)

  - nlp:        [IN] CUTEstModel
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

    chprod(io_err, n, m, goth, x, y, vector, result, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = chprod(n, m, goth, x, y, vector, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    chprod!(n, m, goth, x, y, vector, result, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = chprod(nlp, goth, x, y, vector)

  - nlp:     [IN] CUTEstModel
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chprod!(nlp, goth, x, y, vector, result)

  - nlp:     [IN] CUTEstModel
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

    chprod(io_err, n, m, goth, x, y, vector, result, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = chprod(n, m, goth, x, y, vector, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    chprod!(n, m, goth, x, y, vector, result, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = chprod(nlp, goth, x, y, vector)

  - nlp:     [IN] CUTEstModel
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chprod!(nlp, goth, x, y, vector, result)

  - nlp:     [IN] CUTEstModel
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

"""
chprod!

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

    chcprod(io_err, n, m, goth, x, y, vector, result, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = chcprod(n, m, goth, x, y, vector, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    chcprod!(n, m, goth, x, y, vector, result, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = chcprod(nlp, goth, x, y, vector)

  - nlp:     [IN] CUTEstModel
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chcprod!(nlp, goth, x, y, vector, result)

  - nlp:     [IN] CUTEstModel
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

    chcprod(io_err, n, m, goth, x, y, vector, result, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = chcprod(n, m, goth, x, y, vector, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    chcprod!(n, m, goth, x, y, vector, result, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = chcprod(nlp, goth, x, y, vector)

  - nlp:     [IN] CUTEstModel
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

    chcprod!(nlp, goth, x, y, vector, result)

  - nlp:     [IN] CUTEstModel
  - goth:    [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - y:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - result:  [OUT] Array{Float64, 1}

"""
chcprod!

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

    cjprod(io_err, n, m, gotj, jtrans, x, vector, lvector, result, lresult, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = cjprod(n, m, gotj, jtrans, x, vector, lvector, lresult, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cjprod!(n, m, gotj, jtrans, x, vector, lvector, result, lresult, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = cjprod(nlp, gotj, jtrans, x, vector, lvector, lresult)

  - nlp:     [IN] CUTEstModel
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

    cjprod!(nlp, gotj, jtrans, x, vector, lvector, result, lresult)

  - nlp:     [IN] CUTEstModel
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

    cjprod(io_err, n, m, gotj, jtrans, x, vector, lvector, result, lresult, cutest_lib)

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
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = cjprod(n, m, gotj, jtrans, x, vector, lvector, lresult, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cjprod!(n, m, gotj, jtrans, x, vector, lvector, result, lresult, cutest_lib)

  - n:       [IN] Int
  - m:       [IN] Int
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    result = cjprod(nlp, gotj, jtrans, x, vector, lvector, lresult)

  - nlp:     [IN] CUTEstModel
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

    cjprod!(nlp, gotj, jtrans, x, vector, lvector, result, lresult)

  - nlp:     [IN] CUTEstModel
  - gotj:    [IN] Bool
  - jtrans:  [IN] Bool
  - x:       [IN] Array{Float64, 1}
  - vector:  [IN] Array{Float64, 1}
  - lvector: [IN] Int
  - result:  [OUT] Array{Float64, 1}
  - lresult: [IN] Int

"""
cjprod!

"""# uterminate
The uterminate subroutine deallocates all workspace arrays created
since the last call to usetup.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uterminate

Usage:

    uterminate(io_err, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    uterminate(, cutest_lib)

  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

"""
uterminate

"""# cterminate
The uterminate subroutine deallocates all workspace arrays created
since the last call to csetup.

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cterminate

Usage:

    cterminate(io_err, cutest_lib)

  - io_err:  [OUT] Array{Cint, 1}
  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

    cterminate(, cutest_lib)

  - cutest_lib: [IN] ASCIIString or Ptr{Void} with CUTEst library from sifdecode

"""
cterminate

