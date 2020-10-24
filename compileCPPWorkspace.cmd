echo off & setlocal
set workspaceDir=%1
set searchOpt=%2
set recur=%3
set batchPath=%~dp0
set "i=0"
for /f "delims=" %%a in ('powershell.exe -file %batchPath%\findAndCompCPPFiles.ps1 -workDir %workspaceDir% -searchOpt %searchOpt% -recur %recur%') do(
	set /A i+=1
	set "p!i!=%%a"
)
echo on
if %p1% != "" (cd %workspaceDir% && cl %p1% %p2% && echo. && echo. && %p3%) else (echo Could not find main() in workspace)