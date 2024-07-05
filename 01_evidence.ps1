<#
This file will look for the presence of an 'evidence' subfolder in the working directory and create one if it doesn't exist.

It will then create 5 .txt files, each containing single ASCII character starting from 'A'

#>


#Set the subfolder name, create the path string
$evidencefolderName = "evidence"
$folderPath = Join-Path -Path $PWD -ChildPath $evidencefolderName

#set an upper bounds for the loop below.
$upperbound = 5


#If the evidence folder exists already, skip creating one, otherwise make a subfolder
if (Test-Path -Path $folderPath -PathType Container) {
    Write-Output ""
    Write-Output " evidence subfolder exists, exiting..."
    Write-Output ""
    exit 0
} else {
    Write-Output ""
    Write-Output "evidence subfolder does not exist, creating:"
    New-Item -Path $folderPath -ItemType Directory
    Write-Output ""
    Write-Output "done."
}

#run the the loop <upperbounds> times, and add an ASCII character of 65+i.  This starts at 65 ("A") and goes up.
Set-Location .\evidence
for ($i = 0; $i -lt $upperbound; $i++){
    $filename = "text_${i}.txt" 
    New-Item -ItemType File -Name $filename
    $character = [char]::ConvertFromUtf32(65+$i)
    Add-Content -Path $filename -Value $character
}

#navigate back out of the subfolder to the previous working folder
Set-Location ..
Write-Output ""
Write-Output "Evidence complete.  Exiting..."
