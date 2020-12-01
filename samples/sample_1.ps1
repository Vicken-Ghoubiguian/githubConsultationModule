Using module ..\usedModules\Repository.psm1

$currentRepository = [Repository]::new("Vicken-Ghoubiguian","opencv")
$currentRepository.ToString()

Write-Host "`n" "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" "`n"

$anotherCurrentRepository = [Repository]::new("opencv", "Vicken-Ghoubiguian")
$anotherCurrentRepository.ToString()