"""    usetup(io_err, input, out, io_buffer, n, x, x_l, x_u, libname)

The usetup subroutine sets up the correct data structures for sub‐
sequent computations in the case where the only possible constraints
are bound constraints. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

  - io_err:    [OUT] Array{Cint, 1}
  - input:     [IN] Array{Cint, 1}
  - out:       [IN] Array{Cint, 1}
  - io_buffer: [IN] Array{Cint, 1}
  - n:         [IN] Array{Cint, 1}
  - x:         [OUT] Array{Cdouble, 1}
  - x_l:       [OUT] Array{Cdouble, 1}
  - x_u:       [OUT] Array{Cdouble, 1}
  - libname:   [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_usetup

"""
usetup

"""    csetup(io_err, input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn,
linear, e_order, l_order, v_order, libname)

The csetup subroutine sets up the correct data structures for sub‐
sequent computations on the problem decoded from a SIF file by the
script sifdecoder. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group- partially separable and all constraint
functions are partially separable.

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
  - libname:   [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_csetup

"""
csetup

"""    udimen(io_err, input, n, libname)

The udimen subroutine discovers how many variables are involved in the
problem decoded from a SIF file by the script sifdecoder. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The
objective function is group-partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - n:       [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_udimen

"""
udimen

"""    udimsh(io_err, nnzh, libname)

The udimsh subroutine determine the number of nonzeros required to
store the Hessian matrix of the objective function of the problem
decoded from a SIF file by the script sifdecoder at the point X. This
Hessian matrix is stored as a sparse matrix in coordinate format. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu.
The objective function is group-partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_udimsh

"""
udimsh

"""    udimse(io_err, ne, he_val_ne, he_row_ne, libname)

The udimse subroutine determine the number of nonzeros required to
store the Hessian matrix of the objective function of the problem
decoded from a SIF file by the script sifdecoder at the point X. This
Hessian matrix is stored as a sparse matrix in finite element format
H=eΣ1He, where each square symmetric element H_i involves a small
subset of the rows of the Hessian matrix. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

  - io_err:    [OUT] Array{Cint, 1}
  - ne:        [OUT] Array{Cint, 1}
  - he_val_ne: [OUT] Array{Cint, 1}
  - he_row_ne: [OUT] Array{Cint, 1}
  - libname:   [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_udimse

"""
udimse

"""    uvartype(io_err, n, x_type, libname)

The uvartype subroutine determines the type (continuous, 0-1, integer)
of each variable involved in the problem decoded from a SIF file by
the script sifdecoder. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uvartype

"""
uvartype

"""    unames(io_err, n, pname, vname, libname)

The unames subroutine obtains the names of the problem and its
variables. The problem under consideration is to minimize or maximize
an objective function f(x) over all x ∈ Rn subject to the simple
bounds xl≤x≤xu. The objective function is group-partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_unames

"""
unames

"""    ureport(io_err, calls, time, libname)

The ureport subroutine obtains statistics concerning function
evaluation and CPU time used for unconstrained or bound-constrained
opti‐ mization in a standardized format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ureport

"""
ureport

"""    cdimen(io_err, input, n, m, libname)

The cdimen subroutine discovers how many variables and constraints are
involved in the problem decoded from a SIF file by the script sifde‐
coder. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separa‐ ble and all constraint functions are partially
separable.

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - n:       [OUT] Array{Cint, 1}
  - m:       [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cdimen

"""
cdimen

"""    cdimsj(io_err, nnzj, libname)

The cdimsj subroutine determines the number of nonzero elements
required to store the matrix of gradients of the objective function
and constraint functions for the problem decoded into OUTSDIF.d in the
con‐ strained minimization case. The matrix is stored in sparse
format. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separa‐ ble and all constraint functions are partially
separable.

  - io_err:  [OUT] Array{Cint, 1}
  - nnzj:    [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cdimsj

"""
cdimsj

"""    cdimsh(io_err, nnzh, libname)

The cdimsh subroutine determines the number of nonzero elements
required to store the Hessian matrix of the Lagrangian function for
the problem decoded into OUTSDIF.d in the constrained minimization
case. The matrix is stored in sparse "coordinate" format. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separa‐ ble and all constraint functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cdimsh

"""
cdimsh

