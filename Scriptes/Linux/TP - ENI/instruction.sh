#! /bin/bash

# La ligne ci-dessus est un hashbang (ou shebang)

#======================================================================= 
# FILE: ~toris.sh # USAGE: ./~toris.sh 
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

# afficher du texte
echo toto

# Capturer du texte
read nom

# Affiche une variable 
echo $nom

# Mode débogage du shell
bash -x

#inhiber le retoure à la ligne
echo -n  1 + 1
echo "= 2"

#Utiliser les caractère d'échapement
echo -e

#Variable spécial
# $? = Code de retour


