# LatestCopy
### LatestCopy
### Platform: Windows Powershell v5+
### Description: v2.0.0 of LatestCopy allows the user to create a .zip archive of a Crestron based project, capturing a number of the critical file types for publishing or backing up.
# The Default Search Directory is $env:USERPROFILE\Crestron\ (or C:\Users\USERNAME\Crestron) and can be changed when prompted.
# The Default Destination for a copy is $env:USERPROFILE\Crestron\Temp-PackageProject (or C:\Users\USERNAME\Crestron\Temp-PackageProject) and can be changed when prompted.
# The resulting .zip archive will have the name of the destination folder (e.g. Temp-PackageProject.zip).
# If the file Temp-PackageProject.zip already exists you will be required to move or delete this before continuing (A prompt for deletion and archiving will be given).

### Roadmap (ToDo) ###
# v2.1.0 Add switch statement for build package or archive package
# v2.2.0 Add option for clean and restore (as in create back up copy, then delete contents of vtp/smw folder then restore back up.)
# v3.0.0+ Add and Refactor for alternate file types and/or project senarios.
###
