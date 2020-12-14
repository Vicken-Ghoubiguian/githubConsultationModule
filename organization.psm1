Using module .\usefulClassesAndObjects\gitHubError.psm1

# Definition of the User Powershell class to define a user from the GitHub API...
class Organization {

    # Repository class constructor with organization login...
    Organization([string]$organizationLogin)
    {
        # Create an HTTP request to take the GitHub organization identified by its name and its owner's login...
        $githubGetReposURL = "https://api.github.com/orgs/" + $organizationLogin
    }
}