Function Find-File {
	[cmdletbinding()]
	[Alias("ff")]
	Param (
		[Parameter(Mandatory=$true)]
		[Alias("p")]
		[string]$Pattern
	)
	Process {
		Get-ChildItem -Path . -Filter $Pattern -Recurse | %{$_.FullName}
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
		Get-ChildItem -Path . -Filter $Filter -Recurse | Select-String -Pattern $Patterns | Select-Object -Unique Path | %{$_.Path}
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
		$objs = New-Object System.Collections.Generic.List[System.Object]
	}
	Process {
		$objs.Add($Obj)
	}
	End {
		for ($i=0; $i -lt $objs.Count; $i++) {
			write-host "[", $i, "]", $objs[$i]
		}

		$index = read-host "Pick"
		$obj = $objs[$index]
		set-clipboard -Value $obj
		write-host $obj
	}
}

Function Get-Todo-File {
	Process {
		$file = join-path -Path $env:UserProfile -ChildPath "todo.txt"
		if (!(Test-Path $file)) {
			New-Item -path $env:UserProfile -name "todo.txt" -type "file"
		}

		return $file
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
			write-host "[", $i, "]", $lines[$i]
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
		$content = get-content $file
		[System.Collections.ArrayList]$lines = $content
		[System.Collections.ArrayList]$selectedLines = @()

		$Indexes = $Indexes | sort -desc
		foreach($index in $Indexes) {
			$selectedLines.Add($lines[$index])
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
		$content = get-content $file
		[System.Collections.ArrayList]$lines = $content
		[System.Collections.ArrayList]$selectedLines = @()

		foreach($index in $Indexes) {
			$selectedLines.Add($lines[$index])
		}

		$Indexes = $Indexes | sort -desc
		foreach($index in $Indexes) {
			$lines.RemoveAt($index)
		}

		Todo-Backup
		set-content -path $file -value ($selectedLines, $lines)

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
		[string[]]$Text
	)
	Process {
		$file = Get-Todo-File
		$content = get-content $file

		$Text = $Text -join ' '
		$Text = "(\s+|^)" + $Text + "(\s+|$)"

		$filtered = @($content | where { $_ -notmatch $Text })
		$matched = @($content | where { $_ -match $Text })

		if ($matched.Length -eq 0) {
			write-host "No match"
		} else {
			write-host "Matched tasks:"
			write-host -Object $matched -Separator `n

			if ($Prioritize) {
				Todo-Backup
				set-content -path $file -value ($matched, $filtered)
			} elseif ($Remove) {
				$reply = Read-Host -Prompt "Remove? [y/N]"
				if ( $reply -match "[yY]" ) {
					Todo-Backup
					set-content -path $file -value $filtered
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

		if (Test-Path $bkpFile) {
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
		$reply = Read-Host -Prompt "Delete? [y/N]"
		if ( $reply -match "[yY]" ) {
			$file = Get-Todo-File
			del $file

			write-host "Deleted todo.txt"
		}
	}
}
