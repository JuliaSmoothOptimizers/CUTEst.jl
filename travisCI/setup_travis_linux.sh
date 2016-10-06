#!/bin/bash
set -ev

gfover=$(gfortran -dumpversion | cut -f1,2 -d.)
sudo ln -s /usr/lib/gcc/x86_64-linux-gnu/$gfover/libgfortran.so /usr/local/lib
