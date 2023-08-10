# Stocker dans une variable le résultat de la commande « Get-EventLog system ».

## Quelle commande avez-vous utilisé ?
$log = Get-EventLog -LogName System

# Affichez l’entrée de journal numéro 10.
# $Log[9]
# Quelle est la valeur de l’ « Index » du journal ? (1015)

# Créer une variable qui stockera l’adition de l’index de journal numéro 10 et 20
## Quelle commande avez-vous utilisé ?
$additionLog = $log[9].Index + $log[19].Index

$additionLog