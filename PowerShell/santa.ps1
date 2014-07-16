param($file)

function ConvertTo-Array($hashtable) 
{   
	$result = @()
	$hashtable.GetEnumerator() | % {
		$object = New-Object PSObject	
		Add-Member -inputObject $object -memberType NoteProperty -name Giver -value $_.Name 
		Add-Member -inputObject $object -memberType NoteProperty -name Receiver -value $_.Value 
		$result += $object
	}   
	$result
}

$none = "NONE"
$names = @{}
gc $file | % { $names.Add($_, $none) }
$namesToMatch = $names.Keys.Count
if ($namesToMatch -lt 2) { 	throw "Need at least two names to match" }

while (($names.Keys | ? { $names.$_ -eq $none }).Length -gt 0) 
{
	$from = $names.Keys | ? { $names.$_ -eq $none } | Get-Random
	$to = $names.Keys | ? { $_ -ne $from -and $names.Values -notcontains $_ } | Get-Random
	#"DEBUG: $from, $to"
	if ($from -ne $null -and $to -ne $null -and $from.split()[1] -ne $to.split()[1]) 
	{
		$names.$from = $to
	}
	else
	{
		$undoMatch = $names.Keys | ? { $names.Values -ne $none `
			-and $from.split()[1] -ne $_.split()[1]} | Get-Random
		#"DEBUG: unset $undoMatch"
		if ($undoMatch -ne $null) 
		{
			$names.$undoMatch = $none
		}
	}
	$percentComplete = 100 * ($names.Values | ? { $names.$_ -ne $none }).Length / $namesToMatch
	Write-Progress -activity "Match in Progress" -status "% Complete:" -percentcomplete $percentComplete
}
$results = ConvertTo-Array $names
$results | ft 