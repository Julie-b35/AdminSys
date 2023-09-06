#! /bin/bash
# Information sur l'utilisateur, passage de paramètre
# Si on a plus qu'un paramètre : retour 1
# Si on essaie de se connecter en root : retour 4

nom=$1

if [[ $# -gt 1 ]]; then
	echo "Utilisation du script : $0 [nom]"
	exit 1
elif [[ $# -eq 0 || -z "$nom" ]]; then
	read -rp "Votre nom d'utilisateur ? " nom
	if [[ -z "$nom" ]]; then
		nom=invité
		echo "vous avez été redirigé sur le compte 'invité'"
	fi
fi

if [[ "$nom" = "root" ]]; then
	echo -e "\e[1;31;40mInterdit de se connecter en root\e[0m"
	exit 4
fi

echo "Bonjour $nom, bienvenue sur $HOSTNAME"
echo "fin du script"
