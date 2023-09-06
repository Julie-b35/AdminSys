

function Menu() {
   # Clear-Host
    return Read-Host "Bienvenue dans l'outil d'inventaire, faùtes votre choix parmi les menus
suivants :
1) Affichage des ordinateurs du domaine.
2) Affichage des groupes de domaines locaux
3) Importation des utilisateurs ù AD ù ù partir dùun fichiers ù CSV ù
4) Exportation des utilisateurs ù AD ù dans un fichier ù CSV ù
5) Suppression des utilisateurs ù AD ù
6) Rùsinistialisation des mots de passes des utilisateurs.
7) Quitter

Entrez votre choix "
}



$User = 'AD01\Administrator'
$PWord = Read-Host "Mote de passe de $User " -AsSecureString
#$PWord = '01000000d08c9ddf0115d1118c7a00c04fc297eb010000002f23ddbea11de94aa5e3fd4e918c2bab0000000002000000000003660000c0000000100000002e34942dc06510b563acdf6764205fd90000000004800000a000000010000000015294f0b4862a8f6d2a749b3c498b4e18000000c7e6324cdf2cf6c222a87f5c78867c232684022e41f3481e140000005226ed14982ffb9fe9188aaeac2ed4ad707aafae' | ConvertTo-SecureString
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
#$credential = Get-Credential


# 1) Affichage des ordinateurs du domaine.
function Get-Computer() {
    $nomsPC = ''
    Get-ADComputer -filter * -Credential $credential | Foreach-Object {
        $nomsPC =  "$nomsPC$($_.Name),"
    }
    $nomsPC = $nomsPC -replace ',$'

    Write-Host "Voici la liste des ordinateur prùsent sur l'ad ($nomsPC)" -Foreground Cyan
    Write-Host 
}

# 2) Affichage des groupes de domaines locaux
function Get-Groupes() {
    Write-Host "Afficher des groupes"
    $listeGroupes = ''

    Get-ADGroup -filter * -Credential $credential | Where-Object GroupScope -eq DomainLocal | Foreach-Object {
        
        $listeGroupes =  "$listeGroupes$($_.Name),"
    }
    $listeGroupes = $listeGroupes -replace ',$'
    Write-Host "Voici la liste des groupes prùsent sur l'ad ($listeGroupes)" -Foreground Cyan
    Write-Host 
}

# 3) Importation des utilisateurs ù AD ù ù partir dùun fichiers ù CSV ù
function Import-Utilisateurs() {
    
    $listeUtilisateur = Invoke-Command -ComputerName '192.168.0.1' { Import-Csv "C:\Partage\Exports\CSV\Export_Users_AD.csv"  -Delimiter ';'} -Credential $credential
    $listeUtilisateur | New-ADUser -Credential $credential
    Write-Host "Importation des utilisateurs Fait."  -Foreground Cyan
    Write-Host 
}

#4) Exportation des utilisateurs ù AD ù dans un fichier ù CSV ù
function Export-Utilisateurs() {
    $path =  "C:\Partage\Exports\CSV\Export_Users_AD.csv"
    
    $listeUtilisateur = Get-ADUser -Filter * -Properties *  -Credential $credential | Select-Object GivenName,Surname,Name,SamAccountName,Description,company,City,Department,title
    Invoke-Command -ComputerName '192.168.0.1' {
        $Using:listeUtilisateur | Export-Csv -Path $Using:path -Delimiter ';' -NoTypeInformation 
    } -Credential $credential -ArgumentList $path,$listeUtilisateur 
    Write-Host "Exporter des utilisateurs Faite"  -Foreground Cyan
    Write-Host 
}

#5) Suppression des utilisateurs ù AD ù
function Remove-Utilisateurs() {
    Get-ADUser -filter 'Description -like "Utilisateur std"' -Credential $credential | Remove-AdUser -confirm:$false -Credential $credential
    Write-Host "Utilisateur dont le commentaire est : 'Utilisateur std' ù bien ùtù supprimù."  -Foreground Cyan
    Write-Host 
}

function ResetPassword() {
    $listeUtilisateur = Get-ADUser -filter 'Description -like "Utilisateur std"' -Credential $credential 
    
    foreach ($user in $listeUtilisateur) {
        $pass = ConvertTo-SecureString 'Pa$$w0rd' -AsPlainText -Force
        # $newPass = ConvertFrom-SecureString $pass
        
        Set-AdAccountPassword -Credential $credential -NewPassword $pass -Reset -Identity $user.DistinguishedName

        if ($user.Enabled -eq $False) {
            Set-AdUser -Identity  $user.SamAccountName -Enabled $true -ChangePasswordAtLogon $true
        }

    }
    
    Write-Host "Rùinitialisation des mot de passe des utilisateur faire."  -Foreground Cyan
    Write-Host 
}

do {
    $choix = Menu
    Write-Host 

    switch ($choix) {
        "1" { Get-Computer }
        "2" { Get-Groupes }
        "3" { Import-Utilisateurs }
        "4" { Export-Utilisateurs }
        "5" { Remove-Utilisateurs }
        "6" { ResetPassword}
        "7" { }
        Default { Write-Host "Valeur incorrect"}
    }
} until ( $choix -eq 7)

Write-Host "Merci d'avoir utilisù ce programme."