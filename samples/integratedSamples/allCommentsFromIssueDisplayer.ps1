# Importation of the 'Comment' module...
Using module ..\..\comment.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name, '$repositoryName' for the wished repository's name and '$issueNumber' for the wished issue number...
param (
    [string]$ownerLogin,
    [string]$repositoryName,
    [int]$issueNumber
)