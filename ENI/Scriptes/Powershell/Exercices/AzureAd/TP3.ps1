Import-Module MSOnline

Connect-MsolService

# 1 - Création de l'utilisateur Sacha Touille
New-MsolUser -UserPrincipalName "sacha@rtssr014f-6.lab-eni.fr" -DisplayName "Sacha Touille" -FirstName "Sacha" -LastName "Touille" -password 'Pa$$w0rd' -ForceChangePassword $true -UsageLocation 'JP' -Title 'Cuisinier' -Department 'Restauration'

# 2 - Afin de résoudre le problème de licence, j'ai crée un groupe de sécurité et attribué une licence office 365
#    puis j'ai ajouter sacha au groupe 'G-SEC-LicenceOffice365_E3'
Add-MsolGroupMember -GroupObjectId 21327b50-aa52-4f5c-8550-8d7675979eca -GroupMemberType "User" -GroupMemberObjectId 509ac112-7bdd-44e1-b32d-51e310b73893

# 3 - Création de l'utilisateur labeni
New-MsolUser -UserPrincipalName "labeni@rtssr014f-6.lab-eni.fr" -DisplayName "Lab ENI" -FirstName "Lab" -LastName "Eni" -password 'Pa$$w0rd' -ForceChangePassword $false -UsageLocation 'FR' -Title 'Administrateur' -Department 'Informatique'

# 4 - Aissignation de l'utilisateur labeni au groupe G-SEC-RoleAdminGlobale
Add-MsolGroupMember -GroupObjectId 3c74bc27-c408-4505-9314-aa78171b9631 -GroupMemberType "User" -GroupMemberObjectId 03727f7a-7f01-43be-af78-fec24ff29864

# 5 -Changer la fonction de Oussama Lairbon en chef cuisinier
Get-MsolUser -UserPrincipalName oussama@rtssr014f-6.lab-eni.fr | Set-MsolUser -Title 'Chef Cuisinier'

# 6 - Supprimer Shacha Touille puis le restaurer.
Remove-MsolUser -ObjectId 509ac112-7bdd-44e1-b32d-51e310b73893
Restore-MsolUser -UserPrincipalName "sacha@rtssr014f-6.lab-eni.fr"

# 7 - Vérifier la stratégie de mot de passe :
Get-MsolPasswordPolicy -DomainName 'rtssr014f-6.lab-eni.fr'
Get-MSOLUser | Select-Object UserPrincipalName, PasswordNeverExpires 

# 8 - Créer Plusieurs utilisateur avec le fichiers user-labeni.csv
# Voir le scriptes 'AddUsersMSOnline.ps1'

# 9 - Une fois les différent groupe créer. ajouteez les membres utilisateur avec le services correspondant
# Voir le scripte 'AssignGroupMember'

# Identifiant zachary@rtssr014f-6.lab-eni.fr Mdp Huw07991
# Identifiant oussama@rtssr014f-6.lab-eni.fr Mdp Rod31082
# Identifiant sacha@rtssr014f-6.lab-eni.fr Mdp Pa$$w0rd

# 10 - Réinisialiser le mot de passe de Sacha touille
Set-MsolUserPassword -NewPassword 'Pa$$w0rd' -ForceChangePassword $False

# 11 - Bonus
# Attribue une licence à un utilisateur
Set-MsolUserLicense -UserPrincipalName sacha@rtssr014f-6.lab-eni.fr -AddLicenses WWLx100068:SPE_E5
