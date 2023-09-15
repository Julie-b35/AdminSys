#!/bin/bash

vert='\e[32m'
rouge='\e[31m'
defaut='\e[0m'

menu(){
	echo -e "Choisir parmis les éléments suivants :\n"
	echo -e "\tA - Ajouter un enregistrement complet à ma zone"
	echo -e "\tP - Ajouter un enregistrement pas à pas à ma zone"
	echo -e "\tF - Afficher ma zone"
	echo -e "\tQ - Quitter"
}

validation(){
	echo -e "\nAjout de l'enregistrement à votre zone..."
	echo -e "$1" | tee --append "$zone_temporaire"
	echo ""
	if /usr/sbin/named-checkzone "$zone" "$zone_temporaire"
	then
		echo -e "${vert}[OK]${defaut} Zone $zone"
		echo "Synchronisation..."
		cat "$zone_temporaire" > "$zone_enregistree" || ( echo -e "${rouge}Verrifiez votre zone${defaut} $zone_enregistree" && exit 1 )
		echo -e "${vert}[OK]${defaut} Enregistrement ajouté"
		sudo /srv/recharge-ma-zone.sh && echo -e "${vert}[OK]${defaut} Zone rechargée"
		modif="true"
	else
		echo -e "${rouge}Erreur de validation de la zone${defaut}"
		echo "Votre modification ne correspond pas à la syntaxe DNS."
		echo -e "Proposez à nouveau votre modification :\n"
	fi
}

zone="$(logname).lab-eni.fr"
zone_enregistree="/var/cache/bind/$(logname)"
zone_temporaire=$(mktemp)

while :
do
	menu
	read choix
	case $choix in
		[aA])
			modif="false"
			until $modif ; do
				cat "$zone_enregistree" > "$zone_temporaire"
				unset record
				while [[ -z $record ]]
				do
					echo "Saisir votre enregistrement complet : "
					read -r record
				done
				validation "$record"
			done
		;;
		[pP])
			modif="false"
			until $modif ; do
				cat "$zone_enregistree" > "$zone_temporaire"

				echo -e "\nLe nom de l'enregistrement sera la partie demandée par l'utilisateur du service"
				echo -e "\tAu sein de votre zone, \"@\" représente la zone elle même."
				echo -e "\tVous pouvez aussi préciser un sous-domaine de votre zone."
				echo -e "\tPar exemple \"toto\" vous permet de déclarer \"toto.$zone\"."
				unset nom_r
				while [[ -z $nom_r ]] ; do
					read -p "Nom de l'enregistrement : " nom_r
					if [[ -z $nom_r ]] ; then
						unset confirmation
						read -p "Le nom de l'enregistrement ne peut être vide, utiliser @ par défaut ? (O/n) " confirmation
						[[ -z $confirmation || $confirmation = [Oo] ]] && nom_r="@"
					fi
				done

				echo "Il existe de nombreux types d'enregistrements (https://w.wiki/6322)"
				echo "Les plus courraments utilisé dans nos cours sont :"
				echo -e "\tA\tIPv4"
				echo -e "\tCNAME\tAlias vers un autre nom"
				echo -e "\tTXT\tText pour divers usages (notamment validation de possession)\n"
				unset type_r
				while [[ -z $type_r ]] ; do
				read -p "Type de l'enregistrement : " type_r
					if [[ -z $type_r ]] ; then
						unset confirmation
						read -p "Le type de l'enregistrement ne peut être vide, utiliser A par défaut ? (O/n) " confirmation
						[[ -z $confirmation || $confirmation = [Oo] ]] && type_r="A"
					fi
				done

				echo "La valeur dépend du type d'enregistrement"
				unset valeur_r
				while [[ -z $valeur_r ]] ; do
				read -p "Valeur de l'enregistrement : " valeur_r
					if [[ -z $valeur_r ]] ; then
						echo "La valeur de l'enregistrement ne peut être vide"
					fi
				done

				validation "$nom_r\t$type_r\t$valeur_r"
			done
		;;
		[fF])
			echo -e "\nvvvvvvvv $zone vvvvvvvv\n"
			# Je ne connais pas ioke, mais ça match pas mal la syntaxe
			pygmentize -l ioke "$zone_enregistree"
			echo -e "\n^^^^^^^^ $zone ^^^^^^^^\n"
		;;
		[qQ])
			rm "$zone_temporaire"
			exit
		;;
	esac
done

