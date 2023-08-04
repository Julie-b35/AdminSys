#!/bin/bash
#
# Étant donné un répertoire passé en paramètre
# Afficher des statistiques sur les différents types de fichier
#
# DÉBUT
# Si pas de paramètres ou plus que un paramètre, alors
# 	Documentation à afficher
# 	Fin du programme, code 1
# FinSi
if [[ $# -ne 1 ]]; then
	echo "Utilisation du programme : $0 <repertoire>"
	exit 1
fi
#
rep=$1
# Compter les fichiers de $rep dans $nb_total
nb_total=$(ls "$rep" | wc -l)
echo "Nombre total de fichiers dans $rep : $nb_total"

# Pour chaque extension du fichier fic.ext, faire
#   compter le nombre de fichier finissant par extension dans $rep dans $nb_fic_ext
#   si nb_fic_ext > 0 alors 
#     afficher compteur
#   finsi
# finpour
while read ext; do
	nb_fic_ext=$(ls "$rep"/*."$ext" 2> /dev/null | wc -l)
	if [[ $nb_fic_ext -gt 0 ]]; then
		echo "--------------"
		echo "     $ext"
		echo "--------------"
		echo "-> $nb_fic_ext fichiers"
		echo "-> $((nb_fic_ext*100/nb_total))% des fichiers du répertoire"
	fi
done < fic.ext
# FIN
