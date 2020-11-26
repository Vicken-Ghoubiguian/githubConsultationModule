# Definition of the Repository Powershell class to define a repository from the GitHub API...
class Repository
{

    # All attributes of the Repository class...
    hidden [int]$id
    hidden [string]$nodeID
    hidden [string]$name
    hidden [string]$fullName
    hidden [bool]$isPrivate
    hidden [string]$ownerID
    hidden [string]$ownerLogin
    hidden [string]$page
    hidden [string]$description
    hidden [bool]$isFork
    hidden [System.Array]$forks
    hidden [System.Array]$contributors
    hidden [System.Array]$subscribers

    hidden [string]$mainLanguage
    hidden [System.Array]$allLanguages

    # Repository class constructor...
    Repository([string]$wishedUserLogin)
    {
        
    }
}