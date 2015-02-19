using CUTEst

cint(n) = convert(Cint, n)
macro test_small(ex)
  :(norm($ex)>1e-6 && throw($(string(ex))" should be less than 1e-6"))
end

curdir = pwd();
tmpdir = mktempdir();
cd(tmpdir);

nlp = CUTEstModel(problem)
println(nlp)
