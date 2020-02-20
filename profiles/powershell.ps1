Set-PSReadlineKeyHandler -Key Ctrl+m -Function AcceptLine
Set-PSReadlineKeyHandler -Key Ctrl+w -Function BackwardKillWord
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key Ctrl+Enter -ScriptBlock {
	fd
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
	cls
}

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
		$currentPath = (pwd).Path + "\"
		$dirs = ".", (ls -directory -path . | % {$_.Name})
		$output = $dirs | fzf --layout=reverse --prompt=$currentPath --expect=alt-up --no-sort --preview="rg --max-depth 1 --files {} --color always"

		if([string]::IsNullOrWhiteSpace($output)) {
			break
		}

		$command = $output[0]
		$dir = $output[1]

		if($command -eq "alt-up") {
			cd ..
		} elseif($dir -eq ".") {
			break
		} else {
			cd $dir
		}
	}
}

function ff {
	$currentPath = (pwd).Path + "\"
	$file = fzf --layout=reverse --prompt=$currentPath --no-sort --filepath-word --preview="rg . {} --no-line-number --max-count 1 --after-context 20 --color always"
	if($file) {
		write-host $file
		$file | clip
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
