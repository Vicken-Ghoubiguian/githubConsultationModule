# Importation of the 'Branch' module...
Using module ..\Branch.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name and '$repositoryName' for the wished repository's name...
param (
    [string]$ownerLogin,
    [string]$repositoryName
)

# Get all branches from the whished repository owned by the user identified by its login and put them in the "branchesArray" array...
$branchesArray = [Branch]::listAllBranches($ownerLogin.ToString(), $repositoryName.ToString())

# Browse the array implemented previously and display each branch...
foreach($branch in $branchesArray) {

    $branch.ToString()
}