﻿# Importation of the 'User' module...
Using module ..\..\User.psm1

# Definition of all parameters : '$userLogin' for the wished user's name...
param (
    [string]$userLogin
)

# Creation of an instance of the User Powershell class with the wished parameter...
$currentUser = New-Object -TypeName User -ArgumentList $userLogin

# Display all collected informations about the wished user in the Powershell console...
$currentUser.ToString()