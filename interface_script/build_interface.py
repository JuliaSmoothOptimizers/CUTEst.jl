#!/usr/bin/env python

import os
import re
import subprocess
import textwrap

# Type conversion
cutypes = {"integer":"Cint", "doublereal":"Cdouble", "logical":"Cint",
        "char":"Cchar", "real":"Cdouble"}
jltypes = {"integer":"Int", "doublereal":"Float64", "logical":"Bool",
        "char":"UInt8", "real":"Float64"}

# NLP related
nlp_equivalent = {"n":"nvar", "m":"ncon", "lj":"nnzj", "lh":"nnzh"}
nlp_exception  = {
    "csgr": { "lj":["nnzj","nvar"] },
    "csgrsh": { "lj":["nnzj","nvar"] }
    }
nlp_ignore = [ "usetup", "csetup", "udimen", "cdimen", "udimsh", "cdimsh",
    "udimse", "cdimse", "cdimsj", "unames", "cnames" "connames", "varnames",
    "uvartype", "cvartype", "cterminate", "uterminate" ]

s="  "
el='\n'+2*s

def wrap(str, spc=el):
    return spc.join(textwrap.wrap(str))

# Workarounds
ignore_intent = ["ureport", "creport"]

cutest = os.getenv('CUTEST', "")
if cutest is "":
    print("ERROR: Variable CUTEST not set. Verify your CUTEst installation.")
    exit(1)

