﻿Using module .\gitHubError.psm1
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
    hidden [System.Collections.Hashtable]$members

    hidden [int]$followersCount
    hidden [int]$followingCount
    hidden [int]$publicReposCount
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
            $this.publicReposCount = $githubOrganizationRequestsResult.public_repos
            $this.twitter = $githubOrganizationRequestsResult.twitter_username

            # If "withRepos" parameter is "true"...
            If($withRepos) {

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

    # Organization class constructor with all class attributes in parameter...
    Organization([string]$login, [string]$id, [string]$nodeId, [string]$avatar, [string]$name, [string]$description,
                 [string]$company, [string]$blog, [string]$location, [string]$email, [string]$type, [int]$followers, [int]$following, [int]$reposCount, [string]$twitter,
                 [bool]$withRepos, [bool]$withBranches, [bool]$withLanguages)
    {
        $this.login = $login
        $this.id = $id
        $this.nodeId = $nodeId
        $this.avatar = $avatar
        $this.name = $name
        $this.description = $description
        $this.company = $company
        $this.blog = $blog
        $this.location = $location
        $this.email = $email
        $this.type = $type
        $this.followersCount = $followers
        $this.followingCount = $following
        $this.publicReposCount = $reposCount
        $this.twitter = $twitter

        # If the 'withRepos' variable is 'true'...
        If($withRepos) {

            # Adding the repository to the 'repositories' class attribute which is an array...
            $this.repositories = [Repository]::listAllRepositories($login, "orgs", $withBranches, $withLanguages)
        }
    }

    # Definition of a static function to put all repositories of a user identified by its login inside an array...
    static [System.Array] listAllOrganization([string]$userLogin, [bool]$wantRepos, [bool]$wantBranches, [bool]$wantLanguages)
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

            # Browse all the organizations contained in the received JSON and create all the instances of the Powershell class 'Organization' from this data and add them to the array 'organizationsArray'...
            foreach($organization in $orgsJSONObj) {

                $organizationsArray.Add([Organization]::new($organization.login, 
                                                            $organization.id, 
                                                            $organization.node_id, 
                                                            $organization.avatar_url, 
                                                            $organization.name, 
                                                            $organization.description, 
                                                            $organization.company,
                                                            $organization.blog,
                                                            $organization.location,
                                                            $organization.email,
                                                            $organization.type,
                                                            $organization.followers,
                                                            $organization.following,
                                                            $organization.public_repos,
                                                            $organization.twitter_username,
                                                            $wantRepos,
                                                            $wantBranches,
                                                            $wantLanguages))
            }

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

    # Returns the Organization current instance as String...
    [String] ToString()
    {
        # If no error occurs...
        If(!$this.error) {

            $returningString = "`n"
            $returningString += "Presentation:" + "`n"
            $returningString += "===============" + "`n"

            $returningString += "Id: " + $this.id + "`n" +
                               "Login: " + $this.login + "`n" +
                               "NodeId: " + $this.nodeId + "`n" +
                               "Avatar: " + $this.avatar + "`n" +
                               "Email: " + $this.email + "`n" +
                               "Type: " + $this.type + "`n" +
                               "Name: " + $this.name + "`n" +
                               "Description: " + $this.description + "`n" +
                               "Blog: " +  $this.blog + "`n" +
                               "Location: " +  $this.location + "`n" +
                               "Company: " + $this.company + "`n" +
                               "Public repos count: " + $this.publicReposCount + "`n" +
                               "Followers count: " + $this.followersCount + "`n" +
                               "Following count: " + $this.followingCount + "`n"

                               # If 'repositories' table is not empty (count != 0)...
                               If($this.repositories.Count -ne 0) {

                                   $returningString += "`n"
                                   $returningString += "Repositories:" + "`n"
                                   $returningString += "===============" + "`n"

                                   foreach($repository in $this.repositories) {

                                        $returningString += $repository.ToString() 
                                   }
                               }

                               foreach($repository in $this.repositories) {

                                    $returningString += $repository.ToString() 
                               }

            $returningString += ""

        # Else (an error occurs)...
        } Else {

            $returningString = $this.error.ToString()
        }

        return $returningString
    }

    # Returning the module's type as string...
    [string] getModuleType()
    {
        return "Organization"
    }

    # 'id' attribute getter...
    [int] getId()
    {
        return $this.id
    }

    # 'nodeId' attribute getter...
    [string] getNodeId()
    {
        return $this.nodeId
    }

    # 'blogURL' attribute getter...
    [string] getBlog()
    {
        return $this.blog
    }

    # 'name' attribute getter...
    [string] getName()
    {
        return $this.name
    }

    # 'avatarURL' attribute getter...
    [string] getAvatar()
    {
        return $this.avatar
    }

    # 'type' attribute getter...
    [string] getType()
    {
        return $this.type
    }

    # 'location' attribute getter...
    [string] getLocation()
    {
        return $this.location
    }

    # 'login' attribute getter...
    [string] getLogin()
    {
        return $this.login
    }

    # 'repositories' attribute getter...
    [System.Array] getRepositories()
    {
        return $this.repositories
    }

    # 'members' attribute getter...
    [System.Collections.Hashtable] getMembers()
    {
        return $this.members
    }

    # 'followingCount' attribute getter...
    [int] getFollowingCount()
    {
        return $this.followingCount
    }

    # 'followersCount' attribute getter...
    [int] getFollowersCount()
    {
        return $this.followersCount
    }

    # 'publicReposCount' attribute getter...
    [int] getPublicReposCount()
    {
        return $this.publicReposCount
    }

    # 'error' attribute getter...
    [GitHubError] getGitHubError()
    {
        return $this.error
    }
}