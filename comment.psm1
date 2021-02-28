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
    hidden [string]$url

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

    hidden [GitHubError]$error

    # Comment class constructor with the owner login, the repository name and the issue's number...
    Comment([string]$wishedOwnerLogin, [string]$wishedReposName, [int]$wishedCommentNumber)
    {
        $githubGetCommentURL = "https://api.github.com/repos/" + $wishedOwnerLogin + "/" + $wishedReposName + "/issues/comments/" + $wishedCommentNumber
    }

    # Definition of a static function to get all comments for all issues from a repos identified by its name owned by a owner identified by its login...
    static [System.Array] listAllComments([string]$ownerLogin, [string]$wantRepos)
    {
        return @()
    }

    # Returns the User current instance as String...
    [string] ToString()
    {
        return ""
    }

    # Returning the module's type as string...
    [string] getModuleType()
    {
        return "Comment"
    }

    # 'id' attribute getter...
    [int] getId()
    {
        return $this.id
    }

    # 'nodeId' attribute getter...
    [string] getNodeId()
    {
        return $this.nodeId
    }

    # 'htmlUrl' attribute getter...
    [string] getHtmlUrl()
    {
        return $this.htmlUrl
    }

    # 'issueUrl' attribute getter...
    [string] getIssueUrl()
    {
        return $this.issueUrl
    }

    # 'url' attribute getter...
    [string] getUrl()
    {
        return $this.url
    }



    # 'body' attribute getter...
    [string] getBody()
    {
        return $this.body
    }

    # 'error' attribute getter...
    [GitHubError] getGitHubError()
    {
        return $this.error
    }
}