# Importation of the 'License' module...
Using module ..\license.psm1

# Get all licenses available in GitHub and put them in the "licensesArray" array...
$licensesArray = [License]::listAllDefinedLicenses()

# Implementation of a message box that asks a very specific question...
$additionalValuesLicenseBoxResponse = [System.Windows.MessageBox]::Show("Additional data is available for licenses. Do you want them ?", "Confirmation", "YesNo", "info")

# Browse the array implemented previously and display each branch...
foreach($license in $licensesArray) {

    # If the response from previous message box is "Yes"...
    If($additionalValuesLicenseBoxResponse -eq "Yes") {

        $license.completeAllDatas()
    }

    $license.ToString()
}