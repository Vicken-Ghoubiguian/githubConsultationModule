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