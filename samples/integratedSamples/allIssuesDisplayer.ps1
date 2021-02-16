# Importation of the 'Issue' module...
Using module ..\..\Issue.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name and '$repositoryName' for the wished repository's name...
param (
    [string]$ownerLogin,
    [string]$repositoryName
)

# Get all issues from the whished repository owned by the user identified by its login and put them in the "issuesArray" array...
$issuesArray = [Issue]::listAllIssues($ownerLogin.ToString(), $repositoryName.ToString())

# Browse the array implemented previously and display each issues...
foreach($issue in $issuesArray) {

    $issue.ToString()
}