<#
This file will look for the presence of an 'evidence-copy' subfolder in the working directory and create one if it doesn't exist.

It will then create a copy of each file in the evidence subfolder of the working directory

Each copied file gets "copy_" prepended to the beginning of it.

#>



#Set the subfolder name, create the path string
$subfolderName = "evidence-copy"
$folderPath = Join-Path -Path $PWD -ChildPath $subfolderName

#If the copy folder exists already, skip creating one, otherwise make a subfolder
if (Test-Path -Path $folderPath -PathType Container) {
    Write-Output ""
    Write-Output " evidence-copy subfolder exists, exiting..."
    Write-Output ""
    exit 0
} else {
    Write-Output ""
    Write-Output "copy subfolder does not exist, creating:"
    New-Item -Path $folderPath -ItemType Directory
    Write-Output ""
    Write-Output "done."
}


Write-Output ""
Write-Output "Copying Evidence files"
Write-Output ""

#Set the evidence subfolder name, create the path string
$evidencefolderName = "evidence"
$evidencefolderPath = Join-Path -Path $PWD -ChildPath $evidencefolderName


#Run through a loop for each file in the evidence folder
#create a copy of each file, name the file according to its evidence filename, prepended with "copy_" in the copy subfolder
$filelist = Get-ChildItem -Path $evidencefolderPath -File -Recurse
foreach ($file in $filelist){
    $activeFileName = $file.Name
    $outputFileName = "copy_${activeFileName}"
    Copy-Item -Path $file.FullName -Destination $folderPath\$outputFileName
}