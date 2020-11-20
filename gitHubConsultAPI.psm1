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
}