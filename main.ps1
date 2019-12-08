iex (curl.exe -s 'https://chocolatey.org/install.ps1' | out-string)

# Main
choco install firefox -y
choco install spotify -y
choco install telegram -y
choco install powershell-core -y

choco install fzf -y
choco install ripgrep -y
choco install sharex -y
choco install windirstat -y

# Communication
choco install discord -y

# Dev
choco install git --params "/GitOnlyOnPath /NoShellIntegration" -y
choco install hg -y
choco install vscode --params "/NoContextMenuFile /NoContextMenuFolders" -y
choco install dotnetcore-sdk -y

# Games
choco install steam -y
choco install itch -y

# Audio
choco install reaper -y

# Registry

## map capslock to esc
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /t REG_BINARY /d 00000000000000000200000001003a0000000000
