# df-mod2-forensic-copy


# Repo for powershell automating file copying

## This repo runs in 5 scripts:
- Evidence is created in 5 .txt files
- Evidence hash values are created for each file within the evidence folder
- Evidence files are copied to another subfolder
- Evidence copy files get hash values created for each file in the copy folder
- The hash values are compared between the original hashes and the copy file hashes


## Run the Scripts in order of their numerical prefix.


There are a thousand exceptions I could check for.

The scripts will really only look to see that the folders aren't pre-existing (meaning they've already been run).
If the subfolders already exist, the respective script will stop execution.  

The 05_verify_integrity script will run regardless.  If you have mismatching files/file counts between the two folders, you'd end up with an error, which would be a clear indicator the contents of the two folders are not identical.

## The presence of the folders are there for assignment grading.  If downloading to run/verify locally, delete the folders-- the scripts will create them each time.  Otherwise the scripts will not execute as they'll assume the files already exist...
