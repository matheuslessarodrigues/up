set HOME=%HOMEDRIVE%%HOMEPATH%
set BASEURL=https://raw.githubusercontent.com/vamolessa/up/master/profiles

curl -s --create-dirs %BASEURL%/cmdrc.bat -o %HOME%\cmdrc.bat
curl -s --create-dirs %BASEURL%/shrc -o %HOME%\.profile
curl -s --create-dirs %BASEURL%/windows-terminal.json -o "%LOCALAPPDATA%\Microsoft\Windows Terminal\settings.json"
curl -s --create-dirs %BASEURL%/sshconfig -o %HOME%\.ssh/config
curl -s --create-dirs %BASEURL%/gitconfig -o %HOME%\.gitconfig

for /d %d in (%APPDATA%\Mozilla\Firefox\Profiles\*) do curl -s --create-dirs %BASEURL%/firefox.js -o %d\user.js

echo "all profiles updated!"
