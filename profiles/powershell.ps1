Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

Set-Alias -Name vim -Value nvim-qt.exe -Force
Set-Alias -Name which -Value where.exe -Force

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

function fd {
	while ($true)
	{
		$prompt = (pwd).Path + "\"
		$dirs = "..", (ls -directory -path . | % {$_.Name})
		$dir = $dirs | fzf --layout=reverse --prompt=$prompt

		if([string]::IsNullOrWhiteSpace($dir)) {
			break
		} else {
			cd $dir
		}
	}
}

function download-omnisharp-config {
	$url = "https://matheuslessarodrigues.github.io/up/profiles"
	set-content -path "omnisharp.json" -value (curl.exe -s "$url/omnisharp.json" | out-string)
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (test-path($ChocolateyProfile)) {
	import-module "$ChocolateyProfile"
}
