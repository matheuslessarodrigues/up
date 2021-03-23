# Install Package Managers
invoke-webrequest -useb get.scoop.sh | invoke-expression
scoop install git
scoop bucket add extras
scoop bucket add nerd-fonts

invoke-webrequest -useb https://chocolatey.org/install.ps1 | invoke-expression

# Main
scoop install cascadia-code
scoop install windows-terminal
scoop install busybox
scoop install firefox

$shortcut_path = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk"
remove-item -force $shortcut_path
$shell = new-object -comobject WScript.Shell
$pwsh_shortcut = $shell.CreateShortcut($shortcut_path)
$target_path = scoop which wt | resolve-path | select -expandproperty Path
$pwsh_shortcut.TargetPath = $target_path
$pwsh_shortcut.WorkingDirectory = $target_path | split-path -parent
$pwsh_shortcut.Save()

# Media
scoop install reaper
scoop install mpv
scoop install steam

choco install spotify -y
choco install asio4all -y

# Tools
scoop install fd
scoop install fzf
scoop install ripgrep
scoop install sd
scoop install sharex

# Communication
scoop install telegram
scoop install discord

# Dev
scoop install mercurial
scoop install putty

scoop install rustup-msvc
scoop install rust-analyzer

choco install unity-hub -y
choco install visualstudio2019-workload-vctools -y
choco install visualstudio2019-workload-manageddesktop -y

$msbuild_path = &"${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe
$msbuild_path = $msbuild_path | split-path -Parent
$env:Path += ";$msbuild_path"
[System.Environment]::SetEnvironmentVariable("Path",$env:Path,[System.EnvironmentVariableTarget]::Machine)

# Rust Tools
cargo install verco
cargo install copycat
cargo install emulsion

# Registry
## map capslock to esc
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /t REG_BINARY /d 00000000000000000200000001003a0000000000
## remove bing search
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search /v BingSearchEnabled /t REG_DWORD /d 0 /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search /v CortanaConsent /t REG_DWORD /d 0 /f

# Print Command to update profiles
write-output ""
write-output ""
write-output "DOWNLOAD PROFILES"
write-output ""
write-output "curl.exe -s 'https://raw.githubusercontent.com/vamolessa/up/master/download-profiles.sh' | busybox ash"
