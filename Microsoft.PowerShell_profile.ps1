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
