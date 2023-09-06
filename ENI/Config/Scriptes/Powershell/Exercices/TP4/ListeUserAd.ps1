
#Utilisation de crédential (la connexion SSO ne se transmet pas en SSH) - Pour la connexion au contrôleur de domaine.
$User = 'AD01\Administrator'
$PWord = Read-Host "Mote de passe de $User " -AsSecureString
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

# Tentative de récupatation de la liste d'utilisateur activer sur le contrôleur de domaine.

$listeUsers = Get-ADUser -filter * -Credential $credential
$UserActif = New-Object System.Collections.ArrayList
$UserInactif = New-Object System.Collections.ArrayList

#Liste de tous les utilisateur présent dans l'ad
foreach ($listeUser in $listeUsers) {
    #Si l'utilisateur
    if ($listeUser.Enabled) {
        $UserActif += $listeUser
    } else {
        $UserInactif += $listeUser
    }
}

Write-Host "Utilisateur Acrif : ($(($UserActif | Measure-Object).Count)), Utilisateur Inactif : ($(($UserInactif | Measure-Object).Count))" -ForegroundColor Cyan