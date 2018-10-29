@echo off

rem put inside windows+r "shell:startup"

set wallpaperLocation=%USERPROFILE%\Pictures\SpotlightWallpapers

mkdir %wallpaperLocation%

for /F "tokens=3* USEBACKQ" %%F in (`reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v LandscapeAssetPath`) do (
	set spotlightFile=%%F
)

COPY /Y %spotlightFile% %wallpaperLocation%\current_spotlight.jpg
