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
# Initilisation de  debut_plage_annee avec la valeur de $1
debut_plage_annee=$1
# Initilisation de fin_plage_annee avec la valeur de $2
fin_plage_annee=$2


# Expression régulière pour valider le début et la fin de la plage d'années
declare -r REGEX_CHECK_ANNEE='^[1-9][0-9]?{1,3}$'

# Déclaration des constantes (couleurs)
declare -r ROUGE='\033[1;31m'
declare -r ORANGE='\033[1;33m'
declare -r VERT='\033[32m'
declare -r NOIR='\033[0m'


#Pseudo Code
# Si il  y a plus de 2 paramètres ou si il y a 0 parramètre ou si le paramètre 1 est vide 
#   alors msgErreur="Ce programme requière 1 paramère obligatoire, et 1 paramètre optionnel."
# Sinon si debut_plage_annee N'EST PAS conforme à REGEX_CHECK_ANNEE ou bien que 
# l'ensemble de si fin_plage_annee n'est pas vide et que fin_plage_annee N'EST PAS conforme à REGEX_CHECK_ANNEE 
#   alors msgErreur="Vérifier les paramètres, il semble qu'il ne correspondent pas à des années."
# Sinon si fin_plage_annee est vide (on fourni qu'un seul paramètre)

#Si Il y a plus de 2 paramètre alors on stock un message d'erreur
if [[ $# -gt 2 || $# -eq 0 || -z $debut_plage_annee ]]; then
    msgErreur="Ce programme requière 1 paramère obligatoire, et 1 paramètre optionnel."
elif [[ ! $debut_plage_annee =~ $REGEX_CHECK_ANNEE  || ( -n $fin_plage_annee && ! $fin_plage_annee =~ $REGEX_CHECK_ANNEE ) ]]; then
    msgErreur="Vérifier les paramètres, il semble qu'il ne correspondent pas à des années. (compris entre 1 et 9999)"
#Controle si la fin de la plage n'a pas été définie.
elif [[ -z $fin_plage_annee ]]; then
    fin_plage_annee=$debut_plage_annee
#Contrôle si le début de la plage est plus grande que la fin.
elif [[ $debut_plage_annee -gt $fin_plage_annee ]] ; then
    msg_Warning="$debut_plage_annee est plus grand que $fin_plage_annee, je les inverses."
    debut_plage_annee=$2
    fin_plage_annee=$1
# Si le début de la plage est égale à la fin alors on stock un message d'erreur
elif [[ $debut_plage_annee -eq $fin_plage_annee ]] ; then
    msgErreur="${ROUGE}Le début de la plage ne peut être égale à la fin de la plage de l'année."
fi

#Si un message d'erreur est définie alors on affiche ce message avec la syntaxe
if [[ -n $msgErreur ]]; then
    echo -e "${ROUGE}Erreur : $msgErreur${NOIR}" >/dev/stderr 2>&1
    echo >/dev/stderr 2>&1
    echo -e "${VERT}Syntaxe d'utilisation : $0 DEBUT_PLAGE_ANNEE [FIN_PLAGE_ANNEE] (ex: 1999 2003 ou juste 1999)${NOIR}"  >/dev/stderr 2>&1
    exit 29
elif [[ -n $msg_Warning ]]; then
    echo -e "${ORANGE}Avertissement : $msg_Warning${NOIR}" >/dev/stderr 2>&1
fi


compteurAnnees=$debut_plage_annee
# Boucle la plage de debut jusqu'à ce quelle sois plus grande que celle de la fin.
until [[ $compteurAnnees -gt $fin_plage_annee ]] ; do
    #echo $compteurAnnees
    ligne29=$(cal 2 "$compteurAnnees" | tail -n +2 | grep 29 )
    #ligne29=$(echo $ligne29)
    if [[ -n $ligne29 ]]; then
        ((compteurAnneeBissextiles++))
    #    #echo $ligne29
    #    #echo "$numAnnee est une année bissextiles"   
    fi
    ((compteurAnnees++))
done

#Contrôle si le début de la plage est égale à la fin de la plage (le cas d'un seule paramètre fournis)
if [[ $debut_plage_annee -eq $fin_plage_annee ]] ; then
    if [[ $compteurAnneeBissextiles -eq 1 ]] ; then
        echo -e "${VERT}L'année ${ORANGE}${debut_plage_annee}${VERT} est une année bissextile.${NOIR}"
    else
        echo -e "${ROUGE}L'année ${ORANGE}${debut_plage_annee}${ROUGE} n'est pas une année bissextile.${NOIR}"
    fi
else
    echo -ne "${VERT}Entre ${ORANGE}${debut_plage_annee}"
    echo -ne "${VERT} et ${ORANGE}${fin_plage_annee}"
    if [[ $compteurAnneeBissextiles -eq 1 ]]; then
        echo -e "$VERT, Il y a ${ORANGE}${compteurAnneeBissextiles}${VERT} année bissextile.${NOIR}"
    else
        echo -e "$VERT, Il y a ${ORANGE}${compteurAnneeBissextiles}${VERT} années bissextiles.${NOIR}"
    fi
fi
