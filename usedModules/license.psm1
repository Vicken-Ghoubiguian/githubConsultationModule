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
    License([string]$collectedKey, [string]$collectedName, [string]$collectedSpdxID, [string]$collectedLicense, [string]$collectedNodeID)
    {
        $this.key = $collectedKey
        $this.name = $collectedName
        $this.spdxID = $collectedSpdxID
        $this.licenseURL = $collectedLicense
        $this.nodeID = $collectedNodeID
    }
}