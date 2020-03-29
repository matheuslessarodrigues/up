function download($uri, $targetPath) {
  write-host "downloading $uri to $targetPath..."
  curl.exe "https://raw.githubusercontent.com/matheuslessarodrigues/up/master/profiles/$uri" -s --create-dirs -o $targetPath
}

download "powershell.ps1" $profile
download "alacritty.yml" "$env:APPDATA/alacritty/alacritty.yml"
download "windows-terminal.json" "$env:LOCALAPPDATA/Microsoft/Windows Terminal/profiles.json"
download "sshconfig" "$home\.ssh\config"
download "gitconfig" "$home\.gitconfig"
download "mercurial.ini" "$home\mercurial.ini"
download "update-wallpaper.ps1" "$home\update-wallpaper.ps1"

get-childitem -path "$env:APPDATA/Mozilla/Firefox/Profiles" -Directory | %{download "firefox.js" (join-path $_.FullName "user.js")}

write-host ""
write-host "all profiles updated!"
