$url = "https://matheuslessarodrigues.github.io/up"

// PowerShell Profile
((new-object System.Net.WebClient).DownloadString("$url/Microsoft.PowerShell_profile.ps1")) > $Profile

// Firefox Profile
$firefoxProfile = ((new-object System.Net.WebClient).DownloadString("$url/firefox/user.js"))
get-childitem -path "$env:APPDATA/Mozilla/Firefox/Profiles" -Directory | %{$path = join-path $_.FullName "user.js"; set-content -path $path -value $firefoxProfile;}

// Update Wallpaper
$updateWallpaper = ((new-object System.Net.WebClient).DownloadString("$url/update-wallpaper.bat"))
set-content -path "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup" -value $updateWallpaper
