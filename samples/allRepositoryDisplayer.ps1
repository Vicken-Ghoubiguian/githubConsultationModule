# Importation of the 'Repository' module...
Using module ..\repository.psm1

# Definition of the only one parameter : '$ownerLogin' for the wished owner's name...
param (
    [string]$ownerLogin
)

# Get all repositories from the whished user identified by its login and put them in the "repositoriesArray" array...
$repositoriesArray = [Repository]::listAllRepositories($ownerLogin.ToString())

# Browse the array implemented previously and display each repos...
foreach($repos in $repositoriesArray) {

    $repos.ToString()
}