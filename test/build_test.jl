# Work in a temporary directory.
curdir = pwd();
tmpdir = mktempdir();
cd(tmpdir);

nlp = CUTEstModel(problem);
x0 = nlp.meta.x0
y0 = ones(nlp.meta.ncon) # To guarantee that y0 is not zero

print(nlp);
