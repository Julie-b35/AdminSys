#! /bin/bash

#======================================================================= 
# FILE: ~/Documents/Scriptes/param.sh # USAGE: ~/Documents/Scriptes/param.sh
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

#constante identifiant par défaut
declare -r ID_DEFAULT=invité

#Déclaration des constante sur les couleur
declare -r COULEUR_DEFAUT="\033[0m"
declare -r ROUGE_GRAS="\033[1;31;40m"

# sinon, on attribut l'identifiant avec le 1er argument $1

identifiant="$1"

# Si plusieurs arguments sont passés il affiche sa syntaxe d’utilisation
if [[ $# -gt 1 ]] ; then
    echo "Utilisation : $(basename "$0") [IDENTIFIANT]"
    echo "Utilisation : "$0" [IDENTIFIANT]"
    echo "Ce script permet affiche un message de bienvenue."
    exit 1
# Sinon si aucun argument n'est passé il demande la saisie du nom à l'utilisateur.
elif [[ $# -eq 0 || -z $identifiant ]] ; then
    read -rp "Entrer votre nom d'utilisateur. [$ID_DEFAULT] : " identifiant

    # Si aucun nom n'est saisi (vide), attribue le nom "invité"
    if [[ -z "$identifiant" ]] ; then
        identifiant="$ID_DEFAULT"
        echo "vous avez été redirigé sur le compte \"$ID_DEFAULT\""
    fi
fi

# Si le nom est "root" :
if [[ "$identifiant" = "root" ]] ; then
    # affiche "Interdit de se connecter en root" en rouge gras sur fond noir
    echo -e "${ROUGE_GRAS}Interdit de se connecter en root.${COULEUR_DEFAUT}"
    # quitte le script avec le code retour 4
    exit 4
    fkrlk
    fkeomkfl
    fkekl
fi


# Affiche : Bonjour <nom>, bienvenue sur la machine <nom_de_la_machine>
echo "Bonjour ${identifiant}, bienvenue sur la machine $(hostname)"

# lorsque tout le script se déroule normalement, affiche : "fin du script"
if [[ $? -eq 0 ]] ; then
    echo "fin du script"
fi



#(optionnel)
exit 0