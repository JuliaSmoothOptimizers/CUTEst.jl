#!/usr/bin/env python

import os
import re
import sys
import textwrap

# Type conversion
cutypes = {"integer":"Cint", "doublereal":"Cdouble", "logical":"Cint",
        "char":"Cchar", "real":"Cdouble"}
jltypes = {"integer":"Integer", "doublereal":"Float64", "logical":"Bool",
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
    for line in file:
        if "void CUTEST" in line:
            name = re.search('CUTEST_([a-z]*)', line).group(1).strip()
            functions.append(name)

s="  "
el='\n'+2*s

raw = open("src/raw_interface.jl","w")
med = open("src/medium_interface.jl","w")

for name in functions:
    # Get function name
    vars = {}
    funcall = []
    with open(os.environ['CUTEST']+'/src/tools/'+name+'.f90','r') as f:
        start_function = False
        start_fundef = False
        for line in f:
            line = line.strip().lower()
            if start_fundef:
                for arg in re.search("(.*)[\)&]", line).group(1).split(','):
                    if arg.strip() == "status":
                        arg = "io_err"
                    funcall.append(arg.strip())
                if ")" in line:
                    start_fundef = False
            if "subroutine cutest_"+name+"(" in line:
                start_function = True
                start_fundef = True
                for arg in re.search("\((.*)[&\)]", line).group(1).split(','):
                    if arg.strip() == "status":
                        arg = "io_err"
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
                            if arg.strip() == "status":
                                arg = "io_err"
                            if is_ptr:
                                dims = []
                                for d in dim:
                                    if ":" in d:
                                        a = d.split(':')[0]
                                        b = d.split(':')[1]
                                        d = "{} - {} + 1".format(b.strip(),a.strip())
                                    else:
                                        d = d.strip()
                                    dims.append(d)
                                dim = dims
                            vars[arg.strip().lower()] = {"type":t, "intent":intent,
                                    "ptr":is_ptr, "dim":dim}
            if start_function and "end subroutine" in line:
                break

    funcall = [x for x in funcall if x]

    args = []
    for var in funcall:
        t = cutypes[vars[var]["type"]]
        args.append(var+"::Array{"+t+", 1}")
    raw.write("function "+name+"(")
    raw.write(el.join(textwrap.wrap(
        ', '.join(args)+", libname = fixedlibname")))
    raw.write(")\n")
    raw.write(s+'@eval ccall(("cutest_'+name+'_", $(libname)), Void,\n')
    raw.write(2*s+"(")
    types = []
    for var in funcall:
        t = cutypes[vars[var]["type"]]
        types.append("Ptr{"+t+"}")
    raw.write(el.join(textwrap.wrap(', '.join(types))))
    raw.write("),\n")
    ccall = []
    for var in funcall:
        ccall.append("$({})".format(var))
    raw.write(2*s+el.join(textwrap.wrap(', '.join(ccall))))
    raw.write(")\n")
    raw.write("end\n\n")

    ins = []
    for var in funcall:
        if vars[var]["intent"] == "out":
            continue
        t = jltypes[vars[var]["type"]]
        if vars[var]["ptr"]:
            ins.append(var+"::Array{"+t+", "+str(len(vars[var]["dim"]))+"}")
        else:
            ins.append(var+"::"+t)
    med.write("function jl_"+name+"(")
    med.write(el.join(textwrap.wrap(', '.join(ins))))
    if len(ins) > 0:
        med.write(", ")
    med.write("libname = fixedlibname)\n")
    for var in funcall:
        if vars[var]["intent"] == "in":
            continue
        med.write(s+var + " = ")
        t = cutypes[vars[var]["type"]]
        if vars[var]["ptr"]:
            med.write("Array(" + t + ", ")
            med.write(', '.join(vars[var]["dim"])+")\n")
        else:
            med.write("["+t.lower()+"(0)]\n")
    med.write(s+"@eval CUTEst."+name+"(")
    ccall = []
    for arg in funcall:
        if vars[arg]["ptr"] or vars[arg]["intent"] == "out":
            ccall.append("$("+arg+")")
        else:
            t = cutypes[vars[arg]["type"]].lower()
            ccall.append("$([{}({})])".format(t, arg))
    med.write(el.join(textwrap.wrap(', '.join(ccall))))
    if len(ccall) > 0:
        med.write(", ")
    med.write("$(libname))\n")
    med.write(s+"@cutest_error\n")
    out = []
    for arg in funcall:
        if arg == "io_err":
            continue
        if vars[arg]["intent"] == "out":
            if vars[arg]["ptr"]:
                out.append(arg)
            else:
                out.append(arg+"[1]")
    if len(out) > 0:
        med.write(s+"return "+', '.join(out))
        med.write("\n")
    med.write("end\n\n")

raw.close()
med.close()
