# Definition of the User Powershell class to define a user from the GitHub API...
class User
{

    #
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


    # User class constructor...
    User([string]$login)
    {
        #
        $githubGetUserURL = "https://api.github.com/users/Vicken-Ghoubiguian"
        $githubUserRequest = Invoke-WebRequest -Uri $githubGetUserURL -Method Get
        $githubUserRequestsContent = $githubUserRequest.Content
        $githubUserRequestsJSONContent = @"
                       
$githubUserRequestsContent
"@
        $githubUserRequestsResult = ConvertFrom-Json -InputObject $githubUserRequestsJSONContent

        #
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
    }
}