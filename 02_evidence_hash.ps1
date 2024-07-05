<#
This file will look for the presence of an 'evidence-hash' subfolder in the working directory and create one if it doesn't exist.

It will then create hash files from the contents of the evidence subfolder from the main working directory.

Each hash file gets "hash_" prepended to the beginning of it.

#>



#Set the subfolder name, create the path string
$hashfolderName = "evidence-hash"
$folderPath = Join-Path -Path $PWD -ChildPath $hashfolderName

#If the hash folder exists already, skip creating one, otherwise make a subfolder
if (Test-Path -Path $folderPath -PathType Container) {
    Write-Output ""
    Write-Output " evidence-hash subfolder exists, exiting..."
    Write-Output ""
    exit 0
} else {
    Write-Output ""
    Write-Output "hash subfolder does not exist, creating:"
    New-Item -Path $folderPath -ItemType Directory
    Write-Output ""
    Write-Output "done."
}


Write-Output ""
Write-Output "Getting Hash Values"
Write-Output ""


#Set the evidence subfolder name, create the path string
$evidencefolderName = "evidence"
$evidencefolderPath = Join-Path -Path $PWD -ChildPath $evidencefolderName

#Run through a loop for each file in the evidence folder
#create a SHA256 hash for each file, name the file according to its evidence filename, prepended with "hash_" in the hash subfolder
$filelist = Get-ChildItem -Path $evidencefolderPath -File -Recurse
foreach ($file in $filelist){
    $activeFileName = $file.Name
    $outputFileName = "hash_${activeFileName}"
    Get-FileHash -Path $file.FullName -Algorithm SHA256 | Select-Object -ExpandProperty Hash |Out-File $folderPath\$outputFileName
}