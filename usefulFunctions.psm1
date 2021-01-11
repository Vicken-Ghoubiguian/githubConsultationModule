# Importation of the 'GitHubError' module...
Using module .\gitHubError.psm1

# Importation of the 'User' module...
Using module .\user.psm1

# Definition of a function to get and return all emojis defined in GitHub in an associative array...
function Get_All_GitHub_Emojis {

    # Definition of the 'allEmojis' variable with the default value as 'null'...
    $allEmojis = $null

    # Create an HTTP request to take all GitHub emojis...
    $githubGetAllGitHubEmojisURL = "https://api.github.com/emojis"

    # Bloc we wish execute to get all informations about GitHub emojis...
    try {
        
        # Retrieving and extracting all emojis received from the URL...
        $githubAllGitHubEmojisRequest = Invoke-WebRequest -Uri $githubGetAllGitHubEmojisURL -Method Get
        $allGitHubEmojisJSONObj = ConvertFrom-Json $githubAllGitHubEmojisRequest.Content

        # Affectation of an associative array to the 'allEmojis' variable...
        $allEmojis = @{}

        # Go through the 'foreach' loop to take all the emojis contained in the 'allGitHubEmojisJSONObj' result ...
        foreach($emoji in $allGitHubEmojisJSONObj.PSObject.Properties) {

            # Affectation of the current emoji to the 'allEmojis' associative array...
            $allEmojis[$emoji.Name] = $emoji.Value
        }

    # Bloc to execute if an System.Net.WebException is encountered...
    } catch [System.Net.WebException] {

        $errorType = $_.Exception.GetType().Name

        $errorMessage = $_.Exception.Message

        $errorStackTrace = $_.Exception.StackTrace

        # Affectation of the newly created GitHubError instance to the 'allEmojis' variable...
        $allEmojis = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
    }

    # returning the '$allEmojis' variable...
    return $allEmojis
}

# Definition of a function to get and return the total count of public repos posessed by the wished user...
function Get_Total_Number_Of_Public_Repos {

   # Definition of the only parameter : '$userLogin' for the wished owner's name...
    param (
        [string]$userLogin
    )

    # Creating the 'User' PowerShell class instance from it's own login...
    $currentUser = [User]::new($userLogin.ToString())

    # Returning the exact number of public repos count...
    return $currentUser.getPublicReposCount()
}

#
function Get_All_Languages_Used_By_User {

    # Definition of the only parameter : '$userLogin' for the wished owner's name...
    param (
        [string]$userLogin
    )

    # Creation of the current user from the 'User' PowerShell class and getting all of its repos and languages...
    $currentUser = [User]::new($userLogin, $false, $true, $false, $true, $false, $false)

    #

}