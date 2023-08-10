#Fonction pour demander une date au format Jour/Mois/Ann�e
# Renvoie un type Datetime utile pour la comparaison de Date (entier)
function DemanderDate([string]$prompt) {
    do {
        $echec=$false
        $date = Read-Host -Prompt $prompt
    
        if ($date -notmatch '^[0-9]{2}/[0-9]{2}/[0-9]{4}$') {
            Write-Host "La format que vous avez tapez n'est pas une date."
            $echec=$True
        } 
        $date = $date -split '/'
    
        if ($date[0] -eq '00' -or $date[0] -gt 31) {
            Write-Host "Le jour doit �tre compris entre 01 et 31."
            $date[0] 
            $echec=$True
        }elseif ($date[1] -eq '00' -or $date[1] -gt 12) {
            Write-Host "Le mois doit �tre compris entre 01 et 12."
            $echec=$True
        }elseif ($date[2] -eq '0000') {
            Write-Host "L'ann�e ne doit pas �tre 0000."
            $echec=$True
        }
        
        $date = "$($date[1])/$($date[0])/$($date[2])"
    } while ($echec)

    return [Datetime]$date
}


#R�cup�ration de la date de naissance aupr�s de l'utilisateur
[Datetime]$dateNaissance = DemanderDate('Veuillez indiquer votre date de naissance. (Au format : Jour/Mois/Ann�e)')

# Une boucle do-until pour  y aller au moins 1 fois
do {
    #R�cup�ration de la date � deviner aupr�s de l'utilisateur
    [Datetime]$dateADeviner =  DemanderDate('Veuillez indiquer la date � deviner. (Au format : Jour/Mois/Ann�e)' )

    #Si la date � deviner est sup�rieur � la date de naissance.
    if ( $dateADeviner -gt $dateNaissance )
        { Write-Host "C'est moins" }
    #Sinon si la date � deviner est inferieur � la date de naissance.
    elseif ( $dateADeviner -lt $dateNaissance )
        { Write-Host "C'est plus" }

    #Incr�mentation de compteur de coup.
    $coup++;
} until (
    #Jusqu'� ce que la date de naissance soit �gale � la date devin�.
    $dateNaissance -eq $dateADeviner
)

#Affichage du message de f�licitation.
Write-Host "F�licitation vous avez trouver la date de naissance."
Write-Host "Vous avez r�ussis en $coup coup."

