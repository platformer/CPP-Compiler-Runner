param([string]$workDir, [string]$searchOpt='none', [bool]$recur=0)

$mainFile=""
$otherFiles=""
$executable=""
$foundMain=$false

if ($searchOpt -eq 'none') {
    Get-ChildItem $workDir -Filter "*.cpp" |
    Where-Object { $_.Attributes -ne "Directory"} |
    ForEach-Object {
        if (($foundMain -eq $false) -and (Get-Content $_.FullName | Select-String -CaseSensitive -Pattern (Get-InCommentRegex -searchRegex 'main[\s\r\n]*\([\s\r\n]*\)[\s\r\n]*\{'))) {
            $mainFile=$_.Basename+$_.Extension
            $executable=$_.BaseName+".exe"
            $foundMain=$true
        }
        else {
            $otherFiles+=$_.Name+' '
        }
    }
}
elseif ($searchOpt -eq 'sameName') {
    Get-ChildItem $workDir -Filter "*.cpp" |
    Where-Object { $_.Attributes -ne "Directory"} |
    ForEach-Object {
        if (($foundMain -eq $false) -and (Get-Content $_.FullName | Select-String -CaseSensitive -Pattern (Get-InCommentRegex -searchRegex 'main[\s\r\n]*\([\s\r\n]*\)[\s\r\n]*\{'))) {
            $mainFile=$_.Basename+$_.Extension
            $executable=$_.BaseName+".exe"
            $foundMain=$true
        }
    }

}

return $mainFile,$otherFiles,$executable


function Get-InCommentRegex {
    param ([string]$searchRegex)

    return '(?<!//).*'+$searchRegex+'[.\r\n]*(?!(?<!/\*)[.\r\n]*\*/)'
}