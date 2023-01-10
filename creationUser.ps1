# Permet d'importer le module de l'active directory
Import-Module ActiveDirectory

# Données du fichier CSV stockées dans la variable users, le fichier CSV sera un paramètre dans la commande PowerShell
$users = Import-CSV -Path $args[0] -Delimiter ";"

Foreach($Utilisateur in $users){
    $UtilisateurUsername = $Utilisateur.Username
    $UtilisateurFirstname = $Utilisateur.Firstname
    $UtilisateurName = $Utilisateur.Name
    $UtilisateurPassword = $Utilisateur.Password

   # Vérification existence de l'Utilisateur 
   if (Get-ADUser -Filter {SamAccountName -eq $UtilisateurUsername})
   {
      # User existe
      Write-Warning "L'identifiant $UtilisateurUsername existe deja dans l'AD"
   }
   else
   {
     # User n'existe pas
             New-ADUser -Name "$UtilisateurName $UtilisateurFirstname" `
                    -DisplayName "$UtilisateurName $UtilisateurFirstname" `
                    -GivenName $UtilisateurFirstname `
                    -Surname $UtilisateurName `
                    -SamAccountName $UtilisateurUsername `
                    -Path "OU=utilisateurs,DC=l1-4,DC=lab" `
                    -AccountPassword(ConvertTo-SecureString $UtilisateurPassword -AsPlainText -Force) `
                    -ChangePasswordAtLogon $false `
                    -PasswordNeverExpires $true `
                    -Enabled $true 

        Write-Output "Creation de l'utilisateur : $UtilisateurUsername ($UtilisateurName $UtilisateurFirstname)"
   }
}