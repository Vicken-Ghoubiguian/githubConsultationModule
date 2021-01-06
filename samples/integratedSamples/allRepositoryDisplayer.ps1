# Importation of the 'Repository' module...
Using module ..\..\repository.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name, '$branchesExpected' and '$languagesExpected' that are 2 boolean indicators to specifie if we want all branches and languages respectively or not...
param (
    [string]$ownerLogin,
    [string]$diminutiveType,
    [bool]$branchesExpected,
    [bool]$languagesExpected
)

# Get all repositories from the whished owner identified by its login, with all branches and languages if expected, and put them in the "repositoriesArray" array...
$repositoriesArray = [Repository]::listAllRepositories($ownerLogin.ToString(), $diminutiveType.ToString(), $branchesExpected, $languagesExpected)

# Browse the array implemented previously and display each repos...
foreach($repos in $repositoriesArray) {

    $repos.ToString()
}