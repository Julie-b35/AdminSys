#!/bin/bash

# A COMPLETER #
annee=$1
nummois=1
###annee=2011
rouge='\033[31m'
orange='\033[33m'
vert='\033[32m'
noir='\033[0m'

# A COMPLETER #

# A COMPLETER #
[[ -z $1 ]] && { echo -e "Syntaxe d'utilisation : $0 $rouge <annee> $noir"; exit 13; }

echo "###################"
echo "##  ANNEE $annee   ##"
echo "###################"

# A COMPLETER #
until [[ $nummois -eq 13 ]]
        do
        ligne13=`cal $nummois $annee | grep 13`
	# format du retour de la commande precedente incorrect
	ligne13=$(echo $ligne13)
        if [[ $ligne13 = *13\ 14 ]]
                then
                nommois=`date --date "$nummois/01" +%B`
                listmois="$listmois $nommois,"
                nbremois=`expr $nbremois + 1`
        fi
        nummois=`expr $nummois + 1`
done

# A COMPLETER #
echo -e "En $rouge $listmois $noir surveiller les paraskaviedekatriaphobes "
# A COMPLETER #
case $nbremois in
        1)
        niveau="calme"
        color="$vert"
        ;;
        2)
        niveau="moyenne"
        color="$orange"
        ;;
        *)
        niveau="a forte vigilance"
        color="$rouge"
        ;;
esac

# A COMPLETER #
echo -e "$annee sera une annee ${color}$niveau $noir( $nbremois )"
