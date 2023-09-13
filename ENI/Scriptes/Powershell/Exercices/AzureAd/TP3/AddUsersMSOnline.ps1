$pathCSV = 'C:\Users\jbrindejont2023\OneDrive - ENI Ecole Informatique\Documents\Espace Perso - Cours\19 - Cloud et Microsoft 365\Ressources\user2-labeni.csv'

$listeUsers = Import-Csv -Path $pathCSV -Delimiter ','
$domain = 'rtssr014f-6.lab-eni.fr'


foreach ($user in $listeUsers) {

    $firstName = $user.FirstName.ToLower()
    $paremetters = @{
        UserPrincipalName   = '{1}@{0}' -f $domain, $firstName
        FirstName           = $user.FirstName
        DisplayName         = $user.DisplayName
        LastName            = $user.LastName
        password            = 'Pa$$w0rd'
        ForceChangePassword = $False
        UsageLocation       = 'FR'
        Title               = $user.Title
        Department          = $user.Department
        City                = $user.City
        Country             = $user.Country
    }

    try {
        New-MsolUser  @paremetters -ErrorAction Stop
    }
    catch {
        Write-Error "Une erreur est survenue"
        Write-Error $Error[1].Exception.Message
        exit 1
    }
}

