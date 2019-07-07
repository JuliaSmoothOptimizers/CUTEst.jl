var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#CUTEst.jl-documentation-1",
    "page": "Home",
    "title": "CUTEst.jl documentation",
    "category": "section",
    "text": "This package provides an interface to CUTEst, the Constrained and Unconstrained Test Environment with safe threads for nonlinear optimization.This package uses NLPModels.jl, but it also gives direct access to the CUTEst functions."
},

{
    "location": "#CUTEst-brief-history-1",
    "page": "Home",
    "title": "CUTEst brief history",
    "category": "section",
    "text": "CUTEst has been around for a while. It started as CUTE, then CUTEr, then CUTEr2, and finally CUTEst. The original project can be used independently of Julia.CUTEst works by decoding a .SIF file into other files and objects so that a user compiles links that to his code. It also gives the option of doing that for you, in which case you have to send some code to it\'s folder, and ask for the compilation.CUTEst gives you about 100 methods to access the objective and constraints functions, as well as their derivatives in many different formats. It also gives access to the problem\'s information, like number of variables, constraints, the initial point, the bounds, an so on."
},

{
    "location": "#Installing-1",
    "page": "Home",
    "title": "Installing",
    "category": "section",
    "text": "On Linux, you\'ll need to install wget and gfortran, and possibly have to fix the location of libgfortran.so.On Ubuntu 14.04, you can do this withsudo apt-get install wget gfortran\nsudo ln -s /usr/lib/gcc/x86_64-linux-gnu/$(gfortran -dumpversion | cut -f1,2 -d.)/libgfortran.so /usr/local/libOn Ubuntu 16.04,sudo apt-get install wget gfortran\nsudo ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.3 /usr/local/lib/libgfortran.soOn Archlinux, dosudo pacman -S wget gfortranThe following command should automatically download and install CUTEst and its dependencies (Use ] to enter pkg> mode).pkg> add CUTEst"
},

{
    "location": "#Usage-1",
    "page": "Home",
    "title": "Usage",
    "category": "section",
    "text": "Check the tutorial for complete usage.The simplest use of CUTEst is through the interface of NLPModels.jl.using CUTEst, NLPModels\n\nnlp = CUTEstModel(\"ROSENBR\")\nprintln(\"x0 = $(nlp.meta.x0)\")\nprintln(\"fx = $( obj(nlp, nlp.meta.x0) )\")\nprintln(\"gx = $( grad(nlp, nlp.meta.x0) )\")\nprintln(\"Hx = $( hess(nlp, nlp.meta.x0) )\")\nfinalize(nlp)Check the NLPModels API for details."
},

{
    "location": "#Working-with-CUTEst-directly-1",
    "page": "Home",
    "title": "Working with CUTEst directly",
    "category": "section",
    "text": "We also have implemented function to allow access to the CUTEst functions directly: a core API which is only a wrapper for CUTEst. For more information see the section core."
},

{
    "location": "#Contents-1",
    "page": "Home",
    "title": "Contents",
    "category": "section",
    "text": ""
},

{
    "location": "tutorial/#",
    "page": "Tutorial",
    "title": "Tutorial",
    "category": "page",
    "text": ""
},

{
    "location": "tutorial/#Tutorial-1",
    "page": "Tutorial",
    "title": "Tutorial",
    "category": "section",
    "text": "CUTEst can be accessed in two ways.The first, easiest, and recommended for most users, is using the NLPModels.jl. This is recommended because if you develop something for this an NLPModel, then it can work with CUTEst, but also with other models.\nThe second is the core interface, which is just a wrapper of the Fortran functions, and is not recommended unless you really need and know what you\'re doing."
},

{
    "location": "tutorial/#NLPModels-interface-1",
    "page": "Tutorial",
    "title": "NLPModels interface",
    "category": "section",
    "text": "NLPModels defines an abstract interface to access the objective, constraints, derivatives, etc. of the problem. A reference guide is available to check what you need.Once CUTEst has been installed, open a problem withusing CUTEst\n\nnlp = CUTEstModel(\"ROSENBR\")That\'s it. You can use nlp like any other NLPModel, with one important exception. You have to finalize the model after using it. To be exact, you have to finalize it before opening a new one. There is no problem in closing Julia before finalizing it, for instance.finalize(nlp)Being a NLPModel means that everything created for an AbstractNLPModel will work for CUTEstModel. For instance, JSOSolvers.jl has implementations of optimization methods for AbstractNLPModels.Let\'s make some demonstration of the CUTEstModel.using CUTEst, NLPModels\n\nnlp = CUTEstModel(\"ROSENBR\")\nprintln(\"x0 = $( nlp.meta.x0 )\")\nprintln(\"fx = $( obj(nlp, nlp.meta.x0) )\")\nprintln(\"gx = $( grad(nlp, nlp.meta.x0) )\")\nprintln(\"Hx = $( hess(nlp, nlp.meta.x0) )\")Remember to check the API in case of doubts about these functions.Notice how hess returns a lower triangle matrix. For decompositions that should be enough. For iterative solvers, you may want nabla^2 f(x) v instead, so only the lower triangle won\'t do. But you do havev = ones(nlp.meta.nvar)\nhprod(nlp, nlp.meta.x0, v)You can also use a LinearOperator,using LinearOperators\nn = nlp.meta.nvar\n\nH = hess_op(nlp, nlp.meta.x0)\nH * vThis way, you can use a Krylov method to solve the linear system with the Hessian as matrix. For instance, here is an example computation of a Newton trust-region step.using Krylov\n\nfunction newton()\n  Delta = 10.0\n  x = nlp.meta.x0\n  println(\"0: x = $x\")\n  for i = 1:5\n    print(\"$i: \")\n    H = hess_op(nlp, x)\n    d, stats = Krylov.cg(H, -grad(nlp, x), radius=Delta)\n    x = x + d\n    println(\"x = $x\")\n  end\nendfinalize(nlp)There is no difference in calling a constrained problem, only that some additional functions are available.using CUTEst, NLPModels\n\nnlp = CUTEstModel(\"HS35\")x = nlp.meta.x0\n\ncons(nlp, x)jac(nlp, x)To find out whether these constraints are equalities or inequalities we can check nlp.metaprint(nlp.meta)finalize(nlp)"
},

{
    "location": "tutorial/#Selection-tool-1",
    "page": "Tutorial",
    "title": "Selection tool",
    "category": "section",
    "text": "CUTEst comes with a simple selection tool. It uses a static file generated from the original CLASSF.DB and an execution of each problem.The selection tool works like a filter on the complete set of problems. Using the tool without arguments will return the complete set of problems.using CUTEst # hide\nproblems = CUTEst.select()\nlength(problems)The list of keyword arguments to filter the problems is given below, with their default value.argument default description\nmin_var 0 Minimum number of variables\nmax_var Inf Maximum number of variables\nmin_con 0 Minimum number of constraints (not bounds)\nmax_con Inf Maximum number of constraints\nobjtype all types Type of the objective function. See below.\ncontype all types Type of the constraints. See below.\nonly_free_var false Whether to exclude problems with bounded variables.\nonly_bnd_var false Whether to exclude problem with any free variables.\nonly_linear_con false Whether to exclude problems with nonlinear constraints.\nonly_nonlinear_con false Whether to exclude problems with any linear constraints.\nonly_equ_con false Whether to exclude problems with inequality constraints\nonly_ineq_con false Whether to exclude problems with equality constraints\ncustom_filter nothing A custom filter to be applied to the entries. This requires knowledge of the inner structure, and is present only because we haven\'t implemented every useful combination yet. We welcome pull-requests with implementations of additional queries.objtype description\n\"none\" or \"N\" There is no objective function.\n\"constants\" or \"C\" The objective function is constant.\n\"linear\" or \"L\" The objective function is linear.\n\"quadratic\" or \"Q\" The objective function is quadratic.\n\"sumofsquares\" or \"S\" The objective function is a sum of squares.\n\"other\" or \"O\" The objective function is none of the above.contype description\n\"unc\" or \"U\" There are no constraints nor bounds on the variables.\n\"fixed_vars\" or \"X\" The only constraints are fixed variables.\n\"bounds\" or \"B\" The only constraints are bounds on the variables.\n\"network\" or \"N\" The constraints represent the adjacency matrix of a linear network.\n\"linear\" or \"L\" The constraints are linear.\n\"quadratic\" or \"Q\" The constraints are quadratic.\n\"other\" or \"O\" The constraints are more general than any of the above.The selection tool is not as complete as we would like. Some combinations are still hard to create. Below we create some of the simpler ones."
},

