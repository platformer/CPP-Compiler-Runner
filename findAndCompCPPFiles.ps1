param([string]$workDir, [string]$searchOpt='none', [bool]$recur=0)

$mainFile=""
$otherFiles=""
$executable=""

if ($searchOpt -eq 'none') {
    Get-ChildItem $workDir -Filter "*.cpp" |
    Where-Object { $_.Attributes -ne "Directory"} |
    ForEach-Object {
        If (Get-Content $_.FullName | Select-String -CaseSensitive -Pattern '(?<!//).*main[\s\r\n]*\(.*\)[\s\r\n]*\{[.\r\n]*(?!(?<!/\*)[.\r\n]*\*/)') {
            $mainFile=$_.Name
            $executable=$_.BaseName+".exe"
        }
        else {
            $otherFiles+=$_.Name+' '
        }
    }
}
return $mainFile,$otherFiles,$executable


function Get-InCommentRegex {
    param {
        [string]$searchRegex
    }

    return '(?<!//).*'+$searchRegex+'[.\r\n]*(?!(?<!/\*)[.\r\n]*\*/)'
}