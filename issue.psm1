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

    hidden [System.Array]$events
    hidden [System.Array]$comments
    hidden [System.Array]$labels
    hidden [System.Array]$assignees

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
        $referenceTestVariable = "https://api.github.com/repos/" + $wishedOwnerLogin + "/" + $wishedReposName + "/issues/" + $wishedIssueNumber

        # Bloc we wish execute to get all informations about the wished issue...
        try {

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $this.error = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
        }
    }

    # Issue class constructor with all class attributes in parameter...
    Issue()
    {

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

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $issuesArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        return $issuesArray
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