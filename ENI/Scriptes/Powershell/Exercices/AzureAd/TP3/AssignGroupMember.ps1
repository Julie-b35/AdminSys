
function chackeSameGroupAndDepartment {
    param(
        [Parameter(Mandatory = $true)]
        $departement
    )

    #$listedistributions = Get-MsolGroup -GroupType 'DistributionList'
    $listedistributions = Get-AzureADGroup
    foreach ($distribution in $listedistributions) {
        #$name = ($distribution.DisplayName -Split 'G-365-')
        $name = [string]::join("",(($distribution.DisplayName -Split 'G-365-').Split("`n")))

        if ($name -eq $departement) {
            return $distribution.ObjectID
        }
    }

}

#$listeUsers = Get-MsolUser | Select-Object ObjectID,SignInName,Department
$listeUsers = Get-AzureADUser | Select-Object ObjectID,UserPrincipalName,Department
foreach( $user in $listeUsers) {
    if([string]::IsNullOrEmpty($user.Department)) {
        continue;
    }
    
    $retour = chackeSameGroupAndDepartment $user.Department

    if([string]::IsNullOrEmpty($retour)) {
        continue;
    } 
    Add-AzureADGroupMember -RefObjectId $user.ObjectID -ObjectId $retour
    
    #Write-Host "L'utilisateur $($user.UserPrincipalName) aura pour groupe $retour"
    #$userUPN="<UPN of the user account to add>"
    #$groupName="<display name of the group>"
    
    #Add-AzureADGroupMember -RefObjectId (Get-AzureADUser | Where { $_.UserPrincipalName -eq $userUPN }).ObjectID -ObjectId (Get-AzureADGroup | Where { $_.DisplayName -eq $groupName }).ObjectID
    # Avec cette commande ci-dessous impossible d'intégrer un membre à un groupe Micosoft 365
    # Erreur : Add-MsolGroupMember : You cannot update mail-enabled groups using this cmdlet. Use Exchange Online to perform this operation.
    #  Add-MsolGroupMember -GroupObjectId $retour -GroupMemberType "User" -GroupMemberObjectId $user.ObjectID

}