Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

Set-Alias -Name vim -Value nvim-qt.exe -Force

$env:FZF_DEFAULT_COMMAND='rg --files . --glob "!*.meta"'
$env:DOTNET_CLI_TELEMETRY_OPTOUT=$true

function clip {
	param(
		[parameter(position=0,mandatory=$true,ValueFromPipeline=$true)]$text
	)
	begin{
		$data = [System.Text.StringBuilder]::new()
	}

	process{
		if ($text) {
			[void]$data.AppendLine($text)
		}
	}

	end{
		if ($data) {
			$data.ToString().TrimEnd([Environment]::NewLine) + [Convert]::ToChar(0) | clip.exe
		}
	}
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (test-path($ChocolateyProfile)) {
	import-module "$ChocolateyProfile"
}
