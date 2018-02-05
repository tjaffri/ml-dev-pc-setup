# Install Chocolatey (snippet from https://chocolatey.org/install#install-with-powershellexe)
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install git
choco install git -y

# Install miniconda3
choco install miniconda3 -y

# Set the path for miniconda3 scripts
[Environment]::SetEnvironmentVariable("Path", "C:\ProgramData\Miniconda3\Scripts;" + $env:Path, [EnvironmentVariableTarget]::Machine)

# We are installing in an elevated prompt (chocolatey likes that) however we don't want the miniconda folder to be admin only
# since then we will subsequently always need to work with conda in elevated prompts. As a hack, fix up the permissions for that folder
$Acl = Get-ACL "C:\ProgramData\Miniconda3"
$AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("everyone","full","ContainerInherit,Objectinherit","none","Allow")
$Acl.AddAccessRule($AccessRule)
Set-Acl $SharePath $Acl

# Install vscode, and related extensions/plugins
choco install visualstudiocode --params '/NoDesktopIcon' -y

# Install chrome
choco install googlechrome -y
