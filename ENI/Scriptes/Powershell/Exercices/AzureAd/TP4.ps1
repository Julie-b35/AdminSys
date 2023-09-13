

# Création des unité d'organisation
$path = 'DC=cheouam6,DC=local'
New-ADOrganizationalUnit -Name '_cheouam6' -Path $path
$path = "OU=_cheouam6,$path"
New-ADOrganizationalUnit -Name 'Utilisateurs' -Path $path
New-ADOrganizationalUnit -Name 'Matériels' -Path $path
New-ADOrganizationalUnit -Name 'Groupes' -Path $path
New-ADOrganizationalUnit -Name 'Archives' -Path $path
$path_users = "OU=Utilisateurs,$path"
New-ADOrganizationalUnit -Name 'Rennes' -Path $path_users
New-ADOrganizationalUnit -Name 'Modèles_Utilisateurs' -Path $path_users
$path_Lieux = "OU=Rennes,$path_users"
New-ADOrganizationalUnit -Name 'Informatique' -Path $path_Lieux
New-ADOrganizationalUnit -Name 'Comptabilité' -Path $path_Lieux
New-ADOrganizationalUnit -Name 'Direction' -Path $path_Lieux
New-ADOrganizationalUnit -Name 'Commercial' -Path $path_Lieux
$path_matos = "OU=Matériels,$path"
New-ADOrganizationalUnit -Name 'Rennes' -Path $path_matos
$path_LieuxMatos = "OU=Rennes,$path_matos"
New-ADOrganizationalUnit -Name 'Informatique' -Path $path_LieuxMatos
New-ADOrganizationalUnit -Name 'Comptabilité' -Path $path_LieuxMatos
New-ADOrganizationalUnit -Name 'Direction' -Path $path_LieuxMatos
New-ADOrganizationalUnit -Name 'Commercial' -Path $path_LieuxMatos
$path_groupes = "OU=Groupes,$path"
New-ADOrganizationalUnit -Name 'Domaine_Local' -Path $path_groupes
New-ADOrganizationalUnit -Name 'Groupe_Global' -Path $path_groupes
$path_groupesGlobales = "OU=Groupe_Global,$path_groupes"



# Création des groupes Globaux
$nameGroup = 'GG_Administrateurs'
$param = @{
    Name            = $nameGroup
    SamAccountName  = $nameGroup
    GroupCategory   = 'Security'
    GroupScope      = 'Global'
    DisplayName     = $nameGroup
    Path            = $path_groupesGlobales
    Description     = 'Les Membres de ce groupe sont des administrateur globales'
}
New-ADGroup @param

$nameGroup = 'GG_Informatique'
$param = @{
    Name            = $nameGroup
    SamAccountName  = $nameGroup
    GroupCategory   = 'Security'
    GroupScope      = 'Global'
    DisplayName     = $nameGroup
    Path            = $path_groupesGlobales
    Description     = 'Les Membres de ce groupe font partis du service "Informatique"'
}
New-ADGroup @param


$nameGroup = 'GG_Comptabilité'
$param = @{
    Name            = $nameGroup
    SamAccountName  = $nameGroup
    GroupCategory   = 'Security'
    GroupScope      = 'Global'
    DisplayName     = $nameGroup
    Path            = $path_groupesGlobales
    Description     = 'Les Membres de ce groupe font partis du service "Comptabilité"'
}
New-ADGroup @param

$service = 'Direction'
$nameGroup = "GG_$service"
$param = @{
    Name            = $nameGroup
    SamAccountName  = $nameGroup
    GroupCategory   = 'Security'
    GroupScope      = 'Global'
    DisplayName     = $nameGroup
    Path            = $path_groupesGlobales
    Description     = 'Les Membres de ce groupe font partis du service "' + $service + '"'
}
New-ADGroup @param
$service = 'Commercial'
$nameGroup = "GG_$service"
New-ADGroup @param

# Donner des droit administrateur au groupe GG_Administrateurs
Add-ADGroupMember -Identity 'Administrateurs du schéma' -Members 'GG_Administrateurs'
Add-ADGroupMember -Identity 'Admins du domaine' -Members 'GG_Administrateurs'

# Création des modèles d'utilisateur
$user = @{
    Name        ='Modèle Admin'
    Path        = "OU=Modèles_Utilisateurs,$path_users"
    Description = 'Modèle Compte Administrateur'
    Title       = 'Administrateur'
    Department  = 'Informatique'
    Country     = 'FR'
    City        = 'Rennes'
    DisplayName = 'Modèle Admin'
    GivenName   = 'Modèle'
    Surname     =  'Admin'
}
New-ADUser @user

$user = @{
    Name        ='Modèle Comptables'
    Path        = "OU=Modèles_Utilisateurs,$path_users"
    Description = 'Modèle Comptables'
    Title       = 'Comptable'
    Department  = 'Comptabilité'
    Country     = 'FR'
    City        = 'Rennes'
    DisplayName = 'Modèle Comptables'
    GivenName   = 'Modèle'
    Surname     =  'Comptables'
}
New-ADUser @user

$user = @{
    Name        ='Modèle ResComptable'
    Path        = "OU=Modèles_Utilisateurs,$path_users"
    Description = 'Modèle Responsables Comptables'
    Title       = 'Responsable Comptable'
    Department  = 'Comptabilité'
    Country     = 'FR'
    City        = 'Rennes'
    DisplayName = 'Modèle '
    GivenName   = 'Modèle'
    Surname     =  'Res Comptables'
}
New-ADUser @user


$user = @{
    Name        ='Modèle Direction'
    Path        = "OU=Modèles_Utilisateurs,$path_users"
    Description = 'Modèle Direction '
    Title       = 'Directeur Général'
    Department  = 'Direction'
    Country     = 'FR'
    City        = 'Rennes'
    DisplayName = 'Modèle '
    GivenName   = 'Modèle'
    Surname     =  'Direction'
}
New-ADUser @user


$user = @{
    Name        ='Modèle Commercial'
    Path        = "OU=Modèles_Utilisateurs,$path_users"
    Description = 'Modèle Commercial '
    Title       = 'Commercial'
    Department  = 'Commercial'
    Country     = 'FR'
    City        = 'Rennes'
    DisplayName = 'Modèle '
    GivenName   = 'Modèle'
    Surname     =  'Commercial'
}
New-ADUser @user


Get-ADUser -filter 'name -eq "Modèle Commercial"'
Get-ADUser -filter 'name -eq "Modèle Direction"'
Get-ADUser -filter 'name -eq "Modèle ResComptable"'
Get-ADUser -filter 'name -eq "Modèle Comptables"'
Get-ADUser -filter 'name -eq "Modèle Admin"'
Add-ADGroupMember -Identity 'GG_Administrateurs' -Members 'Modèle Admin'
Add-ADGroupMember -Identity 'GG_Informatique' -Members 'Modèle Admin'
Add-ADGroupMember -Identity 'GG_Comptabilité' -Members 'Modèle ResComptable', 'Modèle Comptables'
Add-ADGroupMember -Identity 'GG_Direction' -Members 'Modèle Direction'
Add-ADGroupMember -Identity 'GG_Commercial' -Members 'Modèle Commercial'
$password = ConvertTo-SecureString 'Pa$$w0rd' -AsPlainText -Force