#! /bin/bash
#
# Compter les années bissextiles
#
# PSEUDOCODE
# Gérer les paramètres passés : 1 : KO, 2 : OK, 3+ : KO

# Condition : $2 ne doit pas être vide, et on ne doit pas avoir plus de 2 paramètres
if [[ -z $1 || -z $2 || $# -gt 2 ]]; then
	echo "Syntaxe : $0 <annee1> <annee2>"
	exit 1
fi

annee1=$1
annee2=$2

if [[ $annee1 -gt $annee2 ]]; then
	echo "$annee2 est plus petit que $annee1, je les inverse."
	annee2=$1
	annee1=$2
fi

compteur_annees=$annee1
nb_annees_bissextiles=0

#tant que compteur_annees plus petit ou égal à annee2, faire
while [[ $compteur_annees -le $annee2 ]]; do
	# Si le mois de février a 29 jours
	# En vérifiant l'avant-dernière ligne de cal 2 XX, si elle contient 29
	if cal 2 $compteur_annees | tail -2 | grep -q 29; then
		((nb_annees_bissextiles++))
	fi
	((compteur_annees++))
done
echo "Entre $annee1 et $annee2, il y a $nb_annees_bissextiles année(s) bissextile(s)"
