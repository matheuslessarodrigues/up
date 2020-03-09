$url = "https://matheuslessarodrigues.github.io/up/profiles"

# PowerShell Profile
curl.exe "$url/powershell.ps1" -o $profile

# Alacritty Profile
curl.exe "$url/alacritty.yml" -o "$env:APPDATA/alacritty/alacritty.yml" --create-dirs

# Firefox Profile
get-childitem -path "$env:APPDATA/Mozilla/Firefox/Profiles" -Directory | %{$path = join-path $_.FullName "user.js"; curl.exe "$url/firefox.js" -o $path;}

# SSH Profile
mkdir "$home\.ssh" -force
curl.exe "$url/sshconfig" -o "$home\.ssh\config"

# Git Profile
curl.exe "$url/gitconfig" -o "$home\.gitconfig"

# Mercurial Profile
curl.exe "$url/mercurial.ini" -o "$home\mercurial.ini"

# Update Wallpaper
curl.exe "$url/update-wallpaper.ps1" -o "$home\update-wallpaper.ps1"
