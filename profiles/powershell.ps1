set-psreadlinekeyhandler -key Ctrl+m -function AcceptLine
set-psreadlinekeyhandler -key Ctrl+w -function BackwardKillWord
set-psreadlinekeyhandler -key Tab -function MenuComplete

$env:FZF_DEFAULT_COMMAND='fd --type f'
$env:DOTNET_CLI_TELEMETRY_OPTOUT=$true

get-alias | remove-alias -force

function cd {
	param([parameter(mandatory=$false,ValueFromPipeline=$true)]$location)
	set-location $location 2>$null
	if(-not $?) {
		write-error $error[0]
		return
	}
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

function set-workspace-here {
	[System.Environment]::SetEnvironmentVariable("workspace", $PWD, [System.EnvironmentVariableTarget]::User)
}

function download-profiles {
	Set-ExecutionPolicy Bypass -Scope Process -Force
	(curl.exe "https://raw.githubusercontent.com/matheuslessarodrigues/up/master/download-profiles.ps1") -join "`n" | invoke-expression
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

if((get-location).Path -eq $home) {
	cd $env:workspace
}
