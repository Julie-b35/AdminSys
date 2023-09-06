# début
# Pour chaque ligne de /etc/passwd
# Découper user pass uid gid comment home shell
# afficher : -------------------------
# afficher Identifiant : $user
# Si $uid est défini, afficher UID : $uid finsi
# Si $gid est défini, afficher GID : $gid finsi
# Si $comment est défini, afficher Description : $comment
# Si $home est défini, afficher : Repertoire personnel : $home
# Si $shell est défini, afficher : Shell : $shell
# finpour
# fin
#
IFS=":"
while read user pass uid gid comment home shell ; do
	echo "-------------------------"
	echo "Identifiant : $user"
	echo "- - - - - - - - -"
	echo -e "UID : $uid\t\tGID : $gid"
	if [[ -n $comment ]]; then
		echo -e "Description :\t\t$comment"
	fi
	if [[ -n $home ]]; then
		echo -e "Repertoire personnel :\t$home"
	fi
	if [[ -n $shell ]]; then
		echo -e "Shell :\t\t\t$shell"
	fi
done < /etc/passwd
