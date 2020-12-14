Using module .\repository.psm1

# Definition of the User Powershell class to define a user from the GitHub API...
class User
{

    # All attributes of the User class...
    hidden [string]$login
    hidden [int]$id
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
    hidden [System.Array]$repositories


    # User class constructor...
    User([string]$wishedUserLogin)
    {
        # Extract all the data relating to the desired user from the received JSON ...
        $githubGetUserURL = "https://api.github.com/users/" + $wishedUserLogin
        $githubUserRequest = Invoke-WebRequest -Uri $githubGetUserURL -Method Get
        $githubUserRequestsContent = $githubUserRequest.Content
        $githubUserRequestsJSONContent = @"
                       
$githubUserRequestsContent
"@
        $githubUserRequestsResult = ConvertFrom-Json -InputObject $githubUserRequestsJSONContent

        # Entering the values ​​for all the attributes of the User class...
        $this.login = $githubUserRequestsResult.login
        $this.id = $githubUserRequestsResult.id
        $this.avatar = $githubUserRequestsResult.avatar_url
        $this.profile = $githubUserRequestsResult.html_url
        $this.type = $githubUserRequestsResult.type
        $this.name = $githubUserRequestsResult.name
        $this.blog = $githubUserRequestsResult.blog
        $this.location = $githubUserRequestsResult.location
        $this.isHireable = $githubUserRequestsResult.hireable
        $this.publicReposCount = $githubUserRequestsResult.public_repos
        $this.followersCount = $githubUserRequestsResult.followers
        $this.followingCount = $githubUserRequestsResult.following

        $this.repositories = [Repository]::listAllRepositories($githubUserRequestsResult.login)
    }

    # Returns the User current instance as String...
    [string] ToString()
    {
        return "(" + 
                   "login: " + $this.login + ", " +
                   "id: " + $this.id + ", " +
                   "avatar: " + $this.avatar + ", " +
                   "profile: " + $this.profile + ", " +
                   "type: " + $this.type + ", " +
                   "name: " + $this.name + ", " +
                   "blog: " + $this.blog + ", " +
                   "location: " + $this.location + ", " +
                   "is hireable: " + $this.isHireable + ", " +
                   "public repos count: " + $this.publicReposCount + ", " +
                   "followers count: " + $this.followersCount + ", " +
                   "following count: " + $this.followingCount +  
                ")"
    }

    # Returns, as a boolean, the result of the comparison between 2 instances of the 'User' class...
    [bool] Equals([User] $otherUser)
    {
        If(($this.id -eq $otherUser.id) -and
           ($this.login -eq $otherUser.login) -and
           ($this.name -eq $otherUser.name)) {

            return True

        } Else {
         
            return False
        }
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
}