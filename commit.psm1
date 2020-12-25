Using module .\usefulClassesAndObjects\gitHubError.psm1

# Definition of the Commit Powershell class to define a repository's commit from the GitHub API...
class Commit
{
    # All attributes of the Commit class...
    hidden [string]$sha
    hidden [string]$nodeId
    hidden [string]$message

    hidden [string]$loginAuthor
    hidden [string]$idAuthor
    hidden [string]$nodeIdAuthor
    hidden [string]$avatarAuthor
    hidden [string]$profileAuthor
    hidden [string]$typeAuthor

    hidden [string]$loginCommitter
    hidden [string]$idCommitter
    hidden [string]$nodeIdCommitter
    hidden [string]$avatarCommitter
    hidden [string]$profileCommitter
    hidden [string]$typeCommitter

    hidden [int]$total
    hidden [int]$additions
    hidden [int]$deletions
    hidden [System.Array]$files

    # Commit class constructor with user login, repository name and sha...
    Commit([string]$wishedUserLogin, [string]$wishedRepositoryName, [string]$wishedSha)
    {
        # Extract all the data relating to the desired commit identified by the desired user login, the desired repository name and desired sha from the received JSON ...
        $githubGetCommitURL = "https://api.github.com/repos/" + $wishedUserLogin + "/" + $wishedRepositoryName + "/commits/" + $wishedSha
    }

    # Commit class constructor with all class attributes in parameter...
    Commit()
    {

    }

    # Definition of a static function to put all commits from a user and a repository identified respectively by its login and its name inside an array...
    static [System.Array] listAllCommits([string]$wishedUserLogin, [string]$wishedRepositoryName)
    {
        # Definition of the 'commitsArray' array which will contain all commits of the wished 'wishedRepositoryName' repo from the wished 'wishedUserLogin' user...
        $commitsArray = [System.Collections.ArrayList]::new()

        # Bloc we wish execute to get all informations about commits...
        try {

            # Create an HTTP request to take all commits of the GitHub repository identified by its name and its owner's login...
            $githubGetCommitsReposURL = "https://api.github.com/repos/" + $wishedUserLogin + "/" + $wishedRepositoryName + "/commits"

            # Retrieving and extracting all commits received from the URL...
            $githubCommitsReposRequest = Invoke-WebRequest -Uri $githubGetCommitsReposURL -Method Get
            $commitsJSONObj = ConvertFrom-Json $githubCommitsReposRequest.Content

            # Implementation of a message box that asks a very specific question...
            $commitsBoxResponse = [System.Windows.MessageBox]::Show("The static function 'listAllCommits' of the 'Commit' class tries to complete all missing datas. Do you want them ?", "Confirmation", "YesNo", "info")

            # Browse all the commits contained in the received JSON and create all the instances of the Powershell class 'Commit' from this data and add them to the array 'commitsArray'...
            foreach($commit in $commitsJSONObj) {

                $commitsArray.Add([Commit]::new())
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $commitsArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        # Returning the '$commitsArray' array...
        return $commitsArray
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

    # 'loginAuthor' attribute getter...
    [string] getLoginAuthor()
    {
        return $this.loginAuthor
    }

    # 'idAuthor' attribute getter...
    [string] getIdAuthor()
    {
        return $this.idAuthor
    }

    # 'nodeIdAuthor' attribute getter...
    [string] getNodeIdAuthor()
    {
        return $this.nodeIdAuthor
    }

    # 'avatarAuthor' attribute getter...
    [string] getAvatarAuthor()
    {
        return $this.avatarAuthor
    }

    # 'profileAuthor' attribute getter...
    [string] getProfileAuthor()
    {
        return $this.profileAuthor
    }

    # 'typeAuthor' attribute getter...
    [string] getTypeAuthor()
    {
        return $this.typeAuthor
    }

    # 'loginCommitter' attribute getter...
    [string] getLoginCommitter()
    {
        return $this.loginCommitter
    }

    # 'idCommitter' attribute getter...
    [string] getIdCommitter()
    {
        return $this.idCommitter
    }

    # 'nodeIdCommitter' attribute getter...
    [string] getNodeIdCommitter()
    {
        return $this.nodeIdCommitter
    }

    # 'avatarCommitter' attribute getter...
    [string] getAvatarCommitter()
    {
        return $this.avatarCommitter
    }

    # 'profileCommitter' attribute getter...
    [string] getProfileCommitter()
    {
        return $this.profileCommitter
    }

    # 'typeCommitter' attribute getter...
    [string] getTypeCommitter()
    {
        return $this.typeCommitter
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