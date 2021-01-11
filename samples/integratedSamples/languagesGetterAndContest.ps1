# Importation of the 'usefulFunctions' module...
Using module ..\..\usefulFunctions.psm1

# Definition of the all required parameter: '$ownerLogin' for the wished owner's login and '$diminutiveType' for the diminutive type of owner ('users' or 'orgs')...
param (
    [string]$ownerLogin,
    [string]$diminutiveType
)

# 
Get_All_Languages_Used_By_User -ownerLogin $ownerLogin -diminutiveType $diminutiveType