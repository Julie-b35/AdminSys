


Créer le compte : useradd -m -s /bin/bash -c "Créé par tp5.sh" $nom
Modifier le mdp : passwd $nom
Supprimer le compte : userdel -r $nom
Vérifier que le compte existe : grep -q ^$nom: /etc/passwd

