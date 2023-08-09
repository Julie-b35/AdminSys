#!/bin/bash

#======================================================================= 
# FILE: ~/Documents/Scriptes/tp2.sh # USAGE: ~/Documents/Scriptes/tp2.sh
# DESCRIPTION: Réalisation de l'atelier 2 sur Le scripting bash
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

#Ce déplacer dans le dossier exécutant le scripte.
cd $(dirname $0)

echo "Bonjour, cette machine est fin prête pour scripter ..."
echo "Scripts Shell présent ici :"

#Lister les fichier du répertoire actuel. (~/Documents/Scriptes/)
ls -l *.sh
echo

echo "Informations relatives à l'interpréteur Bash :"
echo -n "Version : "
bash --version | head -n1
echo -n "Chemin vers l'exécutable : "
which bash
echo "Chemin du fichier .bashrc : /etc/bash.bashrc"
echo -n "Chemin vers Pages de manuel : "
whereis bash | cut -d " " -f 3
echo "Mise à jour disponible ?"
apt list --upgradable bash 2>/dev/null | grep -v ^"En train"