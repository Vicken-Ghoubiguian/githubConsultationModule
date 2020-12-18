# Importation of the 'Repository' module...
Using module ..\repository.psm1

# Definition of the only one parameter : '$ownerLogin' for the wished owner's name...
param (
    [string]$ownerLogin,
    [bool]$branchesExpected,
    [bool]$languagesExpected
)

# Get all repositories from the whished user identified by its login, with all branches and languages if expected, and put them in the "repositoriesArray" array...
$repositoriesArray = [Repository]::listAllRepositories($ownerLogin.ToString(), $branchesExpected.ToBoolean(), $languagesExpected.ToBoolean())

# Browse the array implemented previously and display each repos...
foreach($repos in $repositoriesArray) {

    $repos.ToString()
}