using CUTEst

cint(n) = convert(Cint, n)
curdir = pwd();
tmpdir = mktempdir();
cd(tmpdir);

problem = "HS15.SIF"
nlp = CUTEstModel(problem)
println(nlp)
