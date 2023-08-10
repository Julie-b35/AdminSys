<#
Créer un script qui dans un premier temps demande la saisie de la date de naissance d’un utilisateur. 
Puis dans un second temp demande à l’utilisateur de trouver cette date de naissance en 
indiquant si la valeur saisie est supérieure ou inférieure. 

Si la date saisie est correcte la boucle s’arrête est l’utilisateur est félicité. 
BONUS indiquez le nombre d’essai effectué par l’utilisateur.

#>

# Demande la date de naissance à l'utilisateur

#[datetime]$dateNaissance="01/01/001"

do {
    $echec=$false
    try {
        [datetime]$dateNaissance = Read-Host -Prompt 'Veuillez indiquer votre date de naissance. (Au format : Mois/Jour/Année)'
    }
    catch {
        Write-Error "Une erreur est survenue. Veuillez taper la date de naissance au bon format."
        $echec=$True
    }

} while ($echec)

# Une boucle do-until pour  y aller au moins 1 fois
do {
        
    do {
        $echec=$false
        try {
            [datetime]$dateADeviner = Read-Host -Prompt 'Veuillez indiquer la date à deviner. (Au format : Mois/Jour/Année)' 
        }
        catch {
            Write-Error "Une erreur est survenue. Veuillez taper la date de naissance au bon format."
            $echec=$True
        }

    } while ($echec)

    if ( $dateADeviner -gt $dateNaissance )
        { Write-Host "C'est moins" }
    elseif ( $dateADeviner -lt $dateNaissance )
        { Write-Host "C'est plus" }

    $coup++;
} until (
    #Jusqu'à ce que la date de naissance soit égale à la date deviné.
    $dateNaissance -eq $dateADeviner
)

Write-Host "Félicitation vous avez trouver la date de naissance."
Write-Host "Vous avez réussis en $coup coup."

