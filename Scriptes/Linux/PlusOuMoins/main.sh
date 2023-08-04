#! /bin/bash

#======================================================================= 
# FILE: ~infousers.sh # USAGE: ./~infousers.sh
# DESCRIPTION: Jeu du plus ou moins
# Difficulté 0
# OPTIONS: --- 
# REQUIREMENTS: Connaître les boucles, condition
# BUGS: --- 
# NOTES: --- 
# AUTHOR: Julie Brindejont, julie.brindejont2023@campus-eni.fr
# COMPANY: ENI 
# CREATED: 04/08/2023
# REVISION: 04/08/2023
#=======================================================================

# Ojbectf : Utiliser la commande read

declare -r CHIFFRE_MYSTERE=10

#Initialisation du nombre demandé.
tentative=0

# Affiche un message de bienvenu.
echo
echo "======================================="
echo "|                                      |"
echo "|      Jeu : Plus ou Moins             |"
echo "|                                      |"
echo "======================================="
echo

#Jouer avec read
# -r Désactive le backslash pour échapper les caractères.
# -p Affiche un prompt 
read -rp "Trouve le chiffre mystère. " tentative

if [[ -z $tentative || $tentative = '""' || $tentative = "''" ]]; then
    echo "Tu n'a rien rentré, perdu."
elif [[ $tentative -eq $CHIFFRE_MYSTERE ]]; then
    echo "Félicitation tu à gagné."
else
    echo "Tu à perdu."
fi
echo -e $tentative
