# Importation of the 'usefulFunctions' module...
Using module ..\..\usefulFunctions.psm1

# Definition of the only required parameter: '$ownerLogin' for the wished owner's name...
param (
    [string]$ownerLogin
)

#
$reposCount = Get_Total_Number_Of_Repos -ownerLogin $ownerLogin.ToString()

# Displaying repos count...
Write-Host $reposCount