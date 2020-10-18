param([string]$workDir, [string]$searchOpt='none', [bool]$recur=0)

mainFile=""
otherFiles=""

Get-ChildItem $workDir -Filter "*.cpp" |
Where-Object { $_.Attributes -ne "Directory"} |
ForEach-Object {
If (Get-Content $_.FullName | Select-String -CaseSensitive -Pattern '(?<!//)[.\r\n]*main\s*\(.*\)[.\r\n]+(?!(?<!/\*)[.\r\n]*\*/') {
$mainFile=$_.Name
}
else{
$otherFiles+=$_.Name+' '
}
}