Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

Set-Alias -Name vim -Value nvim-qt.exe -Force

$env:FZF_DEFAULT_COMMAND="rg --files ."

Function Edit-Line {
	[cmdletbinding()]
	[Alias("edit")]
	Param (
		[parameter(ValueFromPipeline)]
		[string]$Line
	)
	Process {
		[System.Windows.Forms.SendKeys]::SendWait($Line)
		$Line = read-host
		write-output $Line
		set-clipboard -Value $Line
	}
}

Function Find-File {
	[cmdletbinding()]
	[Alias("ff")]
	Param (
		[Parameter(Mandatory=$true)]
		[Alias("p")]
		[string]$Pattern
	)
	Process {
		if ($Pattern -notlike "*.*") {
			$Pattern += ".*"
		}

		get-childitem -Path . -Filter $Pattern -Recurse | %{$_.FullName}
	}
}

Function Find-String {
	[cmdletbinding()]
	[Alias("fs")]
	Param (
		[Parameter(Mandatory=$true)]
		[Alias("f")]
		[string]$Filter,
		[Parameter(Mandatory=$true)]
		[Alias("p")]
		[string[]]$Patterns
	)
	Process {
		get-childitem -Path . -Filter $Filter -Recurse | select-string -Pattern $Patterns | select-object -Unique Path | %{$_.Path}
	}
}

Function Pick {
	[cmdletbinding()]
	[Alias("p")]
	Param (
		[parameter(ValueFromPipeline)]
		[Object]$Obj
	)
	Begin {
		$objs = new-object System.Collections.Generic.List[System.Object]
	}
	Process {
		$objs.Add($Obj)
	}
	End {
		if ($objs.Count -gt 1) {
			for ($i=0; $i -lt $objs.Count; $i++) {
				write-host "[", $i, "]", $objs[$i]
			}
			write-host

			$index = read-host -Prompt "Pick"
			$obj = $objs[$index]
			set-clipboard -Value $obj
			write-host $obj
		} elseif ($objs.Count -gt 0) {
			$obj = $objs[0]
			set-clipboard -Value $obj
			write-host $obj
		} else {
			write-host "No objects to pick."
		}
	}
}

Function Get-Todo-File {
	Process {
		$file = join-path -Path $env:UserProfile -ChildPath "todo.txt"
		if (!(test-path $file)) {
			new-item -path $env:UserProfile -name "todo.txt" -type "file"
		}

		return $file
	}
}

Function Todo-Help {
	[cmdletbinding()]
	[Alias("th")]
	Param ()
	Process {
		write-host "Todo Functions:"
		write-host "> Todo-List (tl)"
		write-host "> Todo-Add (ta)"
		write-host "> Todo-Remove (tr)"
		write-host "> Todo-List (tl)"
		write-host "> Todo-Prioritize (tp)"
		write-host "> Todo-Where (tw)"
		write-host "> Todo-Undo (tu)"
		write-host "> Todo-Delete (tdel)"
	}
}

Function Todo-List {
	[cmdletbinding()]
	[Alias("tl")]
	Param ()
	Process {
		$file = Get-Todo-File
		$lines = @(get-content $file)

		for ($i=0; $i -lt $lines.Length; $i++) {
			write-output ("[", $i, "]", $lines[$i] -join " ") -NoEnumerate
		}
	}
}

Function Todo-Add {
	[cmdletbinding()]
	[Alias("ta")]
	Param (
		[Parameter(ValueFromRemainingArguments)]
		[string[]]$Task
	)
	Process {
		$file = Get-Todo-File
		$line = $Task -join ' '

		Todo-Backup
		add-content -path $file -value $line

		write-host "Task added"
	}
}

Function Todo-Remove {
	[cmdletbinding()]
	[Alias("tr")]
	Param (
		[Parameter(ValueFromRemainingArguments)]
		[int[]]$Indexes
	)
	Process {
		$file = Get-Todo-File
		$content = @(get-content $file)
		[System.Collections.ArrayList]$lines = $content
		[System.Collections.ArrayList]$selectedLines = @()

		$Indexes = @($Indexes | sort -desc)
		foreach($index in $Indexes) {
			$_ = $selectedLines.Add($lines[$index])
			$lines.RemoveAt($index)
		}

		Todo-Backup
		set-content -path $file -value $lines

		write-host "Removed tasks:"
		write-host -Object $selectedLines -Separator `n
	}
}

Function Todo-Prioritize {
	[cmdletbinding()]
	[Alias("tp")]
	Param (
		[Parameter(ValueFromRemainingArguments)]
		[int[]]$Indexes
	)
	Process {
		$file = Get-Todo-File
		$content = @(get-content $file)
		[System.Collections.ArrayList]$lines = $content
		[System.Collections.ArrayList]$selectedLines = @()

		$Indexes = @($Indexes)
		foreach($index in $Indexes) {
			$_ = $selectedLines.Add($lines[$index])
		}

		$Indexes = @($Indexes | sort -desc)
		foreach($index in $Indexes) {
			$lines.RemoveAt($index)
		}

		Todo-Backup
		set-content -path $file -value ($selectedLines + $lines)

		write-host "Prioritized tasks:"
		write-host -Object $selectedLines -Separator `n
	}
}

Function Todo-Where {
	[cmdletbinding()]
	[Alias("tw")]
	Param (
		[Alias("p")]
		[switch]$Prioritize,
		[Alias("r")]
		[switch]$Remove,
		[Parameter(ValueFromRemainingArguments)]
		[string[]]$Search
	)
	Process {
		$file = Get-Todo-File
		$content = @(get-content $file)

		$text = $Search -join ' '
		#$text = "(\s+|^)" + $text + "(\s+|$)"

		$filtered = @($content | where { $_ -notmatch $text })
		$matched = @($content | where { $_ -match $text })

		if ($matched.Length -eq 0) {
			write-host "No match"
		} else {
			write-output $matched

			if ($Prioritize) {
				Todo-Backup
				set-content -path $file -value ($matched + $filtered)

				write-host
				write-host "Tasks prioritized"
			} elseif ($Remove) {
				write-host
				$reply = read-host -Prompt "Remove? [y/N]"
				if ( $reply -match "[yY]" ) {
					Todo-Backup
					set-content -path $file -value $filtered

					write-host
					write-host "Tasks removed"
				}
			}
		}
	}
}

Function Todo-Backup {
	Process {
		$file = Get-Todo-File
		$bkpFile = [io.path]::ChangeExtension($file, ".bkp.txt")
		copy-item $file $bkpFile
	}
}

Function Todo-Undo {
	[cmdletbinding()]
	[Alias("tu")]
	Param ()
	Process {
		$file = Get-Todo-File
		$bkpFile = [io.path]::ChangeExtension($file, ".bkp.txt")

		if (test-path $bkpFile) {
			copy-item $bkpFile $file
			write-host "Restored todo.txt"
		} else {
			write-host "No backup file found"
		}
	}
}

Function Todo-Delete {
	[cmdletbinding()]
	[Alias("tdel")]
	Param ()
	Process {
		$reply = read-host -Prompt "Delete? [y/N]"
		if ( $reply -match "[yY]" ) {
			$file = Get-Todo-File
			del $file

			write-host "Deleted todo.txt"
		}
	}
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (test-path($ChocolateyProfile)) {
	import-module "$ChocolateyProfile"
}
