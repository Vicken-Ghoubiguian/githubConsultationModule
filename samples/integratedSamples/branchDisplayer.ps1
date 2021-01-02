# Importation of the 'Branch' module...
Using module ..\..\Branch.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name, '$repositoryName' for the wished repository's name and '$branchName' for the wished branch's name...
param (
    [string]$ownerLogin,
    [string]$repositoryName,
    [string]$branchName
)

# Creation of an instance of the Branch Powershell class with the wished parameter...
$currentBranch = New-Object -TypeName Branch -ArgumentList $ownerLogin, $repositoryName, $branchName

# Display all collected informations about the wished branch in the Powershell console...
$currentBranch.ToString()
