#!/bin/bash

# Définition des variables
# annee (prend comme valeur le 1er argument indiquer)
# nummois (initialisation )
annee=$1
nummois=1
###annee=2011
rouge='\033[31m'
orange='\033[33m'
vert='\033[32m'
noir='\033[0m'

#Informe le nombre de vendredi 13 dans une anné.

# Si $1 est vide, alors affiche la syntaxe puis quite
[[ -z $1 ]] && { echo -e "Syntaxe d'utilisation : $0 $rouge <annee> $noir"; exit 13; }

echo "###################"
echo "##  ANNEE $annee   ##"
echo "###################"

#Faite un boucle de 1 à 12 (à 13 la condition est vrai alors le programme quite la boucle)
until [[ $nummois -eq 13 ]]
        do
        #La commande grep récupère uniquement la ligne où 13 est indiqué.
        # ... quand à sed, il supprimme le l'espace
        ligne13=$(cal "$nummois" "$annee" | grep 13 | sed -e 's/[[:space:]]*$//')
	# format du retour de la commande precedente incorrect
	#ligne13=$(echo $ligne13)
        if [[ $ligne13 = *13\ 14 ]]
                then
                #Le programme rentre ici uniquement si $ligne13 termine par '13 14'
                nommois=$(date --date "$nummois/01" +%B)
                listmois="$listmois $nommois,"
                nbremois=$((nbremois + 1))
        fi
        nummois=$((nummois + 1))
done

# Affiche en rouge la liste des mois à surveiller
echo -e "En $rouge $listmois $noir surveiller les paraskaviedekatriaphobes "
# Switch sur le nombre de vendredi 13 et définie le niveau de vigilence
case $nbremois in
        1)
        niveau="calme"
        color="$vert"
        ;;
        2)
        niveau="moyenne"
        color="$orange"
        ;;
        *)
        niveau="a forte vigilance"
        color="$rouge"
        ;;
esac

# affiche le niveau de vigilence
echo -e "$annee sera une annee ${color}$niveau $noir( $nbremois )"
