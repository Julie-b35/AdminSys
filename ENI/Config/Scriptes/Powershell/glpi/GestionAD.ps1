
function Get-Session
{
    $srv_host = '10.130.15.254'
    $user = 'AD\Administrateur'
    $mdp = Read-Host "Mot de passe : $user "  -AsSecureString 
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $mdp
    return New-PSSession -ComputerName $srv_host -Credential $credential
}

Import-Module -PSSession $(Get-Session) -name ActiveDirectory -prefix DC

function Get-Object
{
    Param (
        [Parameter(Mandatory = $true)]
        [string]$object
    )
    $test = 'CN=WIN10,CN=Computers,DC=olympus,DC=gr'
    $listeObjects = Get-DCADObject -filter *
    
    foreach ($item in $listeObjects){
        if ( $item.DistinguishedName -eq $test) {
            Return $True;
        }
    }

    Return $False
    
}

Function New-Ou {
    #New-ADOrganizationalUnit -Name "UserAccounts" -Path "DC=FABRIKAM,DC=COM"
}

$retour = Get-Object -object 'DC=julie,DC=lcl'


Write-Host $retour

