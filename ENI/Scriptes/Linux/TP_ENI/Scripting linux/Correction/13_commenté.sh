#!/bin/bash

# L'année est passée en paramètre
annee=$1
# Initialisation de la boucle de 1 à 12
nummois=1
###annee=2011
rouge='\033[31m'
orange='\033[33m'
vert='\033[32m'
noir='\033[0m'

# Compter les mois d'une année donnée qui contiennent un vendredi 13

# En l'absence de paramètre (ou s'il est vide), on le demande, et on sort (code 13)
[[ -z $1 ]] && { echo -e "Syntaxe d'utilisation : $0 $rouge <annee> $noir"; exit 13; }

echo "###################"
echo "##  ANNEE $annee   ##"
echo "###################"

# Boucle sur les 12 mois de l'année
until [[ $nummois -eq 13 ]]
        do
	# Récupération des lignes avec 13 dans le calendrier du mois $nummois
        ligne13=`cal $nummois $annee | grep 13`
	# format du retour de la commande precedente incorrect
	# echo va nettoyer les espaces inutiles (avant/pendant/après) et les retours à la ligne
	ligne13=$(echo $ligne13)
	# Si la ligne finit par 13 14 : c'est un vendredi 13 !
        if [[ $ligne13 = *13\ 14 ]]
                then
		# Extraction du nom du mois en utilisant le 1er jour du mois
                nommois=`date --date "$nummois/01" +%B`
		# Sauvegarde du nom du mois avec les précédents
                listmois="$listmois $nommois,"
		# Compteur des mois correspondants. expr considère $nbremois à 0 au démarrage
                nbremois=`expr $nbremois + 1`
        fi
        nummois=`expr $nummois + 1`
done

# $listmois contient " mois1, mois2, …", on l'affiche en couleur
echo -e "En $rouge $listmois $noir surveiller les paraskaviedekatriaphobes "

# Choix de la couleur et du niveau en fonction du nombre de mois contenant des vendredi 13
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

# Affichage du niveau dans la couleur concernée
echo -e "$annee sera une annee ${color}$niveau $noir( $nbremois )"
