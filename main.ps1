iex (curl.exe -s 'https://chocolatey.org/install.ps1' | out-string)

# Main
#choco install fzf -y
choco install firefox -y
choco install sharex -y
choco install windirstat -y
choco install spotify -y

# Communication
choco install discord -y

# Dev
choco install git --params "/GitOnlyOnPath /NoShellIntegration" -y
choco install hg -y
choco install putty -y
choco install vscode --params "/NoContextMenuFile /NoContextMenuFolders" -y
choco install dotnetcore-sdk -y

# Games
choco install steam -y
choco install itch -y

# Update Profiles
iex (curl.exe -s 'https://matheuslessarodrigues.github.io/up/profiles.ps1' | out-string)
