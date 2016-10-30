using Combinatorics

small_problem = "HS4"
large_problem = "AUG3D"
unc_problem = "BARD"
con_problem = "HS51"
equ_problem = "BT1"
ineq_problem = "HS15"
lin_problem = "ANTWERP"
nln_problem = "HS99"
free_problem = "ROSENBR"
bnd_problem = "HS99"

objtypes_problems = ["CHANDHEQ", "HS8", "TRO5X5", "BT8", "HIMMELBF", "JIMACK"]
contypes_problems = ["DIXMAANI", "AIRCRFTB", "BQPGAUSS", "DALLASM", "HS54", "HANGING", "SYNTHES1"]

facts("CUTEst selection tool") do
  problems = filter(x->ismatch(r"SIF$",x), readdir(ENV["MASTSIF"]))
  np = length(problems)
  @fact np --> length(CUTEst.select())
  context("Variables") do
    selection = CUTEst.select(max_var=10)
    n = length(selection)
    @fact small_problem in selection --> true
    @fact large_problem in selection --> false
    selection = CUTEst.select(min_var=11)
    @fact small_problem in selection --> false
    @fact large_problem in selection --> true
    @fact np --> n + length(selection)
    selection = CUTEst.select(only_free_var=true)
    @fact free_problem in selection --> true
    @fact bnd_problem in selection --> false
    selection = CUTEst.select(only_bnd_var=true)
    @fact free_problem in selection --> false
    @fact bnd_problem in selection --> true
  end

  context("Constraints") do
    selection = CUTEst.select(max_con = 0)
    n = length(selection)
    @fact unc_problem in selection --> true
    @fact con_problem in selection --> false
    @fact equ_problem in selection --> false
    @fact ineq_problem in selection --> false
    selection = CUTEst.select(min_con = 1)
    @fact unc_problem in selection --> false
    @fact con_problem in selection --> true
    @fact equ_problem in selection --> true
    @fact ineq_problem in selection --> true
    @fact np --> n + length(selection)

    selection = CUTEst.select(only_equ_con=true)
    @fact equ_problem in selection --> true
    @fact ineq_problem in selection --> false
    selection = CUTEst.select(only_ineq_con=true)
    @fact equ_problem in selection --> false
    @fact ineq_problem in selection --> true

    selection = CUTEst.select(only_linear_con=true)
    @fact lin_problem in selection --> true
    @fact nln_problem in selection --> false
    selection = CUTEst.select(only_nonlinear_con=true)
    @fact lin_problem in selection --> false
    @fact nln_problem in selection --> true
  end

  context("Objective function types") do
    n = length(CUTEst.objtypes)
    npi = 0
    for i = 1:n
      selection = CUTEst.select(objtype=i)
      npi += length(selection)
      @fact objtypes_problems[i] in selection --> true
      for j = setdiff(1:n, i)
        @fact objtypes_problems[j] in selection --> false
      end
      selection_alt = CUTEst.select(objtype=CUTEst.objtypes[i])
      @fact sort(selection_alt) --> sort(selection)
      selection_alt = CUTEst.select(objtype=Symbol(CUTEst.objtypes[i]))
      @fact sort(selection_alt) --> sort(selection)
    end
    @fact npi --> np
    for i = 1:n-1
      for subset in combinations(1:n, i)
        selection = CUTEst.select(objtype=subset)
        for j in subset
          @fact objtypes_problems[j] in selection --> true
        end
        for j in setdiff(1:n, subset)
          @fact objtypes_problems[j] in selection --> false
        end
      end
    end
  end

  context("Constraints types") do
    n = length(CUTEst.contypes)
    npi = 0
    for i = 1:n
      selection = CUTEst.select(contype=i)
      npi += length(selection)
      @fact contypes_problems[i] in selection --> true
      for j = setdiff(1:n, i)
        @fact contypes_problems[j] in selection --> false
      end
      selection_alt = CUTEst.select(contype=CUTEst.contypes[i])
      @fact sort(selection_alt) --> sort(selection)
      selection_alt = CUTEst.select(contype=Symbol(CUTEst.contypes[i]))
      @fact sort(selection_alt) --> sort(selection)
    end
    @fact npi --> np
    for i = 1:n-1
      for subset in combinations(1:n, i)
        selection = CUTEst.select(contype=subset)
        for j in subset
          @fact contypes_problems[j] in selection --> true
        end
        for j in setdiff(1:n, subset)
          @fact contypes_problems[j] in selection --> false
        end
      end
    end
  end

  context("Consistency") do
    set1 = CUTEst.select(contype=["unc"])
    set2 = CUTEst.select(max_con=0, only_free_var=true)
    println("Mastsif says U but are not unc free")
    println(setdiff(set1, set2))
    println("Are unc and free but Mastsif is not U")
    println(setdiff(set2, set1))
    #@fact sort(set1) --> sort(set2)

    set1 = CUTEst.select(contype=["fixed_vars"])
    set2 = CUTEst.select(max_con=0, custom_filter=x ->(
      x["variables"]["fixed"] > 0) && (x["variables"]["fixed"] +
      x["variables"]["free"] == x["variables"]["number"]))
    println("Mastsif says X but aren't")
    println(setdiff(set1, set2))
    println("Unconstrained with some fixed variables, no bounds but not X")
    println(setdiff(set2, set1))
    #@fact sort(set1) --> sort(set2)

    set1 = CUTEst.select(contype=["unc", "fixed_vars", "bounds"])
    set2 = CUTEst.select(max_con=0)
    println("Mastsif says U, X or B, but are not unconstrained")
    println(setdiff(set1, set2))
    println("Unconstrained problems, but not U, X or B")
    println(setdiff(set2, set1))
    #@fact sort(set1) --> sort(set2)

    set1 = CUTEst.select(contype=["linear"])
    set2 = CUTEst.select(min_con=1, only_linear_con=true)
    println("Mastsif says L, but decoding gives otherwise")
    println(setdiff(set1, set2))
    println("Decoding gives linear, but Mastsif disagrees")
    println(setdiff(set2, set1))
    #@fact sort(set1) --> sort(set2)
  end
end

FactCheck.exitstatus()
