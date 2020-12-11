# Importation of the 'Branch' module...
Using module ..\Branch.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name and '$repositoryName' for the wished repository's name...
param (
    [string]$ownerLogin,
    [string]$repositoryName
)

# 
$branchesArray = [Branch]::listAllBranches($ownerLogin.ToString(), $repositoryName.ToString())

#
foreach($branch in $branchesArray) {

    #
    $branch.ToString()
}