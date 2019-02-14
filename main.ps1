iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

// Main
choco install firefox -y
choco install sharex -y
choco install windirstat -y
choco install logitechgaming -y
choco install spotify -y

// Communication
choco install discord -y

// Dev
choco install git --params "/GitOnlyOnPath /NoShellIntegration" -y
choco install hg -y
choco install putty -y
choco install vscode --params "/NoContextMenuFile /NoContextMenuFolders" -y
choco install dotnetcore-sdk -y
//choco install netfx-4.7.1-devpack -y

// Games
choco install steam -y
choco install itch -y

// Archive
//choco install keepass -y
//choco install brave -y
//choco install imageglass -y

// PowerShell Profile
((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/matheuslessarodrigues/up/master/Microsoft.PowerShell_profile.ps1')) > $Profile
