#
class Language {

    #
    hidden [string]$name
    hidden [int]$value
    hidden [int]$totalValue

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