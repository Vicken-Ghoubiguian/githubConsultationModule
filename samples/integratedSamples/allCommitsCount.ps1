# Importation of the 'usefulFunctions' module...
Using module ..\..\usefulFunctions.psm1

# Definition of the all required parameter: '$ownerLogin' for the wished owner's login and '$reposName' for the repository's name...
param (
    [string]$ownerLogin,
    [string]$reposName
)

#
$allCommitsCount = CountAllCommitsForSpecificRepositoryInTheLast52Weeks -ownerLogin $ownerLogin -reposName $reposName

#
Write-Host $allCommitsCount