<#


#>

Using module .\usedModules\repository.psm1
Using module .\usedModules\user.psm1

# Definition of the function 'getUserFromLogin' which returns the gitHub user identified by his login...
function getUserFromLogin {

    # Definition of the only parameter of this function, the user's login ...
    param (
        [string]$wishedLogin
    )

    # Returns the instance of the newly created User class from the login... 
    return [User]::new($wishedLogin)
}

#
function getAllReposFromOwner {

    #
    param (
        [user]$owner
    )

}

#
function getAllReposFromLogin {

    #
    param (
        [string]$userLogin
    )

    # Extract all the data relating to all the repositories of the desired user from the received JSON ...
    $githubGetReposURL = "https://api.github.com/users/" + $wishedUserLogin + "/repos"
    $githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get
    $githubReposRequestsContent = $githubReposRequest.Content
    $githubReposRequestsJSONContent = @"
               
$githubReposRequestsContent
"@
    $githubReposRequestsResult = ConvertFrom-Json -InputObject $githubReposRequestsJSONContent
}

#
function getAllReposFromOwner {

    #
    param (
        [user]$owner
    )

    # Extract all the data relating to all the repositories of the desired user from the received JSON ...
    $githubGetReposURL = "https://api.github.com/users/" + $wishedUserLogin + "/repos"
    $githubReposRequest = Invoke-WebRequest -Uri $githubGetReposURL -Method Get
    $githubReposRequestsContent = $githubReposRequest.Content
    $githubReposRequestsJSONContent = @"
               
$githubReposRequestsContent
"@
    $githubReposRequestsResult = ConvertFrom-Json -InputObject $githubReposRequestsJSONContent
}