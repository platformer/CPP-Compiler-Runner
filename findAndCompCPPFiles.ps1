param([string]$workDir, [string]$searchOpt='none', [bool]$recur=0)

$mainFile=""
$otherFiles=""
$executable=""

Get-ChildItem $workDir -Filter "*.cpp" |
Where-Object { $_.Attributes -ne "Directory"} |
ForEach-Object {
If (Get-Content $_.FullName | Select-String -CaseSensitive -Pattern '(?<!//)[.\r\n]*main\s*\(.*\)[.\r\n]+(?!(?<!/\*)[.\r\n]*\*/') {
$mainFile=$_.Name
$executable=$_.BaseName+".exe"
}
else{
$otherFiles+=$_.Name+' '
}
}
return $mainFile,$otherFiles,$executable