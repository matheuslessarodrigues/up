Function Find-File {
	[cmdletbinding()]
	[Alias("ff")]
	Param (
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
		[string]$FileFilter,
		[string]$Pattern
	)
	Process {
		Get-ChildItem -Recurse $FileFilter | Select-String $Pattern | Select-Object -Unique Path | %{$_.Path}
	}
}
