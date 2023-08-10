#======================================================================= 
# FILE: Microsoft.PowerShell_profile.ps1
# DESCRIPTION: Prompt personalisé pour powershell
#=======================================================================

# Création de la fonction Get-Time (Renvoie l'heure actuelle)
function Get-Time {return $(Get-Date | ForEach-Object {$_.ToLongTimeString()})}

function Get-IsAdmin {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function prompt {
    Write-Host "[$(Get-Time)] "  -ForegroundColor Yellow -noNewLine
    if ( Get-IsAdmin ) 
    {
        Write-Host "$env:USERDOMAIN\$env:USERNAME"  -ForegroundColor Red -noNewLine
    }
    else {
        Write-Host "$env:USERDOMAIN\$env:USERNAME"  -ForegroundColor Cyan -noNewLine
    }
    Write-Host "@"  -ForegroundColor Green -noNewLine
    Write-Host $env:COMPUTERNAME -ForegroundColor Blue -noNewLine
    Write-Host ":"  -ForegroundColor Green -noNewLine
    Write-Host $($(Get-Location).Path.replace($home,"~")) -ForegroundColor Magenta
    Write-Host "--> " -ForegroundColor Green -noNewLine
    Write-Host $? -ForegroundColor Magenta -noNewLine
    Write-Host ":"  -ForegroundColor Green -noNewLine

    if ( Get-IsAdmin ) 
    {
        Write-Host "#"  -ForegroundColor Red -noNewLine
    }
    else {
        Write-Host "$"  -ForegroundColor Cyan -noNewLine
    }
    return '> '
}

# Set the Path
$Profile_ScriptFolder = "C:\AdminSys\Scriptes\Powershell"
if(Test-Path $Profile_ScriptFolder) {
    Set-Location -Path $Profile_ScriptFolder
}

# Show GUI
$IPAddress=@(Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.DefaultIpGateway})[0].IPAddress[0]
$PSVersion=($host | Select-Object -ExpandProperty Version) -replace '^.+@\s'

if (Get-IsAdmin) {
    $modeAdmin = "Mode Administrateur"
} else {
    $modeAdmin = "Mode Utilisateur"
}

Write-Host "======================================================================================================================" -ForegroundColor Yellow
Write-Host "                                                                                                                    " -ForegroundColor Yellow
Write-Host "   +++++++++++++++++++++++++++++++++++++++++++++             |          " -ForegroundColor Yellow -noNewLine; 
Write-Host "Bonjour $($env:USERNAME)"
Write-Host "   +++++++               +++++           +++++++             |          " -ForegroundColor Yellow
Write-Host "   +++++++++++++   +++++++++++   +++++++   +++++             |          " -ForegroundColor Yellow -NoNewline
Write-Host $modeAdmin
Write-Host "   +++++++++++++   +++++++++++   +++++++   +++++             |          " -ForegroundColor Yellow 
Write-Host "   +++++++++++++   +++++++++++   +++++++   +++++             |          " -ForegroundColor Yellow -NoNewline
Write-Host "Non Machine $($env:COMPUTERNAME)" 
Write-Host "   +++   +++++++   ++++   ++++   +++     +++++++             |          " -ForegroundColor Yellow
Write-Host "   +++   +++++++   +++++++++++   +++++++   +++++             |          " -ForegroundColor Yellow -noNewLine
Write-Host "Adresse IP : $IPAddress"
Write-Host "   +++   +++++++   +++++++++++   +++++++   +++++             |          " -ForegroundColor Yellow
Write-Host "   +++   +++++++   +++++++++++   +++++++   +++++             |          " -ForegroundColor Yellow -noNewLine
Write-Host "Identifiant : $env:UserDomain\$env:UserName"
Write-Host "   ++++           ++++++++++++           +++++++             |          " -ForegroundColor Yellow
Write-Host "   +++++++++++++++++++++++++++++++++++++++++++++             |          " -ForegroundColor Yellow -noNewLine
Write-Host "Powershell : $PSVersion"
Write-Host "                                                                        " -ForegroundColor Yellow
Write-Host "======================================================================================================================" -ForegroundColor Yellow