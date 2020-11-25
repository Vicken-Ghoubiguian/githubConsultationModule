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

}