{
    "location": "tutorial/#Unconstrained-problems-1",
    "page": "Tutorial",
    "title": "Unconstrained problems",
    "category": "section",
    "text": "No constraints and no bounds. There are two options:problems = CUTEst.select(max_con=0, only_free_var=true)\nlength(problems)problems = CUTEst.select(contype=\"unc\")\nlength(problems)"
},

{
    "location": "tutorial/#Equality/Inequality-constrainted-problems-with-unbounded-variables-1",
    "page": "Tutorial",
    "title": "Equality/Inequality constrainted problems with unbounded variables",
    "category": "section",
    "text": "problems = CUTEst.select(min_con=1, only_equ_con=true, only_free_var=true)\nlength(problems)problems = CUTEst.select(min_con=1, only_ineq_con=true, only_free_var=true)\nlength(problems)"
},

{
    "location": "tutorial/#Size-range-1",
    "page": "Tutorial",
    "title": "Size range",
    "category": "section",
    "text": "problems = CUTEst.select(min_var=1000, max_var=2000, min_con=100, max_con=500)\nlength(problems)"
},

{
    "location": "tutorial/#Sum-of-squares-problems-with-bounds-1",
    "page": "Tutorial",
    "title": "Sum-of-squares problems with bounds",
    "category": "section",
    "text": "problems = CUTEst.select(objtype=\"sum_of_squares\", contype=\"bounds\")\nlength(problems)"
},

{
    "location": "tutorial/#Quadratic-programming-with-linear-constraints.-1",
    "page": "Tutorial",
    "title": "Quadratic programming with linear constraints.",
    "category": "section",
    "text": "problems = CUTEst.select(objtype=\"quadratic\", contype=\"linear\")\nlength(problems)"
},

{
    "location": "api/#",
    "page": "API",
    "title": "API",
    "category": "page",
    "text": ""
},

{
    "location": "api/#API-1",
    "page": "API",
    "title": "API",
    "category": "section",
    "text": ""
},

{
    "location": "api/#NLPModels-API-1",
    "page": "API",
    "title": "NLPModels API",
    "category": "section",
    "text": "CUTEst accepts the API of NLPModels."
},

{
    "location": "api/#CUTEst.cons_coord",
    "page": "API",
    "title": "CUTEst.cons_coord",
    "category": "function",
    "text": "cons_coord(nlp, x)\n\nComputes the constraint vector and the Jacobian in coordinate format. Usage:\n\nc, jrow, jcol, jval = cons_coord(nlp, x)\n\nnlp:  [IN] CUTEstModel\nx:    [IN] Array{Float64, 1}\nc:    [OUT] Array{Float64, 1}\njrow: [OUT] Array{Int32, 1}\njcol: [OUT] Array{Int32, 1}\njval: [OUT] Array{Float64, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cons_coord!",
    "page": "API",
    "title": "CUTEst.cons_coord!",
    "category": "function",
    "text": "cons_coord!(nlp, x, c, rows, cols, vals)\n\nComputes the constraint vector and the Jacobian in coordinate format. Usage:\n\ncons_coord!(nlp, x, c, rows, cols, vals)\n\nnlp:  [IN] CUTEstModel\nx:    [IN] Array{Float64, 1}\nc:    [OUT] Array{Float64, 1}\njrow: [OUT] Array{Int32, 1}\njcol: [OUT] Array{Int32, 1}\njval: [OUT] Array{Float64, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.consjac",
    "page": "API",
    "title": "CUTEst.consjac",
    "category": "function",
    "text": "consjac(nlp, x)\n\nComputes the constraint vector and the Jacobian in internal sparse format. Usage:\n\nc, J = consjac(nlp, x)\n\nnlp:  [IN] CUTEstModel\nx:    [IN] Array{Float64, 1}\nc:    [OUT] Array{Float64, 1}\nJ:    [OUT] Base.SparseMatrix.SparseMatrixCSC{Float64,Int32}\n\n\n\n\n\n"
},

{
    "location": "api/#Additional-NLPModels-like-API-1",
    "page": "API",
    "title": "Additional NLPModels-like API",
    "category": "section",
    "text": "cons_coord\ncons_coord!\nconsjac"
},

{
    "location": "api/#CUTEst.select-Tuple{}",
    "page": "API",
    "title": "CUTEst.select",
    "category": "method",
    "text": "select(;minvar=1, maxvar=Inf, mincon=0, maxcon=Inf,     objtype=, contype=,     onlyfreevar=false, onlybndvar=false,     onlylinearcon=false, onlynonlinearcon=false,     onlyequcon=false, onlyineqcon=false,     custom_filter=*)\n\nReturns a subset of the CUTEst problems using the classification file classf.json. This file is export together with the package, so if you have an old CUTEst installation, it can lead to inconsistencies.\n\nmin_var and max_var set the number of variables in the problem;\nmin_con and max_con set the number of constraints in the problem\n\n(e.g., use max_con=0 for unconstrained or min_con=1 for constrained)\n\nonly_* flags are self-explaining. Note that they appear in conflicting\n\npairs. Both can be false, but only one can be true.\n\nobjtype is the classification of the objective function according to the\n\nMASTSIF classification file. It can be a number, a symbol, a string, or an array of those.\n\n1, :none or \"none\" means there is no objective function;\n2, :constant or \"constant\" means the objective function is a constant;\n3, :linear or \"linear\" means the objective function is a linear functional;\n4, :quadratic or \"quadratic\" means the objective function is quadratic;\n5, :sum_of_squares or \"sum_of_squares\" means the objective function is a sum of squares\n6, :other or \"other\" means the objective function is none of the above.\n\ncontype is the classification of the constraints according to the same MASTSIF classification file.\n1, :unc or \"unc\" means there are no constraints at all;   2, :fixedvars or \"fixedvars\" means the only constraints are fixed variables;   3, :bounds or \"bounds\" means the only constraints are bounded variables;   4, :network or \"network\" means the constraints represent the adjacency matrix of a (linear) network;   5, :linear or \"linear\" means the constraints are linear;   6, :quadratic or \"quadratic\" means the constraints are quadratic;   7, :other or \"other\" means the constraints are more general.\ncustom_filter is a function to be applied to the problem data, which is a dict with the following fields:\n\"objtype\"           - String    one of the above objective function types   \"contype\"           - String    one of the above constraint types   \"regular\"           - Bool      whether the problem is regular or not   \"derivativeorder\"  - Int       order of the highest derivative available   \"origin\"            - String    origin of the problem: \"academic\", \"modelling\" or \"real\"   \"hasintervalvar\"  - Bool      whether it has interval variables   \"variables\"         - Dict with the following fields     \"canchoose\"      - Bool      whether you can change the number of variables via parameters     \"number\"          - Int       the number of variables (if can_choose, the default)     \"fixed\"           - Int       the number of fixed variables     \"free\"            - Int       the number of free variables     \"boundedbelow\"   - Int       the number of variables bounded only from below     \"boundedabove\"   - Int       the number of variables bounded only from above     \"boundedboth\"    - Int       the number of variables bounded from below and above   \"constraints\"       - Dict with the following fields     \"canchoose\"      - Bool      whether you can change the number of constraints via parameters     \"number\"          - Int       the number of constraints (if can_choose, the default)     \"equality\"        - Int       the number of equality constraints     \"ineqbelow\"      - Int       the number of inequalities of the form c(x) ≧ cl     \"ineqabove\"      - Int       the number of inequalities of the form c(x) ≦ cu     \"ineq_both\"       - Int       the number of inequalities of the form cl ≦ c(x) ≦ cu     \"linear\"          - Int       the number of linear constraints     \"nonlinear\"       - Int       the number of nonlinear constraints\n\nFor instance, if you\'d like to choose only problems with fixed number of   variables, you can pass\n\ncustom_filter=x->x[\"variables\"][\"can_choose\"]==false\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.create_class",
    "page": "API",
    "title": "CUTEst.create_class",
    "category": "function",
    "text": "create_class()\n\nCreates the file classf.json, running each problem in $MASTSIF/CLASSF.DB and extracting the necessary information. It should be left alone, unless you think it is not updated. If you do, please open an issue at https://github.com/JuliaSmoothOptimizers/CUTEst.jl\n\n\n\n\n\n"
},

