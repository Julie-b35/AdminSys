#! /bin/bash
# Afficher un menu pour réaliser des opérations sur les fichiers .sh
#
# Tant que vrai faire
#   Demander à l'utilisateur ce qu'il veut faire, stocker la réponse dans choix
#   Selon la valeur de choix faire
#   	cas B => sauvegarder
#   	cas D => supprimer
#   	cas L => lister
#   	cas Q (ou autre réponse) => quitter
#   finfaire
# finfaire

# Menu
function f_menu() {
	echo "B : Sauvegarder les fichiers du répertoire courant se terminant par .sh avec l'extension .save"
	echo "D : Supprimer les fichiers se terminant par .save"
	echo "L : Lister les fichiers disposants d’une sauvegarde (vert) et ceux non sauvegardés (rouge)"
	echo "Q : Quitter"
}

function f_sauvegarder(){
	echo "Je sauvegarde"
}

function f_supprimer(){
	echo "Je supprime"
}

function f_lister(){
	echo "Je liste"
}

while true; do
	# Affichage du menu
	f_menu
	read choix

	case $choix in
		B)
			f_sauvegarder
			;;
		D)
			f_supprimer
			;;
		L)
			f_lister
			;;
		Q)
			exit 0
			;;
	esac
done
# ???
#
