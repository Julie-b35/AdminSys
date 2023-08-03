#! /bin/bash

#======================================================================= 
# FILE: ~tp7.sh # USAGE: ./~tp7.sh 
# DESCRIPTION: une cli pour la gestion des flux 
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

# Initialisation des variables

# Déclaration du 1er paramètre comme nom de répertoire
repertoire="$1"

# Nombre total de fichiers dans un dossier
nombre_total_fichiers=0

# Déclaration des constantes (couleurs)
declare -r ROUGE='\033[1;31m'
declare -r ORANGE='\033[33m'
declare -r VERT='\033[32m'
declare -r NOIR='\033[0m'

#constante : liste d'extention à contrôler.
declare -r EXTS=".sh .txt"

# Contrôle des paramètres

# Si le nombre de paramètres vaut 0 
# ou bien nombre de paramètres > 1 alors msg_erreur_parametre="Cette commande prend un seul paramètre"
if [[ $# -eq 0 || $# -gt 1 ]]; then
    msg_erreur_parametre="Cette commande prend un seul paramètre."
# Sinon si le paramètre 1 est vide ou bien ce n'est pas un répertoire existant alors msg_erreur_parametre="Ce paramètre doit être un répertoire, et il doit exister."
elif [[ -z $1 || ! -d $1 ]]; then
    msg_erreur_parametre="Ce paramètre doit être un répertoire, et il doit exister."
fi

# Si msg_erreur_parametre c'est qu'il y a eu des erreur de paramètre, alors on affiche ce message ainsi que la syntaxe.
if [[ -n $msg_erreur_parametre ]]; then
    echo -e "${ROUGE}$msg_erreur_parametre${NOIR}" >/dev/stderr
    echo
    echo -e "${VERT}Syntaxe d'utilisation : $(basename "$0") RÉPERTOIRE ${NOIR}"  >/dev/stderr
fi

#Traiter le nombre total de fichiers présent dans le dossier
nombre_total_fichiers=$(( $(find $repertoire -type f 2>/dev/null | wc -l) - 1 ))

echo $nombre_total_fichiers

for ext in $EXTS
do
    #find ${repertoire}
    echo "--------------"
    echo $ext
    echo "--------------"

    echo "nb file"
    echo "30% des fichiers du répertoire"
done


