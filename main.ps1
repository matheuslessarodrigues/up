//Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install keepass -y
choco install firefox -y
choco install vscode --params "/NoContextMenuFile /NoContextMenuFolders" -y
choco install hg -y
choco install git --params "/GitOnlyOnPath /NoShellIntegration" -y
choco install discord -y
choco install steam -y
choco install spotify -y
choco install itch -y
choco install windirstat -y
choco install sharex -y
choco install logitechgaming -y
