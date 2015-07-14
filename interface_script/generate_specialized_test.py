#!/usr/bin/env python

import re
import sys

foos = [ "ccfg", "ccfsg", "cfn", "cgr", "cofg" ]

trip_comp = [ "j_var", "j_fun" ]
triplet = { "Jx": "J" }
trip_resp = { "Jx": "j_var" }
ignore = trip_comp

translate = {
    "n": "nlp.meta.nvar",
    "m": "nlp.meta.ncon",
    "x": "x0",
    "c": "cx",
    "f": "fx",
    "g": "gx",
    "grad": "true",
    "cjac": "Jx",
    "j_val": "Jx",
    "h_val": "Wx",
    "jtrans": "false",
    "lcjac1": "nlp.meta.ncon",
    "lcjac2": "nlp.meta.nvar",
    "y": "y0",
    "grlagf": "false",
    "lj": "nlp.meta.nnzj+nlp.meta.nvar",
    "lj1": "nlp.meta.ncon",
    "lj2": "nlp.meta.nvar",
    "lh1": "nlp.meta.nvar" }

hs = {
    "fx": "f(x0)",
    "cx": "c(x0)",
    "gx": "g(x0)",
    "Jx": "J(x0)",
    "Wx": "W(x0,y0)",
    "nnzj": "nnzj" }

inplaces = [ "cx", "gx", "Jx", "Wx", "j_var", "j_fun" ]
inplace_ignore = [ "j_var", "j_fun" ]

sizeof = {
    "gx": "nlp.meta.nvar",
    "cx": "nlp.meta.ncon",
    "Jx": "nlp.meta.ncon, nlp.meta.nvar",
    "Wx": "nlp.meta.nvar, nlp.meta.nvar",
    "j_var": "Int, nlp.meta.nnzj+nlp.meta.nvar",
    "j_fun": "Int, nlp.meta.nnzj+nlp.meta.nvar" }

sizeofsp = {
    "Jx": "nlp.meta.nnzj+nlp.meta.nvar",
    "Wx": "nlp.meta.nnzh" }

def addTriplet(trip):
    str = "{}_val = copy({}x)\n".format(trip.lower(), trip)
    if trip == "J":
        str += "Jx = zeros(nlp.meta.ncon, nlp.meta.nvar)\n"
        i = "j_fun"
        j = "j_var"
    else:
        str += "{}x = zeros(nlp.meta.nvar, nlp.meta.nvar)\n".format(trip)
        i = "{}_row".format(trip.lower())
        j = "{}_col".format(trip.lower())
    str += "for k = 1:nnz{}\n".format(trip.lower())
    str += "  {}x[{}[k],{}[k]] = {}_val[k]\n".format(trip, i, j, trip.lower())
    str += "end\n"
    str += "@test_approx_eq_eps {}x {} 1e-8\n".format(trip, hs[trip+"x"])
    return str

def generate_test_for_function (foo):
    fname = foo.split("(")[0].strip()
    inplace = fname[-1] == "!"
    test = ''
    inputs = []
    for x in foo[foo.find("(")+1:foo.find(")")].split(","):

        if "libname" in x:
            inputs.append("nlp.libname")
        else:
            x = x[0:x.find(":")].strip()
            if x not in ["1", "2", "3"]:
                x = translate[x] if x in translate else x
                inputs.append(x)
    outputs = []
    for x in foo[foo.find("return")+6:-6].split(","):
        if "[" in x:
            x = x[0:x.find("[")]
        x = x.strip()
        if len(x) == 0:
            continue
        x = translate[x] if x in translate else x
        outputs.append(x)

    if len(outputs) > 0:
        test += ', '.join(outputs) + " = "
    test += "{}({})\n".format(fname, ', '.join(inputs))
    for x in outputs:
        if x in triplet and trip_resp[x] in outputs:
            test += addTriplet(triplet[x])
        elif x not in ignore:
            test += "@test_approx_eq_eps {} {} 1e-8\n".format(x, hs[x])
    if inplace:
        for x in inputs:
            # Check for Array instead
            if x in inplaces:
                if x in triplet and trip_resp[x] in inputs:
                    test = "{} = zeros({})\n".format(x,sizeofsp[x]) + test
                    test += addTriplet(triplet[x])
                else:
                    test = "{} = zeros({})\n".format(x,sizeof[x]) + test
                    if x not in inplace_ignore:
                        test += "@test_approx_eq_eps {} {} 1e-8\n".format(x, hs[x])

    return test

filename = "src/specialized_interface.jl"
content = ''.join(open(filename, "r").readlines()).split("function")[1:]

selection = []
for x in content:
    for foo in foos:
        if foo in x:
            selection.append(x)

print('println("\\nTesting the Specialized interface\\n")\n\n')
for x in selection:
    #print("function ", end="")
    #print(x)
    print(generate_test_for_function(x))
