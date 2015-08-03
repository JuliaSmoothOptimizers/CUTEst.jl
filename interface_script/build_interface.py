#!/usr/bin/env python

import os
import re
import textwrap

# Type conversion
cutypes = {"integer":"Cint", "doublereal":"Cdouble", "logical":"Cint",
        "char":"Cchar", "real":"Cdouble"}
jltypes = {"integer":"Int", "doublereal":"Float64", "logical":"Bool",
        "char":"Uint8", "real":"Float64"}

# NLP related
nlp_equivalent = {"n":"nvar", "m":"ncon", "lj":"nnzj", "lh":"nnzh"}
nlp_exception  = {
    "csgr": { "lj":["nnzj","nvar"] },
    "csgrsh": { "lj":["nnzj","nvar"] }
    }
nlp_ignore = ["usetup", "csetup"]

s="  "
el='\n'+2*s

def wrap(str):
    return el.join(textwrap.wrap(str))

# Workarounds
ignore_intent = ["ureport", "creport"]

cutest = os.getenv('CUTEST', "")
if cutest is "":
    print("ERROR: Variable CUTEST not set. Verify your CUTEst installation.")
    exit(1)

# The function definitions are being read from the C include file.
# This should probably be improved to obtain more information about the
# functions, but this is easier.
def function_names():
    functions = []
    with open(cutest+"/include/cutest.h") as file:
        # Each new function starts with
        # void CUTEST_xxx
        for line in file:
            if "void CUTEST" in line:
                name = re.search('CUTEST_([a-z]*)', line).group(1).strip()
                functions.append(name)
    return functions

# Reads the function to determine each argument with type and dimensions
def get_function_data(name):
    args = []
    types = []
    intents = []
    dims = []
    with open(os.environ['CUTEST']+'/src/tools/'+name+'.f90','r') as f:
        start_function = False
        start_fundef = False
        for line in f:
            line = line.strip().lower()
            #print(line)
            if "subroutine cutest_"+name+"(" in line:
                start_function = True
                start_fundef = True
            if start_fundef:
                match = re.search("([0-9a-zA-Z_, ]*)(\)|&)", line).group(1)
                for arg in match.split(','):
                    arg = arg.strip()
                    if arg == "status":
                        arg = "io_err"
                    elif arg == "":
                        continue
                    args.append(arg)
                if ")" in line:
                    start_fundef = False
                    types = ['']*len(args)
                    intents = ['']*len(args)
                    dims = ['']*len(args)
            if start_function:
                for t in [t for t in cutypes.keys() if t in line]:
                    intent = re.search("intent\( ([a-z]*) \)", line)
                    if intent is None:
                        if name in ignore_intent and \
                                "wp = kind" not in line.lower():
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
                        dim = []
                    lineargs = re.search(":: (.*)", line).group(1).split(',')
                    for arg in lineargs:
                        if arg.strip() == "status":
                            arg = "io_err"
                        if is_ptr:
                            tmp = []
                            for d in dim:
                                if ":" in d:
                                    a = d.split(':')[0]
                                    b = d.split(':')[1]
                                    d = "{} - {} + 1".format(b.strip(),a.strip())
                                else:
                                    d = d.strip()
                                tmp.append(d)
                            dim = tmp
                        else:
                            dim = []
                        fname = arg.strip().lower()
                        i = args.index(fname);
                        types[i] = t
                        intents[i] = intent
                        dims[i] = dim
            if start_function and "end subroutine" in line:
                break
    return args, types, intents, dims

def arguments (args, types, intents, dims, use_types = True, use_nlp = False,
        intent = "all", all_ptrs = True, typeset = jltypes, inplace = False,
        cint_array = False):
    str = []
    for i, arg in enumerate(args):
        if use_nlp and arg == "io_err" and intent != "out":
            str.append("nlp::CUTEstModel")
            continue
        # When using nlp, every `in` argument that is integer is inside nlp
        if use_nlp and intents[i] == "in" and arg in nlp_equivalent.keys():
            continue
        # Check for intent, but when inplace is True, output array variables are
        # passed as input
        if inplace and intents[i] == "out":
            if intent == "out" and len(dims[i]) > 0:
                continue
            if intent == "in" and len(dims[i]) == 0:
                continue
        else:
            if intent != "all" and intents[i] != intent:
                continue
        if intent == "out" and arg == "io_err":
            continue
        if use_types:
            t = typeset[types[i]]
            if len(dims[i]) > 0 or all_ptrs:
                if t == "Int" and intents[i] == "out" and inplace and cint_array:
                    t = "Cint"
                dim = max(1, len(dims[i]))
                t = "Array{{{}, {}}}".format(t, dim)
            str.append("{}::{}".format(arg, t))
        else:
            if intent == "out" and all_ptrs == True and len(dims[i]) == 0:
                str.append(arg+"[1]")
            else:
                str.append(arg)
    return ', '.join(str)


def core_function(name, args, types, dims):
    str = ""
    arg_call = arguments(args, types, [], dims, intent="all",
            use_nlp=False, use_types=True, all_ptrs=True, typeset=cutypes)
    str += "function "+name+"("+wrap( "{}, libname".format(arg_call))+")\n"
    str += s+'@eval ccall(("cutest_{}_", $(libname)), Void,\n'.format(name)
    ptrs = ["Ptr{{{}}}".format(cutypes[t]) for t in types]
    if len(ptrs) == 1:
        ptrs.append('')
    str += 2*s + "(" + wrap(', '.join(ptrs)) + "),\n"
    str += 2*s + wrap(', '.join(["$({})".format(v) for v in args])) + ")\n"
    str += "end\n"
    return str

core_file = open("src/core_interface.jl", "w")

names = function_names()

core_file.write(wrap("export " + ', '.join([x for x in names]))+"\n")
for name in names:
    args, types, intents, dims = get_function_data(name)
    core_file.write(core_function(name, args, types, dims))
    core_file.write("\n")

core_file.close()

