#!/bin/bash

# TODO batch that installs neuron???

# AES below copied and adapted from tensorflow's old recipes

# install using pip from the whl file provided by Google

# if [ `uname` == Darwin ]; then
#     pip install "neuron >= 7.7"
# fi

# if [ `uname` == Linux ]; then
#     pip install "neuron >= 7.7"
# fi


# if [ `uname` == Darwin ]; then
#     pip install "neuron >= 7.7"
#     # pip install . -vv --no-deps --no-build-isolation
#     pip install .
# fi

# if [ `uname` == Linux ]; then
#     pip install "neuron >= 7.7"
#     # pip install . -vv --no-deps --no-build-isolation
#     pip install .
# fi

# # doesn't seem to install since pip can't seem to find pypi
# pip install "neuron >= 7.7"
# $PYTHON -m pip install "neuron >= 7.7"

echo "DEBUG HELLO"
echo "TODO add platform detn logic"

# platform name info https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#preprocessing-selectors

# # osx-arm64
# $PYTHON -m pip install https://files.pythonhosted.org/packages/76/89/4e659723194edb3351a37b60a474843e68f676bc983c41047c234b544494/NEURON-8.2.6-cp312-cp312-macosx_11_0_arm64.whl

FILE_URL=https://files.pythonhosted.org/packages/76/89/4e659723194edb3351a37b60a474843e68f676bc983c41047c234b544494/NEURON-8.2.6-cp312-cp312-macosx_11_0_arm64.whl


# # osx-x86_64
# FILE_URL=https://files.pythonhosted.org/packages/d7/52/50ae4bf3dcc87cf71daa559f1b188b4a8e85f7f19073d976eb12821f8692/NEURON-8.2.6-cp312-cp312-macosx_10_15_x86_64.whl


# # linux64
# FILE_URL=https://files.pythonhosted.org/packages/14/4e/e0c65911a59b646274ba4f6740e8705ff29863879b0a629e92666d682ebd/NEURON-8.2.6-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl

# # aarch64 (this is linux-only, see https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#preprocessing-selectors )
# FILE_URL=https://files.pythonhosted.org/packages/3a/72/6f682afafcb22d795d4c8da189976f9e648eacf7b147ead28c3cd6e7c0fe/NEURON-8.2.6-cp312-cp312-manylinux_2_17_aarch64.manylinux2014_aarch64.whl

# NEURON-8.2.6-cp312-cp312-macosx_10_15_x86_64.whl (14.0 MB view details)

# NEURON-8.2.6-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (15.5 MB view details)

# Uploaded Jul 25, 2024 CPython 3.12 manylinux: glibc 2.17+ x86-64
# NEURON-8.2.6-cp312-cp312-manylinux_2_17_aarch64.manylinux2014_aarch64.whl (14.9 MB view details)

# Uploaded Jul 25, 2024 CPython 3.12 manylinux: glibc 2.17+ ARM64
# NEURON-8.2.6-cp312-cp312-macosx_11_0_arm64.whl (13.2 MB view details)


# $PYTHON -m pip install $FILE_URL
$PYTHON -m pip install --no-deps $FILE_URL


echo "DEBUG HELLO"



# $PYTHON -m pip install https://files.pythonhosted.org/packages/20/8a/767a70e04e4532c05f2b60dc817672e5bfec4911ca6655e8943eadf80670/h5io-0.2.4-py3-none-any.whl

# $PYTHON -m pip install https://files.pythonhosted.org/packages/1d/89/6b4624122d5c61a86e8aebcebd377866338b705ce4f115c45b046dc09b99/find_libpython-0.4.0-py3-none-any.whl

$PYTHON -m pip install . -vv --no-deps --no-build-isolation
# $PYTHON -m pip install .

