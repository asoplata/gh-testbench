#!/bin/bash -l

echo $'\n--> Preparing to build the hnn-core conda "skeleton" using grayskull...'
echo $'--> NOTE: This will OVERWRITE the current build setup files!'
echo $'\nProceed? (y/[n])'
read yesno
if [[ $yesno == [Yy]* ]]; then
    # grayskull pypi hnn-core
    conda skeleton pypi hnn-core
else
    echo "Cancelled, exiting."
fi
