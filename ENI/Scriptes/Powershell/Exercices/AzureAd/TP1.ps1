Import-Module MSOnline

$User ="admin@rtssr014f-6.lab-eni.fr"

$mdp = ConvertTo-SecureString '$R00tsan!' -AsPlainText -Force

$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $mdp

Connect-MsolService -Credential $credential

# Get-Msoluser | select ObjectId,SignInName

#New-MsolUser -UserPrincipalName "sacha@rtssr014f-6.lab-eni.fr" -DisplayName "Sacha Touille" -FirstName "Sacha" -LastName "Touille" -password 'Pa$$w0rd' -ForceChangePassword $true -UsageLocation 'JP' -Title 'Cuisinier' -Department 'Restauration'

#Assigne le membre sacha au groupe G-SEC-LicenceOffice365_E3
# Add-MsolGroupMember -GroupObjectId 21327b50-aa52-4f5c-8550-8d7675979eca -GroupMemberType "User" -GroupMemberObjectId 509ac112-7bdd-44e1-b32d-51e310b73893

# Assigle le membre labeni au groupe G-SEC-RoleAdminGlobale
# Add-MsolGroupMember -GroupObjectId 3c74bc27-c408-4505-9314-aa78171b9631 -GroupMemberType "User" -GroupMemberObjectId 03727f7a-7f01-43be-af78-fec24ff29864

New-MsolUser -UserPrincipalName "labeni@rtssr014f-6.lab-eni.fr" -DisplayName "Lab ENI" -FirstName "Lab" -LastName "Eni" -password 'Pa$$w0rd' -ForceChangePassword $false -UsageLocation 'FR' -Title 'Administrateur' -Department 'Informatique'
Remove-MsolUser -ObjectId 509ac112-7bdd-44e1-b32d-51e310b73893

Restore-MsolUser -UserPrincipalName "sacha@rtssr014f-6.lab-eni.fr"

# Get-MsolUser -ReturnDeletedUse | Remove-MsolUser -RemoveFromRecycleBin -Force