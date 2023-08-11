
function Get-Session
{
    $user = 'AD01\Administrator'
    $mdp = Read-Host "Mot de passe : $user "  -AsSecureString 
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $mdp
    return New-PSSession -ComputerName 172.21.0.3 -Credential $credential
}

function stop {
    param($domaine)
}

#Get-Module -PSSession $Session -ListAvailable
Import-Module -PSSession $Session –name ActiveDirectory –Prefix DC

Get-DCADComputer -Filter * -Properties * -SearchBase 'cn=' | ForEach-Object {

    if ($_.DistinguishedName -notlike "*Domain Controllers*") {
        Invoke-Command -ComputerName $_.Name -ScriptBlock { shutdown /s /f /t 0} -Credential $credential
    }
}
