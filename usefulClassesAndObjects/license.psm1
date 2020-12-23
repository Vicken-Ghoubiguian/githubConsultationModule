Using module .\gitHubError.psm1

# Definition of the License Powershell class to define a license from the GitHub API...
class License
{
    
    # All attributes of the License class...
    hidden [string]$key
    hidden [string]$name
    hidden [string]$spdxID
    hidden [string]$licenseURL
    hidden [string]$nodeID

    hidden [System.Array]$permissions
    hidden [System.Array]$conditions
    hidden [System.Array]$limitations

    hidden [string]$description
    hidden [string]$body
    hidden [bool]$isFeatured
    hidden [string]$implementation
    hidden [string]$chooseALicenseURL

    # License class constructor with license key...
    License([string]$wishedKey)
    {
        # Create an HTTP request to take the GitHub license identified by the 'wishedKey' wished key...
        $githubGetLicenseURL = "https://api.github.com/licenses/" + $wishedKey

        # Bloc we wish execute to get all informations about the wished license...
        try {

            #
            $githubLicenseRequest = Invoke-WebRequest -Uri $githubGetLicenseURL -Method Get
            $githubLicenseRequestsContent = $githubLicenseRequest.Content
            $githubLicenseRequestsJSONContent = @"
               
$githubLicenseRequestsContent
"@
            $githubLicenseRequestsResult = ConvertFrom-Json -InputObject $githubLicenseRequestsJSONContent

            $this.key = $githubLicenseRequestsResult.key
            $this.name = $githubLicenseRequestsResult.name
            $this.spdxID = $githubLicenseRequestsResult.spdx_id
            $this.licenseURL = $githubLicenseRequestsResult.url
            $this.nodeID = $githubLicenseRequestsResult.node_id

            $this.permissions = $githubLicenseRequestsResult.permissions
            $this.conditions = $githubLicenseRequestsResult.conditions
            $this.limitations = $githubLicenseRequestsResult.limitations

            $this.description = $githubLicenseRequestsResult.description
            $this.body = $githubLicenseRequestsResult.body
            $this.isFeatured = $githubLicenseRequestsResult.featured
            $this.implementation = $githubLicenseRequestsResult.implementation
            $this.chooseALicenseURL = $githubLicenseRequestsResult.html_url

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $this.error = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
        }
    }

    # License class constructor with all required parameters for all class attributes...
    License([string]$collectedKey, [string]$collectedName, [string]$collectedSpdxID, [string]$collectedLicenseURL, [string]$collectedNodeID)
    {
        $this.key = $collectedKey.key
        $this.name = $collectedName.name
        $this.spdxID = $collectedSpdxID.spdx_id
        $this.licenseURL = $collectedLicenseURL.url
        $this.nodeID = $collectedNodeID.node_id
    }

    # Create an HTTP request to take all defined licenses from the GitHub...
    static [System.Array] listAllDefinedLicenses()
    {
        # Definition of the 'licensesArray' array which will contain all licenses...
        $licensesArray = [System.Collections.ArrayList]::new()

        # Bloc we wish execute to get all informations about licenses...
        try {

            # Create an HTTP request to take all licenses defined on GitHub...
            $githubGetLicensesURL = "https://api.github.com/licenses"

            # Retrieving and extracting all licenses received from the URL...
            $githubLicensessRequest = Invoke-WebRequest -Uri $githubGetLicensesURL -Method Get
            $licensesJSONObj = ConvertFrom-Json $githubLicensessRequest.Content

            # Browse all the licenses contained in the received JSON and create all the instances of the Powershell class 'License' from this data and add them to the array 'licensesArray'...
            foreach($license in $licensesJSONObj) {

                $licensesArray.Add([License]::new($license.key, $license.name, $license.spdx_id, $license.url, $license.node_id))
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $licensesArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        # Returning the 'licensesArray' array...
        return $licensesArray
    }

    #
    [void] completeAllDatas()
    {
        # Create an HTTP request to take the GitHub license identified by the License current key...
        $githubGetLicenseURL = "https://api.github.com/licenses/" + $this.key

        # 
        $githubLicenseRequest = Invoke-WebRequest -Uri $githubGetLicenseURL -Method Get
        $githubLicenseRequestsContent = $githubLicenseRequest.Content
        $githubLicenseRequestsJSONContent = @"
               
$githubLicenseRequestsContent
"@
        $githubLicenseRequestsResult = ConvertFrom-Json -InputObject $githubLicenseRequestsJSONContent

        # Complete all the other Powershell class 'License' attributes values...
        $this.permissions = $githubLicenseRequestsResult.permissions
        $this.conditions = $githubLicenseRequestsResult.conditions
        $this.limitations = $githubLicenseRequestsResult.limitations
        $this.description = $githubLicenseRequestsResult.description
        $this.body = $githubLicenseRequestsResult.body
        $this.isFeatured = $githubLicenseRequestsResult.featured
        $this.implementation = $githubLicenseRequestsResult.implementation
        $this.chooseALicenseURL = $githubLicenseRequestsResult.html_url
    }

    #
    [String] ToString()
    {
        $returningString = "`n"
        $returningString += "License's name: " + $this.name + "`n"
        $returningString += "SPDX Id of license: " + $this.spdxID + "`n"
        $returningString += "License's URL: " + $this.licenseURL + "`n"
        $returningString += "License's key: " + $this.key + "`n"
        $returningString += "Node Id of license: " + $this.nodeID + "`n"

        If($this.permissions) {

            $returningString += "Permissions: "

            foreach($permissions in $this.permissions) {

                $returningString += $permissions + ", "
            }

            $returningString += "`n"
        }

        If($this.conditions){

            $returningString += "Conditions: "

            foreach($condition in $this.conditions) {

                $returningString += $condition + ", "
            }

            $returningString += "`n"
        }

        If($this.limitations){

            $returningString += "Limitations: "

            foreach($limitation in $this.limitations) {

                $returningString += $limitation + ", "
            }

            $returningString += "`n"
        }

        If($this.description){

            $returningString += "Description: " + $this.description + "`n"
        }

        If($this.body){

            $returningString += "Body: " + $this.body + "`n"
        }

        If($this.isFeatured){

            $returningString += "Is it featured ? " + $this.isFeatured + "`n"
        }

        If($this.implementation){

            $returningString += "Implementation: " + $this.implementation + "`n"
        }

        If($this.chooseALicenseURL){

            $returningString += "'Choose a license' URL: " + $this.chooseALicenseURL + "`n"
        }

        return $returningString
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

    # 'permissions' attribute getter...
    [System.Array] getPermissions()
    {
        return $this.permissions
    }

    # 'conditions' attribute getter...
    [System.Array] getConditions()
    {
        return $this.conditions
    }

    # 'limitations' attribute getter...
    [System.Array] getLimitations()
    {
        return $this.limitations
    }

    # 'description' attribute getter...
    [string] getDescription()
    {
        return $this.description
    }

    # 'body' attribute getter...
    [string] getBody()
    {
        return $this.body
    }

    # 'isFeatured' attribute getter...
    [bool] getISFeatured()
    {
        return $this.isFeatured
    }

    # 'implementation' attribute getter...
    [string] getImplementation()
    {
        return $this.implementation
    }

    # 'chooseALicenseURL' attribute getter...
    [string] getChooseALicenseURL()
    {
        return $this.chooseALicenseURL
    }
}