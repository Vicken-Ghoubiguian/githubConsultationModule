# Importation of the 'Commit' module...
Using module ..\commit.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name and '$repositoryName' for the repository name...
param (
    [string]$ownerLogin,
    [string]$repositoryName
)

# Get all commits from the whished repository owned by the user identified by its login and put them in the "commitsArray" array...
$commitsArray = [Commit]::listAllCommits($ownerLogin.ToString(), $repositoryName.ToString())

# Browse the array implemented previously and display each commit...
foreach($commit in $commitsArray) {

    $commit.ToString()
}