#! /bin/bash

#======================================================================= 
# FILE: ~infousers.sh # USAGE: ./~infousers.sh
# DESCRIPTION: Jeu du plus ou moins
# Difficulté 0
# OPTIONS: --- 
# REQUIREMENTS: Utilisation de echo, conditions et paramètres.
# BUGS: --- 
# NOTES: --- 
# AUTHOR: Julie Brindejont, julie.brindejont2023@campus-eni.fr
# COMPANY: ENI 
# CREATED: 04/08/2023
# REVISION: 04/08/2023
#=======================================================================

# Ojbectf : Afficher un message, gérer des conditions avec les paramètres

declare -r CHIFFRE_MYSTERE=10

# Affiche un message de bienvenu.
echo
echo "======================================="
echo "|                                      |"
echo "|      Jeu : Plus ou Moins             |"
echo "|                                      |"
echo "======================================="
echo

#Jouer avec les paramètres
#Si aucun paramètre n'a été émis.
if [[ $# -eq 0 ]]; then
    echo "Vous n'avez pas entrer le chiffre mystère."
# Sinon Si plus d'un paramètre à été émis
elif [[ $# -gt 1 ]]; then
    echo "Je demande juste un nombre, ni plus, ni moins."
# Sinon si on rentre en paramètre une chaîne vide ("")
elif [[ -z $1 ]]; then
    echo "Tu essaie de m'arnaquer, tu à perdu."
#Sinon si le paramètre est égale au chiffre mystère.
elif [[ $1 -eq $CHIFFRE_MYSTERE ]]; then
    echo "Félicitation tu à gagné."
#Sinon c'est perdu
else
    echo "Tu à perdu."
fi