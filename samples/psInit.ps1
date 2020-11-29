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

$githubGetReposURL = "https://api.github.com/repos/Vicken-Ghoubiguian/opencv/languages"

$githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get

$jsonObj = ConvertFrom-Json $githubReposRequest.Content

$hash = @{}
$finalHash = @{}
$totalValue = 0
foreach($property in $jsonObj.PSObject.Properties) {

    $hash[$property.Name] = $property.Value
    $totalValue = $totalValue + $property.Value
}

foreach($key in $hash.Keys) {

    $percentage = ($hash[$key] * 100)/$totalValue

    $finalHash.Add($key, [Math]::Round($percentage, 1))
}