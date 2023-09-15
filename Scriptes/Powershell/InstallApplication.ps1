#####################################################################
#                                                                   #
#      TP 5:  Messagerie Cloud                                      #
#      (MDM et Office 365 ProPlus)                                  #
#      BONUS : Déployer Office 365 ProPlus                          #
#                                                                   #
#####################################################################

#Permet d'envoyer des message au gestionnaire d'évènement.
function log {
    param (
        [Parameter(Mandatory=$True)]
        [String]$msg,
        [int]$id
    )
    write-eventlog -logname Application -source Deploiement_Office -eventID $id -entrytype Information -message "$msg" -category 1 -rawdata 10,20
}

### Variables
# Chemin UNC vers le partage qui contiens la commande cmd
# IMPORTANT : Les PC doit être autorisé à accéder au partage.
$SharedFolder = "\\SRV-DC01\Logiciels$\"

# Chemin vers le dossier temporaire sur le poste
$LocalFolder = "C:\TEMP"

# Chemin vers le scriptes 
$folder = "Office"
$ScriptName = "setup.exe"
$FileXml = "install-office365-Gpo.xml"


$ExeVersion = "16.0.16731.20234"
 
# Chemin vers l'éxécutable une fois l'installation terminée.
$Excel = "C:\Program Files\Microsoft Office\root\Office16\excelcnv.exe"
$Word =  "C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE"
$DesktopPublic = "C:\Users\Public\Desktop"

# Le logiciel est-il déja installé.
$InstalledVersion = (Get-ItemProperty -Path $Excel -ErrorAction SilentlyContinue).VersionInfo.FileVersion


#echo "La version est de $InstalledVersion" >> "$LOGFolder/$LogFile"

if (($null -eq $InstalledVersion) -or ($null -ne $InstalledVersion -and $InstalledVersion -ne $ExeVersion)) {
    
      # Si $InstalledVersion n'est pas null et que la version est différente : c'est qu'il faut faire une mise à jour
   if($null -ne $InstalledVersion){ 
        Write-Output "Le logiciel va être mis à jour : $InstalledVersion -> $ExeVersion"
        #echo "Le logiciel va être mis à jour : $InstalledVersion -> $ExeVersion" >> "$LOGFolder/$LogFile"
    } else {
        #echo "Le logiciel va être installé. : $ExeVersion"  >> "$LOGFolder/$LogFile"
    }
    
    # Si le chemin réseau vers l'exécutable est valide, on continue
    if(Test-Path "$SharedFolder\$folder\$ScriptName"){
        #echo "La ressource distant à bien été trouvé." >> "$LOGFolder/$LogFile"
    

        # Créer le dossier temporaire en local et copier le dossier sur le poste
        New-Item -ItemType Directory -Path "$LocalFolder" -ErrorAction SilentlyContinue
        #echo "Retour Création $?" >> "$LOGFolder/$LogFile"
        Copy-Item "$SharedFolder\$folder" "$LocalFolder" -Force -Recurse
        #echo "Retour Copie $?" >> "$LOGFolder/$LogFile"

        # Si l'on trouve bien l'exécutable en local, on lance l'installation
        if(Test-Path "$LocalFolder\$folder\$ScriptName"){
            #echo "démarrage du processus" >> "$LOGFolder/$LogFile"
    
            Start-Process -Wait -FilePath "$LocalFolder\$folder\$ScriptName" -ArgumentList "/configure $LocalFolder\$folder\$FileXml"

            $WshShell = New-Object -comObject WScript.Shell
            $Shortcut = $WshShell.CreateShortcut("$DesktopPublic\Excel.lnk")
            $Shortcut.TargetPath = "$Excel"
            $Shortcut.Save()

            $Shortcut2 = $WshShell.CreateShortcut("$DesktopPublic\Word.lnk")
            $Shortcut2.TargetPath = "$Word"
            $Shortcut2.Save()

        }else {
            #echo "La fonction Test path à échoué : $LocalFolder\$folder\$ScriptName" >> "$LOGFolder/$LogFile"
        }

        Remove-Item "$LocalFolder\$folder\" -Recurse -Force

        #Si le dossier est vide le supprimer.
        Remove-Item "$LocalFolder" -ErrorAction SilentlyContinue

        log -msg "L'installation de Office sur $($env:COMPUTERNAME) effectué avec succès." -id 2
    } else {
        log -msg "L'exécutable ($ScriptName) est introuvable sur le partage !" -id 2
        #echo "L'exécutable ($ScriptName) est introuvable sur le partage !"  >> "$LOGFolder/$LogFile"
        #echo "Utilisateur Connecter $($env:UserName)"  >> "$LOGFolder/$LogFile"
        #echo $Error  >> "$LOGFolder/$LogFile"
    }
} else {
    log -msg "Le logiciel est déjà installé dans la bonne version !" -id 1
    #echo "Logiciel déja installé." >> "$LOGFolder/$LogFile"
}