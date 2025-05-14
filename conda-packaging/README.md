
# hnn-core-conda-packaging

This repo has all the code and metadata you need to build the Conda packages for HNN-Core. These packages (`hnn-core-all` and `hnn-core`)should be remade and uploaded every time there is a new version release. Note that currently, this is still a very "manual" process.

This repo is based off of discusison in https://github.com/jonescompneurolab/hnn-core/issues/950 .

# Summary

### Packages

This gives you what you need to build two distinct packages:

- `hnn-core`: A Conda package providing the "minimal" version of HNN-Core, that is, ONLY the API. No GUI, no parallelism, nothin'! This is what has been uploaded to produce https://anaconda.org/jonescompneurolab/hnn-core .
- `hnn-core-all`: A Conda package providing a "maximal" version of HNN-Core, with ALL user-facing features (i.e. those for `gui`, `opt`, and both MPI and Joblib `parallelism`, but not `docs` or `testing`). This is what has been uploaded to produce https://anaconda.org/jonescompneurolab/hnn-core-all .

### Supported platforms

The below keywords are how the Conda package building system refers to these platforms. Definition: when I say "platform", I mean combination of OS and CPU architecture.

- `osx-arm64` (MacOS on Apple Silicon)
- `osx-64` (MacOS on x86_64)
- `linux-64` (Linux on x86_64) (can be *used* on Windows via WSL, but not necessarily *built* using WSL. May be possible, however.)

### Supported versions

Currently, these packages are ONLY built for Python 3.12 specifically. Support for older versions will be added soon.

# "Short" version of how to build the packages:

1. Install Anaconda.

2. Install your system dependencies for the `nrnivmodl` part of HNN-Core's install:
    - For MacOS, you must install Xcode Command-Line Tools using the command `xcode-select --install`. You MUST restart your computer after this, if they were not already installed.
    - For Linux, you must install the fundamental compilation/building tools for your distro. For example, on Ubuntu, the `build-essential` package is probably sufficient, using `sudo apt-get install build-essential`.

3. Clone this repo.

4. Enter your `base` environment, NOT a custom environment! All conda package building must be done in the `base` environment, see https://docs.conda.io/projects/conda-build/en/latest/install-conda-build.html for details.

5. Run the script `00-install-build-deps.sh` using `./00-install-build-deps.sh` or however you like. This installs the builder packages.

