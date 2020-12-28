Using module ..\usefulClassesAndObjects\emojis.psm1

# Call of the famous function 'Get_All_GitHub_Icons'...
$allEmojis = Get_All_GitHub_Icons

#
foreach($emoji in $allEmojis.GetEnumerator()) {

    Write-Host "$($emoji.Name): $($emoji.Value)"
}