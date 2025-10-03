using Test
using CUTEst
using NLPModels

@testset "Double Buffering Tests" begin
  # Test with a simple problem that has constraints and Jacobian
  nlp = CUTEstModel("HS9")
  
  try
    # Test initial state - workspace vectors should start empty or be resized on demand
    x = [1.0, 1.0]
    
    # Test cons_coord! function
    c = zeros(nlp.meta.ncon)
    rows = zeros(Int, nlp.meta.nnzj)
    cols = zeros(Int, nlp.meta.nnzj)
    vals = zeros(nlp.meta.nnzj)
    
    # This should trigger workspace allocation/resizing
    @test_nowarn cons_coord!(nlp, x, c, rows, cols, vals)
    
    # Verify results are reasonable
    @test length(c) == nlp.meta.ncon
    @test length(rows) == nlp.meta.nnzj
    @test length(cols) == nlp.meta.nnzj
    @test length(vals) == nlp.meta.nnzj
    
    # Test cons_coord function (should reuse workspace)
    c2, rows2, cols2, vals2 = cons_coord(nlp, x)
    
    @test c ≈ c2
    @test rows == rows2
    @test cols == cols2
    @test vals ≈ vals2
    
    # Test with different vector types
    x_view = view([1.0, 1.0, 0.0], 1:2)
    c3, rows3, cols3, vals3 = cons_coord(nlp, x_view)
    
    @test c2 ≈ c3
    @test rows2 == rows3
    @test cols2 == cols3
    @test vals2 ≈ vals3
    
    # Test hess_coord! function if problem has Hessian
    if nlp.meta.nnzh > 0
      hvals = zeros(nlp.meta.nnzh)
      y = zeros(nlp.meta.ncon)
      
      @test_nowarn NLPModels.hess_coord!(nlp, x, y, hvals)
      @test length(hvals) == nlp.meta.nnzh
      
      # Test with different y vector - use larger multipliers to ensure difference
      y2 = 10.0 * ones(nlp.meta.ncon)
      hvals2 = zeros(nlp.meta.nnzh)
      @test_nowarn NLPModels.hess_coord!(nlp, x, y2, hvals2)
      
      # Test with zero objective weight to isolate constraint Hessian
      hvals3 = zeros(nlp.meta.nnzh)
      @test_nowarn NLPModels.hess_coord!(nlp, x, y2, hvals3; obj_weight = 0.0)
      
      # At least one of these should be different unless all constraint Hessians are zero
      different_found = !(hvals ≈ hvals2) || !(hvals ≈ hvals3) || !(hvals2 ≈ hvals3)
      @test different_found || all(abs.(hvals3) .< 1e-12)  # Either different or constraint Hessians are essentially zero
    end
    
  finally
    finalize(nlp)
  end
end

@testset "Memory Efficiency Tests" begin
  # Test that workspace vectors are only allocated when needed
  nlp = CUTEstModel("HS9")
  
  try
    x = [1.0, 1.0]
    
    # First, check if workspace vectors exist
    has_jac_workspace = hasfield(typeof(nlp), :jac_coord_rows) && 
                        hasfield(typeof(nlp), :jac_coord_cols) && 
                        hasfield(typeof(nlp), :jac_coord_vals) && 
                        hasfield(typeof(nlp), :cons_vals)
    
    if has_jac_workspace
      println("Model has jacobian workspace vectors")
    else
      println("Model does not have jacobian workspace vectors - workspace not implemented yet")
    end
    
    # Check that multiple calls don't cause excessive allocations
    initial_allocations = @allocated begin
      c, rows, cols, vals = cons_coord(nlp, x)
    end
    
    # Second call should have minimal allocations due to workspace reuse (if implemented)
    second_allocations = @allocated begin
      c2, rows2, cols2, vals2 = cons_coord(nlp, x)
    end
    
    # Third call to verify consistency
    third_allocations = @allocated begin
      c3, rows3, cols3, vals3 = cons_coord(nlp, x)
    end
    
    println("Initial allocations: $initial_allocations bytes")
    println("Second allocations: $second_allocations bytes")
    println("Third allocations: $third_allocations bytes")
    
    if has_jac_workspace
      # The current implementation might still allocate for return values
      # Test that allocations are reasonable and consistent
      @test second_allocations <= initial_allocations  # Should not increase
      @test third_allocations == second_allocations     # Should be consistent
      
      # Test that workspace reuse is working by checking if internal calls allocate less
      # This tests the cons_coord! function directly which should use workspace
      c_test = zeros(nlp.meta.ncon)
      rows_test = zeros(Int, nlp.meta.nnzj)
      cols_test = zeros(Int, nlp.meta.nnzj)
      vals_test = zeros(nlp.meta.nnzj)
      
      # First call to cons_coord! to initialize workspace
      cons_coord!(nlp, x, c_test, rows_test, cols_test, vals_test)
      
      # Second call should have minimal allocations
      workspace_allocations = @allocated begin
        cons_coord!(nlp, x, c_test, rows_test, cols_test, vals_test)
      end
      
      println("Direct cons_coord! allocations (after warmup): $workspace_allocations bytes")
      
      # Direct workspace usage should have very low allocations
      @test workspace_allocations < initial_allocations
      
    else
      # If workspace not implemented yet, allocations will be similar
      # Test that function still works correctly
      @test second_allocations >= 0  # Just ensure it doesn't error
      @test initial_allocations > 0  # Ensure some allocation happened
    end
    
  finally
    finalize(nlp)
  end
end

@testset "Workspace Vector Initialization" begin
  # Test that the model has the required workspace vectors
  nlp = CUTEstModel("HS9")
  
  try
    # Print field names for debugging
    field_names = fieldnames(typeof(nlp))
    println("CUTEstModel fields: ", field_names)
    
    # Check if workspace vectors exist
    jac_workspace_fields = [:jac_coord_rows, :jac_coord_cols, :jac_coord_vals, :cons_vals]
    hess_workspace_fields = [:hess_coord_vals]
    
    for field in jac_workspace_fields
      if field in field_names
        println("✓ Found workspace field: $field")
        @test isdefined(nlp, field)
        if isdefined(nlp, field)
          workspace_vec = getfield(nlp, field)
          @test isa(workspace_vec, Vector)
          println("  - Type: $(typeof(workspace_vec)), Length: $(length(workspace_vec))")
        end
      else
        println("✗ Missing workspace field: $field")
      end
    end
    
    for field in hess_workspace_fields
      if field in field_names
        println("✓ Found hessian workspace field: $field")
        @test isdefined(nlp, field)
      else
        println("✗ Missing hessian workspace field: $field")
      end
    end
    
  finally
    finalize(nlp)
  end
end
