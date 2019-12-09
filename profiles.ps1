$url = "https://matheuslessarodrigues.github.io/up/profiles"

# PowerShell Profile
set-content -path $profile -value (curl.exe -s "$url/powershell.ps1" | out-string)

# Firefox Profile
$firefoxProfile = (curl.exe -s "$url/firefox.js" | out-string)
get-childitem -path "$env:APPDATA/Mozilla/Firefox/Profiles" -Directory | %{$path = join-path $_.FullName "user.js"; set-content -path $path -value $firefoxProfile;}

# SSH Profile
mkdir "$home\.ssh" -force
set-content -path "$home\.ssh\config" -value (curl.exe -s "$url/sshconfig" | out-string)

# Git Profile
set-content -path "$home\.gitconfig" -value (curl.exe -s "$url/gitconfig" | out-string)

# Mercurial Profile
set-content -path "$home\mercurial.ini" -value (curl.exe -s "$url/mercurial.ini" | out-string)

# Update Wallpaper
set-content -path "$home\update-wallpaper.ps1" -value (curl.exe -s "$url/update-wallpaper.ps1" | out-string)
