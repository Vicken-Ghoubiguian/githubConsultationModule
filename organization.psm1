Using module .\gitHubError.psm1
Using module .\Repository.psm1

# Definition of the User Powershell class to define a user from the GitHub API...
class Organization 
{

    hidden [string]$login
    hidden [string]$id
    hidden [string]$nodeId
    hidden [string]$avatar
    hidden [string]$name
    hidden [string]$description
    hidden [string]$company
    hidden [string]$blog
    hidden [string]$location
    hidden [string]$email
    hidden [string]$type

    hidden [System.Array]$repositories

    hidden [int]$followersCount
    hidden [int]$followingCount
    hidden [string]$type
    hidden [string]$twitter
    hidden [GitHubError]$error

    # Repository class constructor...
    Organization([string]$organizationLogin, [bool]$withRepos, [bool]$withBranches, [bool]$withLanguages)
    {
        # Create an HTTP request to take the GitHub organization identified by its name and its owner's login...
        $githubGetOrganizationURL = "https://api.github.com/orgs/" + $organizationLogin

        # Bloc we wish execute to get all informations about the wished organization...
        try {

            #
            $githubOrganizationRequest = Invoke-WebRequest -Uri $githubGetOrganizationURL -Method Get
            $githubOrganizationRequestsContent = $githubOrganizationRequest.Content
            $githubOrganizationRequestsJSONContent = @"
                       
$githubOrganizationRequestsContent
"@
            $githubOrganizationRequestsResult = ConvertFrom-Json -InputObject $githubOrganizationRequestsJSONContent

            $this.login = $githubOrganizationRequestsResult.login
            $this.id = $githubOrganizationRequestsResult.id
            $this.nodeId = $githubOrganizationRequestsResult.node_id
            $this.avatar = $githubOrganizationRequestsResult.avatar_url
            $this.name = $githubOrganizationRequestsResult.name
            $this.description = $githubOrganizationRequestsResult.description
            $this.company = $githubOrganizationRequestsResult.company
            $this.blog = $githubOrganizationRequestsResult.blog
            $this.location = $githubOrganizationRequestsResult.location
            $this.email = $githubOrganizationRequestsResult.email

            $this.type = $githubOrganizationRequestsResult.type
            $this.followersCount = $githubOrganizationRequestsResult.followers
            $this.followingCount = $githubOrganizationRequestsResult.following
            $this.twitter = $githubOrganizationRequestsResult.twitter_username

            # If "withRepos" parameter is "true"...
            If($withRepos -eq $true) {

                # Adding the repository to the 'repositories' class attribute which is an array...
                $this.repositories = [Repository]::listAllRepositories($githubOrganizationRequestsResult.login, "orgs", $withBranches, $withLanguages)
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $this.error = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
        }
    }

    # Definition of a static function to put all repositories of a user identified by its login inside an array...
    static [System.Array] listAllOrganization([string]$userLogin)
    {
        # Definition of the 'organizationsArray' array which will contain all organizations of the wished the wished 'userLogin' user...
        $organizationsArray = [System.Collections.ArrayList]::new()

        # Bloc we wish execute to get all informations about organizations...
        try {

            # Create an HTTP request to take all organizations informations from the GitHub user identified by its login...
            $githubGetOrgsURL = "https://api.github.com/users/" + $userLogin + "/orgs"

            #Retrieving and extracting all repositories received from the URL...
            $githubOrgsRequest = Invoke-WebRequest -Uri $githubGetOrgsURL -Method Get
            $orgsJSONObj = ConvertFrom-Json $githubOrgsRequest.Content

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $organizationsArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        # Returning the '$organizationsArray' array...
        return $organizationsArray
    }

    #
    [String] ToString()
    {

        # If no error occurs...
        If(!$this.error) {

             $returningString = ""

        # Else (an error occurs)...
        } Else {

            $returningString = $this.error.ToString()
        }

        return $returningString
    }

    # 'error' attribute getter...
    [GitHubError] getGitHubError()
    {
        return $this.error
    }
}