rep="$PWD"
extension=txt

echo "répertoire de travail : $rep"
echo "fichiers pouvant être traités :"
ls -1 $rep/*.$extension


echo "Quel fichier voulez-vous traiter ?"

#fic  réponse à la question posée précédemment
#nblign  nombre de lignes de fic
#debut  2 premières lignes de fic
#fin  2 dernières lignes de fic
#Afficher « CARACTERISTIQUES de fic »