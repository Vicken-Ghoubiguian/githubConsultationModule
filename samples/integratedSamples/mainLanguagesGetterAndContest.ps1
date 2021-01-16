# Importation of the 'usefulFunctions' module...
Using module ..\..\usefulFunctions.psm1

# Definition of the all required parameter: '$ownerLogin' for the wished owner's login and '$diminutiveType' for the diminutive type of owner ('users' or 'orgs')...
param (
    [string]$ownerLogin,
    [string]$diminutiveType
)

# Calling the "Get_Main_Languages_Used_By_Owner" function and assigning the result (an hash table containing all main languages used by owner with their respective percentage) to the "allMainLanguagesUsedByOwnerHasTable" variable...
$allMainLanguagesUsedByOwnerHasTable = Get_Main_Languages_Used_By_Owner -ownerLogin $ownerLogin -diminutiveType $diminutiveType