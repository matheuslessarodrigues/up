function download($uri, $targetPath) {
  write-host "downloading $uri..."
  curl.exe "https://matheuslessarodrigues.github.io/up/profiles/$uri" -s -o $targetPath --create-dirs  
}

download("powershell.ps1", $profile)
download("alacritty.yml", "$env:APPDATA/alacritty/alacritty.yml")
download("sshconfig", "$home\.ssh\config")
download("gitconfig", "$home\.gitconfig")
download("mercurial.ini", "$home\mercurial.ini")
download("update-wallpaper.ps1", "$home\update-wallpaper.ps1")

get-childitem -path "$env:APPDATA/Mozilla/Firefox/Profiles" -Directory | %{download("firefox.js", (join-path $_.FullName "user.js"))}
