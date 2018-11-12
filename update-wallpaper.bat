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

for /F "tokens=*" %%F in ('dir %spotlightFolder% /b /od') do (
	set latestFile=%%F
)

echo %latestFile%

for /R %spotlightFolder% %%F in (*) do (
	if %%~nF EQU %latestFile% (
		for /F "tokens=1" %%D in ("%%~tF") do (
			set latestDate=%%D
		)
	)
)

echo %latestDate%

for /R %spotlightFolder% %%F in (*) do (
	for /F "tokens=1" %%D in ("%%~tF") do (
		if %%D EQU %latestDate% (
			for /F "usebackq" %%R in (`powershell -command "$i=New-Object -ComObject Wia.ImageFile; $i.LoadFile('%%F'); if($i.Width -gt $i.Height){$true}"`) do (
				copy /Y %%F %wallpaperLocation%\*.jpg
			)
		)
	)
)
