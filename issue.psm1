# Importation of the 'GitHubError' module...
Using module .\gitHubError.psm1

# Definition of the Issue Powershell class to define a issue from the GitHub API...
class Issue
{
    # All attributes of the Issue class...
    hidden [int]$id
    hidden [int]$number
    hidden [string]$nodeId
    hidden [string]$title
    hidden [string]$url
    hidden [string]$htmlUrl
    hidden [string]$state
    hidden [bool]$locked
    hidden [string]$assignee
    hidden [int]$commentsCount
    hidden [dateTime]$creatingDate
    hidden [dateTime]$updatingDate
    hidden [dateTime]$closingDate
    hidden [string]$body
    hidden [string]$closedBy

    hidden [System.Array]$events = [System.Collections.ArrayList]::new()
    hidden [System.Array]$comments = [System.Collections.ArrayList]::new()
    hidden [System.Array]$labels = [System.Collections.ArrayList]::new()
    hidden [System.Array]$assignees = [System.Collections.ArrayList]::new()

    hidden [int]$userId
    hidden [string]$userLogin
    hidden [string]$userNodeId
    hidden [string]$userAvatar
    hidden [string]$userUrl
    hidden [string]$userHtmlUrl
    hidden [bool]$userSiteAdmin
    hidden [string]$userType

    hidden [GitHubError]$error

    # Issue class constructor with the owner login, the repository name and the issue's number...
    Issue([string]$wishedOwnerLogin, [string]$wishedReposName, [int]$wishedIssueNumber)
    {
        $githubGetIssueURL = "https://api.github.com/repos/" + $wishedOwnerLogin + "/" + $wishedReposName + "/issues/" + $wishedIssueNumber

        # Bloc we wish execute to get all informations about the wished issue...
        try {

            #
            $githubIssueRequest = Invoke-WebRequest -Uri $githubGetIssueURL -Method Get
            $githubIssueRequestsContent = $githubIssueRequest.Content
            $githubIssueRequestsJSONContent = @"
                       
$githubIssueRequestsContent
"@
            $githubIssueRequestsResult = ConvertFrom-Json -InputObject $githubIssueRequestsJSONContent

            # Entering the values ​​for all the attributes of the Issue class...
            $this.id = $githubIssueRequestsResult.id
            $this.number = $githubIssueRequestsResult.number
            $this.nodeId = $githubIssueRequestsResult.node_id
            $this.title = $githubIssueRequestsResult.title
            $this.url = $githubIssueRequestsResult.url
            $this.htmlUrl = $githubIssueRequestsResult.html_url
            $this.state = $githubIssueRequestsResult.state
            $this.locked = $githubIssueRequestsResult.locked
            $this.assignee = $githubIssueRequestsResult.assignee
            $this.commentsCount = $githubIssueRequestsResult.comments
            $this.creatingDate = [Datetime]::Parse($githubIssueRequestsResult.created_at)
            $this.updatingDate = [Datetime]::Parse($githubIssueRequestsResult.updated_at)
            #$this.closingDate = [Datetime]::Parse($githubIssueRequestsResult.closed_at)
            $this.closingDate = [Datetime]::Now
            $this.body = $githubIssueRequestsResult.body
            $this.closedBy = $githubIssueRequestsResult.closed_by

            $this.events = @()
            $this.comments = @()
            $this.labels = @()
            $this.assignees = @()

            $this.userId = $githubIssueRequestsResult.user.id
            $this.userLogin = $githubIssueRequestsResult.user.login
            $this.userNodeId = $githubIssueRequestsResult.user.node_id
            $this.userAvatar = $githubIssueRequestsResult.user.avatar_url
            $this.userUrl = $githubIssueRequestsResult.user.url
            $this.userHtmlUrl = $githubIssueRequestsResult.user.html_url
            $this.userSiteAdmin = $githubIssueRequestsResult.user.site_admin
            $this.userType = $githubIssueRequestsResult.user.type

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $this.error = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
        }
    }

