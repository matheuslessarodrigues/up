# Install Package Managers
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex
scoop install git
scoop bucket add extras

iwr -useb https://chocolatey.org/install.ps1 | iex

# Main
scoop install firefox
scoop install pwsh
scoop install colortool
# scoop install alacritty

$shell = New-Object -ComObject WScript.Shell
$pwsh_shortcut = $shell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk")
$target_path = scoop which pwsh | resolve-path | select -ExpandProperty Path
$pwsh_shortcut.TargetPath = $target_path
$pwsh_shortcut.WorkingDirectory = $target_path | split-path -Parent
$pwsh_shortcut.Save()

# Media
scoop install reaper
scoop install vlc

choco install spotify -y

# Tools
scoop install fzf
scoop install ripgrep
scoop install sharex
scoop install windirstat

# Communication
scoop install telegram
scoop install discord

# Dev
scoop install mercurial
scoop install putty
scoop install vscode-portable
code --install-extension Shan.code-settings-sync

scoop install dotnet-sdk
scoop install rustup-msvc
scoop install unityhub

choco install visualstudio2019-workload-vctools -y
choco install visualstudio2019-workload-manageddesktop -y
choco install unity-hub -y

# Rust Tools
cargo install verco

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
echo "DOWNLOAD PROFILES"
echo ""
echo "iwr -useb https://matheuslessarodrigues.github.io/up/download-profiles.ps1 | iex"
