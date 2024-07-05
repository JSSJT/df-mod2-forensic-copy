<#
This file will look for the presence of an 'copy-hash' subfolder in the working directory and create one if it doesn't exist.

It will then create a hash of each file in the evidence-copy subfolder of the working directory

Each copied file gets "hash_" prepended to the beginning of it.

#>



#Set the subfolder name, create the path string
$hashfolderName = "copy-hash"
$folderPath = Join-Path -Path $PWD -ChildPath $hashfolderName

#If the copy-hash folder exists already, skip creating one, otherwise make a subfolder
if (Test-Path -Path $folderPath -PathType Container) {
    Write-Output ""
    Write-Output " copy-hash subfolder exists, exiting..."
    Write-Output ""
    exit 0
} else {
    Write-Output ""
    Write-Output "copy hash subfolder does not exist, creating:"
    New-Item -Path $folderPath -ItemType Directory
    Write-Output ""
    Write-Output "done."
}

Write-Output ""
Write-Output "Getting Hash Values of copies"
Write-Output ""


#Set the evidence-copy subfolder name, create the path string
$copyfolderName = "evidence-copy"
$copyfolderPath = Join-Path -Path $PWD -ChildPath $copyfolderName


#Run through a loop for each file in the evidence-copy folder
#create a SHA256 hash for each file, name the file according to its evidence filename, prepended with "hash_" in the copy-hash subfolder
$filelist = Get-ChildItem -Path $copyfolderPath -File -Recurse
foreach ($file in $filelist){
    $activeFileName = $file.Name
    $outputFileName = "hash_${activeFileName}"
    Get-FileHash -Path $file.FullName -Algorithm SHA256 | Select-Object -ExpandProperty Hash |Out-File $folderPath\$outputFileName
}