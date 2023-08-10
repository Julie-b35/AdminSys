#Fonction pour demander une date au format Jour/Mois/Année
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
            Write-Host "Le jour doit être compris entre 01 et 31."
            $date[0] 
            $echec=$True
        }elseif ($date[1] -eq '00' -or $date[1] -gt 12) {
            Write-Host "Le mois doit être compris entre 01 et 12."
            $echec=$True
        }elseif ($date[2] -eq '0000') {
            Write-Host "L'année ne doit pas être 0000."
            $echec=$True
        }
        
        $date = "$($date[1])/$($date[0])/$($date[2])"
    } while ($echec)

    return [Datetime]$date
}


#Récupération de la date de naissance auprès de l'utilisateur
[Datetime]$dateNaissance = DemanderDate('Veuillez indiquer votre date de naissance. (Au format : Jour/Mois/Année)')

# Une boucle do-until pour  y aller au moins 1 fois
do {
    #Récupération de la date à deviner auprès de l'utilisateur
    [Datetime]$dateADeviner =  DemanderDate('Veuillez indiquer la date à deviner. (Au format : Jour/Mois/Année)' )

    #Si la date à deviner est supérieur à la date de naissance.
    if ( $dateADeviner -gt $dateNaissance )
        { Write-Host "C'est moins" }
    #Sinon si la date à deviner est inferieur à la date de naissance.
    elseif ( $dateADeviner -lt $dateNaissance )
        { Write-Host "C'est plus" }

    #Incrémentation de compteur de coup.
    $coup++;
} until (
    #Jusqu'à ce que la date de naissance soit égale à la date deviné.
    $dateNaissance -eq $dateADeviner
)

#Affichage du message de félicitation.
Write-Host "Félicitation vous avez trouver la date de naissance."
Write-Host "Vous avez réussis en $coup coup."

