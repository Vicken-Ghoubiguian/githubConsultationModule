# Importation of the 'GitHubError' module...
Using module .\gitHubError.psm1

# Importation of required modules...
Using module .\repository.psm1

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
    $currentUser = [User]::new($userLogin.ToString(), $false, $false, $false, $false, $false, $false)

    # Returning the exact number of public repos count...
    return $currentUser.getPublicReposCount()
}

#
function Get_All_Languages_Used_By_User {

    # Definition of the only parameter : '$ownerLogin' for the wished owner's name and '$diminutiveType' for the type of owner...
    param (
        [string]$ownerLogin,
        [string]$diminutiveType
    )

    # Definition of 'totalForAllRepos' variable to contain the total of value for the whole user...
    $totalForAllRepos = 0

    # Definition of the 'languagesHashTable' hash table to contain all languages as keys with their respective total value for the whole user as values...
    $languagesHashTable = [System.Collections.Hashtable ]::new()

    # Getting all repos from the 'ownerLogin' owner which is a 'diminutiveType' (user or organization)...
    $reposArray = [Repository]::listAllRepositories($ownerLogin.ToString(), $diminutiveType.ToString(), $false, $true)

    # If the first element of the '$reposArray' array is of type "GitHubError" so...
    If($reposArray[0].getModuleType() -ne "GitHubError") {

        #
        foreach($repos in $reposArray) {

            # Getting all languages from the current repos...
            $languagesOfRepos = $repos.getLanguages()

            # If the first element of the '$languagesOfRepos' array is not a $null object, so...
            If($languagesOfRepos[0] -ne $null){

                # If the first element of the '$languagesOfRepos' array is not a "GitHubError" object, so...
                If($languagesOfRepos[0].getModuleType() -ne "GitHubError"){

                    # Calculating the total for all repos by adding the first language's one...
                    $totalForAllRepos += $languagesOfRepos[0].getTotalValue()

                    #
                    foreach($language in $languagesOfRepos){

                        # If the current language is not a "GitHubError" object, so...
                        If($language -ne $null){

                            # If the hash table already contains the current language's name as key, so...
                            If($languagesHashTable.ContainsKey($language.getName())){

                                # Adding the previous value by the value corresponding to the current language...
                                $languagesHashTable[$language.getName()] = $languagesHashTable[$language.getName()] + $language.getValue()

                            # Else...
                            } Else {

                                # Adding the value corresponding to the current language while creating a new key...
                                $languagesHashTable[$language.getName()] = $language.getValue()
                            }
                        }
                    }

                # Else...
                } Else {

                    # Returning the 'GitHubError' object...
                    return $languagesOfRepos[0]
                }
            }
        }

        #
        foreach($languageName in $languagesHashTable.Keys){

            ($languagesHashTable[$languageName] * 100)/$totalForAllRepos
            # Calculating representing percentage for the current language and affectation to it as value...
            Write-Host $languageName " : " [Math]::Round($calculatedPercentage, 1)
        }

        Write-Host "The thing is..." $totalForAllRepos

        # Returning the '$languagesHashTable' hash table
        return $languagesHashTable

    # Else...
    } Else {

        # Returning the 'GitHubError' object...
        return $reposArray[0]
    }
}