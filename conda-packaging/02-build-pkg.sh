#!/bin/bash -l

echo $'\n--> Preparing to build the actual hnn-core conda package...'
if [ `uname` == Darwin ]; then
    conda-build hnn-core -c defaults -c conda-forge
elif [ `uname` == Linux ]; then
    conda-build --prefix-length=80 hnn-core -c defaults -c conda-forge
fi

# conda-build --croot=/tmp/asdf hnn-core -c defaults -c conda-forge
# conda-build --prefix-length=80 hnn-core -c defaults -c conda-forge

# conda-build hnn-core -c conda-forge # leads to a certain clobber
