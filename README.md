# Machine Learning Dev PC Setup
Quick way to consistently set up a new PC with my personal dev preferences for Machine Learning.

> **_Tested most recently on a Surface Book 2, Intel Core i7-8650U, with NVIDIA GeForce GTX 1050 and Windows 10 Pro 1709_**

# 1. Set up OS and Productivity Tools
1. Unbox and admire your shiny new hardware. Go through default OS setup.
2. Install all updates OS (including upgrading to the latest OS version if needed). 
3. Launch Microsoft Store and install all app updates.
4. Enable malware protection, e.g. Windows Defender or other.
5. Download and install Microsoft Office (or other productivity suite), instructions will vary. Sign in.
6. Clean up Taskbar. Remove extraneous items and pin Powershell, Outlook, etc.

# 2. Set up Dev Tools
See comments in ``setup.ps1`` for more information. This is an automated script that installs:

1. [Chocolatey](https://chocolatey.org/)
2. [Git](https://git-scm.com/)
3. [miniconda3](https://conda.io/miniconda.html) - this includes python 3 by default.
4. [Jupyter](https://jupyter.org)
5. [Visual Studio Code](https://code.visualstudio.com/), with the associated [python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python), [pylint](https://www.pylint.org), and [autopep8](https://pypi.python.org/pypi/autopep8)
6. [Google Chrome](https://www.google.com/chrome/)
7. [Node](https://nodejs.org/)

To begin setup, launch Powershell **as an admin** and paste in the following:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tjaffri/ml-dev-pc-setup/master/setup.ps1'))
```

> **Important Note**: After setup is complete, close the powershell window and open a fresh one to continue. For the subsequent commands you can use either ``Powershell`` or ``Git Bash`` (pick your poison). I use ``Git Bash`` to help ease muscle memory when working across dev platforms. If you want to do the same, you might find the ``.bashrc`` file in this repo useful to enable conda and set the path for nodejs automatically.

# 3. Configure Visual Studio Code
After ``setup.ps1`` is complete, and before you launch Visual Studio Code, install some extensions you will need. You may need another elevated prompt for this (launch git bash as administrator):

```bash
source activate
code --install-extension ms-python.python
pip install --upgrade pylint
pip install --upgrade autopep8
```

Now that the extensions are installed, you can launch Visual Studio Code to read the docs, set defaults, and pin it to the taskbar.

To use python in Visual Studio Code, read the docs here: https://code.visualstudio.com/docs/python/python-tutorial. You can skip the part where you need to install python, code linters or formatters since those were installed already by ``setup.ps1``.

Here are some recommended user (global) settings for vscode. You can go to ``File > Preferences > Settings`` or just do ``Command-,`` to bring up user settings. Paste in the following (make sure you are in user settings, not workspace settings which are project specific overrides):

```
{
  // Controls auto save of dirty files. Accepted values:  'off', 'afterDelay', 'onFocusChange' (editor loses focus), 'onWindowChange' (window loses focus). If set to 'afterDelay', you can configure the delay in 'files.autoSaveDelay'.
  "files.autoSave": "afterDelay",
  // Commit all changes when there are no staged changes.
  "git.enableSmartCommit": true,
  // Arguments passed in. Each argument is a separate item in the array.
  "python.formatting.autopep8Args": [
    "--max-line-length=120"
  ],
  // The path of the shell that the terminal uses on Windows.
  "terminal.integrated.shell.windows": "C:\\Program Files\\Git\\bin\\bash.exe",
}
```

> **Note**: As you use vscode, if you get error messages stating that pylint (code linter) or autopep8 (code formatter) is not installed, or get other problems related to importing modules make sure you have set the environment in vscode to python3. Look on the bottom left edge of the IDE to select the environment. If these issues persist, make sure your current conda environment has these packages installed, e.g. type ``conda install pylint`` or ``pip install --upgrade autopep8`` after activating the environment you are using (see section below on managing environments).

# 4. Configure NVIDIA GPU
Assuming you have a compatible NVIDIA GPU, follow the instructions [here](https://www.tensorflow.org/install/install_windows#requirements_to_run_tensorflow_with_gpu_support) to configure it. Here are some additional notes on setup:

1. You can download Visual Studio 2017 Community Edition for free [here](visualstudio.com/downloads).
2. During setup, select the "Desktop development with C++" workload to install the appropriate compiler.
3. **Important:** CUDA 9.1 is not compatible with Tensorflow 1.5 binaries at the time of writing (you can compile from sources and that should work). So be careful what version of CUDA you install. See [here](https://github.com/tensorflow/tensorflow/releases) to check the current release of tensorflow... version 1.6 (when released) should be compatible with CUDA 9.1 but till then install CUDA 9.0 from [here](https://developer.nvidia.com/cuda-90-download-archive).
4. When installing the CUDA tools per the instructions in the link above, make sure you install the base installer as well as any patches available.
5. When building the deviceQuery and bandwidthTest applications per CUDA tools setup documentation, you may need to retarget the solution to your current Windows SDK version to build successfully. The pre-built binaries referenced in the docs may not be available depending on the version of CUDA you download.

# 5. Configure and Run Python
Follow the conda user guide to use python, create and manage environments: https://conda.io/docs/user-guide/overview.html. The following is a condensed summary for common workflows.

### 5.1. Managing Your Environment
Some commonly use packages are installed in the base (global) conda environment (e.g. tensorflow and jupyter). For some standard types of projects you should be able to use that base (global) environment without any changes. The environment should already be active in any bash or powershell window with this standard setup, however if you need to activate it elsewhere just type ``source activate``.

However, there will some situations where there are packages that you may wish to install for a specific project, which are not available in the global environment (and you don't want to install them in the global environment either, perhaps due to versioning issues).

For such projects with custom package requirements, it is recommended that you create a new conda environment. This is a good practice in general when starting new projects since you never know when a custom package will be required.

```bash
conda create --name project-name --clone root
source activate project-name
```

Whenever you update your environment, you should save its definition in case somebody else wants to replicate your environment and build your project. Do this by typing:

```bash
source activate project-name
conda env export > environment.windows.yml
```

Others can then create an environment using your saved ``environment.yml`` file by typing:

```bash
conda env create -f environment.windows.yml
source activate project-name
```

If you clone a repo that contains an ``environment.yml`` file, you should run the same commadn above to create the environment for that repo locally.

### 5.2. Running Projects
To run a script, first ensure that the appropriate conda environment is active. If you see ``(base) `` as a prefix to your bash shell then you are in the base (global) environment, which should be true for all bash shells. If you want to use another environment, for example to use some custom packages that are not installed in the base environment, make sure you run ``source activate project-name``.

Next, type ``python filename.py`` and the correct version of python plus all the dependencies you installed into the environment should resolve.

# 6. Configure Machine Learning Frameworks
Next, install the machine learning frameworks you need which were not installed already by ``setup.ps1`` (the following is my starter list).

### 6.1. Install Jupyter, matpolotlib, etc.
We begin by ensuring conda is up to date and we are in the base conda environment.

```bash
source activate
conda update conda
conda install jupyter -y
conda install matplotlib -y
```

### 6.2. Install Tensorflow

More information [here](https://www.tensorflow.org/install/install_windows).

If you have a compatible NVIDIA GPU, install tensorflow-gpu via native pip using:

```bash
source activate
pip install --ignore-installed --upgrade tensorflow-gpu
```

If you don't have a compatible GPU, install tensorflow via native pip using:

```bash
source activate
pip install --ignore-installed --upgrade tensorflow
```

### 6.3. Validate Tensorflow Installation
More information [here](https://www.tensorflow.org/install/install_windows#validate_your_installation).

### 6.4. Install Keras
More information [here](https://keras.io/#installation).

# 7. Benchmark
``setup.ps1`` does basic Tensorflow setup validation. In addition, you can benchmark your setup to make sure it is performing well by running:

```bash
cd ~
git clone https://github.com/tensorflow/models.git benchmark
cd benchmark
python ./tutorials/image/mnist/convolutional.py
```

The last line will print out per-step timing. With a CPU-only setup (e.g. a Mac without a tensorflow-supported Nvidia GPU), you should expect ~115ms per step. With a fast GPU setup you should get ~10ms per step, a ~10X improvement.

After benchmarking is done, you can delete the ``benchmark`` dir created above.
# 8. Update
To update all chocolatey packages, type:

```bash
choco upgrade all
```

To update all base (global) environment conda packages, type:

```bash
conda update conda
conda update --all
```

To update CUDA and Tensorflow etc you need to peform the steps above all over again.

Please enjoy responsibly.
