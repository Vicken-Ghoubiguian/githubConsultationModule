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

        # Bloc we wish execute to get all informations about the wished comment...
        try {

            #
            $githubCommentRequest = Invoke-WebRequest -Uri $githubGetCommentURL -Method Get
            $githubCommentRequestsContent = $githubCommentRequest.Content
            $githubCommentRequestsJSONContent = @"
               
$githubCommentRequestsContent
"@
            $githubCommentRequestsResult = ConvertFrom-Json -InputObject $githubCommentRequestsJSONContent

            $this.id = $githubCommentRequestsResult.id
            $this.nodeId = $githubCommentRequestsResult.node_id
            $this.htmlUrl = $githubCommentRequestsResult.html_url
            $this.issueUrl = $githubCommentRequestsResult.issue_url
            $this.url = $githubCommentRequestsResult.url
            $this.userId = $githubCommentRequestsResult.user.id
            $this.userLogin = $githubCommentRequestsResult.user.login
            $this.userNodeId = $githubCommentRequestsResult.user.node_id
            $this.userAvatar = $githubCommentRequestsResult.user.avatar_url
            $this.userUrl = $githubCommentRequestsResult.user.url
            $this.userHtmlUrl = $githubCommentRequestsResult.user.html_url
            $this.userSiteAdmin = $githubCommentRequestsResult.user.site_admin
            $this.userType = $githubCommentRequestsResult.user.type
            $this.creatingDate = [Datetime]::Parse($githubCommentRequestsResult.created_at)
            $this.updatingDate = [Datetime]::Parse($githubCommentRequestsResult.updated_at)
            $this.authorAssociation = $githubCommentRequestsResult.author_association
            $this.body = $githubCommentRequestsResult.body

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $this.error = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
        }
    }

    # Definition of a static function to get all comments for all issues from a repos identified by its name owned by a owner identified by its login...
    static [System.Array] listAllComments([string]$ownerLogin, [string]$wantRepos)
    {
        return @()
    }

    # Definition of a static function to get all comments for all issues from an issue identified by its number from a repos identified by its name owned by a owner identified by its login...
    static [System.Array] listAllComments([string]$ownerLogin, [string]$wantRepos, [int]$wantNumberIssue)
    {
        $githubGetCommentsURL = "https://api.github.com/repos/" + $ownerLogin + "/" + $wantRepos + "/issues/" + $wantNumberIssue + "/comments"

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



    # 'creatingDate' attribute getter...
    [dateTime] getCreatingDate()
    {
        return $this.creatingDate
    }

    # 'updatingDate' attribute getter...
    [dateTime] getUpdatingDate()
    {
        return $this.updatingDate
    }

    # 'authorAssociation' attribute getter...
    [string] getAuthorAssociation()
    {
        return $this.authorAssociation
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