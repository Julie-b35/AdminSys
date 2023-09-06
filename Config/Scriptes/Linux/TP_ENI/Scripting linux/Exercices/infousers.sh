#! /bin/bash

#======================================================================= 
# FILE: ~infousers.sh # USAGE: ./~infousers.sh
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

# Sauvegarder la constante de la variable IFS
declare -x OLD_IFS=$IFS
# Changer la variable IFS
IFS=":"
#Boucle tanque que read  lis des entrée dans le fichier /etc/passwd
while read -r pseudo mdp uid gid commentaire home shell; do
    #echo $pseudo $mdp $uid $gid $commentaire $home $shell
    echo "------------------------------------------"
    echo -e "Identifiant :\t\t\t${pseudo}"
    echo "- - - - - - - - - - - - - -"
    echo -e "UID : ${uid}\t\t\tGID : ${gid}"
    #Si le comme
    [[ -n "$commentaire" ]] && echo -e "Description :\t\t\t${commentaire}"
    # (Hors Cours - Intégrer dans l'ifs la virgule pour gérer les commentaire 1 à 1)


    [[ -n "$home" ]]        && echo "Repertoire personnel : ${home}"
    [[ -n "$shell" ]]       && echo -e "Shell : ${shell}\n\n"
done < /etc/passwd

IFS=$OLD_IFS