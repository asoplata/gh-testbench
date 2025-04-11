#!/bin/bash -l

echo $'\n--> Preparing to build the actual hnn-core conda package...'
# conda-build hnn-core -c defaults -c conda-forge
conda-build hnn-core -c conda-forge
