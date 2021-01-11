Using module .\license.psm1
Using module .\branch.psm1
using module .\language.psm1
Using module .\commit.psm1
Using module .\gitHubError.psm1

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
    hidden [string]$ownerType
    hidden [string]$page
    hidden [string]$description
    hidden [bool]$isFork
    hidden [System.Array]$forks
    hidden [int]$forksCount
    hidden [System.Array]$contributors
    hidden [System.Array]$subscribers
    hidden [System.Array]$branches
    hidden [System.Array]$commits
    hidden [License]$license
    hidden [string]$gitURL
    hidden [string]$sshURL
    hidden [string]$cloneURL
    hidden [string]$svnURL
    hidden [string]$archiveURL
    hidden [string]$homePage
    hidden [bool]$isArchived
    hidden [string]$mainLanguage
    hidden [System.Array]$languages
    hidden [GitHubError]$error

    # Repository class constructor with user login and repository name...
    Repository([string]$wishedUserLogin, [string]$wishedRepositoryName, [bool]$withBranches, [bool]$withLanguages)
    {
        # Create an HTTP request to take the GitHub repository identified by its name and its owner's login...
        $githubGetReposURL = "https://api.github.com/repos/" + $wishedUserLogin + "/" + $wishedRepositoryName

        # Bloc we wish execute to get all informations about the wished repository...
        try {
        
            #
            $githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get
            $githubReposRequestsContent = $githubReposRequest.Content
            $githubReposRequestsJSONContent = @"
               
$githubReposRequestsContent
"@
            $githubReposRequestsResult = ConvertFrom-Json -InputObject $githubReposRequestsJSONContent

            #
            $this.id = $githubReposRequestsResult.id
            $this.nodeID = $githubReposRequestsResult.node_id
            $this.name = $githubReposRequestsResult.name
            $this.fullName = $githubReposRequestsResult.full_name
            $this.isPrivate = $githubReposRequestsResult.private
            $this.ownerLogin = $githubReposRequestsResult.owner.login
            $this.ownerID = $githubReposRequestsResult.owner.id
            $this.ownerType = $githubReposRequestsResult.owner.type
            $this.page = $githubReposRequestsResult.html_url
            $this.description = $githubReposRequestsResult.description
            $this.isFork = $githubReposRequestsResult.fork
            $this.forksCount = $githubReposRequestsResult.forks_count

            # If "withBranches" parameter is "true"...
            If ($withBranches -eq $true){

                # Call of the static function 'listAllBranches' of the PowerShell class 'Branch' to obtain all the branches of the repo...
                $this.branches = [Branch]::listAllBranches($this.ownerLogin, $this.name)
            }

            # If "withLanguages" parameter is "true"...
            If ($withLanguages -eq $true){

                # Call of the static function 'listAllLanguage' of the PowerShell class 'Language' to obtain all the languages with details of the repo...
                $this.languages = [Language]::listAllLanguages($this.ownerLogin, $this.name)
            }

            #
            $this.commits = @()
            
            #
            $this.forks = @()

            #
            $this.contributors = @()

            #
            $this.subscribers = @()

            # If the 'license' element exists in the JSON datas received from the previous request...
            If($githubReposRequestsResult.license) {

                # An object of 'License' class is created and affected to the 'license' class attribute...
                $this.license = [License]::new($githubReposRequestsResult.license.key, $githubReposRequestsResult.license.name, $githubReposRequestsResult.license.spdx_id, $githubReposRequestsResult.license.url, $githubReposRequestsResult.license.node_id)

            # Else...
            } Else {

                # The value of 'license' class attribute is set to 'null'...
                $this.license = $null
            }

            #
            $this.gitURL = $githubReposRequestsResult.git_url
            $this.sshURL = $githubReposRequestsResult.ssh_url
            $this.cloneURL = $githubReposRequestsResult.clone_url
            $this.svnURL = $githubReposRequestsResult.svn_url
            $this.archiveURL = $githubReposRequestsResult.archive_url
            $this.homePage = $githubReposRequestsResult.homepage
            $this.isArchived = $githubReposRequestsResult.archived
            $this.mainLanguage = $githubReposRequestsResult.language

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $this.error = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
        }
    }

    # Repository class constructor with all class attributes in parameter...
    Repository([int]$id, [string]$nodeID, [string]$name, [string]$fullName, [bool]$isPrivate, [string]$ownerID, [string]$ownerLogin, [string]$ownerType, 
               [string]$page, [string]$description, [bool]$isFork, [int]$forksCount, [License]$license, [string]$gitURL, [string]$sshURL, 
               [string]$cloneURL, [string]$svnURL, [string]$archiveURL, [string]$homePage, [bool]$isArchived, [string]$mainLanguage, [bool]$wantBranches, [bool]$wantLanguages)
    {
        $this.id = $id
        $this.nodeID = $nodeID
        $this.name = $name
        $this.fullName = $fullName
        $this.isPrivate = $isPrivate
        $this.ownerID = $ownerID
        $this.ownerLogin = $ownerLogin
        $this.ownerType = $ownerType
        $this.page = $page
        $this.description = $description
        $this.isFork = $isFork
        $this.forks = @()
        $this.forksCount = $forksCount
        $this.contributors = @()
        $this.subscribers = @()
        $this.license = $license
        $this.gitURL = $gitURL
        $this.sshURL = $sshURL
        $this.cloneURL = $cloneURL
        $this.svnURL = $svnURL
        $this.archiveURL = $archiveURL
        $this.homePage = $homePage
        $this.isArchived = $isArchived
        $this.mainLanguage = $mainLanguage

        # If the 'wantBranches' variable is 'true'...
        If($wantBranches) {

            # We will get all branches used in the repos in the 'branches' class attribute...
            $this.branches = [Branch]::listAllBranches($ownerLogin, $name)
        }

        # If the 'wantLanguages' variable is 'true'...
        If($wantLanguages) {

            # We will get all languages used in the repos in the 'languages' class attribute...
            $this.languages = [Language]::listAllLanguages($ownerLogin, $name)
        }
    }

    # Definition of a static function to put all repositories of a owner identified by its login and with its type as diminutive inside an array...
    static [System.Array] listAllRepositories([string]$ownerLogin, [string]$diminutiveType, [bool]$wantBranches, [bool]$wantLanguages)
    {
        # Definition of the 'repositoriesArray' array which will contain all repositories of the wished the wished 'userLogin' user...
        $repositoriesArray = [System.Collections.ArrayList]::new()

        #
        If(($diminutiveType -eq "users") -or ($diminutiveType -eq "orgs")) {

            # Bloc we wish execute to get all informations about repositories...
            try {

                # Create an HTTP request to take all repositories informations from the GitHub user identified by its login...
                $githubGetReposURL = "https://api.github.com/" + $diminutiveType + "/" + $ownerLogin + "/repos?per_page=100"

                # Retrieving and extracting all repositories received from the URL...
                $githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get
                $reposJSONObj = ConvertFrom-Json $githubReposRequest.Content

                # Browse all the repos contained in the received JSON and create all the instances of the Powershell class 'Repository' from this data and add them to the array 'repositoriesArray'...
                foreach($repos in $reposJSONObj) {

                    $repositoriesArray.Add([Repository]::new($repos.id, 
                                                             $repos.node_id,
                                                             $repos.name, 
                                                             $repos.full_name,
                                                             $repos.private,
                                                             $repos.owner.id,
                                                             $repos.owner.login,
                                                             $repos.owner.type,
                                                             $repos.html_url,
                                                             $repos.description,
                                                             $repos.isFork,
                                                             $repos.forksCount,
                                                             [License]::new($repos.license.key, $repos.license.name, $repos.license.spdx_id, $repos.license.url, $repos.license.node_id),
                                                             $repos.git_url,
                                                             $repos.ssh_url,
                                                             $repos.clone_url,
                                                             $repos.svn_url,
                                                             $repos.archive_url,
                                                             $repos.homepage,
                                                             $repos.archived,
                                                             $repos.language,
                                                             $wantBranches,
                                                             $wantLanguages
                                                             ))
                }

            # Bloc to execute if an System.Net.WebException is encountered...
            } catch [System.Net.WebException] {
        
                $errorType = $_.Exception.GetType().Name

                $errorMessage = $_.Exception.Message

                $errorStackTrace = $_.Exception.StackTrace

                $repositoriesArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
            }

        # In the contrary case...
        } Else {

            $repositoriesArray.Add([GitHubError]::new("Type unknown", "The type entered in parameter is unknown...", "No stack trace available..."))
        }

        # Returning the '$repositoriesArray' array...
        return $repositoriesArray
    }

    #
    [String] ToString()
    {
        # If no error occurs...
        If(!$this.error) {

            $returningString =  "`n" + "@@@@@@@@@@@@@@@@@@@@@@@@@@" + "`n" +
                   "Id: " + $this.id + "`n" +
                   "Node Id: " + $this.nodeID + "`n" +
                   "Name: " + $this.name + "`n" +
                   "Full name: " + $this.fullName + "`n" +
                   "Page: " + $this.page + "`n" +
                   "Is it private ? " + $this.isPrivate + "`n" +
                   "Is it a fork ? " + $this.isFork + "`n" +
                   "Is it archived ? " + $this.isArchived + "`n" +

                    "@@@@@@@@@@@@@@@@@@@@@@@@@@" + "`n" +

                    "Owner ID: " + $this.ownerID + "`n" +
                    "Owner login: " + $this.ownerLogin + "`n" +
                    "Owner type: " + $this.ownerType + "`n" +

                    "@@@@@@@@@@@@@@@@@@@@@@@@@@" + "`n" +

                    "Main language: " + $this.mainLanguage + "`n"
                    
                    # If the 'languages' attribute, which is an array, is null...
                    If($this.languages -ne $null) {

                        $returningString += "--------------------------" + "`n"

                        foreach($language in $this.languages) {

                            $returningString += $language.ToString()
                        }
                    }

                    # If the 'branches' attribute, which is an array, is null...
                    If($this.branches -ne $null) {

                        $returningString += "@@@@@@@@@@@@@@@@@@@@@@@@@@"

                        foreach($branch in $this.branches) {

                            $returningString += $branch.ToString()
                        }
                    }

                    # If the 'license' attribute, which is an array, is null...
                    If($this.license -ne $null) {

                        $returningString += "@@@@@@@@@@@@@@@@@@@@@@@@@@"

                        $returningString += $this.license.ToString()

                        $returningString += "`n"
                    }

                    "@@@@@@@@@@@@@@@@@@@@@@@@@@" + "`n" +

                    "Git URL: " + $this.gitURL + "`n" +
                    "ssh URL: " + $this.sshURL + "`n" +
                    "svn URL: " + $this.svnURL + "`n" +
                    "home page: " + $this.homePage + "`n"

                    $returningString += "@@@@@@@@@@@@@@@@@@@@@@@@@@"

          # Else (an error occurs)...
          } Else {

                    $returningString = $this.error.ToString()
          }

          return $returningString
    }

    # Returning the module's type as string...
    [string] getModuleType()
    {
        return "Repository"
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

    # 'ownerType' attribute getter...
    [string] getOwnerType()
    {
        return $this.ownerType
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

    # 'archiveURL' attribute getter...
    [string] getArchiveURL()
    {
        return $this.archiveURL
    }

    # 'homePage' attribute getter...
    [string] getHomePage()
    {
        return $this.homePage
    }

    # 'archived' attribute getter...
    [bool] getIsArchived()
    {
        return $this.isArchived
    }

    # 'mainLanguage' attribute getter...
    [string] getMainLanguage()
    {
        return $this.mainLanguage
    }

    # 'allLanguages' attribute getter...
    [System.Array] getLanguages()
    {
        return $this.languages
    }

    # 'branches' attribute getter...
    [System.Array] getBranches()
    {
        return $this.branches
    }

    # 'commits' attribute getter...
    [System.Array] getCommits()
    {
        return $this.commits
    }

    # 'error' attribute getter...
    [GitHubError] getGitHubError()
    {
        return $this.error
    }
}