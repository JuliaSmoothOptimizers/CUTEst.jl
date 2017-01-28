# Tests made to increase the coverage.

function coverage_increase(nlp :: CUTEstModel)
  pname = probname()
  vname = varnames(nlp.meta.nvar)
  if nlp.meta.ncon == 0
    pname, vname = unames(nlp.meta.nvar)
    calls, time = ureport()
    ureport!(calls, time)
  else
    pname, vname, cname = cnames(nlp.meta.nvar, nlp.meta.ncon)
    calls, time = creport()
    creport!(calls, time)
    cname = connames(nlp.meta.ncon)
    cdimchp() # Not clear how it works
    cstats()
  end
end
