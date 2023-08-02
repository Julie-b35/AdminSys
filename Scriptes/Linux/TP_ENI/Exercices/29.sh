#!/bin/bash

#======================================================================= 
# FILE: ~/Documents/Scriptes/tp2.sh # USAGE: ~/Documents/Scriptes/tp2.sh
# DESCRIPTION: Ce script
# 
# OPTIONS: --- 
# REQUIREMENTS: --- 
# BUGS: --- 
# NOTES: --- 
# AUTHOR: Julie
# COMPANY: eni 
# CREATED: 31.07.2023
# REVISION: 31.07.2023
#=======================================================================

# Définition des variables
# Compteur des année bissextiles
compteurAnneeBissextiles=0
# compteur boucle until ()
compteurAnnees=0

# Initilisation de la constante DEBUT_PLAGE_ANNEE avec la valeur de $1
declare -r DEBUT_PLAGE_ANNEE=$1
# Initilisation de la constante FIN_PLAGE_ANNEE avec la valeur de $2
declare -r FIN_PLAGE_ANNEE=$2
# Expression régulière pour valider le début et la fin de la plage d'années
declare -r REGEX_CHECK_ANNEE='^[0-9]{4}$'

# Déclaration des constantes (couleurs)
declare -r ROUGE='\033[1;31m'
declare -r ORANGE='\033[33m'
declare -r VERT='\033[32m'
declare -r NOIR='\033[0m'


writeErreur() {
    echo -e "${ROUGE}Erreur : $1${NOIR}"
    echo
    echo -e "${VERT}Syntaxe d'utilisation : $0 <debut plage annee> <fin plage annee> [ex: 1999 2003]${NOIR}" 
    exit 29
}

#Si Il y a plus de 2 paramètre alors on affiche un message d'erreur
if [[ $# -gt 2 ]]; then
    writeErreur "Ce programme ne prend que 2 paramètres."
#Contrôle si les plages contiennes une année (4 chiffres) - Bien entendu
elif ! [[ $DEBUT_PLAGE_ANNEE =~ $REGEX_CHECK_ANNEE && $FIN_PLAGE_ANNEE =~ $REGEX_CHECK_ANNEE ]] ; then
    writeErreur "Vérifier les paramètres, il semble qu'il ne correspondent pas à des années."
#Contrôle si le début de la plage est plus grande que la fin.
elif [[ $DEBUT_PLAGE_ANNEE -gt $FIN_PLAGE_ANNEE ]] ; then
    writeErreur "${ROUGE}Le début de la plage l'année ne peut être superieur à la fin de la plage de l'année."
elif [[ $DEBUT_PLAGE_ANNEE -eq $FIN_PLAGE_ANNEE ]] ; then
    writeErreur "${ROUGE}Le début de la plage ne peut être égale à la fin de la plage de l'année."
fi

compteurAnnees=$DEBUT_PLAGE_ANNEE
until [[ $compteurAnnees -eq $(($FIN_PLAGE_ANNEE+1)) ]] ; do

    ligne29=$(cal 2 "$compteurAnnees" | tail -n +3 | grep 29 | sed -e 's/[[:space:]]*$//')
    #ligne29=$(echo $ligne29)
    if [[ -n $ligne29 ]]; then
        ((compteurAnneeBissextiles++))
    #    #echo $ligne29
    #    #echo "$numAnnee est une année bissextiles"
        
    fi
    ((compteurAnnees++))
done

echo -ne "${VERT}Entre ${ORANGE}${DEBUT_PLAGE_ANNEE}"
echo -ne "${VERT} et ${ORANGE}${FIN_PLAGE_ANNEE}"
echo -e "$VERT, Il y a ${ORANGE}${compteurAnneeBissextiles}${VERT} année bissextiles.${NOIR}"
