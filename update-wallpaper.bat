@echo off
set wallpaperLocation=%USERPROFILE%\Pictures

FOR /F "tokens=3* USEBACKQ" %%F IN (`reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v LandscapeAssetPath`) DO (
SET spotlightLocation=%%F
)

COPY /Y %spotlightLocation% %wallpaperLocation%\spotlight_wallpaper.jpg

reg delete "HKEY_CURRENT_USER\control panel\desktop" /v TranscodedImageCache /f
reg add "HKEY_CURRENT_USER\control panel\desktop" /v wallpaper /t REG_SZ /d %wallpaperLocation%\spotlight_wallpaper.jpg /f
reg add "HKEY_CURRENT_USER\control panel\desktop" /v WallpaperStyle /t REG_SZ /d 2 /f

RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
