# Install Chocolatey (snippet from https://chocolatey.org/install#install-with-powershellexe)
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install git
choco install git -y

# Install python 3
choco install python -y

# Install vscode
choco install visualstudiocode --params '/NoDesktopIcon' -y

# Launch vscode (makes it easier to pin it to the Taskbar, and you see some docs as well)
code

# Install chrome
choco install googlechrome -y
