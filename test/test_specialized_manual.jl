print("Testing non-NLP interface... ")

outsdif, io_err = "OUTSDIF.d", Cint[0]
funit = 42

sifdecoder("ROSENBR")
ccall(CUTEst.dlsym(CUTEst.cutest_lib, :fortran_open_), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err)
nvar = Int(udimen(funit))
@assert nvar == 2
x, bl, bu = usetup(funit, 0, 6, nvar)
@assert x == [-1.2, 1.0]
ccall(CUTEst.dlsym(CUTEst.cutest_lib, :fortran_close_), Void,
      (Ptr{Int32}, Ptr{Int32}), &funit, io_err)
uterminate()
Libdl.dlclose(CUTEst.cutest_lib)

sifdecoder("ROSENBR")
ccall(CUTEst.dlsym(CUTEst.cutest_lib, :fortran_open_), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err)
nvar = Int(udimen(funit))
@assert nvar == 2
usetup!(funit, 0, 6, nvar, x, bl, bu)
@assert x == [-1.2, 1.0]
ccall(CUTEst.dlsym(CUTEst.cutest_lib, :fortran_close_), Void,
      (Ptr{Int32}, Ptr{Int32}), &funit, io_err)
uterminate()
Libdl.dlclose(CUTEst.cutest_lib)

sifdecoder("HS35")
ccall(CUTEst.dlsym(CUTEst.cutest_lib, :fortran_open_), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err)
nvar, ncon = map(Int, cdimen(funit))
@assert (nvar, ncon) === (3, 1)
x, bl, bu, y, cl, cu, eq, lin = csetup(funit, 0, 6, nvar, ncon, 0, 0, 0)
@assert x == [0.5; 0.5; 0.5]
f, c = cfn(nvar, ncon, x)
@assert f == 2.25
@assert c == [1.0]
ccall(CUTEst.dlsym(CUTEst.cutest_lib, :fortran_close_), Void,
      (Ptr{Int32}, Ptr{Int32}), &funit, io_err)
cterminate()
Libdl.dlclose(CUTEst.cutest_lib)

sifdecoder("HS35")
ccall(CUTEst.dlsym(CUTEst.cutest_lib, :fortran_open_), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err)
nvar, ncon = map(Int, cdimen(funit))
@assert (nvar, ncon) === (3, 1)
csetup!(funit, 0, 6, nvar, ncon, x, bl, bu, y, cl, cu, eq, lin, 0, 0, 0)
@assert x == [0.5; 0.5; 0.5]
f = cfn!(nvar, ncon, x, c)
@assert f == 2.25
@assert c == [1.0]
ccall(CUTEst.dlsym(CUTEst.cutest_lib, :fortran_close_), Void,
      (Ptr{Int32}, Ptr{Int32}), &funit, io_err)
cterminate()
Libdl.dlclose(CUTEst.cutest_lib)

println("done")
