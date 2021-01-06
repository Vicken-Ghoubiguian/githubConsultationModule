# Importation of the 'usefulFunctions' module...
Using module ..\..\usefulFunctions.psm1

# Definition of the only required parameter: '$userLogin' for the wished owner's name...
param (
    [string]$userLogin
)

#
$reposCount = Get_Total_Number_Of_Public_Repos -ownerLogin $userLogin

# Displaying repos count...
Write-Host $reposCount