#!/bin/bash -l

echo $'\n--> Attempting to build the maximal "hnn-core-all" conda package...'

# Need to also include the "defaults" channel, since there is a file clobber/conflict between
# two dependencies if you only use the "conda-forge" channel (as of 20250513)
if [ `uname` == Darwin ]; then
    conda-build recipe -c defaults -c conda-forge
elif [ `uname` == Linux ]; then
    conda-build --prefix-length=80 recipe -c defaults -c conda-forge
    # TODO
    # conda-build --croot=/tmp/asdf recipe -c defaults -c conda-forge
fi
