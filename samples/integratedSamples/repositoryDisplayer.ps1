# Importation of the 'Repository' module...
Using module ..\..\Repository.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name and '$repositoryName' for the wished repository's name...
param (
    [string]$ownerLogin,
    [string]$repositoryName,
    [bool]$branchesExpected,
    [bool]$languagesExpected,
    [bool]$issuesExpected
)

# Creation of an instance of the Repository Powershell class with all wished parameters...
$currentRepository = New-Object -TypeName Repository -ArgumentList $ownerLogin, $repositoryName, $branchesExpected, $languagesExpected, $issuesExpected 

# Display all collected informations about the wished repository in the Powershell console...
$currentRepository.ToString()