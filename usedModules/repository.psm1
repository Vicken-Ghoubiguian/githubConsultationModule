Using module .\license.psm1

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
    hidden [License]$license

    hidden [string]$mainLanguage
    hidden [System.Array]$allLanguages

    # Repository class constructor...
    Repository([string]$wishedUserLogin)
    {
        
    }

    #
    [int] getId()
    {
        return $this.id
    }

    #
    [string] getNodeID()
    {
        return $this.nodeID
    }

    #
    [string] getName()
    {
        return $this.name
    }

    #
    [string] getFullName()
    {
        return $this.fullName
    }

    [bool] getIsPrivate()
    {
        return $this.isPrivate
    }

    #
    [string] getOwnerID()
    {
        return $this.ownerID
    }

    #
    [string] getOwnerLogin()
    {
        return $this.ownerLogin
    }

    #
    [string] getPage()
    {
        return $this.page
    }

    #
    [string] getDescription()
    {
        return $this.description
    }

    #
    [bool] getIsFork()
    {
        return $this.isFork
    }

    #
    [System.Array] getForks()
    {
        return $this.forks
    }

    #
    [System.Array] getContributors()
    {
        return $this.contributors
    }

    #
    [System.Array] getSubscribers()
    {
        return $this.subscribers
    }

    #
    [License] getLicense()
    {
        return $this.license
    }

    #
    [string] getMainLanguage()
    {
        return $this.mainLanguage
    }

    #
    [System.Array] getAllLanguages()
    {
        return $this.allLanguages
    }
}