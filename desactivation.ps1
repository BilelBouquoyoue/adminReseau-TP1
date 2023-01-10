# Permet d'importer le module de l'active directory
Import-Module ActiveDirectory

# Données du fichier CSV stockées dans la variable users, le fichier CSV sera un paramètre dans la commande PowerShell
$users = Import-CSV -Path $args[0] -Delimiter ";"

Foreach($Utilisateur in $users){
    $UtilisateurUsername = $Utilisateur.Username

   # Vérification existence de l'Utilisateur 
   if (Get-ADUser -Filter {SamAccountName -eq $UtilisateurUsername} -SearchBase "OU=utilisateurs,DC=l1-4,DC=lab")
   {
       # User existe
       Disable-ADAccount $UtilisateurUsername
       Write-Output "L'utilisateur $UtilisateurUsername a ete desactive"
   }
   else
   {
        # User n'existe pas
        Write-Warning "L'utilisateur $UtilisateurUsername n'existe pas"
   }
}