# Importation of the 'usefulFunctions' module...
Using module ..\..\usefulFunctions.psm1

# Definition of the all required parameter: '$ownerLogin' for the wished owner's login, '$diminutiveType' for the diminutive type of owner ('users' or 'orgs') and '$withPercentage' for determining which one the percentage value or the number of repos is expected...
param (
    [string]$ownerLogin,
    [string]$diminutiveType,
    [bool]$withPercentage
)

# Calling the "Get_All_Languages_Used_By_Owner" function and assigning the result (an hash table containing all languages used by owner with their respective percentage) to the "allLanguagesUsedByOwnerHasTable" variable...
$allLanguagesUsedByOwnerHasTable = Get_All_Languages_Used_By_Owner  -ownerLogin $ownerLogin -diminutiveType $diminutiveType -withPercentage $withPercentage

# Display of all the languages ​​used with their respective percentage in descending order...
$allLanguagesUsedByOwnerHasTable.GetEnumerator() | Sort-Object -Property Value -Descending