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

    # Comment class constructor with all class attributes in parameter...
    Comment([int]$id, [string]$nodeId, [string]$htmlUrl, [string]$issueUrl, [string]$url, [int]$userId, [string]$userLogin, [string]$userNodeId, [string]$userAvatar, 
    [string]$userUrl, [string]$userHtmlUrl, [bool]$userSiteAdmin, [string]$userType, [dateTime]$creatingDate, [dateTime]$updatingDate, [string]$authorAssociation, [string]$body)
    {
        $this.id = $id
        $this.nodeId = $nodeId
        $this.htmlUrl = $htmlUrl
        $this.issueUrl = $issueUrl
        $this.url = $url
        $this.userId = $userId
        $this.userLogin = $userLogin
        $this.userNodeId = $userNodeId
        $this.userAvatar = $userAvatar
        $this.userUrl = $userUrl
        $this.userHtmlUrl = $userHtmlUrl
        $this.userSiteAdmin = $userSiteAdmin
        $this.userType = $userType
        $this.creatingDate = $creatingDate
        $this.updatingDate = $updatingDate
        $this.authorAssociation = $authorAssociation
        $this.body = $body
    }

    # Definition of a static function to get all comments for all issues from a repos identified by its name owned by a owner identified by its login...
    static [System.Array] listAllComments([string]$ownerLogin, [string]$wantRepos)
    {
        # Definition of the 'branchesArray' array which will contain all comments of the wished repos identified by its name owned by the owner identified by its login...
        $commentsArray = [System.Collections.ArrayList]::new()

        # Bloc we wish execute to get all informations about comments...
        try {

            $githubGetCommentsURL = "https://api.github.com/repos/" + $ownerLogin + "/" + $wantRepos + "/issues/comments"

            # Retrieving and extracting all comments received from the URL...
            $githubCommentsRequest = Invoke-WebRequest -Uri $githubGetCommentsURL -Method Get
            $commentsJSONObj = ConvertFrom-Json $githubCommentsRequest.Content

            # Browse all the comments contained in the received JSON and create all the instances of the Powershell class 'Comment' from this data and add them to the array 'commentsArray'...
            foreach($comment in $commentsJSONObj) {

                $commentsArray.Add([Comment]::new($comment.id, $comment.node_id, $comment.html_url, $comment.issue_url, $comment.url, $comment.user.id, $comment.user.login, $comment.user.node_id, $comment.user.avatar_url,
                                                  $comment.user.url, $comment.user.html_url, $comment.user.site_admin, $comment.user.type, [Datetime]::Parse($comment.user.created_at), [Datetime]::Parse($comment.user.updated_at), $comment.author_association, $comment.body))
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {
        
            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $commentsArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        # Returning the '$branchesArray' array...
        return $commentsArray
    }

    # Definition of a static function to get all comments for all issues from an issue identified by its number, from a repos identified by its name owned by a owner identified by its login...
    static [System.Array] listAllComments([string]$ownerLogin, [string]$wantRepos, [int]$wantNumberIssue)
    {
        # Definition of the 'branchesArray' array which will contain all comments of the wished issue identified by its number, the wished repos identified by its name owned by the owner identified by its login...
        $commentsArray = [System.Collections.ArrayList]::new()

        # Bloc we wish execute to get all informations about comments...
        try {

            $githubGetCommentsURL = "https://api.github.com/repos/" + $ownerLogin + "/" + $wantRepos + "/issues/" + $wantNumberIssue + "/comments"

            # Retrieving and extracting all comments received from the URL...
            $githubCommentsRequest = Invoke-WebRequest -Uri $githubGetCommentsURL -Method Get
            $commentsJSONObj = ConvertFrom-Json $githubCommentsRequest.Content

            # Browse all the comments contained in the received JSON and create all the instances of the Powershell class 'Comment' from this data and add them to the array 'commentsArray'...
            foreach($comment in $commentsJSONObj) {

                $commentsArray.Add([Comment]::new($comment.id, $comment.node_id, $comment.html_url, $comment.issue_url, $comment.url, $comment.user.id, $comment.user.login, $comment.user.node_id, $comment.user.avatar_url,
                                                  $comment.user.url, $comment.user.html_url, $comment.user.site_admin, $comment.user.type, [Datetime]::Parse($comment.user.created_at), [Datetime]::Parse($comment.user.updated_at), $comment.author_association, $comment.body))
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {
        
            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $commentsArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        # Returning the '$branchesArray' array...
        return $commentsArray
    }

    # Returns the User current instance as String...
    [string] ToString()
    {
        # If no error occurs...
        If(!$this.error) {

            $returningString = "`n" + ",,,,,,,,,,,,,,,,,,,,,,,,,,," + "`n" + 

                               ",,,,,,,,,,,,,,,,,,,,,,,,,,," + "`n" +

                               ",,,,,,,,,,,,,,,,,,,,,,,,,,," + "`n" +

                               ",,,,,,,,,,,,,,,,,,,,,,,,,,,"

        # Else (an error occurs)...
        } Else {

            $returningString = $this.error.ToString()
        }

        return $returningString
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

    # 'userId' attribute getter...
    [int] getUserId()
    {
        return $this.userId
    }

    # 'userLogin' attribute getter...
    [string] getUserLogin()
    {
        return $this.userLogin
    }

    # 'userNodeId' attribute getter...
    [string] getUserNodeId()
    {
        return $this.userNodeId
    }

    # 'userAvatar' attribute getter...
    [string] getUserAvatar()
    {
        return $this.userAvatar
    }

    # 'userUrl' attribute getter...
    [string] getUserUrl()
    {
        return $this.userUrl
    }

    # 'userHtmlUrl' attribute getter...
    [string] getUserHtmlUrl()
    {
        return $this.userHtmlUrl
    }

    # 'userSiteAdmin' attribute getter...
    [bool] getUserSiteAdmin()
    {
        return $this.userSiteAdmin
    }

    # 'userType' attribute getter...
    [string] getUserType()
    {
        return $this.userType
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