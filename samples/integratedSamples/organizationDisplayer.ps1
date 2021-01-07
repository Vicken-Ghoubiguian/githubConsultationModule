# Importation of the 'Organization' module...
Using module ..\..\Organization.psm1

# Definition of all parameters : '$organizationLogin' for the wished user's name...
param (
    [string]$organizationLogin,
    [bool]$withRepos,
    [bool]$withBranches,
    [bool]$withLanguages
)

# Creation of an instance of the Organization Powershell class with all wished parameters...
$currentOrganization = New-Object -TypeName Organization -ArgumentList $organizationLogin, $withRepos, $withBranches, $withLanguages

# Display all collected informations about the wished organization in the Powershell console...
$currentOrganization.ToString()