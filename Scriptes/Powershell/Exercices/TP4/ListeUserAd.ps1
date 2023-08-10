
#Utilisation de crédential (la connexion SSO ne se transmet pas en SSH) - Pour la connexion au contrôleur de domaine.
$User = 'AD01\julie'
$PWord = '01000000d08c9ddf0115d1118c7a00c04fc297eb010000002f23ddbea11de94aa5e3fd4e918c2bab0000000002000000000003660000c0000000100000002e34942dc06510b563acdf6764205fd90000000004800000a000000010000000015294f0b4862a8f6d2a749b3c498b4e18000000c7e6324cdf2cf6c222a87f5c78867c232684022e41f3481e140000005226ed14982ffb9fe9188aaeac2ed4ad707aafae' | ConvertTo-SecureString
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
