print("Testing non-NLP interface... ")

outsdif, io_err = "OUTSDIF.d", Cint[0]
funit = 42

cutest_lib = sifdecoder("ROSENBR")
ccall(CUTEst.dlsym(cutest_lib, :fortran_open_), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err)
nvar = Int(udimen(cutest_lib, funit))
@assert nvar == 2
x, bl, bu = usetup(cutest_lib, funit, 0, 6, nvar)
@assert x == [-1.2, 1.0]
ccall(CUTEst.dlsym(cutest_lib, :fortran_close_), Void,
      (Ptr{Int32}, Ptr{Int32}), &funit, io_err)
uterminate(cutest_lib, )
Libdl.dlclose(cutest_lib)

cutest_lib = sifdecoder("ROSENBR")
ccall(CUTEst.dlsym(cutest_lib, :fortran_open_), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err)
nvar = Int(udimen(cutest_lib, funit))
@assert nvar == 2
usetup!(cutest_lib, funit, 0, 6, nvar, x, bl, bu)
@assert x == [-1.2, 1.0]
ccall(CUTEst.dlsym(cutest_lib, :fortran_close_), Void,
      (Ptr{Int32}, Ptr{Int32}), &funit, io_err)
uterminate(cutest_lib, )
Libdl.dlclose(cutest_lib)

cutest_lib = sifdecoder("HS35")
ccall(CUTEst.dlsym(cutest_lib, :fortran_open_), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err)
nvar, ncon = map(Int, cdimen(cutest_lib, funit))
@assert (nvar, ncon) === (3, 1)
x, bl, bu, y, cl, cu, eq, lin = csetup(cutest_lib, funit, 0, 6, nvar, ncon, 0, 0, 0)
@assert x == [0.5; 0.5; 0.5]
f, c = cfn(cutest_lib, nvar, ncon, x)
@assert f == 2.25
@assert c == [1.0]
ccall(CUTEst.dlsym(cutest_lib, :fortran_close_), Void,
      (Ptr{Int32}, Ptr{Int32}), &funit, io_err)
cterminate(cutest_lib, )
Libdl.dlclose(cutest_lib)

cutest_lib = sifdecoder("HS35")
ccall(CUTEst.dlsym(cutest_lib, :fortran_open_), Void,
      (Ptr{Int32}, Ptr{UInt8}, Ptr{Int32}), &funit, outsdif, io_err)
nvar, ncon = map(Int, cdimen(cutest_lib, funit))
@assert (nvar, ncon) === (3, 1)
csetup!(cutest_lib, funit, 0, 6, nvar, ncon, x, bl, bu, y, cl, cu, eq, lin, 0, 0, 0)
@assert x == [0.5; 0.5; 0.5]
f = cfn!(cutest_lib, nvar, ncon, x, c)
@assert f == 2.25
@assert c == [1.0]
ccall(CUTEst.dlsym(cutest_lib, :fortran_close_), Void,
      (Ptr{Int32}, Ptr{Int32}), &funit, io_err)
cterminate(cutest_lib, )
Libdl.dlclose(cutest_lib)

println("done")
