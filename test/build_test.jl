using CUTEst
using Base.Test

# Work in a temporary directory.
curdir = pwd();
tmpdir = mktempdir();
cd(tmpdir);

loadProblem(problem);
x0 = nlp.x0
y0 = ones(nlp.ncon) # To guarantee that y0 is not zero

print(nlp);
