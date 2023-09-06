
$pathToExercices = 'C:\AdminSys\Scriptes\Powershell\Exercices\TP4'

Write-Host "Stocker dans une variable le r�sultat de la commande 'Get-EventLog system'." -Foreground Green
Write-Host "- Quelle commande avez-vous utilis� ? " -Foreground Green -NoNewLine
$log = Get-EventLog -LogName System # Uniquement sur Windows Powershell
Write-Host '$log = Get-EventLog -LogName System' -Foreground Cyan
# Affichez l?entr?e de journal num?ro 10.
Write-Host "- Affichage de l'entr�e num�ro 10: " -Foreground Green
Write-Host "-------------------------------------------------------------------------------------------"
$Log[9]
Write-Host "-------------------------------------------------------------------------------------------"
Write-Host "- Quelle est la valeur de l'Index ? du journal ? "  -Foreground Green -NoNewLine;  Write-Host  $($Log[9].Index) -Foreground Cyan
Write-Host "- Cr�er une variable qui stockera l'adition de l'index de journal num�ro 10 et 20" -Foreground Green
Write-Host "- Quelle commande avez-vous utilis� ? " -Foreground Green -NoNewLine ; Write-Host '$additionLog = $log[9].Index + $log[19].Index' -Foreground Cyan
# Cr?er une variable qui stockera l?adition de l?index de journal num?ro 10 et 20
## Quelle commande avez-vous utilis? ?
$additionLog = $log[9].Index + $log[19].Index
Write-Host " additionLog vaut : $additionLog"

Write-Host "-------------------------------------------------------------------------------------------" -Foreground Yellow

Write-Host "Pour r�pondre au besoin vous utiliserez les structures If et DoWhile." -Foreground Yellow

Write-Host "
Cr�er un script qui dans un premier temps demande la saisie de la date de naissance d'un utilisateur. 
Puis dans un second temp demande ? l'utilisateur de trouver cette date de naissance en indiquant si la valeur saisie est sup�rieure ou inf�rieure.
Si la date saisie est correcte la boucle s'arr�te est l'utilisateur est f�licit�. 
BONUS indiquez le nombre d'essai effectu� par l'utilisateur.
"  -Foreground Green

Write-Host "-------------------------------------------------------------------------------------------" -Foreground Yellow
Write-Host "Appels du scripte date.ps1" -ForegroundColor Cyan 
#. "$pathToExercices\date.ps1"
Write-Host "Voici son contenus"
Get-Content "$pathToExercices\date.ps1"
Write-Host "-------------------------------------------------------------------------------------------" -Foreground Yellow
#powershell -noexit 

Write-Host "� Pour r�pondre au besoin, vous utiliserez les structures If et ForEach." -Foreground Yellow

Write-Host '
Cr�er un script qui g�n�rera deux variables de tableaux $UserActif et $SUserInactif ; 
dans chacune seront stock�s la liste des utilisateurs actif et inactif de votre serveur� ActiveDirectory �
'  -Foreground Green

Write-Host "-------------------------------------------------------------------------------------------" -Foreground Yellow
Write-Host "Appels du scripte ListeUserAd.ps1" -ForegroundColor Cyan 
#. "$pathToExercices\ListeUserAd.ps1"
Write-Host "Voici son contenus"
Get-Content "$pathToExercices\ListeUserAd.ps1"

Write-Host "Indiquez le nombre d�utilisateurs actif et inactif. " -ForegroundColor Green -NoNewline
Write-Host "Utilisateur Acrif : ($(($UserActif | Measure-Object).Count)), Utilisateur Inactif : ($(($UserInactif | Measure-Object).Count))" -ForegroundColor Cyan
Write-Host 
Write-Host "-------------------------------------------------------------------------------------------" -Foreground Yellow


Write-Host "� Utilisation de While / If ou Switch
`tR�alisez un menu � choix multiples, voici l'affichage attendu :" -Foreground Yellow

Write-Host "Appels du scripte GestionAD.ps1" -ForegroundColor Cyan 
#. "$pathToExercices\GestionAD.ps1"
Write-Host "Voici son contenus"
Get-Content "$pathToExercices\GestionAD.ps1"
Write-Host "-------------------------------------------------------------------------------------------" -Foreground Yellow


