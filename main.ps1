iex (curl.exe -s 'https://chocolatey.org/install.ps1' | out-string)

# Main
choco install firefox -y
choco install spotify -y
choco install powershell-core -y

choco install fzf -y
choco install ripgrep -y
choco install sharex -y
choco install windirstat -y

# Communication
choco install telegram -y
choco install discord -y

# Dev
choco install git --params "/GitOnlyOnPath /NoShellIntegration" -y
choco install hg -y
choco install vscode --params "/NoContextMenuFile /NoContextMenuFolders" -y

choco install rustup.install -y
choco install visualstudio2019-workload-vctools --package-parameters "--includeRecommended"
choco install dotnetcore-sdk -y
choco install unity-hub -y

# Games
choco install steam -y
choco install itch -y

# Audio
choco install reaper -y

# Registry
## map capslock to esc
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /t REG_BINARY /d 00000000000000000200000001003a0000000000

## remove vscode explorer integration
reg delete HKEY_CLASSES_ROOT\*\shell\VSCode /f

# Tasks
schtasks /delete /tn "UpdateWallpaper" /f
schtasks /create /tn "UpdateWallpaper" /sc onlogon /delay 0000:30 /rl highest /ru system /tr "powershell.exe -File $home\update-wallpaper.ps1 -ExecutionPolicy Bypass"