"""    cdimse(io_err, ne, he_val_ne, he_row_ne, libname)

The cdimse subroutine determines the number of nonzero elements
required to store the Hessian matrix of the Lagrangian function for
the problem decoded from a SIF file by the script sifdecoder. The
matrix is stored in sparse "finite element" format H=eΣ1He, where each
square symmetric element He involves a small subset of the rows of the
Hessian matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

  - io_err:    [OUT] Array{Cint, 1}
  - ne:        [OUT] Array{Cint, 1}
  - he_val_ne: [OUT] Array{Cint, 1}
  - he_row_ne: [OUT] Array{Cint, 1}
  - libname:   [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cdimse

"""
cdimse

"""    cvartype(io_err, n, x_type, libname)

The cvartype subroutine determines the type (continuous, 0-1, integer)
of each variable involved in the problem decoded from a SIF file by
the script sifdecoder. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to
general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x_type:  [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cvartype

"""
cvartype

"""    cnames(io_err, n, m, pname, vname, cname, libname)

The cnames subroutine obtains the names of the problem, its vari‐
ables and general constraints. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separa‐ ble and all
constraint functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - cname:   [OUT] Array{Cchar, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cnames

"""
cnames

"""    creport(io_err, calls, time, libname)

The creport subroutine obtains statistics concerning function
evaluation and CPU time used for constrained optimization in a
standard‐ ized format. The problem under consideration is to minimize
or maximize an objective function f(x) over all x ∈ Rn subject to
general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - calls:   [OUT] Array{Cdouble, 1}
  - time:    [OUT] Array{Cdouble, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_creport

"""
creport

"""    connames(io_err, m, cname, libname)

The connames subroutine obtains the names of the general con‐ straints
of the problem. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - cname:   [OUT] Array{Cchar, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_connames

"""
connames

"""    pname(io_err, input, pname, libname)

The pname subroutine obtains the name of the problem directly from the
datafile OUTSDIF.d that was created by the script sifdecoder when
decoding a SIF file. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - input:   [IN] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_pname

"""
pname

"""    probname(io_err, pname, libname)

The probname subroutine obtains the name of the problem. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separa‐ ble and all constraint functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - pname:   [OUT] Array{Cchar, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_probname

"""
probname

"""    varnames(io_err, n, vname, libname)

The varnames subroutine obtains the names of the problem vari‐ ables.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separa‐ ble and all constraint functions are partially
separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - vname:   [OUT] Array{Cchar, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_varnames

"""
varnames

"""    ufn(io_err, n, x, f, libname)

The ufn subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ufn

"""
ufn

"""    ugr(io_err, n, x, g, libname)

The ugr subroutine evaluates the gradient of the objective func‐ tion
of the problem decoded from a SIF file by the script sifdecoder at the
point X. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ugr

"""
ugr

"""    uofg(io_err, n, x, f, g, grad, libname)

The uofg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uofg

"""
uofg

"""    ubandh(io_err, n, x, semibandwidth, h_band, lbandh, max_semibandwidth, libname)

The ubandh subroutine extracts the elements which lie within a band of
given semi-bandwidth out of the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

  - io_err:            [OUT] Array{Cint, 1}
  - n:                 [IN] Array{Cint, 1}
  - x:                 [IN] Array{Cdouble, 1}
  - semibandwidth:     [IN] Array{Cint, 1}
  - h_band:            [OUT] Array{Cdouble, 2}
  - lbandh:            [IN] Array{Cint, 1}
  - max_semibandwidth: [OUT] Array{Cint, 1}
  - libname:           [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ubandh

"""
ubandh

"""    udh(io_err, n, x, lh1, h, libname)

The udh subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a dense
matrix. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_udh

"""
udh

"""    ush(io_err, n, x, nnzh, lh, h_val, h_row, h_col, libname)

The ush subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a sparse
matrix in coor‐ dinate format. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ush

"""
ush

