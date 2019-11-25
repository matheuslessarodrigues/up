# Install stuff on fresh windows machine

## Install main stuff

```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex (curl.exe -s 'https://matheuslessarodrigues.github.io/up/main.ps1' | out-string)
```

## Just update profiles

```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex (curl.exe -s 'https://matheuslessarodrigues.github.io/up/profiles.ps1' | out-string)
```

## Files

### Powershell Scripts
- [main](main.ps1) main stuff to install
- [other](other.ps1) other stuff to install
- [webdev](webdev.ps1) webdev stuff to install
- [profiles](profiles.ps1) profiles to update
- [powershell profile](Microsoft.PowerShell_profile.ps1) the powershell profile

### Firefox
- [firefox profile](firefox/user.js) Firefox profile with configs

### Batch Files
- [update-wallpaper](update-wallpaper.bat) auto wallpaper updater
