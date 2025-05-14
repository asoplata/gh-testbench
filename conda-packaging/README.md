
# hnn-core-conda-packaging

This repo has all the code and metadata you should need to manually build 

This probably only needs to be done every time there is a new version release

This creates packages that you can distribute the "easiest" way, which is 1. build the package (TODO explain what artifact is) locally, then 2. push that built package to <anaconda.org> under your account. In the future, it would be nice to transition to using "conda-forge" "feedstocks" (which use CI runners to build the artifacts).

TODO

- optim
- tmp vs prefix


## How to build

purge


- Note: I can attest, it *is* possible to break your Conda install *as a whole* by doing certain actions. E.g., renaming a package `*.conda` file to something else, then trying to install it locally. This seems to break some kind of Conda-wide metadata configuration and makes it impossible to install packages into existing environments. So uhh don't do that.

## How to install

- Locally:

- From the cloud:

## How to upload

Example: (replace the architecture-specific directories and ultimate filename with whatever version you're uploading:

```
anaconda upload --user jonescompneurolab $CONDA_PREFIX/conda-bld/linux-64/hnn-core-all-0.4.1-py312_0.conda
```

## Explanation of recipe contents

- `build.sh`, `meta.yaml`, and `run_test.py` are all filenames with special meaning in the Conda build process; you probably do not want to rename them.

- in `meta.yaml` files, some of the comments ARE required, and DO impact the build process, using Jinja templating.

## Caveats, etc.

You might want to sit down for this part. Additionally, there are a few more (but small) caveats in some of the scripts themselves.

- you need to build in your "base" environment, NOT in a custom environment
- needs forge AND defaults channel for building
- needs forge for run
- nrn wheels
- shipping compiled objects
- Linux:
    - If you are trying to build the package 
- MacOS:
    - XCode stuff
