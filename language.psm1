# Definition of the Language Powershell class to define the current language in a repository from the GitHub API...
class Language {

    # All attributes of the Language class...
    hidden [string]$name
    hidden [int]$value
    hidden [int]$totalValue

    # Language class constructor with all required parameters for all class attributes...
    Language([string]$name, [int]$value, [int]$totalValue)
    {
        $this.name = $name
        $this.value = $value
        $this.totalValue = $totalValue
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
        return ($this.value * 100)/$this.totalValue
    }

    # 'totalValue' attribute getter...
    [int] getTotalValue()
    {
        return $this.totalValue
    }
}