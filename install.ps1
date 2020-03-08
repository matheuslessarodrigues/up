Set-ExecutionPolicy RemoteSigned -scope CurrentUser; iwr -useb get.scoop.sh | iex
scoop install git
scoop bucket add extras
scoop bucket add matheus-bucket https://github.com/matheuslessarodrigues/up.git

# Main
scoop install firefox
scoop install pwsh
scoop install colortool
# scoop install alacritty
scoop install spotify
scoop install vlc

$shortcut_path = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk"
$shell = New-Object -ComObject WScript.Shell
$pwsh_shortcut = $shell.CreateShortcut($shortcut_path)
$pwsh_shortcut.TargetPath = scoop which pwsh
$pwsh_shortcut.Save()

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
scoop install vscode-portable
#iex "$(scoop which code) --install-extension Shan.code-settings-sync"
code --install-extension Shan.code-settings-sync

scoop install dotnet-sdk
scoop install rustup-msvc
scoop install unityhub

scoop install vs-installer
scoop install vs-vs-buildtools

# choco install visualstudio2019-workload-vctools --package-parameters "--includeRecommended"

# Rust Tools
cargo install verco

# Audio
scoop install reaper

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
