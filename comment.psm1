# Importation of the 'GitHubError' module...
Using module .\gitHubError.psm1

# Definition of the Comment Powershell class to define a issue from the GitHub API...
class Comment
{
    # All attributes of the Comment class...
    hidden [int]$id
    hidden [string]$nodeId
    hidden [string]$htmlUrl
    hidden [string]$issueUrl
    hidden [string]$Url

    hidden [int]$userId
    hidden [string]$userLogin
    hidden [string]$userNodeId
    hidden [string]$userAvatar
    hidden [string]$userUrl
    hidden [string]$userHtmlUrl
    hidden [bool]$userSiteAdmin
    hidden [string]$userType

    hidden [dateTime]$creatingDate
    hidden [dateTime]$updatingDate
    hidden [string]$authorAssociation
    hidden [string]$body

    # Comment class constructor with the owner login, the repository name and the issue's number...
    Comment([string]$wishedOwnerLogin, [string]$wishedReposName, [int]$wishedCommentNumber)
    {
        $githubGetCommentURL = "https://api.github.com/repos/" + $wishedOwnerLogin + "/" + $wishedReposName + "/issues/comments/" + $wishedCommentNumber
    }
}