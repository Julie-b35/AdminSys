
<#
Réalisez un script permettant de tester la présence d’un service. Le nom du
service sera variable. Dans le cas ou le service n’est pas existant, aucun message
ne sera affiché mais il sera consigné dans une variable. Un message sera affiché
lorsque tous les services seront testés.
#>




function Read-ListNameService {
    $listeNomService = Read-Host "Donnez moi une liste de nom de services (Service 1 [Service2... ]). "
    $listeNomService = $listeNomService  -split ' '
    return $listeNomService
}


function Get-TestService {
    Param (
        [Parameter(Mandatory = $true)]
        [string]$Name
    )
    

    try {
        return @{"service" = (Get-Service -Name $service -ErrorAction Stop -ErrorVariable error); Status=$true}
     } catch {
        return @{Name = $service; Erreur = $error; Status = $False}
     }
}

function Get-Error {
    Param (
        [Parameter(Mandatory = $true)]
        [System.Collections.ArrayList]$ListeErreursServices
    )
    
    if ( $ListeErreursServices.Count -gt 0) {
        foreach ($ErreurService in $ListeErreursServices) {
            
            $txt = $txt + $ErreurService.Name + ","
            $txtErreur = $txtErreur + "`n" + $ErreurService.Erreur
        }
        $txt = $txt -replace ',$'
        Write-Host 
        Write-Host "Les listes suivant n'existe pas . (" $txt ")" -ForegroundColor Cyan
        Write-Host $txtErreur -ForegroundColor Red
        exit 1
    }
}

$listeRetourGetTestService = New-Object System.Collections.ArrayList

foreach ($service in Read-ListNameService) {
    $retour = Get-TestService -Name $service
    if ($retour.Status -eq $False) {
        $listeRetourGetTestService += $retour
    }
}
Get-Error -ListeErreursServices $listeRetourGetTestService