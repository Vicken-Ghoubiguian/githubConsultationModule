# Definition of the License Powershell class to define a license from the GitHub API...
class License
{
    
    # All attributes of the License class...
    hidden [string]$key
    hidden [string]$name
    hidden [string]$spdxID
    hidden [string]$licenseURL
    hidden [string]$nodeID

    # License class constructor...
    License([string]$collectedKey, [string]$collectedName, [string]$collectedSpdxID, [string]$collectedLicenseURL, [string]$collectedNodeID)
    {
        $this.key = $collectedKey
        $this.name = $collectedName
        $this.spdxID = $collectedSpdxID
        $this.licenseURL = $collectedLicenseURL
        $this.nodeID = $collectedNodeID
    }

    # 'key' attribute getter...
    [string] getKey()
    {
        return $this.key
    }

    # 'name' attribute getter...
    [string] getName()
    {
        return $this.name
    }

    # 'spdxID' attribute getter...
    [string] getSpdxID()
    {
        return $this.spdxID
    }

    # 'licenseURL' attribute getter...
    [string] getLicenseURL()
    {
        return $this.licenseURL
    }

    # 'nodeID' attribute getter...
    [string] getNodeID()
    {
        return $this.nodeID
    }
}