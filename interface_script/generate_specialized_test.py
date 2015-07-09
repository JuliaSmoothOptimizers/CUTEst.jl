#!/usr/bin/env python

import re
import sys

translate = {
    "n": "nlp.meta.nvar",
    "m": "nlp.meta.ncon",
    "x": "x0",
    "c": "cx",
    "f": "fx" }

hs = {
    "fx": "f(x0)",
    "cx": "c(x0)" }

def generate_test_for_function (foo):
    fname = foo.split("(")[0].strip()
    inplace = fname[-1] == "!"
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
        x = translate[x] if x in translate else x
        outputs.append(x)

    test = 'println("\\nTesting the Specialized interface\\n"\n\n'
    if len(outputs) > 0:
        test += ', '.join(outputs) + " = "
    test += "{}({})\n".format(fname, ', '.join(inputs))
    for output in outputs:
        test += "@test_approx_eq_eps {} {} 1e-8\n".format(output, hs[output])
    if inplace:
        for x in inputs:
            if x in hs:
                test += "@test_approx_eq_eps {} {} 1e-8\n".format(x, hs[x])

    return test

filename = "src/specialized_interface.jl"
content = ''.join(open(filename, "r").readlines()).split("function")[1:]

cfns = [x for x in content if "cfn" in x]

for cfn in cfns:
    #print("function ", end="")
    #print(cfn)
    print(generate_test_for_function(cfn))
