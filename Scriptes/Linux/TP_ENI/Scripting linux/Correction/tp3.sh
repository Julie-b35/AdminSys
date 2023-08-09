#! /bin/bash
# Lister les fichiers selon une extension donnée
# Afficher les infos sur un fichier choisi :
# nb de lignes, premières et dernières lignes

rep=$PWD
extension=txt
echo "répertoire de travail : $rep"
echo "fichiers pouvant être traités :"
#Afficher la liste des fichiers de rep ayant pour extension extension
ls -1 ./*."$extension"
echo "Quel fichier voulez-vous traiter ?"
read -r fic

nblign=$(wc -l <"$fic")
debut=$(head -2 "$fic")
fin=$(tail -2 "$fic")

echo "CARACTERISTIQUES de $fic"
echo "Nombre de lignes du fichier : $nblign"
echo "Début du fichier :"
echo "$debut"
echo "Fin du fichier :"
echo "$fin"
