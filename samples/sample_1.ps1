Using module ..\usedModules\Repository.psm1

$currentRepository = [Repository]::new("Vicken-Ghoubiguian","opencv")

Write-Host "-----------------" "Presentation" "-----------------"

Write-Host "Id: " $currentRepository.getId()
Write-Host "Node Id: " $currentRepository.getNodeID()
Write-Host "Name: " $currentRepository.getName()
Write-Host "Full name: " $currentRepository.getDescription()
Write-Host "Page: " $currentRepository.getPage()
Write-Host "Is it private ? " $currentRepository.getIsPrivate()
Write-Host "Is it a fork ? " $currentRepository.getIsFork()
Write-Host "Is it archived ? " $currentRepository.getIsArchived()

Write-Host ""

Write-Host "-----------------" "Owner" "-----------------"

Write-Host "Owner ID: " $currentRepository.getOwnerID()
Write-Host "Owner login: " $currentRepository.getOwnerLogin()

Write-Host ""

Write-Host "-----------------" "Languages" "-----------------"

Write-Host "Main language: " $currentRepository.getMainLanguage()

Write-Host ""

foreach($language in $currentRepository.getAllLanguages().Keys) {

    Write-Host $language ": " $currentRepository.getAllLanguages()[$language] "%"
}

Write-Host ""

Write-Host "-----------------" "License" "-----------------"

Write-Host "Name: " $currentRepository.getLicense().getName()
Write-Host "SPDX Id: " $currentRepository.getLicense().getSpdxID()
Write-Host "License URL: " $currentRepository.getLicense().getLicenseURL()
Write-Host "Key: " $currentRepository.getLicense().getKey()
Write-Host "Node Id: " $currentRepository.getLicense().getNodeID()

Write-Host ""

Write-Host "-----------------" "Contributors" "-----------------"

Write-Host "-----------------" "Subscribers" "-----------------"

Write-Host "-----------------" "Links" "-----------------"

Write-Host "Git URL: " $currentRepository.getGitURL()
Write-Host "ssh URL: " $currentRepository.getSshURL()
Write-Host "svn URL: " $currentRepository.getSvnURL()
Write-Host "home page: " $currentRepository.getHomePage()

Write-Host ""