{
    "location": "api/#Select-tools-1",
    "page": "API",
    "title": "Select tools",
    "category": "section",
    "text": "Modules = [CUTEst]\nPages   = [\"classification.jl\"]\nOrder   = [:function]CUTEst.create_class"
},

{
    "location": "api/#CUTEst.ccfg-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,2},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ccfg",
    "category": "method",
    "text": "ccfg\n\nThe ccfg subroutine evaluates the values of the constraint functions of the problem decoded from a SIF file by the script sifdecoder at the point X, and possibly their gradients. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_ccfg\n\nUsage:\n\nccfg(io_err, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nc:       [OUT] Array{Cdouble, 1}\njtrans:  [IN] Array{Cint, 1}\nlcjac1:  [IN] Array{Cint, 1}\nlcjac2:  [IN] Array{Cint, 1}\ncjac:    [OUT] Array{Cdouble, 2}\ngrad:    [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ccfsg-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ccfsg",
    "category": "method",
    "text": "ccfsg\n\nThe ccfsg subroutine evaluates the values of the constraint functions of the problem decoded from a SIF file by the script sifdecoder at the point X, and possibly their gradients in the constrained minimization case. The gradients are stored in sparse format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_ccfsg\n\nUsage:\n\nccfsg(io_err, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nc:       [OUT] Array{Cdouble, 1}\nnnzj:    [OUT] Array{Cint, 1}\nlj:      [IN] Array{Cint, 1}\nj_val:   [OUT] Array{Cdouble, 1}\nj_var:   [OUT] Array{Cint, 1}\nj_fun:   [OUT] Array{Cint, 1}\ngrad:    [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cchprods-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cchprods",
    "category": "method",
    "text": "cchprods\n\nThe cchprods subroutine forms the product of a vector with each of the Hessian matrix of the constraint functions c(x) corresponding to the problem decoded from a SIF file by the script sifdecoder at the point x= X. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cchprods\n\nUsage:\n\ncchprods(io_err, n, m, goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\ngoth:    [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nvector:  [IN] Array{Cdouble, 1}\nlchp:    [IN] Array{Cint, 1}\nchp_val: [OUT] Array{Cdouble, 1}\nchp_ind: [IN] Array{Cint, 1}\nchp_ptr: [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cchprodsp-NTuple{5,Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cchprodsp",
    "category": "method",
    "text": "cchprodsp\n\nThe cchprodsp subroutine obtains the sparsity structure used when forming the product of a vector with each of the Hessian matrices of the constraint functions c(x) corresponding to the problem decoded from a SIF file by the script sifdecoder at the point x= X.\n\nUsage:\n\ncchprodsp(io_err, m, lchp, chp_ind, chp_ptr)\n\nio_err:  [OUT] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nlchp:    [IN] Array{Cint, 1}\nchp_ind: [IN] Array{Cint, 1}\nchp_ptr: [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ccifg-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ccifg",
    "category": "method",
    "text": "ccifg\n\nThe ccifg subroutine evaluates the value of a particular constraint function of the problem decoded from a SIF file by the script sifdecoder at the point X, and possibly its gradient in the constrained minimization case. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_ccifg\n\nUsage:\n\nccifg(io_err, n, icon, x, ci, gci, grad)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nicon:    [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nci:      [OUT] Array{Cdouble, 1}\ngci:     [OUT] Array{Cdouble, 1}\ngrad:    [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ccifsg-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ccifsg",
    "category": "method",
    "text": "ccifsg\n\nThe ccifsg subroutine evaluates the value of a particular constraint function of the problem decoded from a SIF file by the script sifdecoder at the point X, and possibly its gradient in the constrained minimization case. The gradient is stored in sparse format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_ccifsg\n\nUsage:\n\nccifsg(io_err, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nicon:    [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nci:      [OUT] Array{Cdouble, 1}\nnnzgci:  [OUT] Array{Cint, 1}\nlgci:    [IN] Array{Cint, 1}\ngci_val: [OUT] Array{Cdouble, 1}\ngci_var: [OUT] Array{Cint, 1}\ngrad:    [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cdh-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Float64,2}}",
    "page": "API",
    "title": "CUTEst.cdh",
    "category": "method",
    "text": "cdh\n\nThe cdh subroutine evaluates the Hessian matrix of the Lagrangian function l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The matrix is stored as a dense matrix. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cdh\n\nUsage:\n\ncdh(io_err, n, m, x, y, lh1, h_val)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\nlh1:     [IN] Array{Cint, 1}\nh_val:   [OUT] Array{Cdouble, 2}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cdhc-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Float64,2}}",
    "page": "API",
    "title": "CUTEst.cdhc",
    "category": "method",
    "text": "cdhc\n\nThe cdhc subroutine evaluates the Hessian matrix of the constraint part of the Lagrangian function yTc(x) for the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The matrix is stored as a dense matrix. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cdhc\n\nUsage:\n\ncdhc(io_err, n, m, x, y, lh1, h_val)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\nlh1:     [IN] Array{Cint, 1}\nh_val:   [OUT] Array{Cdouble, 2}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cdimchp-Tuple{Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cdimchp",
    "category": "method",
    "text": "cdimchp\n\nThe cdimchp subroutine determines the number of nonzero elements required to store the products of the Hessian matrices of the constraint functions with a specified vector for the problem decoded into OUTSDIF.d in the constrained minimization case. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cdimchp\n\nUsage:\n\ncdimchp(io_err, nnzchp)\n\nio_err:  [OUT] Array{Cint, 1}\nnnzchp:  [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cdimen-NTuple{4,Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cdimen",
    "category": "method",
    "text": "cdimen\n\nThe cdimen subroutine discovers how many variables and constraints are involved in the problem decoded from a SIF file by the script sifdecoder. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cdimen\n\nUsage:\n\ncdimen(io_err, input, n, m)\n\nio_err:  [OUT] Array{Cint, 1}\ninput:   [IN] Array{Cint, 1}\nn:       [OUT] Array{Cint, 1}\nm:       [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cdimse-NTuple{4,Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cdimse",
    "category": "method",
    "text": "cdimse\n\nThe cdimse subroutine determines the number of nonzero elements required to store the Hessian matrix of the Lagrangian function for the problem decoded from a SIF file by the script sifdecoder. The matrix is stored in sparse \"finite element\" format H=eΣ1He, where each square symmetric element He involves a small subset of the rows of the Hessian matrix. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cdimse\n\nUsage:\n\ncdimse(io_err, ne, he_val_ne, he_row_ne)\n\nio_err:    [OUT] Array{Cint, 1}\nne:        [OUT] Array{Cint, 1}\nhevalne: [OUT] Array{Cint, 1}\nherowne: [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cdimsh-Tuple{Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cdimsh",
    "category": "method",
    "text": "cdimsh\n\nThe cdimsh subroutine determines the number of nonzero elements required to store the Hessian matrix of the Lagrangian function for the problem decoded into OUTSDIF.d in the constrained minimization case. The matrix is stored in sparse \"coordinate\" format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cdimsh\n\nUsage:\n\ncdimsh(io_err, nnzh)\n\nio_err:  [OUT] Array{Cint, 1}\nnnzh:    [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cdimsj-Tuple{Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cdimsj",
    "category": "method",
    "text": "cdimsj\n\nThe cdimsj subroutine determines the number of nonzero elements required to store the matrix of gradients of the objective function and constraint functions for the problem decoded into OUTSDIF.d in the constrained minimization case. The matrix is stored in sparse format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cdimsj\n\nUsage:\n\ncdimsj(io_err, nnzj)\n\nio_err:  [OUT] Array{Cint, 1}\nnnzj:    [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ceh-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ceh",
    "category": "method",
    "text": "ceh\n\nThe ceh subroutine evaluates the Hessian matrix of the Lagrangian function l(x,y)=f(x)+yTc(x) for the problem decoded into OUTSDIF.d at the point (x,y)= (X,Y). This Hessian matrix is stored as a sparse matrix in finite element format H=eΣ1He, where each square symmetric element He involves a small subset of the rows of the Hessian matrix. The problem under consideration consists in minimizing (or maximizing) an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_ceh\n\nUsage:\n\nceh(io_err, n, m, x, y, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row,\n\nherow, lheval, he_val, byrows)\n\nio_err:     [OUT] Array{Cint, 1}\nn:          [IN] Array{Cint, 1}\nm:          [IN] Array{Cint, 1}\nx:          [IN] Array{Cdouble, 1}\ny:          [IN] Array{Cdouble, 1}\nne:         [OUT] Array{Cint, 1}\nlhe_ptr:    [IN] Array{Cint, 1}\nherowptr: [OUT] Array{Cint, 1}\nhevalptr: [OUT] Array{Cint, 1}\nlhe_row:    [IN] Array{Cint, 1}\nhe_row:     [OUT] Array{Cint, 1}\nlhe_val:    [IN] Array{Cint, 1}\nhe_val:     [OUT] Array{Cdouble, 1}\nbyrows:     [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cfn-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.cfn",
    "category": "method",
    "text": "cfn\n\nThe cfn subroutine evaluates the value of the objective function and general constraint functions of the problem decoded from a SIF file by the script sifdecoder at the point X. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cfn\n\nUsage:\n\ncfn(io_err, n, m, x, f, c)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nf:       [OUT] Array{Cdouble, 1}\nc:       [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cgr-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,2}}",
    "page": "API",
    "title": "CUTEst.cgr",
    "category": "method",
    "text": "cgr\n\nThe cgr subroutine evaluates the gradients of the general constraints and of either the objective function f(x) or the Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cgr\n\nUsage:\n\ncgr(io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\ngrlagf:  [IN] Array{Cint, 1}\ng:       [OUT] Array{Cdouble, 1}\njtrans:  [IN] Array{Cint, 1}\nlj1:     [IN] Array{Cint, 1}\nlj2:     [IN] Array{Cint, 1}\nj_val:   [OUT] Array{Cdouble, 2}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cgrdh-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,2},Array{Int32,1},Array{Float64,2}}",
    "page": "API",
    "title": "CUTEst.cgrdh",
    "category": "method",
    "text": "cgrdh\n\nThe cgrdh subroutine evaluates the gradients of the general constraints and of either the objective function f(x) or the Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). It also evaluates the Hessian matrix of the Lagrangian function at (x,y). The gradients and matrices are stored in a dense format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cgrdh\n\nUsage:\n\ncgrdh(io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\ngrlagf:  [IN] Array{Cint, 1}\ng:       [OUT] Array{Cdouble, 1}\njtrans:  [IN] Array{Cint, 1}\nlj1:     [IN] Array{Cint, 1}\nlj2:     [IN] Array{Cint, 1}\nj_val:   [OUT] Array{Cdouble, 2}\nlh1:     [IN] Array{Cint, 1}\nh_val:   [OUT] Array{Cdouble, 2}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.chcprod-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.chcprod",
    "category": "method",
    "text": "chcprod\n\nThe chcprod subroutine forms the product of a vector with the Hessian matrix of the constraint part of the Lagrangian function yTc(x) of the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_chcprod\n\nUsage:\n\nchcprod(io_err, n, m, goth, x, y, vector, result)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\ngoth:    [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\nvector:  [IN] Array{Cdouble, 1}\nresult:  [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.chprod-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.chprod",
    "category": "method",
    "text": "chprod\n\nThe chprod subroutine forms the product of a vector with the Hessian matrix of the Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_chprod\n\nUsage:\n\nchprod(io_err, n, m, goth, x, y, vector, result)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\ngoth:    [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\nvector:  [IN] Array{Cdouble, 1}\nresult:  [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cidh-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,2}}",
    "page": "API",
    "title": "CUTEst.cidh",
    "category": "method",
    "text": "cidh\n\nThe cidh subroutine evaluates the Hessian matrix of either the objective function or a constraint function for the problem decoded from a SIF file by the script sifdecoder at the point X, and possibly its gradient. The matrix is stored as a dense matrix. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cidh\n\nUsage:\n\ncidh(io_err, n, x, iprob, lh1, h)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\niprob:   [IN] Array{Cint, 1}\nlh1:     [IN] Array{Cint, 1}\nh:       [OUT] Array{Cdouble, 2}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cifn-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.cifn",
    "category": "method",
    "text": "cifn\n\nThe cifn subroutine evaluates the value of either the objective function or a constrainted function of the problem decoded from a SIF file by the script sifdecoder at the point X, in the constrained minimization case.\n\nFor more information, run the shell command\n\nman cutest_cifn\n\nUsage:\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\niprob:   [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nf:       [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cigr-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.cigr",
    "category": "method",
    "text": "cigr\n\nThe cigr subroutine evaluates the gradient of either the objective function or a constraint function of the problem decoded from a SIF file by the script sifdecoder at the point X, in the constrained minimization case.\n\nFor more information, run the shell command\n\nman cutest_cigr\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\niprob:   [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ng_val:   [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cisgr-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cisgr",
    "category": "method",
    "text": "cisgr\n\nThe cisgr subroutine evaluates the gradient of either the objective function or a constraint function of the problem decoded from a SIF file by the script sifdecoder at the point X, in the constrained minimization case. The gradient is stored in sparse format.\n\nFor more information, run the shell command\n\nman cutest_cisgr\n\nUsage:\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\niprob:   [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nnnzg:    [OUT] Array{Cint, 1}\nlg:      [IN] Array{Cint, 1}\ng_val:   [OUT] Array{Cdouble, 1}\ng_var:   [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cish-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cish",
    "category": "method",
    "text": "cish\n\nThe cish subroutine evaluates the Hessian of a particular constraint function or the objective function for the problem decoded from a SIF file by the script sifdecoder at the point X, and possibly its gradient. The matrix is stored in sparse format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cish\n\nUsage:\n\ncish(io_err, n, x, iprob, nnzh, lh, h_val, h_row, h_col)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\niprob:   [IN] Array{Cint, 1}\nnnzh:    [OUT] Array{Cint, 1}\nlh:      [IN] Array{Cint, 1}\nh_val:   [OUT] Array{Cdouble, 1}\nh_row:   [OUT] Array{Cint, 1}\nh_col:   [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cjprod-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cjprod",
    "category": "method",
    "text": "cjprod\n\nThe cjprod subroutine forms the product of a vector with the Jacobian matrix, or with its transpose, of the constraint functions of the problem decoded from a SIF file by the script sifdecoder evaluated at the point X. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cjprod\n\nUsage:\n\ncjprod(io_err, n, m, gotj, jtrans, x, vector, lvector, result, lresult)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\ngotj:    [IN] Array{Cint, 1}\njtrans:  [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nvector:  [IN] Array{Cdouble, 1}\nlvector: [IN] Array{Cint, 1}\nresult:  [OUT] Array{Cdouble, 1}\nlresult: [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.clfg-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.clfg",
    "category": "method",
    "text": "clfg\n\nThe clfg subroutine evaluates the value of the Lagrangian function l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the script sifdecoder at the point (X,Y), and possibly its gradient. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_clfg\n\nUsage:\n\nclfg(io_err, n, m, x, y, f, g, grad)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\nf:       [OUT] Array{Cdouble, 1}\ng:       [OUT] Array{Cdouble, 1}\ngrad:    [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cnames-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{UInt8,1},Array{UInt8,2},Array{UInt8,2}}",
    "page": "API",
    "title": "CUTEst.cnames",
    "category": "method",
    "text": "cnames\n\nThe cnames subroutine obtains the names of the problem, its variables and general constraints. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cnames\n\nUsage:\n\ncnames(io_err, n, m, pname, vname, cname)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\npname:   [OUT] Array{UInt8, 1}\nvname:   [OUT] Array{UInt8, 1}\ncname:   [OUT] Array{UInt8, 1}\n\nTo get useful names, use String(x) where x can be pname, vname[:,i], or cname[:,i].\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cofg-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cofg",
    "category": "method",
    "text": "cofg\n\nThe cofg subroutine evaluates the value of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X, and possibly its gradient. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cofg\n\nUsage:\n\ncofg(io_err, n, x, f, g, grad)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nf:       [OUT] Array{Cdouble, 1}\ng:       [OUT] Array{Cdouble, 1}\ngrad:    [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cofsg-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cofsg",
    "category": "method",
    "text": "cofsg\n\nThe cofsg subroutine evaluates the value of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X, and possibly its gradient in sparse format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cofsg\n\nUsage:\n\ncofsg(io_err, n, x, f, nnzg, lg, g_val, g_var, grad)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nf:       [OUT] Array{Cdouble, 1}\nnnzg:    [OUT] Array{Cint, 1}\nlg:      [IN] Array{Cint, 1}\ng_val:   [OUT] Array{Cdouble, 1}\ng_var:   [OUT] Array{Cint, 1}\ngrad:    [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.connames-Tuple{Array{Int32,1},Array{Int32,1},Array{UInt8,2}}",
    "page": "API",
    "title": "CUTEst.connames",
    "category": "method",
    "text": "connames\n\nThe connames subroutine obtains the names of the general constraints of the problem. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_connames\n\nUsage:\n\nconnames(io_err, m, cname)\n\nio_err:  [OUT] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\ncname:   [OUT] Array{UInt8, 1}\n\nTo get useful names, use String(cname[:,i]).\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.creport-Tuple{Array{Int32,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.creport",
    "category": "method",
    "text": "creport\n\nThe creport subroutine obtains statistics concerning function evaluation and CPU time used for constrained optimization in a standardized format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_creport\n\nUsage:\n\ncreport(io_err, calls, time)\n\nio_err:  [OUT] Array{Cint, 1}\ncalls:   [OUT] Array{Cdouble, 1}\ntime:    [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.csetup-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.csetup",
    "category": "method",
    "text": "csetup\n\nThe csetup subroutine sets up the correct data structures for subsequent computations on the problem decoded from a SIF file by the script sifdecoder. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_csetup\n\nUsage:\n\ncsetup(io_err, input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn,\n\nlinear, eorder, lorder, v_order)\n\nio_err:    [OUT] Array{Cint, 1}\ninput:     [IN] Array{Cint, 1}\nout:       [IN] Array{Cint, 1}\nio_buffer: [IN] Array{Cint, 1}\nn:         [IN] Array{Cint, 1}\nm:         [IN] Array{Cint, 1}\nx:         [OUT] Array{Cdouble, 1}\nx_l:       [OUT] Array{Cdouble, 1}\nx_u:       [OUT] Array{Cdouble, 1}\ny:         [OUT] Array{Cdouble, 1}\nc_l:       [OUT] Array{Cdouble, 1}\nc_u:       [OUT] Array{Cdouble, 1}\nequatn:    [OUT] Array{Cint, 1}\nlinear:    [OUT] Array{Cint, 1}\ne_order:   [IN] Array{Cint, 1}\nl_order:   [IN] Array{Cint, 1}\nv_order:   [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.csgr-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.csgr",
    "category": "method",
    "text": "csgr\n\nThe csgr subroutine evaluates the gradients of the general constraints and of either the objective function or the Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). It also evaluates the Hessian matrix of the Lagrangian function at (x,y). The gradients are stored in a sparse format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_csgr\n\nUsage:\n\ncsgr(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\ngrlagf:  [IN] Array{Cint, 1}\nnnzj:    [OUT] Array{Cint, 1}\nlj:      [IN] Array{Cint, 1}\nj_val:   [OUT] Array{Cdouble, 1}\nj_var:   [OUT] Array{Cint, 1}\nj_fun:   [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.csgreh-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.csgreh",
    "category": "method",
    "text": "csgreh\n\nThe csgreh subroutine evaluates both the gradients of the general constraint functions and the Hessian matrix of the Lagrangian function l(x,y)=f(x)+yTc(x) for the problem decoded into OUTSDIF.d at the point (x,y)= (X,Y). This Hessian matrix is stored as a sparse matrix in finite element format H=eΣ1He, where each square symmetric element He involves a small subset of the rows of the Hessian matrix. The subroutine also obtains the gradient of either the objective function or the Lagrangian function, stored in a sparse format. The problem under consideration consists in minimizing (or maximizing) an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_csgreh\n\nUsage:\n\ncsgreh(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, ne,\n\nlheptr, herowptr, hevalptr, lherow, herow, lheval, he_val, byrows)\n\nio_err:     [OUT] Array{Cint, 1}\nn:          [IN] Array{Cint, 1}\nm:          [IN] Array{Cint, 1}\nx:          [IN] Array{Cdouble, 1}\ny:          [IN] Array{Cdouble, 1}\ngrlagf:     [IN] Array{Cint, 1}\nnnzj:       [OUT] Array{Cint, 1}\nlj:         [IN] Array{Cint, 1}\nj_val:      [OUT] Array{Cdouble, 1}\nj_var:      [OUT] Array{Cint, 1}\nj_fun:      [OUT] Array{Cint, 1}\nne:         [OUT] Array{Cint, 1}\nlhe_ptr:    [IN] Array{Cint, 1}\nherowptr: [OUT] Array{Cint, 1}\nhevalptr: [OUT] Array{Cint, 1}\nlhe_row:    [IN] Array{Cint, 1}\nhe_row:     [OUT] Array{Cint, 1}\nlhe_val:    [IN] Array{Cint, 1}\nhe_val:     [OUT] Array{Cdouble, 1}\nbyrows:     [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.csgrp-NTuple{6,Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.csgrp",
    "category": "method",
    "text": "csgrp\n\nThe csgrp subroutine evaluates sparsity pattern used when storing the gradients of the general constraints and of either the objective function or the Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from a SIF file by the script sifdecoder.\n\nFor more information, run the shell command\n\nman cutest_csgrp\n\nUsage:\n\ncsgrp(io_err, n, nnzj, lj, j_var, j_fun)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nnnzj:       [OUT] Array{Cint, 1}\nlj:         [IN] Array{Cint, 1}\nj_var:      [OUT] Array{Cint, 1}\nj_fun:      [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.csgrsh-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.csgrsh",
    "category": "method",
    "text": "csgrsh\n\nThe csgrsh subroutine evaluates the gradients of the general constraints, the Hessian matrix of the Lagrangian function l(x,y)=f(x)+yTc(x) and the gradient of either the objective function or the Lagrangian corresponding to the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The data is stored in sparse format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_csgrsh\n\nUsage:\n\ncsgrsh(io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, nnzh, lh,\n\nhval, hrow, h_col)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\ngrlagf:  [IN] Array{Cint, 1}\nnnzj:    [OUT] Array{Cint, 1}\nlj:      [IN] Array{Cint, 1}\nj_val:   [OUT] Array{Cdouble, 1}\nj_var:   [OUT] Array{Cint, 1}\nj_fun:   [OUT] Array{Cint, 1}\nnnzh:    [OUT] Array{Cint, 1}\nlh:      [IN] Array{Cint, 1}\nh_val:   [OUT] Array{Cdouble, 1}\nh_row:   [OUT] Array{Cint, 1}\nh_col:   [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.csgrshp-NTuple{10,Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.csgrshp",
    "category": "method",
    "text": "csgrshp\n\nThe csgrshp subroutine evaluates sparsity pattern used when storing the gradients of the general constraints and of either the objective function or the Lagrangian function l(x,y)=f(x)+yTc(x), as well as the Hessian of the Lagrangian function, corresponding to the problem decoded from a SIF file by the script sifdecoder.\n\nFor more information, run the shell command\n\nman cutest_csgrshp\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nnnzj:    [OUT] Array{Cint, 1};\nlj:      [IN] Array{Cint, 1}\nj_var:   [OUT] Array{Cint, 1}\nj_fun:   [OUT] Array{Cint, 1}\nnnzh:    [OUT] Array{Cint, 1}\nlh:      [IN] Array{Cint, 1}\nh_row:   [OUT] Array{Cint, 1}\nh_col:   [OUT] Array{Cint, 1};\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.csh-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.csh",
    "category": "method",
    "text": "csh\n\nThe csh subroutine evaluates the Hessian of the Lagrangian function l(x,y)=f(x)+yTc(x) for the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The matrix is stored in sparse format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_csh\n\nUsage:\n\ncsh(io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\nnnzh:    [OUT] Array{Cint, 1}\nlh:      [IN] Array{Cint, 1}\nh_val:   [OUT] Array{Cdouble, 1}\nh_row:   [OUT] Array{Cint, 1}\nh_col:   [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cshc-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cshc",
    "category": "method",
    "text": "cshc\n\nThe cshc subroutine evaluates the Hessian matrix of the constraint part of the Lagrangian function yTc(x) for the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The matrix is stored in sparse format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cshc\n\nUsage:\n\ncshc(io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nm:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ny:       [IN] Array{Cdouble, 1}\nnnzh:    [OUT] Array{Cint, 1}\nlh:      [IN] Array{Cint, 1}\nh_val:   [OUT] Array{Cdouble, 1}\nh_row:   [OUT] Array{Cint, 1}\nh_col:   [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cshcprod-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.cshcprod",
    "category": "method",
    "text": "cshcprod\n\nThe cshcprod subroutine forms the product of a sparse vector with the Hessian matrix of the constraint part of the Lagrangian function yTc(x) corresponding to the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cshcprod\n\nUsage:\n\ncshcprod(io_err, n, m, goth, x, y, nnz_vector, index_nz_vector, vector,\n\nnnzresult, indexnz_result, result)\n\nio_err:          [OUT] Array{Cint, 1}\nn:               [IN] Array{Cint, 1}\nm:               [IN] Array{Cint, 1}\ngoth:            [IN] Array{Cint, 1}\nx:               [IN] Array{Cdouble, 1}\ny:               [IN] Array{Cdouble, 1}\nnnz_vector:      [IN] Array{Cint, 1}\nindexnzvector: [IN] Array{Cint, 1}\nvector:          [IN] Array{Cdouble, 1}\nnnz_result:      [OUT] Array{Cint, 1}\nindexnzresult: [OUT] Array{Cint, 1}\nresult:          [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cshp-NTuple{6,Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cshp",
    "category": "method",
    "text": "cshp\n\nThe cshp subroutine evaluates the sparsity pattern of the Hessian of the Lagrangian function l(x,y)=f(x)+yTc(x) for the problem, decoded from a SIF file by the script sifdecoder, in coordinate format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cshp\n\nUsage:\n\ncshp(io_err, n, nnzh, lh, h_row, h_col)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nnnzh:    [OUT] Array{Cint, 1}\nlh:      [IN] Array{Cint, 1}\nh_row:   [OUT] Array{Cint, 1}\nh_col:   [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cshprod-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.cshprod",
    "category": "method",
    "text": "cshprod\n\nThe cshprod subroutine forms the product of a sparse vector with the Hessian matrix of the Lagrangian function l(x,y)=f(x)+yTc(x) corresponding to the problem decoded from a SIF file by the script sifdecoder at the point (x,y)= (X,Y). The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cshprod\n\nUsage:\n\ncshprod(io_err, n, m, goth, x, y, nnz_vector, index_nz_vector, vector,\n\nnnzresult, indexnz_result, result)\n\nio_err:          [OUT] Array{Cint, 1}\nn:               [IN] Array{Cint, 1}\nm:               [IN] Array{Cint, 1}\ngoth:            [IN] Array{Cint, 1}\nx:               [IN] Array{Cdouble, 1}\ny:               [IN] Array{Cdouble, 1}\nnnz_vector:      [IN] Array{Cint, 1}\nindexnzvector: [IN] Array{Cint, 1}\nvector:          [IN] Array{Cdouble, 1}\nnnz_result:      [OUT] Array{Cint, 1}\nindexnzresult: [OUT] Array{Cint, 1}\nresult:          [OUT] Array{Cdouble, 1}\n\nNotice that vector and result should have allocated dimension of n.\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.csjprod-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.csjprod",
    "category": "method",
    "text": "csjprod\n\nThe csjprod subroutine forms the product of a sparse vector with the Jacobian matrix, or with its transpose, of the constraint functions of the problem decoded from a SIF file by the script sifdecoder evaluated at the point X. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_csjprod\n\nUsage:\n\ncsjprod(io_err, n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector,\n\nlvector, nnzresult, indexnz_result, result, lresult)\n\nio_err:          [OUT] Array{Cint, 1}\nn:               [IN] Array{Cint, 1}\nm:               [IN] Array{Cint, 1}\ngotj:            [IN] Array{Cint, 1}\njtrans:          [IN] Array{Cint, 1}\nx:               [IN] Array{Cdouble, 1}\nnnz_vector:      [IN] Array{Cint, 1}\nindexnzvector: [IN] Array{Cint, 1}\nvector:          [IN] Array{Cdouble, 1}\nlvector:         [IN] Array{Cint, 1}\nnnz_result:      [OUT] Array{Cint, 1}\nindexnzresult: [OUT] Array{Cint, 1}\nresult:          [OUT] Array{Cdouble, 1}\nlresult:         [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cstats-NTuple{5,Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cstats",
    "category": "method",
    "text": "cstats\n\ncstats(io_err, nonlinear_variables_objective,\n\nnonlinearvariablesconstraints, equalityconstraints, linearconstraints)\n\nio_err:                          [OUT] Array{Cint, 1}\nnonlinearvariablesobjective:   [OUT] Array{Cint, 1}\nnonlinearvariablesconstraints: [OUT] Array{Cint, 1}\nequality_constraints:            [OUT] Array{Cint, 1}\nlinear_constraints:              [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cterminate-Tuple{Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cterminate",
    "category": "method",
    "text": "cterminate\n\nThe uterminate subroutine deallocates all workspace arrays created since the last call to csetup.\n\nFor more information, run the shell command\n\nman cutest_cterminate\n\nUsage:\n\ncterminate(io_err)\n\nio_err:  [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.cvartype-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.cvartype",
    "category": "method",
    "text": "cvartype\n\nThe cvartype subroutine determines the type (continuous, 0-1, integer) of each variable involved in the problem decoded from a SIF file by the script sifdecoder. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_cvartype\n\nUsage:\n\ncvartype(io_err, n, x_type)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx_type:  [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.pname-Tuple{Array{Int32,1},Array{Int32,1},Array{UInt8,1}}",
    "page": "API",
    "title": "CUTEst.pname",
    "category": "method",
    "text": "pname\n\nThe pname subroutine obtains the name of the problem directly from the datafile OUTSDIF.d that was created by the script sifdecoder when decoding a SIF file. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_pname\n\nUsage:\n\npname(io_err, input, pname)\n\nio_err:  [OUT] Array{Cint, 1}\ninput:   [IN] Array{Cint, 1}\npname:   [OUT] Array{UInt8, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.probname-Tuple{Array{Int32,1},Array{UInt8,1}}",
    "page": "API",
    "title": "CUTEst.probname",
    "category": "method",
    "text": "probname\n\nThe probname subroutine obtains the name of the problem. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_probname\n\nUsage:\n\nprobname(io_err, pname)\n\nio_err:  [OUT] Array{Cint, 1}\npname:   [OUT] Array{UInt8, 1}\n\nTo get a useful name, use String(pname).\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ubandh-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Float64,2},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ubandh",
    "category": "method",
    "text": "ubandh\n\nThe ubandh subroutine extracts the elements which lie within a band of given semi-bandwidth out of the Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group- partially separable.\n\nFor more information, run the shell command\n\nman cutest_ubandh\n\nUsage:\n\nubandh(io_err, n, x, semibandwidth, h_band, lbandh, max_semibandwidth)\n\nio_err:            [OUT] Array{Cint, 1}\nn:                 [IN] Array{Cint, 1}\nx:                 [IN] Array{Cdouble, 1}\nsemibandwidth:     [IN] Array{Cint, 1}\nh_band:            [OUT] Array{Cdouble, 2}\nlbandh:            [IN] Array{Cint, 1}\nmax_semibandwidth: [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.udh-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Float64,2}}",
    "page": "API",
    "title": "CUTEst.udh",
    "category": "method",
    "text": "udh\n\nThe udh subroutine evaluates the Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. This Hessian matrix is stored as a dense matrix. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_udh\n\nUsage:\n\nudh(io_err, n, x, lh1, h)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nlh1:     [IN] Array{Cint, 1}\nh:       [OUT] Array{Cdouble, 2}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.udimen-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.udimen",
    "category": "method",
    "text": "udimen\n\nThe udimen subroutine discovers how many variables are involved in the problem decoded from a SIF file by the script sifdecoder. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_udimen\n\nUsage:\n\nudimen(io_err, input, n)\n\nio_err:  [OUT] Array{Cint, 1}\ninput:   [IN] Array{Cint, 1}\nn:       [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.udimse-NTuple{4,Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.udimse",
    "category": "method",
    "text": "udimse\n\nThe udimse subroutine determine the number of nonzeros required to store the Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. This Hessian matrix is stored as a sparse matrix in finite element format H=eΣ1He, where each square symmetric element H_i involves a small subset of the rows of the Hessian matrix. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_udimse\n\nUsage:\n\nudimse(io_err, ne, he_val_ne, he_row_ne)\n\nio_err:    [OUT] Array{Cint, 1}\nne:        [OUT] Array{Cint, 1}\nhevalne: [OUT] Array{Cint, 1}\nherowne: [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.udimsh-Tuple{Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.udimsh",
    "category": "method",
    "text": "udimsh\n\nThe udimsh subroutine determine the number of nonzeros required to store the Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. This Hessian matrix is stored as a sparse matrix in coordinate format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_udimsh\n\nUsage:\n\nudimsh(io_err, nnzh)\n\nio_err:  [OUT] Array{Cint, 1}\nnnzh:    [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ueh-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ueh",
    "category": "method",
    "text": "ueh\n\nThe ueh subroutine evaluates the Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. This Hessian matrix is stored as a sparse matrix in finite element format H=eΣ1He, where each square symmetric element He involves a small subset of the rows of the Hessian matrix. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_ueh\n\nUsage:\n\nueh(io_err, n, x, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,\n\nlheval, heval, byrows)\n\nio_err:     [OUT] Array{Cint, 1}\nn:          [IN] Array{Cint, 1}\nx:          [IN] Array{Cdouble, 1}\nne:         [OUT] Array{Cint, 1}\nlhe_ptr:    [IN] Array{Cint, 1}\nherowptr: [OUT] Array{Cint, 1}\nhevalptr: [OUT] Array{Cint, 1}\nlhe_row:    [IN] Array{Cint, 1}\nhe_row:     [OUT] Array{Cint, 1}\nlhe_val:    [IN] Array{Cint, 1}\nhe_val:     [OUT] Array{Cdouble, 1}\nbyrows:     [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ufn-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.ufn",
    "category": "method",
    "text": "ufn\n\nThe ufn subroutine evaluates the value of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_ufn\n\nUsage:\n\nufn(io_err, n, x, f)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nf:       [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ugr-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.ugr",
    "category": "method",
    "text": "ugr\n\nThe ugr subroutine evaluates the gradient of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_ugr\n\nUsage:\n\nugr(io_err, n, x, g)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ng:       [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ugrdh-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Float64,2}}",
    "page": "API",
    "title": "CUTEst.ugrdh",
    "category": "method",
    "text": "ugrdh\n\nThe ugrdh subroutine evaluates the gradient and Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. This Hessian matrix is stored as a dense matrix. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_ugrdh\n\nUsage:\n\nugrdh(io_err, n, x, g, lh1, h)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ng:       [OUT] Array{Cdouble, 1}\nlh1:     [IN] Array{Cint, 1}\nh:       [OUT] Array{Cdouble, 2}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ugreh-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ugreh",
    "category": "method",
    "text": "ugreh\n\nThe ugreh subroutine evaluates the gradient and Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. This Hessian matrix is stored as a sparse matrix in finite element format H=eΣ1He, where each square symmetric element H sub e involves a small subset of the rows of the Hessian matrix. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_ugreh\n\nUsage:\n\nugreh(io_err, n, x, g, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,\n\nlheval, heval, byrows)\n\nio_err:     [OUT] Array{Cint, 1}\nn:          [IN] Array{Cint, 1}\nx:          [IN] Array{Cdouble, 1}\ng:          [OUT] Array{Cdouble, 1}\nne:         [OUT] Array{Cint, 1}\nlhe_ptr:    [IN] Array{Cint, 1}\nherowptr: [OUT] Array{Cint, 1}\nhevalptr: [OUT] Array{Cint, 1}\nlhe_row:    [IN] Array{Cint, 1}\nhe_row:     [OUT] Array{Cint, 1}\nlhe_val:    [IN] Array{Cint, 1}\nhe_val:     [OUT] Array{Cdouble, 1}\nbyrows:     [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ugrsh-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ugrsh",
    "category": "method",
    "text": "ugrsh\n\nThe ugrsh subroutine evaluates the gradient and Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. This Hessian matrix is stored as a sparse matrix in coordinate format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group- partially separable.\n\nFor more information, run the shell command\n\nman cutest_ugrsh\n\nUsage:\n\nugrsh(io_err, n, x, g, nnzh, lh, h_val, h_row, h_col)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\ng:       [OUT] Array{Cdouble, 1}\nnnzh:    [OUT] Array{Cint, 1}\nlh:      [IN] Array{Cint, 1}\nh_val:   [OUT] Array{Cdouble, 1}\nh_row:   [OUT] Array{Cint, 1}\nh_col:   [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.uhprod-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.uhprod",
    "category": "method",
    "text": "uhprod\n\nThe uhprod subroutine forms the product of a vector with the Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_uhprod\n\nUsage:\n\nuhprod(io_err, n, goth, x, vector, result)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\ngoth:    [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nvector:  [IN] Array{Cdouble, 1}\nresult:  [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.unames-Tuple{Array{Int32,1},Array{Int32,1},Array{UInt8,1},Array{UInt8,2}}",
    "page": "API",
    "title": "CUTEst.unames",
    "category": "method",
    "text": "unames\n\nThe unames subroutine obtains the names of the problem and its variables. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_unames\n\nUsage:\n\nunames(io_err, n, pname, vname)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\npname:   [OUT] Array{UInt8, 1}\nvname:   [OUT] Array{UInt8, 1}\n\nTo get useful names, use String(x) where x can be pname or vname[:,i].\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.uofg-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Float64,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.uofg",
    "category": "method",
    "text": "uofg\n\nThe uofg subroutine evaluates the value of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X, and possibly its gradient. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group- partially separable.\n\nFor more information, run the shell command\n\nman cutest_uofg\n\nUsage:\n\nuofg(io_err, n, x, f, g, grad)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nf:       [OUT] Array{Cdouble, 1}\ng:       [OUT] Array{Cdouble, 1}\ngrad:    [IN] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ureport-Tuple{Array{Int32,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.ureport",
    "category": "method",
    "text": "ureport\n\nThe ureport subroutine obtains statistics concerning function evaluation and CPU time used for unconstrained or bound-constrained optimization in a standardized format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group- partially separable.\n\nFor more information, run the shell command\n\nman cutest_ureport\n\nUsage:\n\nureport(io_err, calls, time)\n\nio_err:  [OUT] Array{Cint, 1}\ncalls:   [OUT] Array{Cdouble, 1}\ntime:    [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.usetup-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Float64,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.usetup",
    "category": "method",
    "text": "usetup\n\nThe usetup subroutine sets up the correct data structures for subsequent computations in the case where the only possible constraints are bound constraints. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group- partially separable.\n\nFor more information, run the shell command\n\nman cutest_usetup\n\nUsage:\n\nusetup(io_err, input, out, io_buffer, n, x, x_l, x_u)\n\nio_err:    [OUT] Array{Cint, 1}\ninput:     [IN] Array{Cint, 1}\nout:       [IN] Array{Cint, 1}\nio_buffer: [IN] Array{Cint, 1}\nn:         [IN] Array{Cint, 1}\nx:         [OUT] Array{Cdouble, 1}\nx_l:       [OUT] Array{Cdouble, 1}\nx_u:       [OUT] Array{Cdouble, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ush-Tuple{Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ush",
    "category": "method",
    "text": "ush\n\nThe ush subroutine evaluates the Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. This Hessian matrix is stored as a sparse matrix in coordinate format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group- partially separable.\n\nFor more information, run the shell command\n\nman cutest_ush\n\nUsage:\n\nush(io_err, n, x, nnzh, lh, h_val, h_row, h_col)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx:       [IN] Array{Cdouble, 1}\nnnzh:    [OUT] Array{Cint, 1}\nlh:      [IN] Array{Cint, 1}\nh_val:   [OUT] Array{Cdouble, 1}\nh_row:   [OUT] Array{Cint, 1}\nh_col:   [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ushp-NTuple{6,Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.ushp",
    "category": "method",
    "text": "ushp\n\nThe ushp subroutine evaluates the sparsity pattern of the Hessian matrix of the objective function of the problem, decoded from a SIF file by the script sifdecoder, in coordinate format. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_ushp\n\nUsage:\n\nushp(io_err, n, nnzh, lh, h_row, h_col)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nnnzh:    [OUT] Array{Cint, 1}\nlh:      [IN] Array{Cint, 1}\nh_row:   [OUT] Array{Cint, 1}\nh_col:   [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.ushprod-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1},Array{Int32,1},Array{Int32,1},Array{Float64,1}}",
    "page": "API",
    "title": "CUTEst.ushprod",
    "category": "method",
    "text": "ushprod\n\nThe ushprod subroutine forms the product of a sparse vector with the Hessian matrix of the objective function of the problem decoded from a SIF file by the script sifdecoder at the point X. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_ushprod\n\nUsage:\n\nushprod(io_err, n, goth, x, nnz_vector, index_nz_vector, vector, nnz_result,\n\nindexnzresult, result)\n\nio_err:          [OUT] Array{Cint, 1}\nn:               [IN] Array{Cint, 1}\ngoth:            [IN] Array{Cint, 1}\nx:               [IN] Array{Cdouble, 1}\nnnz_vector:      [IN] Array{Cint, 1}\nindexnzvector: [IN] Array{Cint, 1}\nvector:          [IN] Array{Cdouble, 1}\nnnz_result:      [OUT] Array{Cint, 1}\nindexnzresult: [OUT] Array{Cint, 1}\nresult:          [OUT] Array{Cdouble, 1}\n\nNotice that vector and result should have allocated dimension of n.\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.uterminate-Tuple{Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.uterminate",
    "category": "method",
    "text": "uterminate\n\nThe uterminate subroutine deallocates all workspace arrays created since the last call to usetup.\n\nFor more information, run the shell command\n\nman cutest_uterminate\n\nUsage:\n\nuterminate(io_err)\n\nio_err:  [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.uvartype-Tuple{Array{Int32,1},Array{Int32,1},Array{Int32,1}}",
    "page": "API",
    "title": "CUTEst.uvartype",
    "category": "method",
    "text": "uvartype\n\nThe uvartype subroutine determines the type (continuous, 0-1, integer) of each variable involved in the problem decoded from a SIF file by the script sifdecoder. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to the simple bounds xl≤x≤xu. The objective function is group-partially separable.\n\nFor more information, run the shell command\n\nman cutest_uvartype\n\nUsage:\n\nuvartype(io_err, n, x_type)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nx_type:  [OUT] Array{Cint, 1}\n\n\n\n\n\n"
},

