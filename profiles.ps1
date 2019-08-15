$url = "https://matheuslessarodrigues.github.io/up"

# PowerShell Profile
new-item -path $profile -force
(curl.exe -s "$url/Microsoft.PowerShell_profile.ps1" | out-string) > $Profile

# Firefox Profile
$firefoxProfile = (curl.exe -s "$url/firefox/user.js" | out-string)
get-childitem -path "$env:APPDATA/Mozilla/Firefox/Profiles" -Directory | %{$path = join-path $_.FullName "user.js"; set-content -path $path -value $firefoxProfile;}

# Update Wallpaper
#$updateWallpaper = (curl.exe -s "$url/update-wallpaper.bat" | out-string)
#set-content -path "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup" -value $updateWallpaper
