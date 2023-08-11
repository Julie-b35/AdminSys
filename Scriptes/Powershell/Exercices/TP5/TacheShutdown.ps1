
$user = 'AD01\Administrator'
$mdp = Read-Host "Mot de passe : $user "  -AsSecureString 
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $mdp
$session = New-PSSession -ComputerName 172.21.0.3 -Credential $credential

#Get-Module -PSSession $Session -ListAvailable
#Import-Module -PSSession $Session –name ActiveDirectory –Prefix DC

Enter-PSSession $session 

hostname.exe

Exit-PSSession