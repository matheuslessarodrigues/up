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
