Using module .\usefulClassesAndObjects\gitHubError.psm1

# Definition of the Commit Powershell class to define a repository's commit from the GitHub API...
class Commit
{

    # Commit class constructor...
    Commit([string]$wishedUserLogin, [string]$wishedRepositoryName)
    {
        # Create an HTTP request to take all commits of the GitHub repository identified by its name and its owner's login...
        $githubGetCommitsReposURL = "https://api.github.com/repos/" + $wishedUserLogin + "/" + $wishedRepositoryName + "/commits"
    }
}