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

To begin setup, launch Powershell **as an admin** and paste in the following:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tjaffri/ml-dev-pc-setup/master/setup.ps1'))
```

# 3. Configure Visual Studio Code
After setup is complete, Visual Studio Code will launch automatically. You can read the docs, set defaults, and pin it to the taskbar.

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
To configure Python, **close and relaunch** Powershell **as an admin** and perform the following steps:

### 5.1. Set up pipenv

```powershell
pip3 install pipenv
```

### 5.2. Install Tensorflow
More information [here](https://www.tensorflow.org/install/install_windows).

If you have a compatible NVIDIA GPU, install tensorflow-gpu via native pip using:

```powershell
pip install --upgrade tensorflow-gpu
```

If you don't have a compatible GPU, install tensorflow via native pip using:

```powershell
pip install --upgrade tensorflow
```

### 5.3. Validate Tensorflow Installation
More information [here](https://www.tensorflow.org/install/install_windows#validate_your_installation).

### 5.4. Install Keras
More information [here](https://keras.io/#installation).


# 6. Running Python
python 3 and tensorflow are available globally in this setup. No ``virtualenv`` needed to access tensorflow. Use ``pipenv`` to manage dependencies other than tensorflow for individual projects.

> **Note:** Official ``pipenv`` support in vscode is a [work in progress](https://github.com/Microsoft/vscode-python/issues/404). After that ships, the following steps will likely get simpler.

### 6.1. Installing Dependencies (or Starting Fresh)
1. Clone repo locally, then cd into it in a terminal, e.g. bash. If you're starting fresh, just ``mkdir`` a new directory.
2. Run vscode via ``code .``. Once vscode is running, launch the integrated terminal. Do subsequent operations in the vscode integrated terminal.
3. Run ``pipenv install --dev`` to install all dependencies using ``pipenv``. If you are starting fresh this will init pipenv and create a Pipfile, virtual environment, etc.
4. Run ``pipenv shell`` to activate the virtual environment in your terminal.
5. If you need to add a new dependency, run ``pipenv install dependency-name`` and it will be added to the Pipfile etc. for this virtual env. If your dependency is dev-time only, run ``pipenv install dependency-name --dev``.

### 6.2. Run
To run a script, first ensure that your pipenv shell is running by typing ``pipenv shell`` in the integrated terminal.

Next, type ``python filename.py`` and the correct version of python plus all the dependencies you installed via pipenv should resolve. A few notes:
1. You might need to explicitly run python3 instead of python if that ends up resolving to python 2. You can run ``python --version`` to see what version it resolving to.
2. If you get errors resolving dependencies make sure you are installing dependencies in your pipenv as discussed above, and also ensure you are running the python installed in the virtualenv. You can run ``where python`` to make sure it is a path inside your virtualenv.

### 6.3. Debug
If you want to use the built-in debugger in vscode, you will find that imported packages are not found if the built-in debugger is using the system python (not the one in your virtual env). To remedy this, you can update your ``launch.json`` to reference the pythonPath in your virtualenv. You can get this path by doing ``where python`` inside your virtualenv (make sure you use the full path, not a relative path).

Since this will be project and machine specific you should make sure you don't commit the launch.json to git.

# 7. Benchmark
In addition to the validation above, you can benchmark your setup to make sure it is performing well by running:

```powershell
mkdir Source
cd Source
git clone https://github.com/tensorflow/models.git
python models\tutorials\image\mnist\convolutional.py
```

The last line will print out per-step timing. With a CPU-only setup (e.g. a PC without a tensorflow-supported Nvidia GPU), you should expect ~110ms per step. With a fast GPU setup you should get <10ms per step, a 10X improvement.

# 8. Update
To update all chocolatey packages, type:

```powershell
choco upgrade all
```

To update all pipenv packages, enter your working directory and then type:

```powershell
pipenv update 
```

To update CUDA and Tensorflow etc you need to peform the steps above all over again.

Please enjoy responsibly.
