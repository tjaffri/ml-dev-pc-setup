# Machine Learning Dev PC Setup
Quick way to consistently set up a new PC with my personal dev preferences for Machine Learning.

> Tested most recently on a custom built desktop with RTX 3080 GPU and Windows 11

# 1. Set up OS and Productivity Tools

1. Unbox and admire your shiny new hardware. Go through default OS setup.
2. Install all updates OS (including upgrading to the latest OS version if needed). 
3. Launch Microsoft Store and install all app updates.
4. Enable malware protection, e.g. Windows Defender or other.
5. Download and install Microsoft Office (or other productivity suite), instructions will vary. Sign in. 
6. Download Teams (or other chat service e.g. Teams, Slack), instructions will vary. Sign in.
7. Clean up Taskbar. Remove extraneous items and pin Teams, Slack, Outlook, etc.
8. Set up printers / peripherals as needed.
9. Launch Windows Terminal (from Start / Search) and pin it to the taskbar.

# 2. Set up Dev Tools
See comments in ``setup.ps1`` for more information. This is an automated script that installs:

1. [WSL Ubuntu](https://docs.microsoft.com/en-us/windows/wsl/install)
2. [Winmerge](http://winmerge.org/)
3. [ScreenToGif](https://www.screentogif.com/)
4. [Visual Studio Code](https://code.visualstudio.com/)
5. [Docker Desktop](https://www.docker.com/products/docker-desktop)

To begin setup, launch Windows Terminal **as an admin** and paste in the following into the default (Powershell) terminal:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tjaffri/ml-dev-pc-setup/master/setup.ps1'))
```

> **Important Note**: After setup is complete, close the powershell window and then RESTART your machine. We continue below inside WSL Ubuntu.

Take a moment and pin some more tools to your taskbar. I prefer to pin `Winmerge`, `ScreenToGif` and `Visual Studio Code` at this point.

# 3. Configure WSL Ubuntu and VS Code Environment
After the restart above, Ubuntu should launch automatically. If not, you can launch it yourself (Search for it in Start). On first run, you will be asked to specify a username and password for the Ubuntu instance.

Take a moment and make Ubuntu the default in Windows Terminal. See instructions [here](https://www.howtogeek.com/720524/how-to-change-the-default-shell-in-windows-terminal/)

1. Set up git lfs using the steps here: https://github.com/git-lfs/git-lfs/wiki/Installation#ubuntu. Specifically, run:

```bash
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
git lfs install --skip-smudge
```

2. Configure git username:

```bash
git config --global user.name "Your Name"
git config --global user.email you@example.com
```

2. Clone your repos, then make sure credentials are persisted:
    1. ``git clone https://.../foo.git``
    2. Specify username and password (ideally a single use token) to clone
    3. cd into the cloned repo dir, then run ``git config credential.helper store``
    4. Run ``git pull`` again, then specify the username and password again. This time it will be persisted.
