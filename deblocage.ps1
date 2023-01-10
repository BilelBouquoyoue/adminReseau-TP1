# Permet d'importer le module de l'active directory
Import-Module ActiveDirectory

# Données du fichier CSV stockées dans la variable users, le fichier CSV sera un paramètre dans la commande PowerShell
$users= Import-Csv -Path $args[0] -Delimiter ";"

Foreach($user in $users){
    $UtilisateurUsername = $user.Username

    # Vérification existence de l'Utilisateur 
    if (Get-ADUser -Filter {SamAccountName -eq $UtilisateurUsername} -SearchBase "OU=utilisateurs,DC=l1-4,DC=lab")
    {
        # User existe
        Unlock-ADAccount $user.Username
        Write-Output "L'utilisateur $UtilisateurUsername a ete debloque"
    }
    else
    {
        # User n'existe pas
        Write-Warning "L'utilisateur $UtilisateurUsername n'existe pas"
    }
}