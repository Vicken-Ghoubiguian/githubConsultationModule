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
    hidden [string]$html_url
    hidden [string]$state
    hidden [bool]$locked
    hidden [string]$assignee
    hidden [int]$commentsCount
    hidden [dateTime]$creating_date
    hidden [dateTime]$updating_date
    hidden [dateTime]$closing_date
    hidden [string]$body
    hidden [string]$closed_by

    hidden [System.Array]$events
    hidden [System.Array]$comments
    hidden [System.Array]$labels
    hidden [System.Array]$assignees

    hidden [int]$id
    hidden [string]$login
    hidden [string]$node_id
    hidden [string]$avatar
    hidden [string]$url
    hidden [string]$html_url
    hidden [bool]$siteAdmin
    hidden [string]$type

    hidden [GitHubError]$error
}