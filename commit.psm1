Using module .\usefulClassesAndObjects\gitHubError.psm1

# Definition of the Commit Powershell class to define a repository's commit from the GitHub API...
class Commit
{
    # All attributes of the Commit class...
    hidden [string]$sha
    hidden [string]$nodeId
    hidden [string]$message

    hidden [string]$loginAuthor
    hidden [string]$loginIdAuthor
    hidden [string]$loginNodeIdAuthor
    hidden [string]$loginAvatarAuthor
    hidden [string]$profileAuthor
    hidden [string]$typeAuthor

    hidden [string]$loginCommitter
    hidden [string]$loginIdCommitter
    hidden [string]$loginNodeIdCommitter
    hidden [string]$loginAvatarCommitter
    hidden [string]$profileCommitter
    hidden [string]$typeCommitter

    hidden [int]$total
    hidden [int]$additions
    hidden [int]$deletions
    hidden [System.Array]$files

    # Commit class constructor...
    Commit([string]$wishedUserLogin, [string]$wishedRepositoryName)
    {
        # Create an HTTP request to take all commits of the GitHub repository identified by its name and its owner's login...
        $githubGetCommitsReposURL = "https://api.github.com/repos/" + $wishedUserLogin + "/" + $wishedRepositoryName + "/commits"
    }
}