export objcons, objgrad, obj, cons_coord, cons, hess_coord, hess, hprod, hprod!

function objcons(nlp :: CUTEstModel, x :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  io_err = Cint[0];
  f = Cdouble[0];
  c = Array(Float64, ncon);
  if ncon > 0
    @eval ccall((:cutest_cfn_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 $(io_err),  &$(nvar),   &$(ncon),   $(x),         $(f),         $(c));
  else
    @eval ccall((:cutest_ufn_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}),
                 $(io_err),  $(nvar),    $(x),         $(f));
  end
  @cutest_error

  return ncon > 0 ? (f[1], c) : f[1];
end


function objgrad(nlp :: CUTEstModel, x :: Array{Float64,1}, grad :: Bool)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  f = Cdouble[0];
  io_err = Cint[0];
  if grad
    g = Array(Float64, nvar);
    get_grad = 1;
  else
    g = Array(Float64, 0);
    get_grad = 0;
  end
  cutest_fcn = ncon > 0 ? "cutest_cofg_" : "cutest_uofg_";  # How do you do this with symbols?
  @eval ccall(($(cutest_fcn), $(nlp.libname)), Void,
            (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
             $(io_err),  &$(nvar),   $(x),         $(f),         $(g),         &$(get_grad));
  @cutest_error

  return grad ? (f[1], g) : f[1];
end

obj(nlp :: CUTEstModel, x :: Array{Float64,1}) = objgrad(nlp, x, false);


function cons_coord(nlp :: CUTEstModel, x :: Array{Float64,1}, grad :: Bool)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzj = nlp.meta.nnzj;
  io_err = Cint[0];
  c = Array(Float64, ncon);
  jsize = grad ? nlp.meta.nnzj : 0;
  get_j = grad ? 1 : 0;
  jval = Array(Float64, jsize);
  jrow = Array(Int32, jsize);
  jcol = Array(Int32, jsize);

  @eval ccall((:cutest_ccfsg_, $(nlp.libname)), Void,
              (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
               $(io_err),  &$(nvar),   &$(ncon),   $(x),         $(c),         &$(nnzj),   &$(jsize),  $(jval),      $(jcol),    $(jrow),    &$(get_j));
  @cutest_error

  return grad ? (c, jrow, jcol, jval) : c;
end

function cons(nlp :: CUTEstModel, x :: Array{Float64,1}, grad :: Bool)
  if grad
    (c, jrow, jcol, jval) = cons_coord(nlp, x, grad);
    return (c, sparse(jrow, jcol, jval, nlp.meta.ncon, nlp.meta.nvar))
  else
    return cons_coord(nlp, x, grad);
  end
end

cons(nlp :: CUTEstModel, x :: Array{Float64,1}) = cons_coord(nlp, x, false);


function hess_coord(nlp :: CUTEstModel, x :: Array{Float64,1}, y :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzh = nlp.meta.nnzh;
  io_err = Cint[0];
  hval = Array(Float64, nnzh);
  hrow = Array(Int32, nnzh);
  hcol = Array(Int32, nnzh);
  this_nnzh = Cint[0];
  if ncon > 0
    @eval ccall((:cutest_csh_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32},   Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 $(io_err),  &$(nvar),   &$(ncon),   $(x),         $(y),         $(this_nnzh), &$(nnzh),   $(hval),      $(hrow),    $(hcol));
  else
    @eval ccall((:cutest_ush_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32},   Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 $(io_err),  &$(nvar),   $(x),         $(this_nnzh),   &$(nnzh), $(hval),      $(hrow),    $(hcol));
  end
  @cutest_error

  return (hrow, hcol, hval);
end

function hess_coord(nlp :: CUTEstModel, x :: Array{Float64,1})
  hess_coord(nlp, x, zeros(nlp.meta.ncon))
end

function hess(nlp :: CUTEstModel, x :: Array{Float64,1}, y :: Array{Float64,1})
  (hrow, hcol, hval) = hess_coord(nlp, x, y);
  H = spzeros(nlp.meta.nvar, nlp.meta.nvar)
  for k = 1:length(hval)
    i = hrow[k]
    j = hcol[k]
    H[i,j] = hval[k]
    if i != j
      H[j,i] = hval[k]
    end
  end
  return H
end

function hess(nlp :: CUTEstModel, x :: Array{Float64,1})
  hess(nlp, x, zeros(nlp.meta.ncon))
end

function hprod(nlp :: CUTEstModel, x :: Array{Float64,1}, y :: Array{Float64,1}, v :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  io_err = Cint[0];
  hv = Array(Float64, nvar);
  goth = Cint[0];
  if ncon > 0
    @eval ccall((:cutest_chprod_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 $(io_err),  &$(nvar),   &$(ncon),   $(goth),    $(x),         $(y),         $(v),         $(hv));
  else
    @eval ccall((:cutest_uhprod_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 $(io_err),  &$(nvar),   $(goth),    $(x),         $(v),         $(hv));
  end
  @cutest_error

  return hv;
end

function hprod!(nlp :: CUTEstModel, x :: Array{Float64,1}, y :: Array{Float64,1}, v :: Array{Float64,1}, hv :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  io_err = Cint[0];
  goth = Cint[0];
  if ncon > 0
    @eval ccall((:cutest_chprod_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 $(io_err),  &$(nvar),   &$(ncon),   $(goth),    $(x),         $(y),         $(v),         $(hv));
  else
    @eval ccall((:cutest_uhprod_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 $(io_err),  &$(nvar),   $(goth),    $(x),         $(v),         $(hv));
  end
  @cutest_error

  return hv;
end

hprod(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}) = hprod(nlp, x, zeros(nlp.meta.ncon), v)

hprod!(nlp :: CUTEstModel, x :: Array{Float64,1}, v :: Array{Float64,1}, hv :: Array{Float64,1}) = hprod!(nlp, x, zeros(nlp.meta.ncon), v, hv)
