import DataStructures: OrderedDict
using JSON

"""`create_class()`

Creates the file `classf.json`, running each problem in `\$MASTSIF/CLASSF.DB` and
extracting the necessary information. It should be left alone, unless you think
it is not updated. If you do, please open an issue at
[https://github.com/JuliaSmoothOptimizers/CUTEst.jl](https://github.com/JuliaSmoothOptimizers/CUTEst.jl)
"""
function create_class()
  classdb = open(readlines, joinpath(ENV["MASTSIF"], "CLASSF.DB"))
  problems = OrderedDict()
  nlp = 0
  for line in classdb
    sline = split(line)
    p = String(sline[1])
    cl = split(sline[2], "")

    print("Problem $p... ")
    try
      nlp = CUTEstModel(p)
      problems[p] = Dict(
          :objtype          => classdb_objtype[cl[1]],
          :contype          => classdb_contype[cl[2]],
          :regular          => cl[3] == "R",
          :derivative_order => Int(cl[4][1]-'0'),
          :origin           => classdb_origin[cl[6]],
          :has_internal_var => cl[7] == "Y",
          :variables        => Dict(
            :can_choose     => sline[3][1] == "V",
            :number         => nlp.meta.nvar,
            :fixed          => length(nlp.meta.ifix),
            :free           => length(nlp.meta.ifree),
            :bounded_below  => length(nlp.meta.ilow),
            :bounded_above  => length(nlp.meta.iupp),
            :bounded_both   => length(nlp.meta.irng)
          ),
          :constraints      => Dict(
            :can_choose     => sline[4][1] == "V",
            :number         => nlp.meta.ncon,
            :equality       => length(nlp.meta.jfix),
            :ineq_below     => length(nlp.meta.jlow),
            :ineq_above     => length(nlp.meta.jupp),
            :ineq_both      => length(nlp.meta.jrng),
            :linear         => nlp.meta.nlin,
            :nonlinear      => nlp.meta.nnln
          )
      )
      println("done")
    catch ex
      println("errored: $ex")
    finally
      finalize(nlp)
    end
  end
  open(joinpath(dirname(@__FILE__), "classf.json"), "w") do jsonfile
    JSON.print(jsonfile, problems, 2)
  end
end
