Function Find-File {
	[cmdletbinding()]
	[Alias("ff")]
	Param (
		[string]$Filter
	)
	Process {
		Get-ChildItem -Path . -Filter $Filter -Recurse | %{$_.FullName}
	}
}
