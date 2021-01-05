# Importation of the 'Commit' module...
Using module ..\..\commit.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name and '$repositoryName' for the repository name...
param (
    [string]$ownerLogin,
    [string]$repositoryName,
    [bool]$withAllMissingDatas
)

# Get all commits with missing datas from the whished repository owned by the user identified by its login and put them in the "commitsArray" array...
$commitsArray = [Commit]::listAllCommits($ownerLogin.ToString(), $repositoryName.ToString(), $withAllMissingDatas.ToBoolean())

# Browse the array implemented previously and display each commit...
foreach($commit in $commitsArray) {

    $commit.ToString()
}