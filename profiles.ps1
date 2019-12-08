$url = "https://matheuslessarodrigues.github.io/up"

# PowerShell Profile
$powershellProfile = (curl.exe -s "$url/Microsoft.PowerShell_profile.ps1" | out-string)
set-content -path $profile -value $powershellProfile

# Firefox Profile
$firefoxProfile = (curl.exe -s "$url/firefox/user.js" | out-string)
get-childitem -path "$env:APPDATA/Mozilla/Firefox/Profiles" -Directory | %{$path = join-path $_.FullName "user.js"; set-content -path $path -value $firefoxProfile;}

# Update Wallpaper
$updateWallpaper = (curl.exe -s "$url/update-wallpaper.bat" | out-string)
set-content -path "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\update-wallpaper.bat" -value $updateWallpaper
."$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\update-wallpaper.bat"
