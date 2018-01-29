# Machine Learning Dev PC Setup
Quick way to consistently set up a new PC with my personal dev preferences for Machine Learning.

> **_Tested most recently on a Surface Book 2, Intel Core i7-8650U, with NVIDIA GeForce GTX 1050 and Windows 10 Pro 1709_**

# Set up OS and Productivity Tools
1. Unbox and admire your shiny new hardware. Go through default OS setup.
2. Install all updates OS (including upgrading to the latest OS version if needed). 
3. Launch Microsoft Store and install all app updates.
3. Download and install Microsoft Office (or other productivity suite), instructions will vary. Sign in.
4. Clean up Taskbar. Remove extraneous items and pin Powershell, Outlook, etc.

# Set up Dev Tools
See comments in ``setup.ps1`` for more information. This is an automated script that installs:

1. [Chocolatey](https://chocolatey.org/)
2. [Git](https://git-scm.com/)
3. [Python 3](https://www.python.org/downloads/)
4. [Visual Studio Code](https://code.visualstudio.com/)
6. [Google Chrome](https://www.google.com/chrome/)

To begin setup, launch Powershell **as an admin** and paste in the following:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tjaffri/ml-dev-pc-setup/master/setup.ps1'))
```

After setup is complete, Visual Studio Code will launch automatically. You can read the docs, set defaults, and pin to the Taskbar.

To finish setting up Visual Studio Code, follow the instructions here: https://code.visualstudio.com/docs/python/python-tutorial. You can skip the part where you need to install python, and simply select the python 3 environment in vscode.

# Configure NVIDIA GPU
Assuming you have a compatible NVIDIA GPU, follow the instructions [here](https://www.tensorflow.org/install/install_windows#requirements_to_run_tensorflow_with_gpu_support) to configure it. Here are some additional notes on setup:

1. You can download Visual Studio 2017 Community Edition for free [here](visualstudio.com/downloads).
2. During setup, select the Desktop development with C++ workload to install the appropriate compiler.
> Note: CUDA 9.1 is not compatible with Tensorflow 1.5 binaries at the time of writing (you can compile from sources and that should work). So be careful what version of CUDA you install. See [here](https://github.com/tensorflow/tensorflow/releases) to check the current release of tensorflow... version 1.6 (when released) should be compatible with CUDA 9.1.
3. When installing the CUDA tools per the instructions in the link above, make sure you install the base installer as well as any patches available.
4. When building the deviceQuery and bandwidthTest applications per CUDA tools setup documentation, you may need to retarget the solution to your current Windows SDK version to build successfully. The pre-built binaries may not work.

# Configure Python
To configure Python, **close and relaunch** Powershell **as an admin** and perform the following steps:

## Set up pipenv

```powershell
pip3 install pipenv
```

## Install Tensorflow
More information [here](https://www.tensorflow.org/install/install_windows).

If you have a compatible NVIDIA GPU, install tensorflow-gpu via native pip using:

```powershell
pip3 install --upgrade tensorflow-gpu
```

If you don't have a compatible GPU, install tensorflow via native pip using:

```powershell
pip3 install --upgrade tensorflow
```

## Validate Tensorflow Installation
More information [here](https://www.tensorflow.org/install/install_windows#validate_your_installation).

# Use
...

# Test
In addition to the validation above, you can benchmark your setup to make sure it is performing well by running:

```powershell
mkdir Source
cd Source
git clone https://github.com/tensorflow/models.git
python models/tutorials/image/mnist/convolutional.py
```

The last line will print out per-step timing. With a CPU-only setup (e.g. a PC without a tensorflow-supported Nvidia GPU), you should expect ~110ms per step. With a fast GPU setup you should get <10ms per step, a 10X improvement.

# Update
...

Please enjoy responsibly.
