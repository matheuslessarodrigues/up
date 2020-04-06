Set-PSReadlineKeyHandler -key Ctrl+m -function AcceptLine
Set-PSReadlineKeyHandler -key Ctrl+w -function BackwardKillWord
Set-PSReadlineKeyHandler -key Tab -function MenuComplete

$env:BAT_PAGER="less -FR --no-init"
$env:FZF_DEFAULT_COMMAND='fd --type f'
$env:DOTNET_CLI_TELEMETRY_OPTOUT=$true

Set-Alias -name vim -value nvim-qt.exe -force
Set-Alias -name which -value where.exe -force
Set-Alias -name cat -value bat.exe -force
Remove-Alias -name cd -force
Remove-Alias -name ls -force

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

function ls {
	param([parameter(position=0,mandatory=$false,ValueFromPipeline=$true)]$location)
	$saved_pwd = pwd
	if($location) {
		set-location $location
	}
	fd -d 1
	set-location $saved_pwd
}

function cd {
	param([parameter(position=0,mandatory=$false,ValueFromPipeline=$true)]$location)
	set-location $location
	$Host.UI.RawUI.WindowTitle = pwd | split-path -leaf
}

function ff {
	$currentPath = (pwd).Path + "\"
	$file = fzf --layout=reverse --prompt=$currentPath --no-sort --filepath-word --preview="bat {} --paging never --line-range :50 --style snip --color always"
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
	iwr -useb "https://raw.githubusercontent.com/matheuslessarodrigues/up/master/profiles/download-profiles.ps1" | iex
}

function download-omnisharp-config {
	curl.exe "https://raw.githubusercontent.com/matheuslessarodrigues/up/master/profiles/omnisharp.json" -O
}

function ssh-keygen {
	param([parameter(position=0,mandatory=$true,ValueFromPipeline=$true)]$keyname)
	begin {
		git bash --cd-to-home --hide -c "ssh-keygen -q -t rsa -f .ssh/$keyname -N ''"
		cat "$home/.ssh/$keyname.pub"
	}
}

function git-clone {
	param(
		$key,
		[parameter(position=0,mandatory=$true)]$url,
		[parameter(position=1,mandatory=$false,ValueFromRemainingArguments=$true)]$remaining
	)
	begin {
		if($key) {
			git clone -c "core.sshcommand=ssh -i ~/.ssh/$key" $url @remaining
		} else {
			git clone $url @remaining
		}
	}
}

cd $env:workspace