"""    ueh(io_err, n, x, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
lhe_val, he_val, byrows, libname)

The ueh subroutine evaluates the Hessian matrix of the objective
function of the problem decoded from a SIF file by the script
sifdecoder at the point X. This Hessian matrix is stored as a sparse
matrix in finite element format H=eΣ1He, where each square symmetric
element He involves a small subset of the rows of the Hessian matrix.
The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to the simple bounds
xl≤x≤xu. The objective function is group-partially separable.

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
  - libname:    [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ueh

"""
ueh

"""    ugrdh(io_err, n, x, g, lh1, h, libname)

The ugrdh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
dense matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ugrdh

"""
ugrdh

"""    ugrsh(io_err, n, x, g, nnzh, lh, h_val, h_row, h_col, libname)

The ugrsh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
sparse matrix in coordinate format. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to the simple bounds xl≤x≤xu. The objective function is group-
partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ugrsh

"""
ugrsh

"""    ugreh(io_err, n, x, g, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
lhe_val, he_val, byrows, libname)

The ugreh subroutine evaluates the gradient and Hessian matrix of the
objective function of the problem decoded from a SIF file by the
script sifdecoder at the point X. This Hessian matrix is stored as a
sparse matrix in finite element format H=eΣ1He, where each square
symmetric element H sub e involves a small subset of the rows of the
Hessian matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to the
simple bounds xl≤x≤xu. The objective function is group-partially
separable.

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
  - libname:    [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ugreh

"""
ugreh

"""    uhprod(io_err, n, goth, x, vector, result, libname)

The uhprod subroutine forms the product of a vector with the Hes‐ sian
matrix of the objective function of the problem decoded from a SIF
file by the script sifdecoder at the point X. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective
function is group-partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uhprod

"""
uhprod

"""    cfn(io_err, n, m, x, f, c, libname)

The cfn subroutine evaluates the value of the objective function and
general constraint functions of the problem decoded from a SIF file by
the script sifdecoder at the point X. The problem under consideration
is to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separa‐ ble and all
constraint functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - c:       [OUT] Array{Cdouble, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cfn

"""
cfn

"""    cofg(io_err, n, x, f, g, grad, libname)

The cofg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient. The problem under consideration is
to minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separa‐ ble and all
constraint functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cofg

"""
cofg

"""    cofsg(io_err, n, x, f, nnzg, lg, g_val, g_var, grad, libname)

The cofsg subroutine evaluates the value of the objective function of
the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly its gradient in sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separa‐ ble
and all constraint functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - nnzg:    [OUT] Array{Cint, 1}
  - lg:      [IN] Array{Cint, 1}
  - g_val:   [OUT] Array{Cdouble, 1}
  - g_var:   [OUT] Array{Cint, 1}
  - grad:    [IN] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cofsg

"""
cofsg

"""    ccfg(io_err, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad, libname)

The ccfg subroutine evaluates the values of the constraint func‐ tions
of the problem decoded from a SIF file by the script sifdecoder at the
point X, and possibly their gradients. The problem under considera‐
tion is to minimize or maximize an objective function f(x) over all x
∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequal‐ ities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint func‐ tions are partially separable.

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
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ccfg

"""
ccfg

"""    clfg(io_err, n, m, x, y, f, g, grad, libname)

The clfg subroutine evaluates the value of the Lagrangian function
l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the
script sifdecoder at the point (X,Y), and possibly its gradient. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separa‐ ble and all constraint functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - f:       [OUT] Array{Cdouble, 1}
  - g:       [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_clfg

"""
clfg

"""    cgr(io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, libname)

The cgr subroutine evaluates the gradients of the general con‐
straints and of either the objective function f(x) or the Lagrangian
function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from
a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separa‐ ble and all constraint functions are partially separable.

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
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cgr

"""
cgr

"""    csgr(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, libname)

The csgr subroutine evaluates the gradients of the general con‐
straints and of either the objective function or the Lagrangian
function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from
a SIF file by the script sifdecoder at the point (x,y)= (X,Y). It also
evaluates the Hessian matrix of the Lagrangian function at (x,y). The
gradients are stored in a sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separa‐ ble
and all constraint functions are partially separable.

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
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_csgr

"""
csgr

