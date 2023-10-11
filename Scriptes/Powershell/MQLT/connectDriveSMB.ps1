#$oldDebugPreference = $DebugPreference
#$DebugPreference = 'Continue'

$User = 'nathr'
$password = 'ag39fVianrDgKJ'
$securePassword = ConvertTo-SecureString -AsPlainText $password -Force
$secureCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $securePassword

$addresse = 'NASmqlt'
#$addresse = '192.168.20.96'

$listOfShares = @(
    @{Drive="X"; Share="dossier_commun"},
    @{Drive="Y"; Share="photos"}
)

foreach ($share in $listOfShares) {
    Write-Host "Vérification de la présence du partage $($share.Share) ayant pour lecteur : '$($share.Drive):' : " 
    #$share
    Try {
        $ret = Get-PSDrive -Scope Global -Name $share.Drive -ErrorAction Stop

        Write-Debug "Lecteur détecté. démontage du partage."
        if ($ret.DisplayRoot -eq "\\$addresse\$($share.Share)") {
            #le point de montage est correct, suppression du point de montage
            Remove-PSDrive -Name $share.Drive -ErrorAction Stop
        } else {
            # Sinon, la lette du lecteur est déjà occupé.
            Write-Error "Le lecteur : $($share.Drive) est déja pris par le montage suivant : $($ret.DisplayRoot)"
        }
    }catch {
       $msg = $Error[0].ToString()
       if ($msg -like 'Lecteur introuvable*') {  
            Write-Debug "lecteur non détecter, possible de poursuivre la commande."
       } else {
            Write-Error $msg -ErrorAction Stop
       }
    }

    #Les lecteurs n'ont pas été détecté, montage des lecteurs réseaux
    try {
        $ret = New-PSDrive -Name $share.Drive -Root \\$addresse\$($share.Share) -PSProvider FileSystem -Persist -Credential $secureCredential -Scope Global -ErrorAction Stop
        Write-Host "Montage du lecteur réseau : $($share.Drive) sur le dossier NAS : $($share.Share) réalisé avec succès."
        Write-Host
    }
    catch {
        #Write-Debug $share.Drive  \\$addresse\$share.Share
        Write-Error $Error[0] -ErrorAction Stop

    }
}

#Get-PSDrive
#$DebugPreference = $oldDebugPreference