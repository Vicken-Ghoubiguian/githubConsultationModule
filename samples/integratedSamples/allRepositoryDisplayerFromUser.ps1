# Importation of the 'User' module...
Using module ..\..\User.psm1

# Definition of all parameters : '$userLogin' for the wished user's name, '$branchesExpected' and '$languagesExpected' that are 2 boolean indicators to specifie if we want all branches and languages respectively or not...
param (
    [string]$userLogin,
    [bool]$branchesExpected,
    [bool]$languagesExpected
)

# Get all repositories from the whished user identified by its login, with all branches and languages if expected, and put them in the "repositoriesArray" array...
$repositoriesArray = [User]::listAllReposFromUser($userLogin.ToString(), $withBranches, $withLanguages)

# Browse the array implemented previously and display each repos...
foreach($repos in $repositoriesArray) {

    $repos.ToString()
}