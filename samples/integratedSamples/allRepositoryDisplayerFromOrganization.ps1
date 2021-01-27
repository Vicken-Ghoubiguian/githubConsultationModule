# Importation of the 'Organization' module...
Using module ..\..\Organization.psm1

# Definition of all parameters : '$organizationLogin' for the wished organization's name, '$branchesExpected' and '$languagesExpected' that are 2 boolean indicators to specifie if we want all branches and languages respectively or not...
param (
    [string]$organizationLogin,
    [bool]$branchesExpected,
    [bool]$languagesExpected
)

# Get all repositories from the whished user identified by its login, with all branches and languages if expected, and put them in the "repositoriesArray" array...
$repositoriesArray = [Organization]::listAllReposFromOrganization($organizationLogin.ToString(), $withBranches, $withLanguages)

# Browse the array implemented previously and display each repos...
foreach($repos in $repositoriesArray) {

    $repos.ToString()
}