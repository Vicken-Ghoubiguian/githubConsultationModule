# Importation of the 'File' module...
Using module ..\file.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name and '$repositoryName' for the wished repository's name...
param (
    [string]$ownerLogin,
    [string]$repositoryName
)

# Get all files from the whished repository owned by the user identified by its login and put them in the "filesArray" array...
$filesArray = [File]::listAllFilesInRepos($ownerLogin.ToString(), $repositoryName.ToString())