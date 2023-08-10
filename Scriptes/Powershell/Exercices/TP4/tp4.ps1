
Get-Location
$pathToExercices = 'C:\AdminSys\Scriptes\Powershell\Exercices\TP4'

Write-Host "Stocker dans une variable le résultat de la commande « Get-EventLog system »." -Foreground Green
Write-Host "- Quelle commande avez-vous utilisé ? " -Foreground Green -NoNewLine
$log = Get-EventLog -LogName System # Uniquement sur Windows Powershell
Write-Host '$log = Get-EventLog -LogName System' -Foreground Cyan
# Affichez l’entrée de journal numéro 10.
Write-Host "- Affichage de l'entrée numéro 10: " -Foreground Green
Write-Host "-------------------------------------------------------------------------------------------"
$Log[9]
Write-Host "-------------------------------------------------------------------------------------------"
Write-Host "- Quelle est la valeur de l’ « Index » du journal ? "  -Foreground Green -NoNewLine;  Write-Host  $($Log[9].Index) -Foreground Cyan
Write-Host "- Créer une variable qui stockera l’adition de l’index de journal numéro 10 et 20" -Foreground Green
Write-Host "- Quelle commande avez-vous utilisé ? " -Foreground Green -NoNewLine ; Write-Host '$additionLog = $log[9].Index + $log[19].Index' -Foreground Cyan
# Créer une variable qui stockera l’adition de l’index de journal numéro 10 et 20
## Quelle commande avez-vous utilisé ?
$additionLog = $log[9].Index + $log[19].Index

Write-Host "-------------------------------------------------------------------------------------------" -Foreground Yellow

Write-Host "Pour répondre au besoin vous utiliserez les structures If et DoWhile." -Foreground Yellow

Write-Host "
Créer un script qui dans un premier temps demande la saisie de la date de naissance d’un utilisateur. 
Puis dans un second temp demande à l’utilisateur de trouver cette date de naissance en indiquant si la valeur saisie est supérieure ou inférieure.
Si la date saisie est correcte la boucle s’arrête est l’utilisateur estfélicité. 
BONUS indiquez le nombre d’essai effectué par l’utilisateur.
"  -Foreground Green

Write-Host "Appels du scripte date.ps1" -ForegroundColor Cyan

#Start-Process -FilePath .\Scriptes\Powershell\Exercices\TP3\test.ps1