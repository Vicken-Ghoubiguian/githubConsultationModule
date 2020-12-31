# Importation of the 'Repository' module...
Using module ..\..\repository.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name, '$branchesExpected' and '$languagesExpected' that are 2 boolean indicators to specifie if we want all branches and languages respectively or not...
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