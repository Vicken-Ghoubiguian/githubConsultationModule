# Importation of the 'Language' module...
Using module ..\..\language.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name and '$repositoryName' for the wished repository's name...
param (
    [string]$ownerLogin,
    [string]$repositoryName
)

# Get all languages from the whished repository owned by the user identified by its login and put them in the "languagesArray" array...
$languagesArray = [Language]::listAllLanguages($ownerLogin.ToString(), $repositoryName.ToString())

# Browse the array implemented previously and display each language...
foreach($language in $languagesArray) {

    $language.ToString()
}