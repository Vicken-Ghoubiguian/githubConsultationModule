# Importation of the 'usefulFunctions' module...
Using module ..\..\usefulFunctions.psm1

# Definition of the only required parameter: '$userLogin' for the wished owner's name...
param (
    [string]$userLogin
)

Get_All_Languages_Used_By_User -userLogin $userLogin