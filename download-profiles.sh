download() {
  echo "downloading $1 to $2..."
  curl "https://raw.githubusercontent.com/matheuslessarodrigues/up/master/profiles/$1" -s --create-dirs -o $2
}

download "ashrc" "$HOME/.profile"
download "windows-terminal.json" "$LOCALAPPDATA/Microsoft/Windows Terminal/profiles.json"
download "sshconfig" "$HOME/.ssh/config"
download "gitconfig" "$HOME/.gitconfig"
download "mercurial.ini" "$HOME/mercurial.ini"
download "update-wallpaper.ps1" "$HOME/update-wallpaper.ps1"

fd -d 1 -t d . $APPDATA/Mozilla/Firefox/Profiles -x sh -c "download firefox.js \"{}user.js\""

echo ""
echo "all profiles updated!"
