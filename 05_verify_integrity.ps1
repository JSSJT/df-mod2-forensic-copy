<#
This file will populate lists for the files in two subfolders:  evidence-hash and copy-hash

It will then compare the hash values of text files in these two folders.

If the two hash values are identical, then the evidence files which were copied in script3 are considered true copies of the original evidence.

#>



Write-Output ""
Write-Output "Comparing hash values..."
Write-Output ""

#Set the subfolder names for the two hash locations, create strings
$hashfolderName = "evidence-hash"
$hashfolderPath = Join-Path -Path $PWD -ChildPath $hashfolderName

$copyfolderName = "copy-hash"
$copyfolderPath = Join-Path -Path $PWD -ChildPath $copyfolderName


#Enumerate a list of each file in the two hash subfolders.
$hashfilelist = Get-ChildItem -Path $hashfolderPath -File
$copyhashfilelist = Get-ChildItem -Path $copyfolderPath -File

#Create lists to hold the two hash files lists
$hashfilenames = New-Object System.Collections.ArrayList
$copyhashfilenames = New-Object System.Collections.ArrayList


# Populate the two lists with the file collections to be compared
foreach ($file in $hashfilelist){
    $hashfilenames.Add($file.FullName)
 
}

foreach ($file in $copyhashfilelist){
    $copyhashfilenames.Add($file.FullName)
 
}


# Run through a loop for each file in the evidence hash folder.  Compare the hash from the evidence with the hash from the copied evidence files created in script4.
for ($i = 0; $i -lt $hashfilenames.Count; $i++){

    #Set a content holder for comparison. Standardize the CRLF characters with RAW and Trim leading and trailing whitespace.
    $hashcontent = (Get-Content -Path $hashfilenames[$i] -Raw)| ForEach-Object { $_.Trim() }
    $copycontent = (Get-Content -Path $copyhashfilenames[$i] -Raw)| ForEach-Object { $_.Trim() }
    
    # Display the file being compared
    Write-Output ""
    Write-Output "Comparing: " $copyhashfilenames[$i]
    Write-Output ""
    Write-Output $hashcontent
    Write-Output $copycontent
    Write-Output ""
    

    #Give feedback if the hash values are equal or not.
    if ($hashcontent -eq $copycontent) {
        Write-Output "Hash values match"
    } else {
        Write-Output "Hash values are incorrect"
    }


}
