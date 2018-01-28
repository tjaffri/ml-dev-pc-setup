# Install Chocolatey (snippet from https://chocolatey.org/install#install-with-powershellexe)
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install git
choco install git

# Install python 3
choco install python

# Install pipenv
pip install pipenv

# Install Tensorflow with virtualenv (instructions at https://www.tensorflow.org/install/install_windows)

# Validate Tensorflow installation per https://www.tensorflow.org/install/install_windows#validate_your_installation

# Install vscode
choco install visualstudiocode

# Launch vscode (makes it easier to pin it to the Taskbar, and you see some docs as well)
code

# Install chrome
choco install googlechrome
