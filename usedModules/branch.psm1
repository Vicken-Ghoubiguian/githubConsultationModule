# Definition of the Branch Powershell class to define a license from the GitHub API...
class Branch {

    # All attributes of the Branch class...
    hidden [string]$name
    hidden [string]$lastCommitSha
    hidden [string]$lastCommitURL
    hidden [bool]$isProtected

    # Branch class constructor...
    Branch([string]$collectedName, [string]$collectedLastCommitSha, [string]$collectedLastCommitURL, [bool]$collectedIsProtected)
    {
        $this.name = $collectedName
        $this.lastCommitSha = $collectedLastCommitSha
        $this.lastCommitURL = $collectedLastCommitURL
        $this.isProtected = $collectedIsProtected
    }
    
    # Definition of a static function to put all branches from a user and a repository identified respectively by its login and its name inside an array...
    Static [System.Array] listAllBranches([string]$wishedLogin, [string]$wishedRepos)
    {
        #
        $githubGetBranchesURL = "https://api.github.com/repos/" + $wishedLogin + "/" + $wishedRepos + "/branches"

        return @("Ok", "Testy", "Testou")
    }

    # 'name' attribute getter...
    [string] getName()
    {
        return $this.name
    }

    # 'lastCommitSha' attribute getter...
    [string] getLasCommitSha()
    {
        return $this.lastCommitSha
    }

    # 'lastCommitURL' attribute getter...
    [string] getLastCommitURL()
    {
        return $this.lastCommitURL
    }

    # 'isProtected' attribute getter...
    [bool] getIsProtected()
    {
        return $this.isProtected
    }
}