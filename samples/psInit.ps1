<#

#>

$githubGetUserURL = "https://api.github.com/users/Vicken-Ghoubiguian"

$githubUserRequest = Invoke-WebRequest -Uri $githubGetUserURL -Method Get

$githubUserRequestsContent = $githubUserRequest.Content

$githubUserRequestsJSONContent = @"
               
$githubUserRequestsContent
"@

$githubUserRequestsResult = ConvertFrom-Json -InputObject $githubUserRequestsJSONContent

Write-Host -NoNewLine "------------------------------------------------------"

$githubGetReposURL = "https://api.github.com/users/Vicken-Ghoubiguian/repos"

$githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get

$githubReposRequestsContent = $githubReposRequest.Content

$githubReposRequestsJSONContent = @"
               
$githubReposRequestsContent
"@

$githubReposRequestsResult = ConvertFrom-Json -InputObject $githubReposRequestsJSONContent

Write-Host -NoNewLine "------------------------------------------------------"

$githubGetReposURL = "https://api.github.com/users/Vicken-Ghoubiguian/repos"

$githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get

$githubReposRequestsContent = $githubReposRequest.Content
        
$githubReposRequestsJSONContent = @"
               
$githubReposRequestsContent
"@

$githubReposRequestsResult = ConvertFrom-Json -InputObject $githubReposRequestsJSONContent

Write-Host -NoNewLine "------------------------------------------------------"

$githubGetReposURL = "https://api.github.com/repos/Vicken-Ghoubiguian/weathermodule/languages"

$githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get

$githubReposRequestsContent = $githubReposRequest.Content

$jsonObj = ConvertFrom-Json $githubReposRequestsContent

$hash = @{}

foreach($property in $jsonObj.PSObject.Properties) {

    $hash[$property.Name] = $property.Value
}

$totalValue = 0
foreach($value in $hash.Values) {

    $totalValue = $totalValue + $value

    Write-Host $value
}