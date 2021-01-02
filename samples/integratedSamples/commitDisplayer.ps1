# Importation of the 'Commit' module...
Using module ..\..\Commit.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name, '$repositoryName' for the wished repository's name and '$commitSha' for the wished commit's sha...
param (
    [string]$ownerLogin,
    [string]$repositoryName,
    [string]$commitSha
)

# Creation of an instance of the Commit Powershell class with all wished parameters...
$currentCommit = New-Object -TypeName Commit -ArgumentList $ownerLogin, $repositoryName, $commitSha

# Display all collected informations about the wished commit in the Powershell console...
$currentCommit.ToString()