# Importation of the 'Organization' module...
Using module ..\..\organization.psm1

# Definition of all parameters : '$userLogin' for the wished user's name, '$reposExpected', '$branchesExpected' and '$languagesExpected' that are 3 boolean indicators to specifie if we want all repos, branches and languages respectively or not...
param (
    [string]$userLogin,
    [bool]$reposExpected,
    [bool]$branchesExpected,
    [bool]$languagesExpected
)

# Get all organizations from the whished user identified by its login, with all repos, branches and languages if expected, and put them in the "organizationsArray" array...
$organizationsArray = [Organization]::listAllOrganization($userLogin.ToString(), $reposExpected, $branchesExpected, $languagesExpected)

# Browse the array implemented previously and display each organization...
foreach($organization in $organizationsArray) {

    $organization.ToString()
}