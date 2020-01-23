#https://github.com/timothymctim/Bing-wallpapers

$wallpaperLocation="$home\Pictures\SpotlightWallpapers"
if(test-path $wallpaperLocation) {
	remove-item -recurse -force $wallpaperLocation
}
mkdir $wallpaperLocation

$spotlightFolder="$env:LOCALAPPDATA\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"

get-childitem $spotlightFolder | foreach-object {
	$img=New-Object -ComObject Wia.ImageFile
	$path=$_.FullName
	$img.LoadFile($path)
	if(($img.Width -gt $img.Height) -and ($img.Height -gt 720)) {
		copy-item $path -destination "$wallpaperLocation\$($_.BaseName).jpg"
	}
}
