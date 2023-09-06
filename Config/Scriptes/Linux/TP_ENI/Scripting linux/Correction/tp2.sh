#! /bin/bash
# Infos sur bash, premier script

echo "Bonjour, cette machine est fin prête pour scripter …"
echo "Scripts Shell présent ici :"
# Affiche la liste détaillée des scripts Shell présents dans le répertoire courant
ls -l *.sh
echo
echo "Informations relatives à l’interpréteur Bash :"
# Affiche la version de Bash installée
bash --version | head -1
# Affiche les chemins : du binaire de Bash, du fichier bashrc commun à tous les utilisateurs et du
# fichier contenant les pages de manuel de Bash
whereis bash
echo " Mise à jour disponible ? "
# Affiche si une version mise à jour de Bash est disponible
apt list --upgradable bash 2>/dev/null | grep -v ^Listing...
