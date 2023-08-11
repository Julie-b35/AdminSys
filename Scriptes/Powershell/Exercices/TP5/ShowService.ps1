
<#
Réalisez un script permettant de tester la présence d’un service. Le nom du
service sera variable. Dans le cas ou le service n’est pas existant, aucun message
ne sera affiché mais il sera consigné dans une variable. Un message sera affiché
lorsque tous les services seront testés.
#>

$listeNomService = Read-Host "Donnez moi une liste de nom de services (Service 1 [Service2... ]). " -split ' '
$listeNomService

try {
    Get-Service -Name $nomService
}catch {
    Write-Host "Le nom de service existe pas."
}