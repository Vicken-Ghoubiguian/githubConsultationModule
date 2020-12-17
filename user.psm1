﻿Using module .\Repository.psm1
Using module .\usefulClassesAndObjects\gitHubError.psm1

# Definition of the User Powershell class to define a user from the GitHub API...
class User
{
    # All attributes of the User class...
    hidden [string]$login
    hidden [int]$id
    hidden [string]$nodeId
    hidden [string]$avatar
    hidden [string]$profile
    hidden [string]$type
    hidden [string]$name
    hidden [string]$blog
    hidden [string]$location
    hidden [bool]$isHireable
    hidden [int]$publicReposCount
    hidden [int]$followersCount
    hidden [int]$followingCount
    hidden [string]$company
    hidden [string]$email
    hidden [string]$bio
    hidden [string]$twitter
    hidden [GitHubError]$error

    hidden [System.Array]$repositories
    hidden [System.Array]$following
    hidden [System.Array]$followers
    hidden [System.Array]$organizations
    hidden [System.Array]$events

    # User class constructor...
    User([string]$wishedUserLogin)
    {
        # Extract all the data relating to the desired user from the received JSON ...
        $githubGetUserURL = "https://api.github.com/users/" + $wishedUserLogin

        # Bloc we wish execute to get all informations about the wished repository...
        try {

            #
            $githubUserRequest = Invoke-WebRequest -Uri $githubGetUserURL -Method Get
            $githubUserRequestsContent = $githubUserRequest.Content
            $githubUserRequestsJSONContent = @"
                       
$githubUserRequestsContent
"@
            $githubUserRequestsResult = ConvertFrom-Json -InputObject $githubUserRequestsJSONContent

            # Entering the values ​​for all the attributes of the User class...
            $this.login = $githubUserRequestsResult.login
            $this.id = $githubUserRequestsResult.id
            $this.nodeId = $githubUserRequestsResult.node_id
            $this.avatar = $githubUserRequestsResult.avatar_url
            $this.profile = $githubUserRequestsResult.html_url
            $this.type = $githubUserRequestsResult.type
            $this.name = $githubUserRequestsResult.name
            $this.blog = $githubUserRequestsResult.blog
            $this.location = $githubUserRequestsResult.location
            $this.isHireable = $githubUserRequestsResult.hireable
            $this.company = $githubUserRequestsResult.company
            $this.email = $githubUserRequestsResult.email
            $this.bio = $githubUserRequestsResult.bio
            $this.publicReposCount = $githubUserRequestsResult.public_repos
            $this.followersCount = $githubUserRequestsResult.followers
            $this.followingCount = $githubUserRequestsResult.following
            $this.twitter = $githubUserRequestsResult.twitter_username

            # Implementation of a message box that asks a very specific question...
            $repositoriesBoxResponse = [System.Windows.MessageBox]::Show("The constructor of the 'User' class now tries to get all repositories. Do you want them ?", "Confirmation", "YesNo", "info")

            # If the response from previous message box is "Yes", all repositories from user will be get and put in an array...
            If($repositoriesBoxResponse -eq "Yes") {

                # Implementation of a message box that asks a very specific question...
                $branchesBoxResponse = [System.Windows.MessageBox]::Show("The constructor of the 'User' class now tries to get all branches of the current repository. Do you want them ?", "Confirmation", "YesNo", "info")

                # If the response from previous message box is "Yes", 'withBranches' variable is set at 'true"...
                If($branchesBoxResponse -eq "Yes") {

                    $withBranches = $true

                # In the other case, 'withBranches' variable is set at 'false'...
                } Else {

                    $withBranches = $false
                }

                # Implementation of a message box that asks a very specific question...
                $languagesBoxResponse = [System.Windows.MessageBox]::Show("The constructor of the 'User' class now tries to get its hands on all languages with details used in the current repository. Do you want them ?", "Confirmation", "YesNo", "info")

                # If the response from previous message box is "Yes", 'withLanguages' variable is set at 'true"...
                If($languagesBoxResponse -eq "Yes") {

                    $withLanguages = $true

                # In the other case, 'withLanguages' variable is set at 'false'...
                } Else {

                    $withLanguages = $false
                }

                # Adding the repository to the 'repositories' class attribute which is an array...
                $this.repositories = [Repository]::listAllRepositories($githubUserRequestsResult.login, $withBranches, $withLanguages)
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $this.error = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
        }
    }

    # Returns the User current instance as String...
    [string] ToString()
    {
        # If no error occurs...
        If(!$this.error) {

            $returningString = "`n" + "Id: " + $this.id + "`n" +
                               "Login: " + $this.login + "`n" +
                               "NodeId: " + $this.nodeId + "`n" +
                               "Avatar: " + $this.avatar + "`n" +
                               "Email: " + $this.email + "`n" +
                               "Bio: " + $this.bio + "`n" +
                               "Profile: " + $this.profile + "`n" +
                               "Type: " + $this.type + "`n" +
                               "Name: " + $this.name + "`n" +
                               "Blog: " +  $this.blog + "`n" +
                               "Location: " +  $this.location + "`n" +
                               "Is hireable ? " + $this.isHireable + "`n" +
                               "Company: " + $this.company + "`n" +
                               "Public repos count: " + $this.publicReposCount + "`n" +
                               "Followers count: " + $this.followersCount + "`n" +
                               "Following count: " + $this.followingCount + "`n" + "`n"

                               $returningString += "-----------------" + "Repositories" + "-----------------" + "`n"

                               foreach($repository in $this.repositories) {

                                    $returningString += $repository.ToString() 
                               }

                               $returningString += "-----------------" + "Followers" + "-----------------" + "`n"

                               $returningString += "-----------------" + "Following" + "-----------------" + "`n"

                               $returningString += "-----------------" + "Organizations" + "-----------------" + "`n"

                               $returningString += "-----------------" + "Events" + "-----------------" + "`n"

                               $returningString += "`n"

        # Else (an error occurs)...
        } Else {

            $returningString = $this.error.ToString()
        }

        return $returningString
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

    # 'isHireable' attribute getter...
    [bool] getIsHireable()
    {
        return $this.isHireable
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

    # 'profile' attribute getter...
    [string] getProfile()
    {
        return $this.profile
    }

    # 'login' attribute getter...
    [string] getLogin()
    {
        return $this.login
    }

    # 'error' attribute getter...
    [GitHubError] getGitHubError()
    {
        return $this.error
    }

    # 'company' attribute getter...
    [string] getCompany()
    {
        return $this.company
    }

    # 'email' attribute getter...
    [string] getEmail()
    {
        return $this.email
    }

    # 'bio' attribute getter...
    [string] getBio()
    {
        return $this.bio
    }

    # 'twitter' attribute getter...
    [string] getTwitter()
    {
        return $this.twitter
    }

    # 'repositories' attribute getter...
    [System.Array] getRepositories()
    {
        return $this.repositories
    }
}