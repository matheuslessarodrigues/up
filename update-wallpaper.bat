@echo off
rem put inside windows+r "shell:startup"

set wallpaperLocation=%USERPROFILE%\Pictures\SpotlightWallpapers

if EXIST %wallpaperLocation% (
	del %wallpaperLocation%\*.* /S /Q
) ELSE (
	mkdir %wallpaperLocation%
)

for /F "tokens=3* usebackq" %%F in (`reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v HotspotImageFolderPath`) do (
	set spotlightFolder=%%F
)

echo %spotlightFolder%

for /R %spotlightFolder% %%F in (*) do (
	for /F "tokens=1" %%D in ("%%~tF") do (
		if %%D EQU %date% (
			for /F "usebackq" %%R in (`powershell -command "$i=New-Object -ComObject Wia.ImageFile; $i.LoadFile('%%F'); if($i.Width -gt $i.Height){$true}"`) do (
				copy /Y %%F %wallpaperLocation%\*.jpg
			)
		)
	)
)
