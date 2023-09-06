param(
    # Si remote est appelé.
    [Parameter(Mandatory = $false,
        ParameterSetName = 'remote',
        HelpMessage = "Activer remote si le'ad est a distance.",
        Position = 0)]
    [Switch] $remote
)

# Définition des constantes
Set-Variable NAME_CONFIG_FILE -Option Constant -Value ""

function checkConfigFile {

}

if ($remote) {
    #$User = 'AD\Administrateur'
    #$PWord = Read-Host "Mote de passe de $User " -AsSecureString
    #$PWord = '01000000d08c9ddf0115d1118c7a00c04fc297eb010000002f23ddbea11de94aa5e3fd4e918c2bab0000000002000000000003660000c0000000100000002e34942dc06510b563acdf6764205fd90000000004800000a000000010000000015294f0b4862a8f6d2a749b3c498b4e18000000c7e6324cdf2cf6c222a87f5c78867c232684022e41f3481e140000005226ed14982ffb9fe9188aaeac2ed4ad707aafae' | ConvertTo-SecureString
    #$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
}

checkConfigFile