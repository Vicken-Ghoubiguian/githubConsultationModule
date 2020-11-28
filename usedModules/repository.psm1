Using module .\license.psm1
Using module .\user.psm1

# Definition of the Repository Powershell class to define a repository from the GitHub API...
class Repository
{

    # All attributes of the Repository class...
    hidden [int]$id
    hidden [string]$nodeID
    hidden [string]$name
    hidden [string]$fullName
    hidden [bool]$isPrivate
    hidden [string]$ownerID
    hidden [string]$ownerLogin
    hidden [string]$page
    hidden [string]$description
    hidden [bool]$isFork
    hidden [System.Array]$forks
    hidden [int]$forksCount
    hidden [System.Array]$contributors
    hidden [System.Array]$subscribers
    hidden [License]$license
    hidden [string]$gitURL
    hidden [string]$sshURL
    hidden [string]$cloneURL
    hidden [string]$svnURL
    hidden [string]$homePage
    hidden [bool]$archived
    hidden [string]$mainLanguage
    hidden [System.Array]$allLanguages

    # Repository class constructor with user login and repository name...
    Repository([string]$wishedUserLogin, [string]$wishedRepositoryName)
    {
        
    }

    # Definition of a static function to put all repositories of a user identified as a User class instance inside an array...
    static [System.Array] listAllRepositoriesFromOwner([User]$owner)
    {
        # Extract all the data relating to all the repositories of the desired user from the received JSON ...
        $githubGetReposURL = "https://api.github.com/users/" + $owner.getLogin() + "/repos"
        $githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get
        $githubReposRequestsContent = $githubReposRequest.Content
        $githubReposRequestsJSONContent = @"
               
$githubReposRequestsContent
"@
        $githubReposRequestsResult = ConvertFrom-Json -InputObject $githubReposRequestsJSONContent

        return @()
    }

    # Definition of a static function to put all repositories of a user identified by its login inside an array...
    static [System.Array] listAllRepositoriesFromLogin([string]$login)
    {
        # Extract all the data relating to all the repositories of the desired user from the received JSON ...
        $githubGetReposURL = "https://api.github.com/users/" + $login + "/repos"
        $githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get
        $githubReposRequestsContent = $githubReposRequest.Content
        $githubReposRequestsJSONContent = @"
               
$githubReposRequestsContent
"@
        $githubReposRequestsResult = ConvertFrom-Json -InputObject $githubReposRequestsJSONContent

        return @()
    }

    # 'id' attribute getter...
    [int] getId()
    {
        return $this.id
    }

    # 'nodeID' attribute getter...
    [string] getNodeID()
    {
        return $this.nodeID
    }

    # 'name' attribute getter...
    [string] getName()
    {
        return $this.name
    }

    # 'fullName' attribute getter...
    [string] getFullName()
    {
        return $this.fullName
    }

    # 'isPrivate' attribute getter...
    [bool] getIsPrivate()
    {
        return $this.isPrivate
    }

    # 'ownerID' attribute getter...
    [string] getOwnerID()
    {
        return $this.ownerID
    }

    # 'ownerLogin' attribute getter...
    [string] getOwnerLogin()
    {
        return $this.ownerLogin
    }

    # 'page' attribute getter...
    [string] getPage()
    {
        return $this.page
    }

    # 'description' attribute getter...
    [string] getDescription()
    {
        return $this.description
    }

    # 'isFork' attribute getter...
    [bool] getIsFork()
    {
        return $this.isFork
    }

    # 'forks' attribute getter...
    [System.Array] getForks()
    {
        return $this.forks
    }

    # 'forksCount' attribute getter...
    [int] getForksCount()
    {
        return $this.forksCount
    }

    # 'contributors' attribute getter...
    [System.Array] getContributors()
    {
        return $this.contributors
    }

    # 'subscribers' attribute getter...
    [System.Array] getSubscribers()
    {
        return $this.subscribers
    }

    # 'license' attribute getter...
    [License] getLicense()
    {
        return $this.license
    }

    # 'gitURL' attribute getter...
    [string] getGitURL()
    {
        return $this.gitURL
    }

    # 'sshURL' attribute getter...
    [string] getSshURL()
    {
        return $this.sshURL
    }

    # 'cloneURL' attribute getter...
    [string] getCloneURL()
    {
        return $this.cloneURL
    }

    # 'svnURL' attribute getter...
    [string] getSvnURL()
    {
        return $this.svnURL
    }

    # 'homePage' attribute getter...
    [string] getHomePage()
    {
        return $this.homePage
    }

    # 'archived' attribute getter...
    [bool] getArchived()
    {
        return $this.archived
    }

    # 'mainLanguage' attribute getter...
    [string] getMainLanguage()
    {
        return $this.mainLanguage
    }

    # 'allLanguages' attribute getter...
    [System.Array] getAllLanguages()
    {
        return $this.allLanguages
    }
}