# Importation of the 'Language' module...
Using module ..\language.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name and '$repositoryName' for the wished repository's name...
param (
    [string]$ownerLogin,
    [string]$repositoryName
)

#
$languagesArray = [Language]::listAllLanguages($ownerLogin, $repositoryName)

#
foreach($language in $languagesArray) {

    #
    $language.ToString()
}