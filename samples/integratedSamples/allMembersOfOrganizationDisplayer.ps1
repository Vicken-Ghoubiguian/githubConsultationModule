# Importation of the 'Organization' module...
Using module ..\..\Organization.psm1

# Definition of the only parameter '$organizationLogin' for the wished organization's name...
param (
    [string]$organizationLogin
)

# Get all members of the whished organization identified by its login...
$membersArray = [Organization]::listAllMembers($organizationLogin.ToString())

# Browse the array implemented previously and display each member...
foreach($member in $membersArray) {

    $member

    Write-Host "`n"
}