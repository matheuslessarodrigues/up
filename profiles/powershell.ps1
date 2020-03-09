Set-PSReadlineKeyHandler -Key Ctrl+m -Function AcceptLine
Set-PSReadlineKeyHandler -Key Ctrl+w -Function BackwardKillWord
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key "Ctrl+k,Y" -Function SelectBackwardsLine
Set-PSReadlineKeyHandler -Key "Ctrl+k,O" -Function SelectLine

$env:FZF_DEFAULT_COMMAND='rg --files . --glob "!*.meta"'
$env:DOTNET_CLI_TELEMETRY_OPTOUT=$true

Set-Alias -Name vim -Value nvim-qt.exe -Force
Set-Alias -Name which -Value where.exe -Force

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
		$dirs = ".", (ls -directory -path . -name)
		$output = $dirs | fzf --layout=reverse --prompt=$currentPath --expect=';' --print-query --no-sort --preview="rg --max-depth 1 --files {} --color always"

		if([string]::IsNullOrWhiteSpace($output)) {
			break
		}

		$query = $output[0]
		$command = $output[1]
		$dir = $output[2]

		if($command -eq ";") {
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

function update-profiles {
	Set-ExecutionPolicy Bypass -Scope Process -Force; iex (curl.exe -s 'https://matheuslessarodrigues.github.io/up/update-profiles.ps1' | out-string)
}

function download-omnisharp-config {
	$url = "https://matheuslessarodrigues.github.io/up/profiles"
	set-content -path "omnisharp.json" -value (curl.exe -s "$url/omnisharp.json" | out-string)
}
