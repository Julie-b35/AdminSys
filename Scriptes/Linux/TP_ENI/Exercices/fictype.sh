#! /bin/bash

#======================================================================= 
# FILE: ~tp7.sh # USAGE: ./~tp7.sh 
# DESCRIPTION: Commande qui donne le nombre de fichiers par extension
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

# Pourcentage de fichiers dans un dossiers par extension
pourcentage_fichiers_par_ext=0

msg_erreur_parametre=
msg=""

# Déclaration des constantes (couleurs)
declare -r ROUGE='\033[1;31m'
declare -r ORANGE='\033[1;33m'
declare -r VERT='\033[32m'
declare -r NOIR='\033[0m'


# Contrôle des paramètres

# Si le nombres de paramètres > 1 
#   alors msg_erreur_parametre="Cette commande prend un seul paramètre"
# Sinon si aucun pararamètre n'a été fournis
#   alors on prend le répertoire actuel (.) comme valeur de répertoire
# Sinon si le paramètre 1 est vide ou bien que ce n'est pas un répertoire existant 
#   alors msg_erreur_parametre="Ce paramètre doit être un répertoire, et il doit exister."

if [[ $# -gt 1 ]]; then
    msg_erreur_parametre="Cette commande prend un seul paramètre."

elif [[ $# -eq 0 ]]; then
    echo -e "${ORANGE}Aucune paramètre fournis, je prend l'emplacement actuel comme répertoire.${NOIR}" > /dev/stderr
    repertoire=.
elif [[ -z $repertoire || ! -d $repertoire ]]; then
    msg_erreur_parametre="Ce paramètre doit être un répertoire, et il doit exister."
fi

# Si msg_erreur_parametre esst définie c'est qu'il y a eu des erreur de paramètre, 
#   alors on affiche ce message ainsi que la syntaxe.

if [[ -n $msg_erreur_parametre ]]; then
    echo -e "${ROUGE}$msg_erreur_parametre${NOIR}" >/dev/stderr
    echo
    echo -e "${VERT}Syntaxe d'utilisation : $(basename "$0") [RÉPERTOIRE] ${NOIR}"  >/dev/stderr
    exit 1
fi

#Traiter le nombre total de fichiers présent dans le dossier
nombre_total_fichiers=$(find "$repertoire" -maxdepth 1 -type f 2>/dev/null | wc -l) 

if [[ $nombre_total_fichiers -eq 0 ]]; then
    echo "Aucun fichier dans ce dossier : $(realpath "$repertoire")"
    exit
fi

echo "Nombre total de fichiers dans $(realpath "$repertoire") : ${nombre_total_fichiers}"

#Pour chaque extension présent dans le fichier type.ext, faire.
#for ext in $(cat types.ext)
while read -r ext
do
     #Traiter le nombre de fichiers par extension.
    nombre_fichiers=$(find "$repertoire"  -maxdepth 1 -type f -name "*$ext" 2>/dev/null | wc -l) 

    #Si aucun fichier trouvé
    # alors on continue à l'itération suivante.
    if [[ $nombre_fichiers -eq 0 ]]; then
        continue
    elif [[ $nombre_fichiers -gt 1 ]]; then
        msg="-> $nombre_fichiers fichiers"
    else
        msg="-> $nombre_fichiers fichier"
    fi
    
    # Traiter le pourcentage de fichiers par extension
    # nombre_total_fichiers = 100%
    pourcentage_fichiers_par_ext=$((nombre_fichiers * 100 / nombre_total_fichiers))

    # Afficher le résultat.
    #find ${repertoire}
    echo "--------------"
    echo "$ext"
    echo "--------------"
    echo "$msg"
    echo "${pourcentage_fichiers_par_ext}% des fichiers du répertoire"
#done
done < types.ext


