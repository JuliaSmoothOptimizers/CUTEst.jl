#!/usr/bin/env python

import os
import re
import sys
import textwrap

# Type conversion
cutypes = {"integer":"Int32", "doublereal":"Float64", "logical":"Int32",
        "char":"Uint8", "real":"Float64"}

# Workarounds
ignore_intent = ["ureport", "creport"]

cutest = os.getenv('CUTEST', "")
if cutest is "":
    print("ERROR: Variable CUTEST not set. Verify your CUTEst installation.")
    exit(1)

# The function definitions are being read from the C include file.
# This should probably be improved to obtain more information about the
# functions, but this is easier.
functions = []
with open(cutest+"/include/cutest.h") as file:
    # Each new function starts with
    # void CUTEST_xxx
    start_function = False
    for line in file:
        if start_function:
            function += " " + line.strip()
        if "void CUTEST" in line:
            start_function = True
            function = line.strip()
        if start_function and ";" in line:
            start_function = False
            functions.append(function)

s="  "
el='\n'+2*s

raw = open("src/raw_interface.jl","w")
med = open("src/medium_interface.jl","w")

for function in functions:
    # Get function name
    name = re.search('CUTEST_([a-z]*)', function).group(1)
    # Get function arguments
    args = re.search('\((.*)\)', function).group(1).split(',')
    matches = [re.search('([a-z]*) \*(.*)', arg.strip()) for arg in args]
    # Create a list of [type,variable name]
    vars = [[m.group(1),m.group(2)] for m in matches]

    # Raw interface
    raw.write(el.join(textwrap.wrap("function "+name+" ("+', '.join([v[1]
        for v in vars])+", libname = fixedlibname)", width=80)))
    raw.write("\n")
    raw.write(s+"@eval ccall((\"cutest_"+name+"_\", $(libname)), Void,")
    raw.write("\n")
    if len(vars) == 1:
        raw.write(2*s+"(Ptr{"+cutypes[vars[0][0]]+"},),")
        raw.write("\n")
    else:
        raw.write(el.join(textwrap.wrap(2*s+"(" +
            ', '.join(["Ptr{"+cutypes[v[0]]+"}" for v in vars])+"),",
            width=80)))
        raw.write("\n")
    raw.write(el.join(textwrap.wrap(2*s+', '.join(["$("+v[1]+")" for v in vars]) + ")",
        width=80)))
    raw.write("\n")
    raw.write("end\n\n")

    vars = {}
    funcall = []
    # Medium interface
    with open(os.environ['CUTEST']+'/src/tools/'+name+'.f90','r') as f:
        start_function = False
        start_fundef = False
        for line in f:
            line = line.strip().lower()
            if start_fundef:
                for arg in re.search("(.*)[\)&]", line).group(1).split(','):
                    funcall.append(arg.strip())
                start_fundef = False
            if "subroutine cutest_"+name+"(" in line:
                start_function = True
                start_fundef = True
                for arg in re.search("\((.*)[&\)]", line).group(1).split(','):
                    funcall.append(arg.strip())
                if ")" in line:
                    start_fundef = False
            if start_function:
                for t in cutypes.keys():
                    if t in line:
                        intent = re.search("intent\( ([a-z]*) \)", line)
                        if intent is None:
                            if name in ignore_intent:
                                intent = "out"
                            else:
                                continue
                        else:
                            intent = intent.group(1).strip()
                        if intent == "inout":
                            intent = "in"
                        if "dimension" in line:
                            is_ptr = True
                            dim = re.search("dimension\(([ a-z_,:0-9]*)\)",
                                    line).group(1).split(',')
                        else:
                            is_ptr = False
                            dim = 0
                        args = re.search(":: (.*)", line).group(1).split(',')
                        for arg in args:
                            vars[arg.strip().lower()] = {"type":t, "intent":intent,
                                    "ptr":is_ptr, "dim":dim}
            if start_function and "end subroutine" in line:
                break

    funcall = [x for x in funcall if x]
    ins = [arg for arg in funcall if vars[arg]["intent"] == "in"]
    print("function jl_"+name+"(", end="")
    print(el.join(textwrap.wrap(', '.join(ins))), end="")
    if len(ins) > 0:
        print("; ", end="")
    print("libname = fixedlibname)")
    for var in funcall:
        if vars[var]["intent"] == "in":
            continue
        print(s+var + " = ", end="")
        t = cutypes[vars[var]["type"]]
        if vars[var]["ptr"]:
            dim = vars[var]["dim"]
            print("Array(" + t + ", ", end="")
            dims = []
            for d in dim:
                if ":" in d:
                    a = d.split(':')[0]
                    b = d.split(':')[1]
                    d = "{} - {} + 1".format(b.strip(),a.strip())
                else:
                    d = d.strip()
                dims.append(d)
            print(', '.join(dims)+")")
        else:
            print("["+t.lower()+"(0)]")
    print(s+"@eval CUTEst."+name+"(", end="")
    ccall = []
    for arg in funcall:
        if vars[arg]["ptr"] or vars[arg]["intent"] == "out":
            ccall.append("$("+arg+")")
        else:
            t = cutypes[vars[arg]["type"]].lower()
            ccall.append("$([{}({})])".format(t, arg))
    print(el.join(textwrap.wrap(', '.join(ccall))), end="")
    if len(ccall) > 0:
        print(", ", end="")
    print("$(libname))")
    out = []
    for arg in funcall:
        if vars[arg]["intent"] == "out":
            if vars[arg]["ptr"]:
                out.append(arg)
            else:
                out.append(arg+"[1]")
    if len(out) > 0:
        print(s+"return "+', '.join(out))
    print("end\n")

raw.close()
med.close()
