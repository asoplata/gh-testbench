

1. Install Windows Subsystem for Linux (WSL): Open the "PowerShell" or "Windows Command Prompt" programs in administrator mode by right-clicking either and selecting "Run as administrator". Then, in the window, run the following command:

```
wsl --install
```

Follow the default options for your install. For more information, see https://learn.microsoft.com/en-us/windows/wsl/install .

2. Close the PowerShell or Command Prompt window.
3. You will now have a new App available called "Ubuntu". Run that app. (This app runs a full version of the Linux operating system from inside Windows.)
4. The first time you start Ubuntu, it will prompt you to "Create a default Unix user account" and ask for a password. Make sure you write down your password somewhere.
5. You should now see a prompt and a blinking cursor similar to PowerShell/Command Prompt. Copy and paste the following commands. If you entered a password in Step 4, enter that when it prompts you for your password. (This step installs some system packages we need.)

```bash
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install wget
```

6. In the same window, copy and paste the following commands, then follow the prompts. We strongly recommend that when are asked  `Do you wish to update your shell profile to automatically initialize conda?` you enter `yes`. If you do not, then you will have to manually activate Conda whenever you open your Ubuntu app using the command this program provides at the end. (If you see output similar to `WARNING: Your machine hardware does not appear to be x86_64`, then please contact us. You may be able to install by using https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh instead.)

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

7. Close the Ubuntu window, then open a new one. Your prompt should now saw `(base)` at the beginning.
8. Copy and paste the following series of commands. These will remove any existing Conda environments named `hnn-core-env`, but it will install HNN with Parallelism/MPI support, which is the fastest version of HNN.

```bash
conda activate base
conda env remove -y -n hnn-core-env
conda create -y -q -n hnn-core-env python=3.12
conda activate hnn-core-env
mkdir -p $CONDA_PREFIX/etc/conda/activate.d $CONDA_PREFIX/etc/conda/deactivate.d
echo "export OLD_LD_LIBRARY_PATH=\$LD_LIBRARY_PATH" >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\${CONDA_PREFIX}/lib" >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
echo "export LD_LIBRARY_PATH=\$OLD_LD_LIBRARY_PATH" >> $CONDA_PREFIX/etc/conda/deactivate.d/env_vars.sh
echo "unset OLD_LD_LIBRARY_PATH" >> $CONDA_PREFIX/etc/conda/deactivate.d/env_vars.sh
export OLD_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${CONDA_PREFIX}/lib
conda install -y -q "openmpi>5" mpi4py -c conda-forge
pip install "hnn-core[gui,opt,parallel]"
```

9. HNN should now be installed! Next, run the following commands, and **write down the number** that is output. (This is the number of "Cores" for MPI that you should use later.)

```bash
conda activate hnn-core-env
python -c "import psutil ; print(psutil.cpu_count(logical=False)-1)"
```

10. Test that everything is working by starting the HNN GUI. This consists of two steps. First, enter the following command in your Ubuntu app

```bash
hnn-gui
```

11. Then, go to your browser, and navigate to [http://localhost:8866](http://localhost:8866)
12. You should now see the HNN GUI window. In the `Simulation` tab, set `Cores` to the number you received from step 9, and then run a simulation to test that HNN works.
13. You're done! If your simulation completed then HNN is installed.
14. In the future, the next time you need to re-enter our Conda Environment that we have installed HNN into, do the following: Open the Ubuntu program, type `conda activate hnn-core-env`, and that's it! From there, you can either run Python code using the HNN API that you have writen, or start the GUI using the `hnn-gui` command. Note that every time you start the GUI, you will need to navigate to [http://localhost:8866](http://localhost:8866) in your browser.
