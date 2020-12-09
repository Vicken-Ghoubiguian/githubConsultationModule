﻿Using module .\usefulClassesAndObjects\gitHubError.psm1

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
    static [System.Array] listAllBranches([string]$wishedLogin, [string]$wishedRepos)
    {
        # Definition of the 'branchesArray' array which will contain all branches of the wished 'wishedRepos' repo from the wished 'wishedLogin' user...
        $branchesArray = [System.Collections.ArrayList]::new()

        # Bloc we wish execute to get all informations about branches...
        try {

            # Create an HTTP request to take all branches informations from the GitHub repository identified by its name and its owner's login...
            $githubGetBranchesURL = "https://api.github.com/repos/" + $wishedLogin + "/" + $wishedRepos + "/branches"

            # Retrieving and extracting all branches received from the URL...
            $githubBranchesRequest = Invoke-WebRequest -Uri $githubGetBranchesURL -Method Get
            $branchesJSONObj = ConvertFrom-Json $githubBranchesRequest.Content

            # Browse all the branches contained in the received JSON and create all the instances of the Powershell class 'Branch' from this data and add them to the array 'branchesArray'...
            foreach($branch in $branchesJSONObj) {

                $branchesArray.Add([Branch]::new($branch.name, $branch.commit.sha, $branch.commit.url, $branch.protected))
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {
        
            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $branchesArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        # Returning the '$branchesArray' array...
        return $branchesArray
    }

    #
    [String] ToString()
    {
        $returningString = "`n"
        $returningString +=  "Name: " + $this.getName() + "`n"
        $returningString += "Last commit SHA: " + $this.getLasCommitSha() + "`n"
        $returningString += "Last commit URL: " + $this.getLastCommitURL() + "`n"
        $returningString += "Is is protected ? " + $this.getIsProtected() + "`n"

        return $returningString
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