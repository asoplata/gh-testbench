#!/bin/bash -l

echo $'\n--> Attempting to build the maximal "hnn-core-all" conda package...'

# Need to also include the "defaults" channel, since there is a file clobber/conflict between
# two dependencies if you only use the "conda-forge" channel (as of 20250513)
if [ `uname` == Darwin ]; then
    conda-build recipe -c defaults -c conda-forge
elif [ `uname` == Linux ]; then
    conda-build --croot=/tmp/asdf recipe -c defaults -c conda-forge
    # If the above 'croot' attempt runs into errors, especially with paths or
    # filesystem issues, then you can try uncommenting the following command
    # and using it instead. This 'croot' method for building on systems where
    # the main partition is encrypted is preferred, according to conda-build's
    # documentation, but the 'prefix-length' argument will work too. However,
    # the documentation claims it is less portable.
    #
    # conda-build --prefix-length=80 recipe -c defaults -c conda-forge

    echo "
--> Post-build Linux instructions: Note that the package, if it was built
correctly, has been built inside your TEMPORARY directory, i.e. '/tmp/asdf'.
This is done because Conda tries to build packages in environments where the
path exceeds 255 characters on purpose, but this is broken if you are building
on a partition that is disk-encrypted. There are two methods documented in the
build script to get around this, and the default build script uses one of them.
This also means you need to do a couple extra steps:

--> AFTER you have built the package, you should do the following:

1. Copy the directory at '/tmp/asdf/linux-64' (itself, not just the
contents) into '\$CONDA_PREFIX/conda-bld'. This is safe to do regardless
if you have built one or both packages. For example:

    cp -r /tmp/asdf/linux-64 \$CONDA_PREFIX/conda-bld

2. Re-index the conda-building directory you just copied the packages into (you
may have to 'conda install conda-index'). For example:

    conda index \$CONDA_PREFIX/conda-bld

3. Then, you should be good to go. Proceed with testing the packages, then
uploading them.
    "
fi
