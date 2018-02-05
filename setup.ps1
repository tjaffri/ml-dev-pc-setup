# Install Chocolatey (snippet from https://chocolatey.org/install#install-with-powershellexe)
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install git
choco install git -y

# Install miniconda3
choco install miniconda3 -y
conda activate
conda update conda

# Install jupyter
conda install jupyter -y

# Install matplotlib
conda install matplotlib -y

# Install vscode, and related extensions/plugins
choco install visualstudiocode --params '/NoDesktopIcon' -y
code --install-extension ms-python.python
pip install --upgrade pylint
pip install --upgrade autopep8

# Launch vscode (makes it easier to pin it to the Taskbar, and you see some docs as well)
code

# Install chrome
choco install googlechrome -y
