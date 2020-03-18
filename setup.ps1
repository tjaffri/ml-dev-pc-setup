# Install Chocolatey (snippet from https://chocolatey.org/install#install-with-powershellexe)
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install git
choco install git -y

# Install and configure git-lfs
choco install git-lfs.install -y

# Install node
choco install nodejs -y

# Install ngrok
choco install ngrok.portable -y

# Install wget
choco install wget -y

# Install winmerge
choco install winmerge -y

# Install miniconda3
choco install miniconda3 -y

# Set the path for miniconda3 scripts
[Environment]::SetEnvironmentVariable("Path", "C:\tools\miniconda3\Scripts;" + $env:Path, [EnvironmentVariableTarget]::Machine)

# We are installing in an elevated prompt (chocolatey likes that) however we don't want the miniconda folder to be admin only
# since then we will subsequently always need to work with conda in elevated prompts. As a hack, fix up the permissions for that folder
$MinicondaPath = "C:\tools\miniconda3"
$Acl = Get-ACL $MinicondaPath
$AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "Full", "ContainerInherit, ObjectInherit" , "None" , "Allow")
$Acl.AddAccessRule($AccessRule)
Set-Acl $MinicondaPath $Acl

# Install vscode, and related extensions/plugins
choco install visualstudiocode --params '/NoDesktopIcon' -y

# Install chrome
choco install googlechrome -y --ignore-checksums
