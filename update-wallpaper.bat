@echo off

REM schtasks /create /tn "start" /sc onstart /delay 0000:30 /rl highest /ru system /tr "powershell.exe -file <<The powershell script path>>
REM put inside windows+r "shell:startup"

set wallpaperLocation=%USERPROFILE%\Pictures\SpotlightWallpapers

mkdir %wallpaperLocation%

FOR /F "tokens=3* USEBACKQ" %%F IN (`reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v LandscapeAssetPath`) DO (
SET spotlightLocation=%%F
echo %%F
)

COPY /Y %spotlightLocation% %wallpaperLocation%\current_spotlight.jpg

REM reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v TranscodedImageCache /f
REM reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d %wallpaperLocation%\current_spotlight.bmp /f
REM reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 10 /f

REM RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
