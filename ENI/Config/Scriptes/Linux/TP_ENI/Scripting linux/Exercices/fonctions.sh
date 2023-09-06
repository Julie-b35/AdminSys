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

#Inclusion du fichier contenant les fonctions.
. /home/julie/AdminSys/Scriptes/Linux/TP_ENI/Exercices/fonctions.fonc

#Pseudo Code
#Initialiser les variable:
# Préllablement crée une variable (quiter=false, choix=0)
quiter=false
choix=0


# Déclaration des constante pour le vert, rouge, noir
declare -r ROUGE='\033[1;31m'
declare -r VERT='\033[1;32m'
declare -r NOIR='\033[0m'

# Afficher une présentation : 
echo
echo "==========================================="
echo "|                                         |"
echo "|       TP : Sur les Fonctions            |"
echo "|                                         |"
echo "==========================================="
echo



# Gestion du menu 
# Faire une boucle infinie avec until (jusqu'à ce que quiter=true.) -- Pour quiter le programme.
#   Afficher Menu (fonction)
#   Demander à l'utilisateur son choix : Que souhaitez-vous faire ? 
#
#   Traitement du choix (menu via case)
#   -> 1 fonc_sauvegarder_scriptes (fonctions)
#   -> 2 fonc_supprimer_sauvegarde (fonctions)
#   -> 3 fonc_liste_sauvegarde (fonctions)
#   -> 4 quiter=true
#   -> autre : Reproposer le menu.
#fonc_menu

until $quiter; do
    fonc_menu
    read -rp "Que souhaitez-vous faire ? " choix

    case $choix in
        1)
            fonc_sauvegarder_scriptes; fonc_autre_chose;
            ;;
        2)
            fonc_supprimer_sauvegarde; fonc_autre_chose;
            ;;
        3)
            fonc_liste_sauvegarde; fonc_autre_chose;
            ;;
        q|Q)
            fonc_quiter
            ;;
        *)
            echo -e "\nMauvais choix : Je vous relance le menu.\n"
            ;;
    esac
done

