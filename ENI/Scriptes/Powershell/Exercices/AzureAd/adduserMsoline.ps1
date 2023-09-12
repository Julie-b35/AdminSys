$pathCSV = 'C:\Users\jbrindejont2023\OneDrive - ENI Ecole Informatique\Documents\Espace Perso - Cours\19 - Cloud et Microsoft 365\Ressources\user-labeni.csv'

$listeUsers = Import-Csv -Path $pathCSV -Delimiter ','
$domain = 'rtssr014f-6.lab-eni.fr'


function AddUser {
    param(
        [Parameter(Mandatory = $true)]
        $user
    )

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
    #New-MsolUser -UserPrincipalName "labeni@rtssr014f-6.lab-eni.fr" -DisplayName "Lab ENI" -FirstName "Lab" -LastName "Eni" -password 'Pa$$w0rd' -ForceChangePassword $false -UsageLocation 'FR' 
# -Title 'Administrateur' -Department 'Informatique'

}


function GetObjectIDUser {
    param(
        [Parameter(Mandatory = $true)]
        $user
    )
    $firstName = $user.FirstName.ToLower()
    $UserPrincipalName = "$firstName@$domain"
    $objetID = Get-MsolUser -UserPrincipalName $UserPrincipalName | Select-Object ObjectID 
    #Write-Host Get-TypeData $objetID
    return $objetID[0]
}

function listeCsv {
    foreach ($user in $listeUsers) {
        
        $objectUser = GetObjectIDUser -user $user
        Add-MsolGroupMember -GroupObjectId '21327b50-aa52-4f5c-8550-8d7675979eca' -GroupMemberType "User" -GroupMemberObjectId $objectUser.ObjectId
    }
}

<#

#>
function chackeSameGroupAndDepartment {
    param(
        [Parameter(Mandatory = $true)]
        $departement
    )

    Get-MsolGroup -GroupType 'DistributionList' | ForEach-Object {
        $name = $_.DisplayName -Split 'G-365-'
        $objetId = $_.ObjectId
        if([string]::IsNullOrEmpty($name)) {
            continue;
        }
        elseif ($name -eq $departement) {
            return $objetId
        }
    }
    return $false
}

$listeUsers = Get-MsolUser | Select-Object ObjectID,SignInName,Department

foreach( $user in $listeUsers) {
    if([string]::IsNullOrEmpty($user.Department)) {
        continue;
    }
    if($ret -eq $false) {
        continue;
    }
    $ret = chackeSameGroupAndDepartment $user.Department
    $user

    $ret
    
}