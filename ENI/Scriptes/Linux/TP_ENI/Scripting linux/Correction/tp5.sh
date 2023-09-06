#!/bin/bash
# usersmgmt.sh
# Gestion d'un utilisateur (suppression/mot de passe/création/vérification)
# Renvoie 3 si on ne le lance pas en root
# Renvoie 4 si on essaie de modifier l'utilisateur root
nom=$1

if [[ "$LOGNAME" != "root" ]]; then
	echo "Ce script doit être lancé en root"
	exit 3
fi

if [[ $# -gt 1 ]]; then
	echo "Utilisation du script : sudo $0 [nom]"
	exit 1
elif [[ $# -eq 0 || -z "$nom" ]]; then
	read -rp "Saisir l'identifiant utilisateur souhaité : " nom
	if [[ -z "$nom" ]]; then
		exit 1
	fi
fi

if [[ "$nom" = "root" ]]; then
	echo -e "\e[1;31;40mInterdit de modifier root\e[0m"
	exit 4
fi



echo "GESTION DES UTILISATEURS : $nom"
echo "--------------------------"
echo "C - Créer le compte utilisateur"
echo "M - Modifier le mot de passe de l'utilisateur"
echo "S - Supprimer le compte utilisateur"
echo "V - Vérifier si le compte utilisateur existe"
echo "Q - quitter"

echo -n "Votre choix : "
read -r choix

case $choix in
	c|C)
		echo "Création de $nom"
		useradd -m -s /bin/bash -c "Créé par tp5.sh" "$nom"
		;;
	[mM])
		echo "Modification du mot de passe de $nom"
		passwd "$nom"
		;;
	S|s)
		echo "Suppression de $nom"
		userdel -r "$nom" 2>/dev/null
		;;
	V|v)
		echo "Vérification de l'existence du compte"
		if grep -q ^$nom: /etc/passwd; then
			echo "Compte utilisateur de $nom EXISTANT"
		else
			echo "Compte utilisateur de $nom INEXISTANT"
		fi
		;;
	*)
		echo "Bye"
		exit
		;;
esac
