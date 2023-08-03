#! /bin/bash

#======================================================================= 
# FILE: ~tp7.sh # USAGE: ./~tp7.sh 
# DESCRIPTION: Jeux du plus ou moins
# 
# OPTIONS: --- 
# REQUIREMENTS: --- 
# BUGS: --- 
# NOTES: --- 
# AUTHOR: Penthium2, contact@viperr.org 
# COMPANY: viperr 
# CREATED: 05.03.2015 
# REVISION: 02.08.2019 
#=======================================================================

# Déclaration des constantes (couleurs)
declare -r ROUGE='\033[1;31m'
declare -r ORANGE='\033[1;33m'
declare -r VERT='\033[32m'
declare -r NOIR='\033[0m'

declare -r MAX='100'
declare -r MAX_TENTATIVE=10

iteration=0
chiffre_mystere= $((1+  RANDOM % MAX_TENTATIVE ))

if [[ $# -gt 0 ]] ; then
    echo "Ce jeu ne prend aucun paramètre." 2>/dev/null
fi

echo $(echo $MAX_TENTATIVE | wc -c )

#Boucle tan que iteration plus petit que MAX_TENTATIVE
while [[ $iteration -lt $MAX_TENTATIVE ]]; do
    read -rp "Trouve le nombre mystère : " nombre

    #if [[ -z $nombre || ! $nombre]]

    ((iteration++))
done