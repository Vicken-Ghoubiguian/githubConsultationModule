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

    # 'id' attribute getter...
    [int] getId()
    {
        return $this.id
    }

    # 'nodeID' attribute getter...
    [string] getNodeID()
    {
        return $this.nodeID
    }

    # 'name' attribute getter...
    [string] getName()
    {
        return $this.name
    }

    # 'fullName' attribute getter...
    [string] getFullName()
    {
        return $this.fullName
    }

    # 'isPrivate' attribute getter...
    [bool] getIsPrivate()
    {
        return $this.isPrivate
    }

    # 'ownerID' attribute getter...
    [string] getOwnerID()
    {
        return $this.ownerID
    }

    # 'ownerLogin' attribute getter...
    [string] getOwnerLogin()
    {
        return $this.ownerLogin
    }

    # 'page' attribute getter...
    [string] getPage()
    {
        return $this.page
    }

    # 'description' attribute getter...
    [string] getDescription()
    {
        return $this.description
    }

    # 'isFork' attribute getter...
    [bool] getIsFork()
    {
        return $this.isFork
    }

    # 'forks' attribute getter...
    [System.Array] getForks()
    {
        return $this.forks
    }

    # 'contributors' attribute getter...
    [System.Array] getContributors()
    {
        return $this.contributors
    }

    # 'subscribers' attribute getter...
    [System.Array] getSubscribers()
    {
        return $this.subscribers
    }

    # 'license' attribute getter...
    [License] getLicense()
    {
        return $this.license
    }

    # 'mainLanguage' attribute getter...
    [string] getMainLanguage()
    {
        return $this.mainLanguage
    }

    # 'allLanguages' attribute getter...
    [System.Array] getAllLanguages()
    {
        return $this.allLanguages
    }
}