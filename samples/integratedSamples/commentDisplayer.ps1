# Importation of the 'Comment' module...
Using module ..\..\Comment.psm1

# Definition of all parameters : '$ownerLogin' for the wished owner's name, '$repositoryName' for the wished repository's name and '$CommentNumber' for the wished comment number...
param (
    [string]$ownerLogin,
    [string]$repositoryName,
    [int]$commentNumber
)

# Creation of an instance of the Comment Powershell class with all wished parameters...
$currentComment = New-Object -TypeName Comment -ArgumentList $ownerLogin, $repositoryName, $commentNumber

# Display all collected informations about the wished comment in the Powershell console...
$currentComment.ToString()