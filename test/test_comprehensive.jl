using CUTEst
using BenchmarkTools
using LinearAlgebra
using NLPModels

# Test with an unconstrained problem first
println("Testing with unconstrained problem (ROSENBR):")
nlp1 = CUTEstModel{Float64}("ROSENBR")
x0 = nlp1.meta.x0

println("Problem loaded: $(nlp1.meta.name) ($(nlp1.meta.nvar) vars, $(nlp1.meta.ncon) cons)")
vals_h = Vector{Float64}(undef, nlp1.meta.nnzh)
hess_coord!(nlp1, x0, vals_h)

b_hess = @benchmark hess_coord!($nlp1, $x0, $vals_h) samples=100 evals=5
println("hess_coord!: $(b_hess.allocs) allocations, $(BenchmarkTools.prettytime(median(b_hess).time))")

finalize(nlp1)

# Test with a constrained problem
println("\nTesting with constrained problem (HS6):")
nlp2 = CUTEstModel{Float64}("HS6")
x0 = nlp2.meta.x0

println("Problem loaded: $(nlp2.meta.name) ($(nlp2.meta.nvar) vars, $(nlp2.meta.ncon) cons)")
println("nnzj: $(nlp2.meta.nnzj), nnzh: $(nlp2.meta.nnzh)")

# Test basic functionality
f = obj(nlp2, x0)
g = similar(x0)
grad!(nlp2, x0, g)
println("obj/grad: f = $(round(f, digits=6)), ||g|| = $(round(norm(g), digits=6))")

# Test constraint functions
c = Vector{Float64}(undef, nlp2.meta.ncon)
cons!(nlp2, x0, c)
println("constraints: ||c|| = $(round(norm(c), digits=6))")

# Test cons_coord - this should show major allocation improvements
println("\nTesting cons_coord allocation improvements:")
c1, rows1, cols1, vals1 = cons_coord(nlp2, x0)

# Benchmark cons_coord
b_cons = @benchmark cons_coord($nlp2, $x0) samples=100 evals=5
println("cons_coord: $(b_cons.allocs) allocations, $(BenchmarkTools.prettytime(median(b_cons).time))")
println("Memory: $(BenchmarkTools.prettymemory(median(b_cons).memory))")
println("Returned $(length(vals1)) Jacobian elements")

# Test cons_coord! 
rows = Vector{Cint}(undef, nlp2.meta.nnzj)
cols = Vector{Cint}(undef, nlp2.meta.nnzj)
vals = Vector{Float64}(undef, nlp2.meta.nnzj)
c_out = Vector{Float64}(undef, nlp2.meta.ncon)

b_cons_inplace = @benchmark cons_coord!($nlp2, $x0, $c_out, $rows, $cols, $vals) samples=100 evals=5
println("cons_coord!: $(b_cons_inplace.allocs) allocations, $(BenchmarkTools.prettytime(median(b_cons_inplace).time))")

# Test type conversion
println("\nTesting type conversion improvements:")
x0_f32 = Float32.(x0)
g_f32 = Vector{Float32}(undef, nlp2.meta.nvar)

b_grad_conv = @benchmark grad!($nlp2, $x0_f32, $g_f32) samples=100 evals=5
println("grad! with Float32->Float64 conversion: $(b_grad_conv.allocs) allocations")
println("Time: $(BenchmarkTools.prettytime(median(b_grad_conv).time))")

# Test hess_coord with constraints
vals_h2 = Vector{Float64}(undef, nlp2.meta.nnzh)
y = zeros(nlp2.meta.ncon)
hess_coord!(nlp2, x0, y, vals_h2)

b_hess2 = @benchmark hess_coord!($nlp2, $x0, $y, $vals_h2) samples=100 evals=5
println("hess_coord! (constrained): $(b_hess2.allocs) allocations, $(BenchmarkTools.prettytime(median(b_hess2).time))")

finalize(nlp2)
