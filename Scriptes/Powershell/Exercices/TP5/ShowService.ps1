
<#
Réalisez un script permettant de tester la présence d’un service. Le nom du
service sera variable. Dans le cas ou le service n’est pas existant, aucun message
ne sera affiché mais il sera consigné dans une variable. Un message sera affiché
lorsque tous les services seront testés.
#>



# Fonction pour récupérer des noms de service auprès de l'utilisateur.
function Read-ListNameService {
    $listeNomService = Read-Host "Donnez moi une liste de nom de services (Service 1 [Service2... ]). "
    $listeNomService = $listeNomService  -split ' '
    return $listeNomService
}


#Fonction qui test 1 nom de service
# Si tous va bien alors la fonction renvoie un dictionnaire {Service = Objects (Get-Service); Status = $true}
# Sinon la fonction renvoie un disctionnaire { Name = Nom du service; Erreur = l'erreur intersepté; Status = $False}
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

# La fonction ne fait que parcouris un tableau contenant le dictionnaire retourné par Get-TestService
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

#Initialisation d'un tableau de liste d'erreurs.
# Met fin au scripte en présence d'erreur de nom de service.
$listeRetourGetTestService = New-Object System.Collections.ArrayList

foreach ($service in Read-ListNameService) {
    # Appel à la fonction interne pour tester un nom de service
    $retour = Get-TestService -Name $service
    # Si status envoir false alors on incrémente le tableau d'erreur
    if ($retour.Status -eq $False) {
        $listeRetourGetTestService += $retour
    # Sinon on affiche Le résultat retournée par (Get-Service) en brut (Format-table)
    } else {
        $retour.service
    }
}
#Appel à une fonction interne (les affiche le cas échant et quite le programme.)
Get-Error -ListeErreursServices $listeRetourGetTestService 