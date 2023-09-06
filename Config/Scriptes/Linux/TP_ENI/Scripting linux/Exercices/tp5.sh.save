#! /bin/bash

#======================================================================= 
# FILE: ~/Documents/Scriptes/tp5.sh # USAGE: ~/Documents/Scriptes/tp5.sh
# DESCRIPTION: Réalisation de l'atelier 4 sur Le scripting bash
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

#Déclaration des variables
#identifiant = $1 (sois le nom d'utilisation)

# Identification de l'utilisateur

[[ $UID -ne 0 ]] && echo "Ce script doit être lancé en root" && exit 1;


read -rp "Saisir l'identifiant utilisateur souhaité : " nom

if [[ -z "$nom" ]] ; then
    echo "Vous n'avez pas entrer de nom d'utilisateur."
    exit 1
fi


echo
echo "GESTION DES UTILISATEURS : ${nom}"
echo "--------------------------"
echo "C - Créer le compte utilisateur"
echo "M - Modifier le mot de passe de l'utilisateur"
echo "S - Supprimer le compte utilisateur"
echo "V - Vérifier si le compte utilisateur existe"
echo "Q - quitter"


read -rp "Votre choix : " choix

if [[ -z "$choix" ]]; then
        echo "Vous n'avez pas entrer de choix."
        exit 1
fi

case $choix in
    [cCmM])
        if grep -q ^$nom: /etc/passwd; then
            echo "Le compte utilisateur de $nom est déjà crée."
            exit 1
        fi 
        ;;
    c|C)

        echo "Création du compte utilisateur..."
        useradd -m -s /bin/bash -c "Crée pat tp5.sh" "$nom" 2>/tmp/tp5_error

        if [[ $? -eq 0 ]] ; then
            echo "Le compte à bien été crée ."
        fi
        ;;
    m|M)
        echo "Modification du mot de passe..."
        passwd "$nom"

        if [[ $? -eq 0 ]] ; then
            echo "Le mot de passe à bien été modifié."
        fi
        ;;
    s|S)
        echo "Suppression du compte..."
        deluser "$nom" 2>/tmp/tp5_error

        if [[ $? -eq 0 ]] ; then
            echo "Le compte à bien été supprimé"
        fi
        ;;
    v|V)
        echo "Vérification de l'existence du compte"
        if grep -q ^$nom: /etc/passwd; then
            echo "Compte utilisateur de $nom EXISTE"
        else
            echo "Compte utilisateur de $nom INEXISTANT."
        fi 
        ;;
    q|Q)
        exit 
        ;;
    *)
        echo "Vous avez entrez un mauvais choix."
        exit 1
        ;;
esac

#useradd -m -s /bin/bash -c "Crée pat tp5.sh"
#passwd 




echo "nom = \"$nom\""
echo "choix = \"$choix\""

