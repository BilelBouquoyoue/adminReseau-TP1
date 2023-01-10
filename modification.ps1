#Permet d'importer le module de l'active directory
Import-Module ActiveDirectory

# Données du fichier CSV stockées dans la variable users, le fichier CSV sera un paramètre dans la commande PowerShell
$users = Import-Csv -Path $args[0] -Delimiter ";"

Foreach($user in $users) {
    $Username= $user.Username
    $NewFirstName= $user.NewFirstName
    $NewLastName= $user.NewLastName
    $NewUsername= $user.NewUsername

    if (Get-ADUser -Filter {SamAccountName -eq $Username}) {
        try {
            Set-ADUser -Identity (Get-ADUser -Filter {SamAccountName -eq $Username}) -GivenName $NewFirstName -Surname $NewLastName -SamAccountName $NewUsername
            Write-Host "$Username a bien ete modifie"
        }
        catch {
            Write-Host "Une erreur s'est produite lors de la modification de $Username"
        }
    }
    else {
        Write-Host "Il n'y a pas d'utilisateur $Username"
    }
}