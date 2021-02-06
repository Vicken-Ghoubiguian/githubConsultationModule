# Importation of the 'GitHubError' module...
Using module .\gitHubError.psm1

# Definition of the Language Powershell class to define the current language in a repository from the GitHub API...
class Language
{
    # All attributes of the Language class...
    hidden [string]$name
    hidden [int]$value
    hidden [int]$totalValue
    hidden [float]$percentage

    # Language class constructor with all required parameters for all class attributes...
    Language([string]$name, [int]$value, [int]$totalValue)
    {
        $this.name = $name
        $this.value = $value
        $this.totalValue = $totalValue

        #
        $this.percentage = ($value * 100)/$totalValue
    }

    # Definition of a static function to put all languages from a user and a repository identified respectively by its login and its name inside an array...
    static [System.Array] listAllLanguages([string]$wishedLogin, [string]$wishedRepos)
    {
        # Definition of the 'languagesArray' array which will contain all languages of the wished 'wishedRepos' repo from the wished 'wishedLogin' user...
        $languagesArray = [System.Collections.ArrayList]::new()

        # Bloc we wish execute to get all informations about langauges...
        try {

            # Create an HTTP request to take all the languages and their respective proportions used in the GitHub repository identified by its name and its owner's login...
            $githubGetLanguagesReposURL = "https://api.github.com/repos/" + $wishedLogin + "/" + $wishedRepos + "/languages"

            # Retrieving and extracting all languages received from the URL...
            $githubLanguagesReposRequest = Invoke-WebRequest -Uri $githubGetLanguagesReposURL -Method Get
            $languagesJSONObj = ConvertFrom-Json $githubLanguagesReposRequest.Content

            # 
            $totalSumValue = 0
            foreach($language in $languagesJSONObj.PSObject.Properties) {

                $totalSumValue = $totalSumValue + $language.Value
            }

            #
            foreach($language in $languagesJSONObj.PSObject.Properties) {

                $languagesArray.add([Language]::new($language.Name, $language.Value, $totalSumValue))
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $languagesArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        # Returning the '$languagesArray' array...
        return $languagesArray
    }

    # Returns the Language current instance as String...
    [String] ToString()
    {
        $returningString =  $this.name + ": " + [Math]::Round($this.percentage, 1) + "%" + "`n"

        return $returningString
    }

    # Returning the module's type as string...
    [string] getModuleType()
    {
        return "Language"
    }

    # 'name' attribute getter...
    [string] getName()
    {
        return $this.name
    }

    # 'value' attribute getter...
    [int] getValue()
    {
        return $this.value
    }

    # 'percentage' calculator getter...
    [float] getPercentage()
    {
        return $this.percentage
    }

    # 'totalValue' attribute getter...
    [int] getTotalValue()
    {
        return $this.totalValue
    }
}