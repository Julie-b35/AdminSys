
$tabPath = $profile -split '\\'
$nameScripte = $tabPath | Select-Object -Last 1

#New-Item -Path "c:\" -Name "logfiles" -ItemType "directory"
$tabPath
$nameScripte