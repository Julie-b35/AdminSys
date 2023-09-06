$File="\\cd01\Partage\Exports\CSV\Export_Users_AD.csv"



Import-Csv -Path $File -Delimiter ';' | ForEach-Object {
    #Write-Host $_.Givenname
    # Givenname;Surname;Name;samaccountname;UserPrincipalname;Description;company;City;Department;title
    #"DistinguishedName";"Enabled";"GivenName";"Nalme";"ObjectClass";"ObjectGUID";"SamAccountName";"SID";"Surname";"UserPrincipalName"
    # "GivenName";"Surname";"Namle";"SamAccountName";"Description";"company";"City";"Department";"title"
    $Attributes = @{
        Enabled = $False
        UserPrincipalNAme = $_.UserPrincipalname
        Description = $_.Description
        company = $_.company
        City = $_.City
        Department = $_.Department
        title = $_.title
        GivenName = $_.Givenname
        SamAccountName = $_.samaccountname
        Surname = $_.Surname
        Name = $_.Namle
    }
    New-ADUser @Attributes
}
#>


# The operation failed because UPN value provided for addition/modification is not unique forest-wide.
#Import-Csv -Path $File -Delimiter ';' | New-ADUser 
Import-Csv -Path $File2 -Delimiter ';' | New-ADUser @{Name = $_.Nalme}

#Get-ADUser -Filter * -Properties * | Remove-ADUser -Confirm:$false