    # Issue class constructor with all class attributes in parameter...
    Issue([int]$id, [int]$number, [string]$nodeId, [string]$title, [string]$url, [string]$htmlUrl, [string]$state, [bool]$locked, [string]$assignee, [int]$commentsCount,
          [dateTime]$creatingDate, [dateTime]$updatingDate, [dateTime]$closingDate, [string]$body, [string]$closedBy, [System.Array]$events, [System.Array]$comments,
          [System.Array]$labels, [System.Array]$assignees, [int]$userId, [string]$userLogin, [string]$userNodeId, [string]$userAvatar, [string]$userUrl, [string]$userHtmlUrl,
          [bool]$userSiteAdmin, [string]$userType)
    {
        $this.id = $id
        $this.number = $number
        $this.nodeId = $nodeId
        $this.title = $title
        $this.url = $url
        $this.htmlUrl = $htmlUrl
        $this.state = $state
        $this.locked = $locked
        $this.assignee = $assignee
        $this.commentsCount = $commentsCount
        $this.creatingDate = $creatingDate
        $this.updatingDate = $updatingDate
        $this.closingDate = $closingDate
        $this.body = $body
        $this.closedBy = $closedBy
        $this.events = $events
        $this.comments = $comments
        $this.labels = $labels
        $this.assignees = $assignees
        $this.userId = $userId
        $this.userLogin = $userLogin
        $this.userNodeId = $userNodeId
        $this.userAvatar = $userAvatar
        $this.userUrl = $userUrl
        $this.userHtmlUrl = $userHtmlUrl
        $this.userSiteAdmin = $userSiteAdmin
        $this.userType = $userType
    }

    # Definition of a static function to get all issues from a repos identified by its name owned by a owner identified by its login...
    static [System.Array] listAllIssues([string]$ownerLogin, [string]$wantRepos)
    {
        # Definition of the 'issuesArray' array which will contain all issues of the wished 'wantRepos' owned by the 'ownerLogin' owner...
        $issuesArray = [System.Collections.ArrayList]::new()

        # Bloc we wish execute to get all informations about the wished issue...
        try {

            # Create an HTTP request to take all issues from the GitHub repos identified by its name owned by the GitHub user identified by its login...
            $githubGetIssuesURL = "https://api.github.com/repos/" + $ownerLogin + "/" + $wantRepos + "/issues"

            # Retrieving and extracting all repositories received from the URL...
            $githubIssuesRequest = Invoke-WebRequest -Uri $githubGetIssuesURL -Method Get
            $issuesJSONObj = ConvertFrom-Json $githubIssuesRequest.Content

            # Browse all the issues contained in the received JSON and create all the instances of the Powershell class 'Issue' from this data and add them to the array 'issuesArray'...
            foreach($issue in $issuesJSONObj) {

                $issuesArray.Add([Issue]::new($issue.id,
                                              $issue.number,
                                              $issue.node_id,
                                              $issue.title,
                                              $issue.url,
                                              $issue.html_url,
                                              $issue.state,
                                              $issue.locked,
                                              $issue.assignee,
                                              $issue.comments,
                                              [Datetime]::Parse($issue.created_at),
                                              [Datetime]::Parse($issue.updated_at),
                                              #[Datetime]::Parse($issue.closed_at),
                                              [Datetime]::Now,
                                              $issue.body,
                                              "not specified",
                                              @(),
                                              @(),
                                              @(),
                                              @(),
                                              $issue.user.id,
                                              $issue.user.login,
                                              $issue.user.node_id,
                                              $issue.user.avatar_url,
                                              $issue.user.url,
                                              $issue.user.html_url,
                                              $issue.user.site_admin,
                                              $issue.user.type
                                              ))
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $issuesArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        return $issuesArray
    }

    # Definition of a static function to get all specific issues from a repos identified by its name owned by a owner identified by its login...
    static [System.Array] listAllSpecificIssues([string]$ownerLogin, [string]$wantRepos)
    {
        return @()
    }

    # 'events' attribute getter...
    [System.Array] getEvents()
    {
        return $this.events
    }

    # 'comments' attribute getter...
    [System.Array] getComments()
    {
        return $this.comments
    }

    # 'labels' attribute getter...
    [System.Array] getLabels()
    {
        return $this.labels
    }

    # 'assignees' attribute getter...
    [System.Array] getAssignees()
    {
        return $this.assignees
    }

    # 'userId' attribute getter...
    [string] getUserId()
    {
        return $this.userId
    }

    # 'userLogin' attribute getter...
    [string] getUserLogin()
    {
        return $this.userLogin
    }

    # 'userNode_id' attribute getter...
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

    # 'userType' attribute getter...
    [string] getUserType()
    {
        return $this.userType
    }

    # 'userSiteAdmin' attribute getter...
    [string] getUserSiteAdmin()
    {
        return $this.userSiteAdmin
    }

    # 'error' attribute getter...
    [GitHubError] getGitHubError()
    {
        return $this.error
    }
}