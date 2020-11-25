# Definition of the Repository Powershell class to define a repository from the GitHub API...
class Repository
{

    # Repository class constructor...
    Repository([string]$wishedUserLogin)
    {
        # Extract all the data relating to all the repositories of the desired user from the received JSON ...
        $githubGetReposURL = "https://api.github.com/users/" + $wishedUserLogin + "/repos"
        $githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get
        $githubReposRequestsContent = $githubReposRequest.Content
        $githubReposRequestsJSONContent = @"
               
$githubReposRequestsContent
"@
        $githubReposRequestsResult = ConvertFrom-Json -InputObject $githubReposRequestsJSONContent
    }
}