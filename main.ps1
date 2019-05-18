$url = "https://matheuslessarodrigues.github.io/up"

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

// Main
choco install fzf -y
choco install firefox -y
choco install sharex -y
choco install windirstat -y
choco install spotify -y

// Communication
choco install discord -y

// Dev
choco install git --params "/GitOnlyOnPath /NoShellIntegration" -y
choco install hg -y
choco install putty -y
choco install vscode --params "/NoContextMenuFile /NoContextMenuFolders" -y
choco install dotnetcore-sdk -y

// Games
choco install steam -y
choco install itch -y

// PowerShell Profile
((new-object System.Net.WebClient).DownloadString("$url/Microsoft.PowerShell_profile.ps1")) > $Profile

// Firefox Profile
$firefoxProfile = ((new-object System.Net.WebClient).DownloadString("$url/firefox/user.js"))
get-childitem -path "$env:APPDATA/Mozilla/Firefox/Profiles" -Directory | %{$path = join-path $_.FullName "user.js"; set-content -path $path -value $firefoxProfile;}

// Update Wallpaper
$updateWallpaper = ((new-object System.Net.WebClient).DownloadString("$url/update-wallpaper.bat"))
set-content -path "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup" -value $updateWallpaper
