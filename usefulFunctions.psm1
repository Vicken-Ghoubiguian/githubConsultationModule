# Importation of the 'GitHubError' module...
Using module .\gitHubError.psm1

# Importation of required modules...
Using module .\repository.psm1
Using module .\language.psm1

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

# Definition of a function to get and return all languages used by a owner (user or organization) with their respective percentage of use calculated...
function Get_All_Languages_Used_By_Owner {

    # Definition of all parameters : '$ownerLogin' for the wished owner's name, '$diminutiveType' for the type of owner and '$withPercentage' for determining which one the percentage value or the number of repos is expected...
    param (
        [string]$ownerLogin,
        [string]$diminutiveType,
        [bool]$withPercentage
    )

    # Definition of 'totalForAllRepos' variable to contain the total of value for the whole owner...
    $totalForAllRepos = 0

    # Definition of the 'languagesHashTable' hash table to contain all languages as keys with their respective total value for the whole owner as values...
    $languagesHashTable = [System.Collections.Hashtable]::new()

    # Definition of the 'returningLanguagesHashTable' hash table to contain all languages as keys with their respective percentage for the whole ower as values...
    $returningLanguagesHashTable = [System.Collections.Hashtable]::new()

    # Getting all repos from the 'ownerLogin' owner which is a 'diminutiveType' (user or organization)...
    $reposArray = [Repository]::listAllRepositories($ownerLogin.ToString(), $diminutiveType.ToString(), $false, $true, $false)

    # If the first element of the '$reposArray' array is of type "GitHubError" so...
    If($reposArray[0].getModuleType() -ne "GitHubError") {

        # Browse the "$reposArray" array to get and treat each element with a foreach loop...
        foreach($repos in $reposArray) {

            # Getting all languages from the current repos...
            $languagesOfRepos = $repos.getLanguages()

            # If the first element of the '$languagesOfRepos' array is not a $null object, so...
            If($languagesOfRepos[0] -ne $null){

                # If the first element of the '$languagesOfRepos' array is not a "GitHubError" object, so...
                If($languagesOfRepos[0].getModuleType() -ne "GitHubError"){

                    # Calculating the total for all repos by adding the first language's one...
                    $totalForAllRepos += $languagesOfRepos[0].getTotalValue()

                    # Browse the "$languagesOfRepos" array to get and treat each element with a foreach loop...
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

        # If the '$withPercentage' is true, so...
        If($withPercentage -eq $true){

            # Browse the whole keys of "$languagesHashTable" array to get and treat each element with a foreach loop...
            foreach($languageName in $languagesHashTable.Keys){

                # Calculating representing percentage for the current language and affectation to it as value...
                $calculatedPercentage = ($languagesHashTable[$languageName] * 100)/$totalForAllRepos

                # Affectation of the "calculatedPercentage" value in the "returningLanguagesHashTable" hash table at the "languageName" key...
                $returningLanguagesHashTable[$languageName] = $calculatedPercentage
            }

        # Else...
        } Else {

            # Affectation of the 'languagesHashTable' hash table to the 'returningLanguagesHashTable' hash table...
            $returningLanguagesHashTable = $languagesHashTable
        }

        # Returning the '$returningLanguagesHashTable' hash table with respective column names...
        return $returningLanguagesHashTable

    # Else...
    } Else {

        # Returning the 'GitHubError' object...
        return $reposArray[0]
    }
}

# Definition of a function to get and return all main languages used by a owner (user or organization) with their respective percentage of use calculated...
function Get_Main_Languages_Used_By_Owner {

    # Definition of all parameters : '$ownerLogin' for the wished owner's name, '$diminutiveType' for the type of owner and '$withPercentage' for determining which one the percentage value or the number of repos is expected...
    param (
        [string]$ownerLogin,
        [string]$diminutiveType,
        [bool]$withPercentage
    )

    # Definition of 'totalOfRepos' variable to contain the total count of repos for the whole owner...
    $totalOfRepos = 0

    # Definition of the 'checkingVariableForMainLanguage' variable to lead some processes...
    $checkingVariableForMainLanguage = ""

    # Definition of the 'languagesArray' hash table to contain all main languages of each project as keys with their respective total value for the whole owner as values...
    $languagesHashTable = [System.Collections.Hashtable]::new()

    # Definition of the 'returningLanguagesHashTable' hash table to contain all main languages of each project as keys with their respective percentage for the whole owner as values...
    $returningLanguagesHashTable = [System.Collections.Hashtable]::new()

    # Getting all repos from the 'ownerLogin' owner which is a 'diminutiveType' (user or organization)...
    $reposArray = [Repository]::listAllRepositories($ownerLogin.ToString(), $diminutiveType.ToString(), $false, $false, $false)

    # Browse the "$reposArray" array to get and treat each element with a foreach loop...
    foreach($repos in $reposArray){

        # If the 'repos' current repos is not a "GitHubError" object, so...
        If($repos -ne $null){

            # If the current repos 'repos' is of type "GitHubError" (and the only element of the 'reposArray' array in this case), so...
            If($repos.getModuleType() -ne "GitHubError"){

                # Incrementing the 'totalOfRepos' variable as the total count of repos for the whole owner...
                $totalOfRepos += 1

                # If the main language of the current repos is empty, so...
                If($repos.getMainLanguage() -eq ""){

                    # Taking all languages of the current repos and assign them in the '$languagesOfRepos' array...
                    $languagesOfRepos = [Language]::listAllLanguages($ownerLogin, $repos.getName())

                    # If the '$languagesOfRepos' array has 0 elements, so...
                    If($languagesOfRepos.Count -gt 0) {

                        # Definition of the 'mainLanguageName' variable which contains the main language's name...
                        $mainLanguageName = ""

                        # Definition of the 'mainLanguagevalue' variable which contains the main language's value...
                        $mainLanguagevalue = 0

                        # Browse the "$languagesOfRepos" array to get and treat each element with a foreach loop...
                        foreach($language in $languagesOfRepos){

                            # If the value contained in the 'mainLanguagevalue' variable is less than the current language's value, so...
                            If($mainLanguagevalue -lt $language.getValue()){

                                # Changing the 'mainLanguageName' value with the current language's name...
                                $mainLanguageName = $language.getName()

                                # Changing the 'mainLanguagevalue' value with the current language's value...
                                $mainLanguagevalue = $language.getValue()
                            }
                        }

                        # So the value contained in the 'mainLanguageName' variable is affected to the 'checkingVariableForMainLanguage' one...
                        $checkingVariableForMainLanguage = $mainLanguageName

                    # Else...
                    } Else {

                        # Assignment of the character string "(unspecified main language)" in the variable "$checkingVariableForMainLanguage"...
                        $checkingVariableForMainLanguage = "(unspecified main language)"
                    }

                # Else...
                } Else {

                    # Assignment of the main language of the current repos in the variable "$checkingVariableForMainLanguage"...
                    $checkingVariableForMainLanguage = $repos.getMainLanguage()
                }

                # If the hash table already contains the 'checkingVariableForMainLanguage' main language's name as key, so...
                If($languagesHashTable.ContainsKey($checkingVariableForMainLanguage)){

                    # Adding the previous value by the value corresponding to the 'checkingVariableForMainLanguage' main language...
                    $languagesHashTable[$checkingVariableForMainLanguage] = $languagesHashTable[$checkingVariableForMainLanguage] + 1

                # Else...
                } Else {

                    # Adding 1 to the current main language while creating a new key...
                    $languagesHashTable[$checkingVariableForMainLanguage] = 1
                }

            # Else...
            } Else {

                # Returning the 'GitHubError' object...
                return $repos
            }
        }
    }

    # If the '$withPercentage' is true, so...
    If($withPercentage -eq $true){

        # Browse the whole keys of "$languagesHashTable" array to get and treat each element with a foreach loop...
        foreach($languageName in $languagesHashTable.Keys){

            # Calculating representing percentage for the current language and affectation to it as value...
            $calculatedPercentage = ($languagesHashTable[$languageName] * 100)/$totalOfRepos

            # Affectation of the "calculatedPercentage" value in the "returningLanguagesHashTable" hash table at the "languageName" key...
            $returningLanguagesHashTable[$languageName] = $calculatedPercentage
        }

    # Else...
    } Else {

        # Affectation of the 'languagesHashTable' hash table to the 'returningLanguagesHashTable' hash table...
        $returningLanguagesHashTable = $languagesHashTable
    }

    # Returning the '$returningLanguagesHashTable' hash table with respective column names...
    return $returningLanguagesHashTable
}

# Definition of a function to count all commits in a repos specified by its name and its owner's login...
function countAllCommitsForSpecificRepository {

    #  Definition of the all parameter: '$ownerLogin' for the wished owner's login and '$reposName' for the repository's name...
    param (
        [string]$ownerLogin,
        [string]$reposName
    )

    # Create an HTTP request to take the participation for the GitHub repository identified by its name and its owner's login...
    $githubParticipationURL = "https://api.github.com/repos/" + $ownerLogin + "/" + $reposName + "/stats/participation"

    # Bloc we wish execute to get all results about the defined HTTP request...
    try {
        
        # Definition of the 'allCommitsCount' variable to get all commits' count...
        $allCommitsCount = 0;

        #
        $githubParticipationRequest = Invoke-WebRequest -Uri $githubParticipationURL -Method Get
        $githubParticipationRequestsContent = $githubParticipationRequest.Content
        $githubParticipationRequestsJSONContent = @"
               
$githubParticipationRequestsContent
"@
        $githubParticipationRequestsResult = ConvertFrom-Json -InputObject $githubParticipationRequestsJSONContent

        # Return the 'allCommitsCount' variable's value...
        return $allCommitsCount

    # Bloc to execute if an System.Net.WebException is encountered...
    } catch [System.Net.WebException] {

        $errorType = $_.Exception.GetType().Name

        $errorMessage = $_.Exception.Message

        $errorStackTrace = $_.Exception.StackTrace

        # Return the newly created GitHubError instance...
        return [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
    }
}