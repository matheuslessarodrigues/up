Set-PSReadlineKeyHandler -key Ctrl+m -function AcceptLine
Set-PSReadlineKeyHandler -key Ctrl+w -function BackwardKillWord
Set-PSReadlineKeyHandler -key Tab -function MenuComplete
Set-PSReadlineKeyHandler -key "Ctrl+k,Y" -function SelectBackwardsLine
Set-PSReadlineKeyHandler -key "Ctrl+k,O" -function SelectLine

$env:FZF_DEFAULT_COMMAND='rg --files . --glob "!*.meta" 2> nul'
$env:DOTNET_CLI_TELEMETRY_OPTOUT=$true

Set-Alias -name vim -value nvim-qt.exe -force
Set-Alias -name which -value where.exe -force
Remove-Alias -name cd -force

$alacritty_profile = "$env:APPDATA/alacritty/alacritty.yml"

function clip {
	param([parameter(position=0,mandatory=$true,ValueFromPipeline=$true)]$text)
	begin {
		$data = [System.Text.StringBuilder]::new()
	}
	process {
		if($text) {
			[void]$data.AppendLine($text)
		}
	}
	end {
		if($data) {
			$data.ToString().TrimEnd([Environment]::NewLine) + [Convert]::ToChar(0) | clip.exe
		}
	}
}

function cd {
	param([parameter(position=0,mandatory=$false,ValueFromPipeline=$true)]$location)
	set-location $location
	$Host.UI.RawUI.WindowTitle = pwd | split-path -leaf
}

function fd {
	while($true)
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

function fp {
	param([parameter(position=0,mandatory=$true,ValueFromPipeline=$true)]$text)
	begin {
		$data = [System.Text.StringBuilder]::new()
	}
	process {
		if($text) {
			[void]$data.AppendLine($text)
		}
	}
	end {
		if($data) {
			$selection = $data.ToString().Trim() | fzf --layout=reverse --no-sort
			if($selection) {
				write-host $selection
				$selection | clip
			}
		}
	}
}

function set-workspace-here {
	[System.Environment]::SetEnvironmentVariable("workspace", $PWD, [System.EnvironmentVariableTarget]::User)
}

function download-profiles {
	Set-ExecutionPolicy Bypass -Scope Process -Force
	iwr -useb https://matheuslessarodrigues.github.io/up/download-profiles.ps1 | iex
}

function download-omnisharp-config {
	curl.exe "https://matheuslessarodrigues.github.io/up/profiles/omnisharp.json" -O
}

function update-colors {
	curl.exe "https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Gruvbox%20Dark.itermcolors" -o "$home\terminal-colorscheme.itermcolors"
	colortool "$home\terminal-colorscheme.itermcolors"
}

cd $env:workspace