"""    ccfsg(io_err, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad, libname)

The ccfsg subroutine evaluates the values of the constraint func‐
tions of the problem decoded from a SIF file by the script sifdecoder
at the point X, and possibly their gradients in the constrained
minimization case. The gradients are stored in sparse format. The
problem under consideration is to minimize or maximize an objective
function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i
∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separa‐ ble and all constraint functions are partially separable.

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
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ccfsg

"""
ccfsg

"""    ccifg(io_err, n, icon, x, ci, gci, grad, libname)

The ccifg subroutine evaluates the value of a particular con‐ straint
function of the problem decoded from a SIF file by the script
sifdecoder at the point X, and possibly its gradient in the
constrained minimization case. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separable and all
constraint func‐ tions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - icon:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - ci:      [OUT] Array{Cdouble, 1}
  - gci:     [OUT] Array{Cdouble, 1}
  - grad:    [IN] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ccifg

"""
ccifg

"""    ccifsg(io_err, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad, libname)

The ccifsg subroutine evaluates the value of a particular con‐ straint
function of the problem decoded from a SIF file by the script
sifdecoder at the point X, and possibly its gradient in the
constrained minimization case. The gradient is stored in sparse
format. The problem under consideration is to minimize or maximize an
objective function f(x) over all x ∈ Rn subject to general equations
ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈
mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is
group-partially separable and all constraint functions are partially
separable.

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
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ccifsg

"""
ccifsg

"""    cgrdh(io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val, libname)

The cgrdh subroutine evaluates the gradients of the general con‐
straints and of either the objective function f(x) or the Lagrangian
function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from
a SIF file by the script sifdecoder at the point (x,y)= (X,Y). It also
evaluates the Hessian matrix of the Lagrangian function at (x,y). The
gradients and matrices are stored in a dense format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separa‐ ble
and all constraint functions are partially separable.

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
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cgrdh

"""
cgrdh

"""    cdh(io_err, n, m, x, y, lh1, h_val, libname)

The cdh subroutine evaluates the Hessian matrix of the Lagrangian
function l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by
the script sifdecoder at the point (x,y)= (X,Y). The matrix is stored
as a dense matrix. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 2}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cdh

"""
cdh

"""    csh(io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col, libname)

The csh subroutine evaluates the Hessian of the Lagrangian func‐ tion
l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the
script sifdecoder at the point (x,y)= (X,Y). The matrix is stored in
sparse format. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

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
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_csh

"""
csh

"""    cshc(io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col, libname)

The cshc subroutine evaluates the constraint part of the Hessian of
the Lagrangian function yTc(x) for the problem decoded from a SIF file
by the script sifdecoder at the point (x,y)= (X,Y). The matrix is
stored in sparse format. The problem under consideration is to
minimize or maximize an objective function f(x) over all x ∈ Rn
subject to general equations ci(x)=0, (i ∈ 1,...,mE), general
inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds
xl≤x≤xu. The objective function is group-partially separa‐ ble and all
constraint functions are partially separable.

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
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cshc

"""
cshc

"""    ceh(io_err, n, m, x, y, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row,
he_row, lhe_val, he_val, byrows, libname)

The ceh subroutine evaluates the Hessian matrix of the Lagrangian
function l(x,y)=f(x)+yTc(x) for the problem decoded into OUTSDIF.d at
the point (x,y)= (X,Y). This Hessian matrix is stored as a sparse
matrix in finite element format H=eΣ1He, where each square symmetric
element He involves a small subset of the rows of the Hessian matrix.
The problem under consideration consists in minimizing (or maximizing)
an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group- partially separable and all constraint
functions are partially separable.

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
  - libname:    [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_ceh

"""
ceh