{
    "location": "api/#CUTEst.varnames-Tuple{Array{Int32,1},Array{Int32,1},Array{UInt8,2}}",
    "page": "API",
    "title": "CUTEst.varnames",
    "category": "method",
    "text": "varnames\n\nThe varnames subroutine obtains the names of the problem variables. The problem under consideration is to minimize or maximize an objective function f(x) over all x ∈ Rn subject to general equations ci(x)=0, (i ∈ 1,...,mE), general inequalities ci(x)≤ci(x)≤ci(x), (i ∈ mE+1,...,m), and simple bounds xl≤x≤xu. The objective function is group-partially separable and all constraint functions are partially separable.\n\nFor more information, run the shell command\n\nman cutest_varnames\n\nUsage:\n\nvarnames(io_err, n, vname)\n\nio_err:  [OUT] Array{Cint, 1}\nn:       [IN] Array{Cint, 1}\nvname:   [OUT] Array{UInt8, 1}\n\nTo get useful names, use String(vname[:, i]).\n\n\n\n\n\n"
},

{
    "location": "api/#Core-API-1",
    "page": "API",
    "title": "Core API",
    "category": "section",
    "text": "Modules = [CUTEst]\nPages   = [\"core_interface.jl\"]\nOrder   = [:function]"
},

{
    "location": "api/#CUTEst.sifdecoder-Tuple{String,Vararg{Any,N} where N}",
    "page": "API",
    "title": "CUTEst.sifdecoder",
    "category": "method",
    "text": "Decode problem and build shared library.\n\nOptional arguments are passed directly to the SIF decoder. Example:     sifdecoder(\"DIXMAANJ\", \"-param\", \"M=30\").\n\n\n\n\n\n"
},