# Read from $CUTEST/man/man3/cutest_... between DESCRIPTION and ARGUMENTS
def man_description(name):
    my_env = os.environ
    my_env["MANWIDTH"] = "1000"
    out = subprocess.check_output(["man", "-P", "cat", "cutest_"+name],
            universal_newlines = True, env = my_env)
    desc = []
    parsing = False
    for line in out.split("\n"):
        if "DESCRIPTION" in line:
            parsing = True
            continue
        if "ARGUMENTS" in line:
            break
        if parsing:
            desc.append(line.strip())
    s = re.sub('CUTEST_', ' ', " ".join(desc))
    s = re.sub(' +', ' ', s)
    return wrap(s, "\n")

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
                        dim = re.search("dimension\(([ a-z_,:0-9+]*)\)",
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

def arguments(args, types, intents, dims, use_types = True, intent = "all",
        all_ptrs = True, typeset = jltypes, inplace = False):
    str = []
    for i, arg in enumerate(args):
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
                dim = max(1, len(dims[i]))
                if t == "Int":
                    t = "Cint"
                t = "Array{{{}, {}}}".format(t, dim)
            str.append("{}::{}".format(arg, t))
        else:
            if intent == "out" and all_ptrs == True and len(dims[i]) == 0:
                str.append(arg+"[1]")
            else:
                str.append(arg)
    return ', '.join(str)

def header_doc(name):
    str = '"""# {}\n'.format(name)
    if name == "cstats":
        return str
    str += man_description(name) + "\n\n"
    str += "For more information, run the shell command\n\n"
    str += "    man cutest_" + name + "\n\n"
    str += "Usage:\n\n"
    return str

def core_doc(name, args, types, intents, dims):
    help_args = arguments(args, types, [], dims, intent="all",
            use_types=False, all_ptrs=True, typeset=cutypes)
    str = "    " + name + "(" + wrap(help_args, "\n") + ")\n\n"
    n = max([7] + [len(arg) for arg in args])
    for i, arg in enumerate(args):
        k = n - len(arg)
        d = max([len(dims[i]), 1])
        str += "  - {}: {}[{}] Array{{{}, {}}}\n".format(arg, " "*k,
                intents[i].upper(), cutypes[types[i]], d)
    return str

def spec_doc(name, args, types, intents, dims, inplace):
    if name == "cstats":
        return ""
    in_args = arguments(args, types, intents, dims, intent="in",
            use_types=False, all_ptrs=False, inplace=inplace)
    out_args = arguments(args, types, intents, dims, intent="out",
            use_types=False, all_ptrs=False, inplace=inplace)

    str = ""
    if inplace:
        name += "!"
    str += "    "
    if out_args != "":
        str += "{} = ".format(out_args)
    str += "{}({})\n\n".format(name, in_args)

    n = max([7] + [len(arg) for arg in args])
    for i, arg in enumerate(args):
        if arg == "io_err":
            continue
        k = n - len(arg)
        t = jltypes[types[i]]
        if len(dims[i]) > 0:
            if t == "Int":
                t = "Cint"
            t = "Array{{{}, {}}}".format(t, len(dims[i]))
        str += "  - {}: {}[{}] {}\n".format(arg, " "*k,
                intents[i].upper(), t)
    return str

def footer_doc(name):
    return '"""\n' + name + "\n\n"

def core_function(name, args, types, dims):
    str = ""
    arg_call = arguments(args, types, [], dims, intent="all",
            use_types=True, all_ptrs=True, typeset=cutypes)
    str += "function "+name+"("+wrap(arg_call)+")\n"
    str += s+'ccall(dlsym(cutest_lib, "cutest_{}_"), Void,\n'.format(name)
    ptrs = ["Ptr{{{}}}".format(cutypes[t]) for t in types]
    if len(ptrs) == 1:
        ptrs.append('')
    str += 2*s + "(" + wrap(', '.join(ptrs)) + "),\n"
    str += 2*s + wrap(', '.join(args)) + ")\n"
    str += "end\n"
    return str

def specialized_function(name, args, types, intents, dims, inplace = False):
    str = ""
    arg_call = arguments(args, types, intents, dims, intent="in",
            use_types=True, all_ptrs=False, inplace=inplace)

    str += "function " + name
    if inplace:
        str += "!"
    if arg_call != "":
        str += wrap("({})".format(arg_call) )+"\n"
    else:
        str += "()\n"
    for i, arg in enumerate(args):
        if intents[i] == "in":
            continue
        if len(dims[i]) > 0 and inplace:
            continue
        t = cutypes[types[i]]
        if len(dims[i]) > 0:
            str += s+"{}".format(arg)
            str += " = Array({}, {})\n".format(t, ', '.join(dims[i]))
        else:
            str += s+"{} = {}[0]\n".format(arg, t)
    out = []
    for i, arg in enumerate(args):
        if len(dims[i]) > 0:
            out.append("{}".format(arg))
        elif intents[i] == "out":
            out.append("{}".format(arg))
        else:
            out.append("{}[{}]".format(cutypes[types[i]], arg))
    str += wrap(s+"{}({})".format(name, ', '.join(out))) + "\n"
    str += s+"@cutest_error\n"
    returns = arguments(args, 0, intents, dims, intent="out", use_types=False,
            all_ptrs=True, inplace=inplace)
    if returns != "":
        returns = " " + returns
    str += s+"return"+returns
    str += "\nend\n"
    return str

def need_inplace(intents, dims):
    n = len(intents)
    return any([intents[i] == "out" and len(dims[i]) > 0 for i in range(n)])

core_file = open("src/core_interface.jl", "w")
spec_file = open("src/specialized_interface.jl", "w")

names = function_names()

core_file.write(wrap("export " + ', '.join([x for x in names]))+"\n\n")
spec_file.write(wrap("export " + ', '.join([x for x in names]))+"\n")
spec_file.write(wrap("export " + ', '.join([x+"!" for x in names]))+"\n")
spec_file.write("\n")

for name in names:
    args, types, intents, dims = get_function_data(name)
    core_file.write(header_doc(name))
    core_file.write(core_doc(name, args, types, intents, dims))
    core_file.write('"""\n')
    core_file.write(core_function(name, args, types, dims))
    core_file.write("\n")

    # Some functions return values that should be obtained while creating nlp
    spec_file.write('"""\n')
    spec_file.write(spec_doc(name, args, types, intents, dims, inplace=False))
    spec_file.write('"""\n')
    spec_file.write(specialized_function(name, args, types, intents, dims,
        inplace=False))
    spec_file.write("\n")

    # Some functions don't need a ! version
    if need_inplace(intents, dims):
        spec_file.write('"""\n')
        spec_file.write(spec_doc(name, args, types, intents, dims, inplace=True))
        spec_file.write('"""\n')
        spec_file.write(specialized_function(name, args, types, intents, dims,
            inplace=True))
        spec_file.write("\n")

core_file.close()
spec_file.close()
