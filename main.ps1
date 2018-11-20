//Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

// Main
choco install keepass -y
choco install firefox -y
choco install imageglass -y
choco install sharex -y
choco install windirstat -y
choco install spotify -y
choco install logitechgaming -y

// Communication
choco install telegram -y
choco install discord -y

// Dev
choco install git --params "/GitOnlyOnPath /NoShellIntegration" -y
choco install hg -y
choco install putty -y
choco install vscode --params "/NoContextMenuFile /NoContextMenuFolders" -y
choco install dotnetcore-sdk -y

// Games
choco install steam -y
choco install itch -y
