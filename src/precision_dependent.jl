for (typ, cutest_lib) in ((Cdouble, :cutest_lib_double),
                          (Cfloat, :cutest_lib_single))

  @eval begin

    function usetup(io_err::Vector{Cint}, input::Vector{Cint}, out::Vector{Cint},
        io_buffer::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        x_l::Vector{$typ}, x_u::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_usetup_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ},
        Ptr{$typ}, Ptr{$typ}),
        io_err, input, out, io_buffer, n, x, x_l, x_u)
    end

    function csetup(io_err::Vector{Cint}, input::Vector{Cint}, out::Vector{Cint},
        io_buffer::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, x_l::Vector{$typ}, x_u::Vector{$typ},
        y::Vector{$typ}, c_l::Vector{$typ}, c_u::Vector{$typ},
        equatn::Vector{Cint}, linear::Vector{Cint}, e_order::Vector{Cint},
        l_order::Vector{Cint}, v_order::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_csetup_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
        Ptr{$typ}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ},
        Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
        io_err, input, out, io_buffer, n, m, x, x_l, x_u, y, c_l, c_u, equatn,
        linear, e_order, l_order, v_order)
    end

    function ufn(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        f::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_ufn_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ}),
        io_err, n, x, f)
    end

    function ugr(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        g::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_ugr_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ}),
        io_err, n, x, g)
    end

    function uofg(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        f::Vector{$typ}, g::Vector{$typ}, grad::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_uofg_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}),
        io_err, n, x, f, g, grad)
    end

    function udh(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        lh1::Vector{Cint}, h::Array{$typ, 2})
      ccall(dlsym(eval($cutest_lib), "cutest_udh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{$typ}),
        io_err, n, x, lh1, h)
    end

    function ush(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        nnzh::Vector{Cint}, lh::Vector{Cint}, h_val::Vector{$typ},
        h_row::Vector{Cint}, h_col::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_ush_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint},
        Ptr{$typ}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, x, nnzh, lh, h_val, h_row, h_col)
    end

    function ueh(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        ne::Vector{Cint}, lhe_ptr::Vector{Cint}, he_row_ptr::Vector{Cint},
        he_val_ptr::Vector{Cint}, lhe_row::Vector{Cint},
        he_row::Vector{Cint}, lhe_val::Vector{Cint},
        he_val::Vector{$typ}, byrows::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_ueh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
        Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}),
        io_err, n, x, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
        lhe_val, he_val, byrows)
    end

    function ugrdh(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        g::Vector{$typ}, lh1::Vector{Cint}, h::Array{$typ, 2})
      ccall(dlsym(eval($cutest_lib), "cutest_ugrdh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ}, Ptr{Cint},
        Ptr{$typ}),
        io_err, n, x, g, lh1, h)
    end

    function ugrsh(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        g::Vector{$typ}, nnzh::Vector{Cint}, lh::Vector{Cint},
        h_val::Vector{$typ}, h_row::Vector{Cint}, h_col::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_ugrsh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ}, Ptr{Cint},
        Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, x, g, nnzh, lh, h_val, h_row, h_col)
    end

    function ugreh(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        g::Vector{$typ}, ne::Vector{Cint}, lhe_ptr::Vector{Cint},
        he_row_ptr::Vector{Cint}, he_val_ptr::Vector{Cint},
        lhe_row::Vector{Cint}, he_row::Vector{Cint}, lhe_val::Vector{Cint},
        he_val::Vector{$typ}, byrows::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_ugreh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ}, Ptr{Cint},
        Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
        Ptr{$typ}, Ptr{Cint}),
        io_err, n, x, g, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row,
        lhe_val, he_val, byrows)
    end

    function uhprod(io_err::Vector{Cint}, n::Vector{Cint}, goth::Vector{Cint},
        x::Vector{$typ}, vector::Vector{$typ},
        result::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_uhprod_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{$typ}),
        io_err, n, goth, x, vector, result)
    end

    function ushprod(io_err::Vector{Cint}, n::Vector{Cint}, goth::Vector{Cint},
        x::Vector{$typ}, nnz_vector::Vector{Cint},
        index_nz_vector::Vector{Cint}, vector::Vector{$typ},
        nnz_result::Vector{Cint}, index_nz_result::Vector{Cint},
        result::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_ushprod_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint},
        Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}),
        io_err, n, goth, x, nnz_vector, index_nz_vector, vector, nnz_result,
        index_nz_result, result)
    end

    function ubandh(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        semibandwidth::Vector{Cint}, h_band::Array{$typ, 2},
        lbandh::Vector{Cint}, max_semibandwidth::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_ubandh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}),
        io_err, n, x, semibandwidth, h_band, lbandh, max_semibandwidth)
    end

    function cfn(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, f::Vector{$typ}, c::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_cfn_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{$typ}),
        io_err, n, m, x, f, c)
    end

    function cofg(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        f::Vector{$typ}, g::Vector{$typ}, grad::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_cofg_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}),
        io_err, n, x, f, g, grad)
    end

    function cofsg(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        f::Vector{$typ}, nnzg::Vector{Cint}, lg::Vector{Cint},
        g_val::Vector{$typ}, g_var::Vector{Cint}, grad::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_cofsg_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ}, Ptr{Cint},
        Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, x, f, nnzg, lg, g_val, g_var, grad)
    end

    function ccfg(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, c::Vector{$typ}, jtrans::Vector{Cint},
        lcjac1::Vector{Cint}, lcjac2::Vector{Cint}, cjac::Array{$typ, 2},
        grad::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_ccfg_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}),
        io_err, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
    end

    function clfg(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, f::Vector{$typ},
        g::Vector{$typ}, grad::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_clfg_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{$typ}, Ptr{$typ}, Ptr{Cint}),
        io_err, n, m, x, y, f, g, grad)
    end

    function cgr(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, grlagf::Vector{Cint},
        g::Vector{$typ}, jtrans::Vector{Cint}, lj1::Vector{Cint},
        lj2::Vector{Cint}, j_val::Array{$typ, 2})
      ccall(dlsym(eval($cutest_lib), "cutest_cgr_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}),
        io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val)
    end

    function csgr(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, grlagf::Vector{Cint},
        nnzj::Vector{Cint}, lj::Vector{Cint}, j_val::Vector{$typ},
        j_var::Vector{Cint}, j_fun::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_csgr_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun)
    end

    function ccfsg(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, c::Vector{$typ}, nnzj::Vector{Cint},
        lj::Vector{Cint}, j_val::Vector{$typ}, j_var::Vector{Cint},
        j_fun::Vector{Cint}, grad::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_ccfsg_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, m, x, c, nnzj, lj, j_val, j_var, j_fun, grad)
    end

    function ccifg(io_err::Vector{Cint}, n::Vector{Cint}, icon::Vector{Cint},
        x::Vector{$typ}, ci::Vector{$typ}, gci::Vector{$typ},
        grad::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_ccifg_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{$typ}, Ptr{Cint}),
        io_err, n, icon, x, ci, gci, grad)
    end

    function ccifsg(io_err::Vector{Cint}, n::Vector{Cint}, icon::Vector{Cint},
        x::Vector{$typ}, ci::Vector{$typ}, nnzgci::Vector{Cint},
        lgci::Vector{Cint}, gci_val::Vector{$typ}, gci_var::Vector{Cint},
        grad::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_ccifsg_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, icon, x, ci, nnzgci, lgci, gci_val, gci_var, grad)
    end

    function cgrdh(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, grlagf::Vector{Cint},
        g::Vector{$typ}, jtrans::Vector{Cint}, lj1::Vector{Cint},
        lj2::Vector{Cint}, j_val::Array{$typ, 2}, lh1::Vector{Cint},
        h_val::Array{$typ, 2})
      ccall(dlsym(eval($cutest_lib), "cutest_cgrdh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
        Ptr{$typ}, Ptr{Cint}, Ptr{$typ}),
        io_err, n, m, x, y, grlagf, g, jtrans, lj1, lj2, j_val, lh1, h_val)
    end

    function cdh(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, lh1::Vector{Cint},
        h_val::Array{$typ, 2})
      ccall(dlsym(eval($cutest_lib), "cutest_cdh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{$typ}),
        io_err, n, m, x, y, lh1, h_val)
    end

    function cdhc(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, lh1::Vector{Cint},
        h_val::Array{$typ, 2})
      ccall(dlsym(eval($cutest_lib), "cutest_cdhc_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{$typ}),
        io_err, n, m, x, y, lh1, h_val)
    end

    function csh(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, nnzh::Vector{Cint},
        lh::Vector{Cint}, h_val::Vector{$typ}, h_row::Vector{Cint},
        h_col::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_csh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)
    end

    function cshc(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, nnzh::Vector{Cint},
        lh::Vector{Cint}, h_val::Vector{$typ}, h_row::Vector{Cint},
        h_col::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_cshc_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, m, x, y, nnzh, lh, h_val, h_row, h_col)
    end

    function ceh(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, ne::Vector{Cint},
        lhe_ptr::Vector{Cint}, he_row_ptr::Vector{Cint},
        he_val_ptr::Vector{Cint}, lhe_row::Vector{Cint},
        he_row::Vector{Cint}, lhe_val::Vector{Cint},
        he_val::Vector{$typ}, byrows::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_ceh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
        Ptr{Cint}, Ptr{$typ}, Ptr{Cint}),
        io_err, n, m, x, y, ne, lhe_ptr, he_row_ptr, he_val_ptr, lhe_row,
        he_row, lhe_val, he_val, byrows)
    end

    function cidh(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        iprob::Vector{Cint}, lh1::Vector{Cint}, h::Array{$typ, 2})
      ccall(dlsym(eval($cutest_lib), "cutest_cidh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}),
        io_err, n, x, iprob, lh1, h)
    end

    function cish(io_err::Vector{Cint}, n::Vector{Cint}, x::Vector{$typ},
        iprob::Vector{Cint}, nnzh::Vector{Cint}, lh::Vector{Cint},
        h_val::Vector{$typ}, h_row::Vector{Cint}, h_col::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_cish_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
        Ptr{$typ}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, x, iprob, nnzh, lh, h_val, h_row, h_col)
    end

    function csgrsh(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, grlagf::Vector{Cint},
        nnzj::Vector{Cint}, lj::Vector{Cint}, j_val::Vector{$typ},
        j_var::Vector{Cint}, j_fun::Vector{Cint}, nnzh::Vector{Cint},
        lh::Vector{Cint}, h_val::Vector{$typ}, h_row::Vector{Cint},
        h_col::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_csgrsh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint},
        Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, nnzh, lh,
        h_val, h_row, h_col)
    end

    function csgreh(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        x::Vector{$typ}, y::Vector{$typ}, grlagf::Vector{Cint},
        nnzj::Vector{Cint}, lj::Vector{Cint}, j_val::Vector{$typ},
        j_var::Vector{Cint}, j_fun::Vector{Cint}, ne::Vector{Cint},
        lhe_ptr::Vector{Cint}, he_row_ptr::Vector{Cint},
        he_val_ptr::Vector{Cint}, lhe_row::Vector{Cint},
        he_row::Vector{Cint}, lhe_val::Vector{Cint},
        he_val::Vector{$typ}, byrows::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_csgreh_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint},
        Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
        Ptr{Cint}, Ptr{$typ}, Ptr{Cint}),
        io_err, n, m, x, y, grlagf, nnzj, lj, j_val, j_var, j_fun, ne,
        lhe_ptr, he_row_ptr, he_val_ptr, lhe_row, he_row, lhe_val, he_val,
        byrows)
    end

    function chprod(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        goth::Vector{Cint}, x::Vector{$typ}, y::Vector{$typ},
        vector::Vector{$typ}, result::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_chprod_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ},
        Ptr{$typ}, Ptr{$typ}, Ptr{$typ}),
        io_err, n, m, goth, x, y, vector, result)
    end

    function cshprod(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        goth::Vector{Cint}, x::Vector{$typ}, y::Vector{$typ},
        nnz_vector::Vector{Cint}, index_nz_vector::Vector{Cint},
        vector::Vector{$typ}, nnz_result::Vector{Cint},
        index_nz_result::Vector{Cint}, result::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_cshprod_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ},
        Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint},
        Ptr{Cint}, Ptr{$typ}),
        io_err, n, m, goth, x, y, nnz_vector, index_nz_vector, vector,
        nnz_result, index_nz_result, result)
    end

    function chcprod(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        goth::Vector{Cint}, x::Vector{$typ}, y::Vector{$typ},
        vector::Vector{$typ}, result::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_chcprod_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ},
        Ptr{$typ}, Ptr{$typ}, Ptr{$typ}),
        io_err, n, m, goth, x, y, vector, result)
    end

    function cshcprod(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        goth::Vector{Cint}, x::Vector{$typ}, y::Vector{$typ},
        nnz_vector::Vector{Cint}, index_nz_vector::Vector{Cint},
        vector::Vector{$typ}, nnz_result::Vector{Cint},
        index_nz_result::Vector{Cint}, result::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_cshcprod_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ},
        Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint},
        Ptr{Cint}, Ptr{$typ}),
        io_err, n, m, goth, x, y, nnz_vector, index_nz_vector, vector,
        nnz_result, index_nz_result, result)
    end

    function cjprod(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        gotj::Vector{Cint}, jtrans::Vector{Cint}, x::Vector{$typ},
        vector::Vector{$typ}, lvector::Vector{Cint},
        result::Vector{$typ}, lresult::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_cjprod_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ},
        Ptr{$typ}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}),
        io_err, n, m, gotj, jtrans, x, vector, lvector, result, lresult)
    end

    function csjprod(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        gotj::Vector{Cint}, jtrans::Vector{Cint}, x::Vector{$typ},
        nnz_vector::Vector{Cint}, index_nz_vector::Vector{Cint},
        vector::Vector{$typ}, lvector::Vector{Cint},
        nnz_result::Vector{Cint}, index_nz_result::Vector{Cint},
        result::Vector{$typ}, lresult::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_csjprod_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ},
        Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
        Ptr{$typ}, Ptr{Cint}),
        io_err, n, m, gotj, jtrans, x, nnz_vector, index_nz_vector, vector,
        lvector, nnz_result, index_nz_result, result, lresult)
    end

    function cchprods(io_err::Vector{Cint}, n::Vector{Cint}, m::Vector{Cint},
        goth::Vector{Cint}, x::Vector{$typ}, vector::Vector{$typ},
        lchp::Vector{Cint}, chp_val::Vector{$typ}, chp_ind::Vector{Cint},
        chp_ptr::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_cchprods_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ},
        Ptr{$typ}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint}),
        io_err, n, m, goth, x, vector, lchp, chp_val, chp_ind, chp_ptr)
    end

    function cifn(io_err::Vector{Cint}, n::Vector{Cint}, iprob::Vector{Cint},
        x::Vector{$typ}, f::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_cifn_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ}),
        io_err, n, iprob, x, f)
    end

    function cisgr(io_err::Vector{Cint}, n::Vector{Cint}, iprod::Vector{Cint},
        x::Vector{$typ}, nnzg::Vector{Cint}, lg::Vector{Cint},
        g_val::Vector{$typ}, g_var::Vector{Cint})
      ccall(dlsym(eval($cutest_lib), "cutest_cisgr_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{Cint}, Ptr{Cint},
         Ptr{$typ}, Ptr{Cint}),
        io_err, n, iprod, x, nnzg, lg, g_val, g_var)
    end

    function cigr(io_err::Vector{Cint}, n::Vector{Cint}, iprob::Vector{Cint},
        x::Vector{$typ}, g_val::Vector{$typ})
      ccall(dlsym(eval($cutest_lib), "cutest_cigr_"), Nothing,
        (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{$typ}, Ptr{$typ}),
        io_err, n, iprob, x, g_val)
    end

  end

end