"""    cidh(io_err, n, x, iprob, lh1, h, libname)

The cidh subroutine evaluates the Hessian matrix of either the
objective function or a constraint function for the problem decoded
from a SIF file by the script sifdecoder at the point X, and possibly
its gra‐ dient. The matrix is stored as a dense matrix. The problem
under consideration is to minimize or maximize an objective function
f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈
1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m),
and simple bounds xl≤x≤xu. The objective function is group-partially
separa‐ ble and all constraint functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - iprob:   [IN] Array{Cint, 1}
  - lh1:     [IN] Array{Cint, 1}
  - h:       [OUT] Array{Cdouble, 2}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cidh

"""
cidh

"""    cish(io_err, n, x, iprob, nnzh, lh, h_val, h_row, h_col, libname)

The cish subroutine evaluates the Hessian of a particular con‐ straint
function or the objective function for the problem decoded from a SIF
file by the script sifdecoder at the point X, and possibly its gradi‐
ent. The matrix is stored in sparse format. The problem under
consideration is to minimize or maximize an objective function f(x)
over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE),
general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple
bounds xl≤x≤xu. The objective function is group-partially separa‐ ble
and all constraint functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - iprob:   [IN] Array{Cint, 1}
  - nnzh:    [OUT] Array{Cint, 1}
  - lh:      [IN] Array{Cint, 1}
  - h_val:   [OUT] Array{Cdouble, 1}
  - h_row:   [OUT] Array{Cint, 1}
  - h_col:   [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cish

"""
cish

"""    csgrsh(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, nnzh, lh,
h_val, h_row, h_col, libname)

The csgrsh subroutine evaluates the gradients of the general con‐
straints, the Hessian matrix of the Lagrangian function
l(x,y)=f(x)+yTc(x) and the gradient of either the objective function
or the Lagrangian corresponding to the problem decoded from a SIF file
by the script sifdecoder at the point (x,y)= (X,Y). The data is stored
in sparse format. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

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
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_csgrsh

"""
csgrsh

"""    csgreh(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, ne,
lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val,
byrows, libname)

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
group- partially separable and all constraint functions are partially
separable.

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
  - libname:    [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_csgreh

"""
csgreh

"""    chprod(io_err, n, m, goth, x, y, vector, result, libname)

The chprod subroutine forms the product of a vector with the Hes‐ sian
matrix of the Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to
the problem decoded from a SIF file by the script sifdecoder at the
point (x,y)= (X,Y). The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_chprod

"""
chprod

"""    chcprod(io_err, n, m, goth, x, y, vector, result, libname)

The chcprod subroutine forms the product of a vector with the Hes‐
sian matrix of the constraint part of the Lagrangian function yTc(x)
of the problem decoded from a SIF file by the script sifdecoder at the
point (x,y)= (X,Y). The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

  - io_err:  [OUT] Array{Cint, 1}
  - n:       [IN] Array{Cint, 1}
  - m:       [IN] Array{Cint, 1}
  - goth:    [IN] Array{Cint, 1}
  - x:       [IN] Array{Cdouble, 1}
  - y:       [IN] Array{Cdouble, 1}
  - vector:  [IN] Array{Cdouble, 1}
  - result:  [OUT] Array{Cdouble, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_chcprod

"""
chcprod

"""    cjprod(io_err, n, m, gotj, jtrans, x, vector, lvector, result, lresult, libname)

The cjprod subroutine forms the product of a vector with the Jaco‐
bian matrix, or with its transpose, of the constraint functions of the
problem decoded from a SIF file by the script sifdecoder evaluated at
the point X. The problem under consideration is to minimize or
maximize an objective function f(x) over all x ∈ Rn subject to general
equations ci(x)=0, (i ∈ 1,...,mE), general inequalities
ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The
objective function is group-partially separa‐ ble and all constraint
functions are partially separable.

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
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cjprod

"""
cjprod

"""    uterminate(io_err, libname)

The uterminate subroutine deallocates all workspace arrays created
since the last call to usetup.

  - io_err:  [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_uterminate

"""
uterminate

"""    cterminate(io_err, libname)

The uterminate subroutine deallocates all workspace arrays created
since the last call to csetup.

  - io_err:  [OUT] Array{Cint, 1}
  - libname: [IN] ASCIIString

This help was generated automatically and may contain
errors. For more information, run the shell command

    man cutest_cterminate

"""
cterminate

