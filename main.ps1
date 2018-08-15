//Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install firefox -y
choco install vscode -y
choco install hg -y
choco install git -y
choco install discord -y
choco install steam -y
choco install spotify -y
choco install itch -y
choco install keepass -y
choco install windirstat -y
choco install sharex -y
choco install putty -y

// verco
new-item -itemtype directory -force -path "$env:APPDATA\..\Local\verco"
$verco_version="0.7.1"
invoke-webrequest -uri "https://github.com/matheuslessarodrigues/verco/releases/download/v$verco_version/verco.exe" -outfile "$env:APPDATA\..\Local\verco\verco.exe"

$oldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
$newPath=$oldPath+";$env:APPDATA\..\Local\verco"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH –Value $newPath
