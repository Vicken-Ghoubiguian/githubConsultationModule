# Importation of the 'Issue' module...
Using module ..\..\Issue.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name and '$repositoryName' for the wished repository's name...
param (
    [string]$ownerLogin,
    [string]$repositoryName
)

# Creation of an instance of the Issue Powershell class with all wished parameters...
$currentIssue = New-Object -TypeName Issue -ArgumentList $ownerLogin, $repositoryName

# Display all collected informations about the wished issue in the Powershell console...
$currentIssue.ToString()