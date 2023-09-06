$File2="\\cd01\Partage\Exports\CSV\Export_Users_AD.csv"

#Givenname;Surname;Name;samaccountname;UserPrincipalname;Description;company;City;Department;title
Get-ADUser -Filter * -Properties * | Select-Object GivenName,Surname,Name,SamAccountName,Description,company,City,Department,title | Export-Csv -Path $File2 -Delimiter ';' -NoTypeInformation
Get-ADComputer -Filter * | Export-Csv -Path $File2 -Delimiter ';' -NoTypeInformation -Force -Append
