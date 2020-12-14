Using module .\usefulClassesAndObjects\gitHubError.psm1

# Definition of the User Powershell class to define a user from the GitHub API...
class Organization {

    hidden [GitHubError]$error

    # Repository class constructor with organization login...
    Organization([string]$organizationLogin)
    {
        # Create an HTTP request to take the GitHub organization identified by its name and its owner's login...
        $githubGetReposURL = "https://api.github.com/orgs/" + $organizationLogin

        # Bloc we wish execute to get all informations about the wished organization...
        try {

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $this.error = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
        }
    }
}