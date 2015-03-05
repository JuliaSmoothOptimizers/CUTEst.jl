using CUTEst
using Base.Test

# Work in a temporary directory.
curdir = pwd();
tmpdir = mktempdir();
cd(tmpdir);

nlp = CUTEstModel(problem);
x0 = nlp.meta.x0

print(nlp);
