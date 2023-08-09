# ++++++++++++++++++++++++++++++++++
# Window, Path and Help

 

# Set windows prompt
function Get-Time {return $(Get-Date | ForEach {$_.ToLongTimeString()})}
function prompt {
    Write-Host "[" -noNewLine
    Write-Host $(Get-Time) -ForegroundColor Yellow -noNewLine
    Write-Host "] " -noNewLine
    Write-Host $($(Get-Location).Path.replace($home,"~")) -ForegroundColor Green -noNewLine
    Write-Host $(if ($nestedpromptlevel -ge 1) { '>>' }) -noNewLine
    return "> "
}

 

# Set the Path
$Profile_ScriptFolder = "C:\Script"
if(Test-Path $Profile_ScriptFolder) {
    Set-Location -Path $Profile_ScriptFolder
}

 

# Show GUI
$IPAddress=@(Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.DefaultIpGateway})[0].IPAddress[0]
$PSVersion=($host | Select-Object -ExpandProperty Version) -replace '^.+@\s'

 

Write-Host "# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" -ForegroundColor Yellow
Write-Host "# + " -ForegroundColor blue -nonewline; Write-Host "+++++++++++"
Write-Host "# + " -ForegroundColor blue -nonewline; Write-Host "+++  ++++++`tHi $($env:UserName)!"
Write-Host "# + " -ForegroundColor blue -nonewline; Write-Host "++++  +++++"
Write-Host "# + " -ForegroundColor blue -nonewline; Write-Host "+++++  ++++`tComputerName`t`t" -nonewline; Write-Host $($env:COMPUTERNAME)
Write-Host "# + " -ForegroundColor blue -nonewline; Write-Host "+++++  ++++`tIP Address`t`t" -nonewline; Write-Host $IPAddress
Write-Host "# + " -ForegroundColor blue -nonewline; Write-Host "++++  +   +`tUserName`t`t" -nonewline; Write-Host $env:UserDomain\$env:UserName
Write-Host "# + " -ForegroundColor blue -nonewline; Write-Host "+++  ++++++`tPowerShell `t`t" -nonewline; Write-Host $PSVersion
Write-Host "# + " -ForegroundColor blue -nonewline; Write-Host "+++++++++++"
Write-Host "# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++`n" -ForegroundColor Yello

 

# Refresh Help
Start-Job -Name "UpdateHelp" -ScriptBlock { Update-Help -Force } | Out-null
Write-Host "Updating Help in background (Get-Help to check)" -ForegroundColor 'DarkGray'

 

# ++++++++++++++++++++++++++++++++++
# Other
# ++++++++++++++++++++++++++++++++++

 

# Learn something today (show a random cmdlet help and "about" article
Get-Command -Module Microsoft*,Cim*,PS*,ISE | Get-Random | Get-Help -ShowWindow