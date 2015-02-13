export objcons, objgrad, obj, cons_coord, cons, hess_coord, hess, terminate

function objcons(nlp :: CUTEstModel, x :: Array{Float64,1})
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  io_err = Int32[0];
  f = Float64[0];
  c = Array(Float64, ncon);
  if ncon > 0
    @eval ccall((:cutest_cfn_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                 $(io_err),  $(nvar),    $(ncon),    $(x),         $(f),         $(c));
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
  f = Float64[0];
  io_err = Int32[0];
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

  return (f, g);
end

obj(nlp :: CUTEstModel, x :: Array{Float64,1}) = objgrad(nlp, x, false);


function cons_coord(nlp :: CUTEstModel, x :: Array{Float64,1}, grad :: Bool)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzj = nlp.meta.nnzj;
  io_err = Int32[0];
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


function hess_coord(nlp :: CUTEstModel, x :: Array{Float64,1};
                    y :: Array{Float64,1}=nlp.meta.y0)
  nvar = nlp.meta.nvar;
  ncon = nlp.meta.ncon;
  nnzh = nlp.meta.nnzh;
  io_err = Int32[0];
  hval = Array(Float64, nnzh);
  hrow = Array(Int32, nnzh);
  hcol = Array(Int32, nnzh);
  this_nnzh = Int32[0];
  if ncon > 0
    @eval ccall((:cutest_csh_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 $(io_err),  &$(nvar),   &$(ncon),   $(x),         $(y),         $(this_nnzh),   &$(nnzh),   $(hval),      $(hrow),    $(hcol));
  else
    @eval ccall((:cutest_ush_, $(nlp.libname)), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
                 $(io_err),  &$(nvar),   $(x),         $(this_nnzh),   &$(nnzh),   $(hval),      $(hrow),    $(hcol));
  end
  @cutest_error

  return (hrow, hcol, hval);
end

function hess(nlp :: CUTEstModel, x :: Array{Float64,1};
              y :: Array{Float64,1}=nlp.meta.y0)
  (hrow, hcol, hval) = hess_coord(nlp, x, y=y);
  return sparse(hrow, hcol, hval, nlp.meta.nvar, nlp.meta.nvar);
end

function terminate(nlp :: CUTEstModel)
  if (nlp.initialized)
    io_err = Int32[0];
    termfoo = nlp.meta.ncon > 0 ? "cutest_cterminate_" : "cutest_uterminate_";
    @eval ccall(($(termfoo), $(nlp.libname)), Void, (Ptr{Int32},), $(io_err));
    @cutest_error
    nlp.initialized = false
  end
end

