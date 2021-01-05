# Importation of the 'Repository' module...
Using module ..\repository.psm1

# Definition of a function to get and return the total count of repos posessed by the wished owner...
function Get_Total_Number_Of_Repos {

    # Definition of all parameters : '$ownerLogin' for the wished owner's name, '$branchesExpected' and '$languagesExpected' that are 2 boolean indicators to specifie if we want all branches and languages respectively or not...
    param (
        [string]$ownerLogin
    )

    # Get all repositories from the whished user identified by its login, with all branches and languages if expected, and put them in the "repositoriesArray" array...
    $repositoriesArray = [Repository]::listAllRepositories($ownerLogin.ToString(), $false, $false)

    # Returning the number of repositories that the owner identified by its login...
    return $repositoriesArray.Count
}