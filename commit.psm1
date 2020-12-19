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
    Commit([string]$wishedUserLogin, [string]$wishedRepositoryName, [string]$wishedSha)
    {
        # Extract all the data relating to the desired commit identified by the desired user login, the desired repository name and desired sha from the received JSON ...
        $githubGetCommitURL = "https://api.github.com/repos/" + $wishedUserLogin + "/" + $wishedRepositoryName + "/commits/" + $wishedSha
    }

    # Definition of a static function to put all commits from a user and a repository identified respectively by its login and its name inside an array...
    static [System.Array] listAllCommits([string]$wishedUserLogin, [string]$wishedRepositoryName)
    {
        # Create an HTTP request to take all commits of the GitHub repository identified by its name and its owner's login...
        $githubGetCommitsReposURL = "https://api.github.com/repos/" + $wishedUserLogin + "/" + $wishedRepositoryName + "/commits"

        #
        return @()
    }

    # 'sha' attribute getter...
    [string] getSha()
    {
        return $this.sha
    }

    # 'nodeId' attribute getter...
    [string] getNodeId()
    {
        return $this.nodeId
    }

    # 'message' attribute getter...
    [string] getMessage()
    {
        return $this.message
    }

    # 'total' attribute getter...
    [int] getTotal()
    {
        return $this.total
    }

    # 'additions' attribute getter...
    [int] getAdditions()
    {
        return $this.additions
    }

    # 'deletions' attribute getter...
    [int] getDeletions()
    {
        return $this.deletions
    }

    # 'files' attribute getter...
    [System.Array] getFiles()
    {
        return $this.files
    }
}