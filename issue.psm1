# Importation of the 'GitHubError' module...
Using module .\gitHubError.psm1

# Definition of the Issue Powershell class to define a issue from the GitHub API...
class Issue
{

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