using NLPModelsIpopt

# exercise jac_structure!() and hess_structure!()
# and ensure jac_coord!() and hess_coord!() do not
# access the row and col index vectors
for name in ("ROSENBR", "HS6", "HS22")
  model = CUTEstModel(name)
  jac_structure!(model)
  hess_structure!(model)
  finalize(model)
  # reinitialize
  model = CUTEstModel(name)
  ipopt(model)
  finalize(model)
end
