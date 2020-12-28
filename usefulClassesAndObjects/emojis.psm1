Using module .\usefulClassesAndObjects\gitHubError.psm1

#
function Get-All-GitHub-Icons {

    #
    $allEmojis = $null

    # Create an HTTP request to take all GitHub icons...
    $githubGetAllGitHubIconsURL = "https://api.github.com/emojis"

    # Bloc we wish execute to get all informations about GitHub emojis...
    try {
        
    # Bloc to execute if an System.Net.WebException is encountered...
    } catch [System.Net.WebException] {

        $errorType = $_.Exception.GetType().Name

        $errorMessage = $_.Exception.Message

        $errorStackTrace = $_.Exception.StackTrace

        $allEmojis = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
    }

    # returning the '$allEmojis' variable...
    return $allEmojis
}