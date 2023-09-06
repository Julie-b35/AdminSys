#$dateNaissance = Read-Host -Prompt 'Veuillez indiquer votre date de naissance. (Au format : Jour/Jour/Année)'

if ( $dateNaissance -match '^(0[1-9]|[1-2][0-9]|3[1-2])$') {
    Write-Host "Format Date Ok"
}

#//2020-12-6 (2038)

$var1 = "06/04/1984"
$dvar1 = Get-date $var1

Write-Host "dvar1 = $($dvar1.GetType())"
Write-Host "var1 = $($var1.GetType())"
$dvar1