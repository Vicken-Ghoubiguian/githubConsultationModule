# Importation of the 'Comment' module...
Using module ..\..\comment.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name, '$repositoryName' for the wished repository's name and '$issueNumber' for the wished issue number...
param (
    [string]$ownerLogin,
    [string]$repositoryName,
    [int]$issueNumber
)

# Get all comments from a whished issue identified by its number of the whished repos identified by its name and owned by a owner identified by its login...
$commentsArray = [Comment]::listAllComments($ownerLogin.ToString(), $organizationLogin.ToString())

# Browse the array implemented previously and display each comment...
foreach($comment in $commentsArray) {

    $comment.ToString()
}