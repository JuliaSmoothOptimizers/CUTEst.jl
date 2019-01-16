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

@testset "CUTEst selection tool" begin
  problems = filter(x->occursin(r"SIF$",x), readdir(ENV["MASTSIF"]))
  np = length(problems)
  @test np == length(CUTEst.select())
  @testset "Variables" begin
    selection = CUTEst.select(max_var=10)
    n = length(selection)
    @test small_problem in selection
    @test !(large_problem in selection)
    selection = CUTEst.select(min_var=11)
    @test !(small_problem in selection)
    @test large_problem in selection
    @test np == n + length(selection)
    selection = CUTEst.select(only_free_var=true)
    @test free_problem in selection
    @test !(bnd_problem in selection)
    selection = CUTEst.select(only_bnd_var=true)
    @test !(free_problem in selection)
    @test bnd_problem in selection
  end

  @testset "Constraints" begin
    selection = CUTEst.select(max_con = 0)
    n = length(selection)
    @test unc_problem in selection
    @test !(con_problem in selection)
    @test !(equ_problem in selection)
    @test !(ineq_problem in selection)
    selection = CUTEst.select(min_con = 1)
    @test !(unc_problem in selection)
    @test con_problem in selection
    @test equ_problem in selection
    @test ineq_problem in selection
    @test np == n + length(selection)

    selection = CUTEst.select(only_equ_con=true)
    @test equ_problem in selection
    @test !(ineq_problem in selection)
    selection = CUTEst.select(only_ineq_con=true)
    @test !(equ_problem in selection)
    @test ineq_problem in selection

    selection = CUTEst.select(only_linear_con=true)
    @test lin_problem in selection
    @test !(nln_problem in selection)
    selection = CUTEst.select(only_nonlinear_con=true)
    @test !(lin_problem in selection)
    @test nln_problem in selection
  end

  @testset "Objective function types" begin
    n = length(CUTEst.objtypes)
    npi = 0
    for i = 1:n
      selection = CUTEst.select(objtype=i)
      npi += length(selection)
      @test objtypes_problems[i] in selection
      for j = setdiff(1:n, i)
        @test !(objtypes_problems[j] in selection)
      end
      selection_alt = CUTEst.select(objtype=CUTEst.objtypes[i])
      @test sort(selection_alt) == sort(selection)
      selection_alt = CUTEst.select(objtype=Symbol(CUTEst.objtypes[i]))
      @test sort(selection_alt) == sort(selection)
    end
    @test npi == np
    for i = 1:n-1
      for subset in combinations(1:n, i)
        selection = CUTEst.select(objtype=subset)
        for j in subset
          @test objtypes_problems[j] in selection
        end
        for j in setdiff(1:n, subset)
          @test !(objtypes_problems[j] in selection)
        end
      end
    end
  end

  @testset "Constraints types" begin
    n = length(CUTEst.contypes)
    npi = 0
    for i = 1:n
      selection = CUTEst.select(contype=i)
      npi += length(selection)
      @test contypes_problems[i] in selection
      for j = setdiff(1:n, i)
        @test !(contypes_problems[j] in selection)
      end
      selection_alt = CUTEst.select(contype=CUTEst.contypes[i])
      @test sort(selection_alt) == sort(selection)
      selection_alt = CUTEst.select(contype=Symbol(CUTEst.contypes[i]))
      @test sort(selection_alt) == sort(selection)
    end
    @test npi == np
    for i = 1:n-1
      for subset in combinations(1:n, i)
        selection = CUTEst.select(contype=subset)
        for j in subset
          @test contypes_problems[j] in selection
        end
        for j in setdiff(1:n, subset)
          @test !(contypes_problems[j] in selection)
        end
      end
    end
  end

  @testset "Consistency" begin
    set1 = CUTEst.select(contype=["unc"])
    set2 = CUTEst.select(max_con=0, only_free_var=true)
    @test sort(set1) == sort(set2)

    set1 = CUTEst.select(contype=["fixed_vars"])
    set2 = CUTEst.select(max_con=0, custom_filter=x ->(
      x["variables"]["fixed"] > 0) && (x["variables"]["fixed"] +
      x["variables"]["free"] == x["variables"]["number"]))
    @test sort(set1) == sort(set2)

    set1 = CUTEst.select(contype=["unc", "fixed_vars", "bounds"])
    set2 = CUTEst.select(max_con=0)
    @test sort(set1) == sort(set2)

    set1 = CUTEst.select(contype=["linear"])
    set2 = CUTEst.select(min_con=1, only_linear_con=true)
    println("Mastsif says L, but decoding gives otherwise")
    println(setdiff(set1, set2))
    println("Decoding gives linear, but Mastsif disagrees")
    println(setdiff(set2, set1))
    #@test sort(set1) == sort(set2)
  end

  @testset "Canonicalization" begin
    set1 = CUTEst.select(objtype=1:4)
    @test !(isempty(set1))
  end

end
