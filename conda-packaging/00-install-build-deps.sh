#!/bin/bash -l

echo $'\n--> Preparing to install dependencies for building Conda packages...'
echo $'--> NOTE: To build conda packages, it is recommended that you DO use the "base" environment, NOT a custom environment, unlike normal conda usage.'
echo $'\nSee https://docs.conda.io/projects/conda-build/en/stable/install-conda-build.html for more details.'

conda activate base
# Use the recommended "grayskull" for building our initial skeleton
conda install -y -q conda-build conda-forge::grayskull
