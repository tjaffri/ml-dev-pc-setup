# Install Chocolatey (snippet from https://chocolatey.org/install#install-with-powershellexe)
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install git
choco install git -y

# Install miniconda3
choco install miniconda3 -y
[Environment]::SetEnvironmentVariable("Path", "C:\ProgramData\Miniconda3\Scripts;" + $env:Path, [EnvironmentVariableTarget]::Machine)

# Install vscode, and related extensions/plugins
choco install visualstudiocode --params '/NoDesktopIcon' -y

# Install chrome
choco install googlechrome -y
