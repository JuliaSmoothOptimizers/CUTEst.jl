import JSON

# Some enumerations and correspondance dicts
const objtypes = [:none, :constant, :linear, :quadratic, :sum_of_squares, :other]
const classdb_objtype = [x=>objtypes[i] for (i,x) in enumerate("NCLQSO")]

const contypes = [:unc, :only_fixed, :only_bounds, :network, :linear, :quadratic, :general]
const classdb_contype = [x=>contypes[i] for (i,x) in enumerate("UXBNLQO")]

const origins = [:academic, :modelling, :real]
const classdb_origin = [x=>origins[i] for (i,x) in enumerate("AMR")]

function create_class()
  classdb = open(readlines, joinpath(ENV["MASTSIF"], "CLASSF.DB"))
  problems = Dict()
  for line in classdb
    sline = split(line)
    p = sline[1]
    cl = sline[2]

    print("Problem $p... ")
    nlp = CUTEstModel(p)
    problems[p] = Dict(
        :objtype          => classdb_objtype[cl[1]],
        :contype          => classdb_contype[cl[2]],
        :regular          => cl[3] == 'R',
        :derivative_order => Int(cl[4]-'0'),
        :origin           => classdb_origin[cl[6]],
        :has_internal_var => cl[7] == 'Y',
        :variables        => Dict(
          :can_choose     => sline[3][1] == 'V',
          :number         => nlp.meta.nvar,
          :fixed          => length(nlp.meta.ifix),
          :free           => length(nlp.meta.ifree),
          :bounded_below  => length(nlp.meta.ilow),
          :bounded_above  => length(nlp.meta.iupp),
          :bounded_both   => length(nlp.meta.irng)
        ),
        :constraints      => Dict(
          :can_choose     => sline[4][1] == 'V',
          :number         => nlp.meta.ncon,
          :equality       => length(nlp.meta.jfix),
          :ineq_below     => length(nlp.meta.jlow),
          :ineq_above     => length(nlp.meta.jupp),
          :ineq_both      => length(nlp.meta.jrng),
          :linear         => length(nlp.meta.nlin),
          :nonlinear      => length(nlp.meta.nnln)
        )
    )
                                
    cutest_finalize(nlp)
    println("done")
  end
  open("classf.json", "w") do jsonfile
    JSON.print(jsonfile, problems)
  end
end
