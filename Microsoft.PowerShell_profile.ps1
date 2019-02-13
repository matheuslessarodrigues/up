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
		$lines = get-content $file

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
		add-content -path $file -value $line
	}
}

Function Todo-RemoveAt {
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

		$Indexes = $Indexes | sort -desc
		foreach($index in $Indexes) {
			$lines.RemoveAt($index)
		}

		set-content -path $file -value $lines
	}
}

Function Todo-RemoveWhere {
	[cmdletbinding()]
	[Alias("tw")]
	Param (
		[Alias("a")]
		[switch]$All,
		[Parameter(ValueFromRemainingArguments)]
		[string[]]$Text
	)
	Process {
		$file = Get-Todo-File
		$content = get-content $file

		$Text = $Text -join ' '
		$Text = "(\s+|^)" + $Text + "(\s+|$)"

		$filtered = @($content | where { $_ -notmatch $Text })

		if (($filtered.Length -eq ($content.Length - 1)) -or $All) {
			set-content -path $file -value $content
		} elseif ($filtered.Length -lt ($content.Length - 1)) {
			$matches = $content | where { $_ -match $Text }

			write-host "More than one match:"
			write-host -Object $matches -Separator `n
		}
	}
}

Function Todo-Delete {
	[cmdletbinding()]
	[Alias("tdel")]
	Param ()
	Process {
		$file = Get-Todo-File
		del $file
	}
}
