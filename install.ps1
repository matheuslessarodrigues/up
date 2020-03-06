iex (curl.exe -s 'https://chocolatey.org/install.ps1' | out-string)

# Main
choco install firefox -y
choco install spotify -y
choco install alacritty -y

New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows PowerShell" -Name "Windows PowerShell.lnk" -Value "$env:ChocolateyInstall\bin\alacritty.exe" -Force

# Tools
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
## remove bing search
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search /v BingSearchEnabled /t REG_DWORD /d 0 /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search /v CortanaConsent /t REG_DWORD /d 0 /f
## remove vscode explorer integration
reg delete HKEY_CLASSES_ROOT\*\shell\VSCode /f

# Tasks
## update wallpaper
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -File $home\update-wallpaper.ps1"
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = New-ScheduledTaskPrincipal -UserID "$env:USERDOMAIN\$env:USERNAME" -LogonType S4U -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask UpdateWallpaper -InputObject $task -Force

# Print Command to update profiles
echo ""
echo ""
echo "UPDATE PROFILES"
echo ""
echo "Set-ExecutionPolicy Bypass -Scope Process -Force; iex (curl.exe -s 'https://matheuslessarodrigues.github.io/up/update-profiles.ps1' | out-string)"
