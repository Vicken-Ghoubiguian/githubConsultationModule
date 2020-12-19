# Importation of the 'License' module...
Using module ..\usefulClassesAndObjects\license.psm1

# Get all licenses available in GitHub and put them in the "licensesArray" array...
$licensesArray = [License]::listAllDefinedLicenses()

# Browse the array implemented previously and display each branch...
foreach($license in $licensesArray) {

    $license.ToString()
}