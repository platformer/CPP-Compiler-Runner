echo off & setlocal
set workspaceDir=%1
set searchOpt=%2
set recur=%3
set batchPath=%~dp0
powershell.exe -file "%batchPath%findAndCompCPPFiles.ps1" -workDir %workspaceDir% -searchOpt %searchOpt% -recur %recur%