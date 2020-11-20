# Definition of the User Powershell class to define a user from the GitHub API...
class User
{

    # All attributes of the User class...
    hidden [string]$login
    hidden [string]$id
    hidden [string]$avatarURL
    hidden [string]$htmlURL
    hidden [string]$type
    hidden [string]$name
    hidden [string]$blogURL
    hidden [string]$location
    hidden [bool]$isHireable
    hidden [int]$publicReposCount
    hidden [int]$followersCount
    hidden [int]$followingCount


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
        $this.login =$githubUserRequestsResult.login
        $this.id = $githubUserRequestsResult.id
        $this.avatarURL = $githubUserRequestsResult.avatar_url
        $this.htmlURL = $githubUserRequestsResult.html_url
        $this.type = $githubUserRequestsResult.type
        $this.name = $githubUserRequestsResult.name
        $this.blogURL = $githubUserRequestsResult.blog
        $this.location = $githubUserRequestsResult.location
        $this.isHireable = $githubUserRequestsResult.hireable
        $this.publicReposCount = $githubUserRequestsResult.public_repos
        $this.followersCount = $githubUserRequestsResult.followers
        $this.followingCount = $githubUserRequestsResult.following
    }

    # 'followingCount' attribute getter
    [int] getFollowingCount()
    {
        return $this.followingCount
    }

    # 'followersCount' attribute getter
    [int] getFollowersCount()
    {
        return $this.followersCount
    }

    # 'publicReposCount' attribute getter
    [int] getPublicReposCount()
    {
        return $this.publicReposCount
    }

    # 'isHireable' attribute getter
    [bool] getIsHireable()
    {
        return $this.isHireable
    }

    # 'id' attribute getter
    [string] getId()
    {
        return $this.id
    }

    # 'blogURL' attribute getter
    [string] getBlogURL()
    {
        return $this.blogURL
    }

    # 'name' attribute getter
    [string] getName()
    {
        return $this.name
    }

    # 'avatarURL' attribute getter
    [string] getAvatarURL()
    {
        return $this.avatarURL
    }

    # 'type' attribute getter
    [string] getType()
    {
        return $this.type
    }

    # 'location' attribute getter
    [string] getLocation()
    {
        return $this.location
    }

    # 'htmlURL' attribute getter
    [string] getHtmlURL()
    {
        return $this.htmlURL
    }

    # 'login' attribute getter
    [string] getLogin()
    {
        return $this.login
    }
}