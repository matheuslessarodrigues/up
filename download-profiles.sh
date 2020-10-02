download() {
  echo "downloading $1 to $2..."
  curl "https://raw.githubusercontent.com/matheuslessarodrigues/up/master/profiles/$1" -s --create-dirs -o "$2"
}

download "ashrc" "$HOME/.profile"
download "windows-terminal.json" "$LOCALAPPDATA/Microsoft/Windows Terminal/settings.json"
download "sshconfig" "$HOME/.ssh/config"
download "gitconfig" "$HOME/.gitconfig"
download "mercurial.ini" "$HOME/mercurial.ini"
download "update-wallpaper.ps1" "$HOME/update-wallpaper.ps1"
download "pepper.lua" "$HOME/pepper.lua"

for d in `find $APPDATA/Mozilla/Firefox/Profiles -mindepth 1 -maxdepth 1 -type d`
do
  download firefox.js "$d/user.js"
done

echo ""
echo "all profiles updated!"