6. Begin by building the `hnn-core-all` package-file for your local platform, using the following sub-steps:
    A. `cd` into `hnn-core-all`. This subdirectory contains everything you should need for building the `hnn-core-all` package-file on your local platform.
    B. Run the local script `01-build-pkg.sh` using `./01-build-pkg.sh` or however you like. This will take a couple minutes, and this is where any problems will arise, since this is the actual package build step. See details below in the [How to build](#how-to-build) section.
    C. Assuming the last step was successful, there should now be some new files and folders located in a directory you can access with `cd $CONDA_PREFIX/conda-bld`. There should be a directory that is one of the above platform keywords of your local platform, e.g. `osx-arm64`. Inside that directory will be the "package-file" I keep mentioning, which will be have a name that ends in `.conda` like `<pkg name>-<pkg version>-<python version>_<build number>.conda`. For example, in my case, there is now a file there called `hnn-core-all-0.4.1-py312_0.conda`. This is the "package-file" that all this work is for.

7. Test the newly-built package file:
    A. First, install it into a new environment using the following:
```
conda create -y -q -n test python=3.12
conda activate test
conda install hnn-core-all -c local -c conda-forge  # Run this line exactly how it is!
```
    B. Then, run some test sims like with `hnn-gui` or whatever, and MAKE SURE to test that MPI parallelism works. Also test that Optimization works, by, for example, making sure that this script https://github.com/jonescompneurolab/hnn-core/blob/master/examples/howto/optimize_evoked.py at least successfully starts running the second iteration. You could also copy and run the tests locally, such as by downloading https://github.com/jonescompneurolab/hnn-core/tree/master/hnn_core/tests , installing `pip install pytest`, then running `pytest .`.
    C. If possible, try running the new package-file on another computer of the same platform. See [How to install](#how-to-install) below for how to do that (it's a little weird).

8. Finally, once you're satisfied that the package works, it's time to upload it. You will be uploading it from the command line, similar to how we've uploaded to Pypi in the past.
    A. If you haven't already, make an account on [anaconda.org](https://anaconda.org), and get your user account added to the [jonescompneurolab Organization](https://anaconda.org/jonescompneurolab) for permissions. WARNING: Note that you need an account on "anaconda dot ORG", not "dot COM" or "dot CLOUD"! Anaconda has many websites and you need to use [anaconda.org](https://anaconda.org). The different websites do not necessarily talk to each other!
    B. In your terminal run the command `anaconda login`. Note that that uses `anaconda` and not just `conda`! Also, if it complains that it doesn't have the command, you may need to `conda install anaconda-client`.
    C. You should now be ready to upload. Remember that "package-file" I specifically mentioned before? You need to upload that, but for the Organization, not your personal account. The example command I used to upload it before is this:
```
anaconda upload --user jonescompneurolab $CONDA_PREFIX/conda-bld/osx-arm64/hnn-core-all-0.4.1-py312_0.conda
```
Note that you will probably have to change the platform-specific directory name, and the exact filename, if you are reading this.
    D. Fortunately, in contrast to Pypi and `conda-forge`, uploads to [anaconda.org](https://anaconda.org) are NOT immutable, and CAN be changed. If you need to replace the package-file because of a mistake or any reason, you can Anaconda's existing version with a different local one, using a command like below (the only difference is the additional `--force` argument):
```
anaconda upload --force --user jonescompneurolab $CONDA_PREFIX/conda-bld/osx-arm64/hnn-core-all-0.4.1-py312_0.conda
```

9. Almost done: just to be safe, you should also test that the online version of the file works too. Depending on how soon Anaconda provides the newly uploaded package (usually instantly), do the following:
```
conda create -y -q -n test python=3.12
conda activate test
conda install hnn-core-all -c jonescompneurolab -c conda-forge  # Run this line exactly how it is!
```
Assuming all your testing works, you should be done with package delivery of `hnn-core-all` for your local platform.

10. Now, you get to do it all over again! Assuming you have built `hnn-core-all` for one of the three [Supported platforms](#supported-platforms), you should now do it for the remaining ones. Currently, this requires you to use a computer that HAS that platform. However, in the future, using CI runners (e.g. via Github Actions) will enable a way to do that without requiring you to have physical access to such a platform.

11. Now, you get to do it all over again, AGAIN! Repeat the above steps, except doing them for the package in the `./hnn-core` subdirectory, rather than the `./hnn-core-all` subdirectory. Since `hnn-core` is a subset of `hnn-core-all`, there should be no bugs in the build process for `hnn-core` that aren't first discovered when building `hnn-core-all`. You will instead be dealing with a similarly named package-file, for example like `$CONDA_PREFIX/conda-bld/linux-64/hnn-core-0.4.1-py312_0.conda`.

# Longer version details:

# How to build

wheels

purge


### Explanation of recipe contents

- `build.sh`, `meta.yaml`, and `run_test.py` are all filenames with special meaning in the Conda build process; you probably do not want to rename them.

- in `meta.yaml` files, some of the comments ARE required, and DO impact the build process, using Jinja templating.


- Note: I can attest, it *is* possible to break your Conda install *as a whole* by doing certain actions. E.g., renaming a package `*.conda` file to something else, then trying to install it locally. This seems to break some kind of Conda-wide metadata configuration and makes it impossible to install packages into existing environments. So uhh don't do that.

# How to install

- Locally:


Note that Conda has some strong opinions, and one of those is that you don't install the package by just passing in the file name. Instead, it treats locally-built packages using the "channel name" `local` (see https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/channels.html ). 


- From another computer:

Actually testing that a package-file you built on one computer works on a different computer of the same platform is a little weird but not too bad.

conda-index

- From the cloud:


# Caveats, etc.

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

# Future work

If you've read this far, then you've probably realized there's **significant** room for improvements.

- Top priority: Add support for more Python versions.
- Top priority: Removing the need to build locally. Ideally, we should make movements towards how `conda-forge` does it by building the actual package-files using CI runners: see the diagram at https://conda-forge.org/docs/maintainer/understanding_conda_forge/feedstocks/ . We could start by doing this using Github Actions. I don't know where the final package-files would end up (maybe as Releases? or just copied into the repo itself?).
- Relatedly, if we did start building our packages-files from CI, I would be wary and of any automatic pushes to `anaconda.org` directly, at least until provide more consistent testing. Part of this testing should be `hnn-core`'s actual tests themselves! Currently, using `hnn-core`'s tests on an install that is NOT a local-source-install is difficult, and would probably require code changes.
- Another future goal is to transition to providing HNN-Core conda packages via the `conda-forge` community system, instead of pushing specific package-files directly to `anaconda.org` as we currently do. This requires more work: https://conda-forge.org/docs/maintainer/adding_pkgs/ . We would need to work with the `conda-forge` community and eventual become maintainers of a "feedstock" repo, after adapting our build process to do things the `conda-forge` way. Their way is very different than ours: the feedstock repo is just the recipe + metadata, and ALL building is done through CI orchestration. This is made more complicated due to our very weird, platform-and-architecture-specific NEURON wheel dependency.
- There is currently a "clobber aka file clash" if you try to run the build using ONLY the `conda-forge` channel. By clobber, what I mean is that two different dependency packages both try to provide their own version of a certain shared library binary file. In other words, there is a problem with our dependency tree if we strictly use packages from the `conda-forge` channel. I've gotten around this for now by forcing our build to use BOTH the `defaults` and `conda-forge` channel, but it could result in other problems down the line, since we are mixing-and-matching packages from two very different channels. In general, the packages in `defaults` tend to be stable but much older, while the `conda-forge` packages tend to be much newer but also less stable (the classic software-package-management problem).