{
    "location": "api/#Internal-1",
    "page": "API",
    "title": "Internal",
    "category": "section",
    "text": "Modules = [CUTEst]\nPages   = [\"CUTEst.jl\"]\nOrder   = [:function]"
},

{
    "location": "core/#",
    "page": "Core",
    "title": "Core",
    "category": "page",
    "text": ""
},

{
    "location": "core/#Working-with-CUTEst-directly-1",
    "page": "Core",
    "title": "Working with CUTEst directly",
    "category": "section",
    "text": "When working with CUTEst, we created a core interface, which is essentially a wrapper for the CUTEst functions. You probably don\'t want to use that, because the NLPModels interface is much more friendlier, as just as useful. See its tutorial.CUTEst in Fortran defines functions called with cutest_u* or cutest_c*, for the unconstrained and constrained cases, respectively. For each of those, we dropped the cutest_, so the functions cutest_ufn and cutest_cfn are available as ufn and cfn. To use then you have to convert the types using Cint and Cdouble, and pass arrays because of the underlying pointers in Fortran. In practice, there isn\'t much improvement in calling these or ccalls, except for the use of the internal cutest_lib.Only use these functions if you really know what you\'re doing.If you want to use these functions, you should still decode the problem as an NLP, by doingnlp = CUTEstModel(\"PROBLEM\")\n...\nfinalize(nlp)Otherwise you\'ll have to manage the CUTEst library, the decoding, the file unit numbers, OUTSDIF.d, setup, etc."
},

{
    "location": "reference/#",
    "page": "Reference",
    "title": "Reference",
    "category": "page",
    "text": ""
},

{
    "location": "reference/#Reference-1",
    "page": "Reference",
    "title": "Reference",
    "category": "section",
    "text": ""
},

]}
