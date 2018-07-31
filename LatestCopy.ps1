### LatestCopy
### Platform: Windows Powershell v5+
### Public Release: v2.0.1
### Date: 25/07/2018
### Description: v2.0.0 of LatestCopy allows the user to create a .zip archive of a Crestron based project, capturing a number of the critical file types for publishing or backing up.
# The Default Search Directory is $env:USERPROFILE\Crestron\ (or C:\Users\USERNAME\Crestron) and can be changed when prompted.
# The Default Destination for a copy is $env:USERPROFILE\Crestron\Temp-PackageProject (or C:\Users\USERNAME\Crestron\Temp-PackageProject) and can be changed when prompted.
# The resulting .zip archive will have the name of the destination folder (e.g. Temp-PackageProject.zip).
# If the file Temp-PackageProject.zip already exists you will be required to move or delete this before continuing (A prompt for deletion and archiving will be given).
# v2.0.1 Added *.c3prj folder

### Roadmap (ToDo) ###
# v2.1.0 Add switch statement for build package or archive package
# v2.2.0 Add option for clean and restore (as in create back up copy, then delete contents of vtp/smw folder then restore back up.)
# v3.0.0+ Add and Refactor for alternate file types and/or project senarios.
###



$defaultSearchDirectory = "$env:USERPROFILE\Crestron\" #Default Directory where this script is placed and run from ["..\" = one directory path above current directory.].

$consolePromptSearchDirectory = Read-Host "Please enter the directory where you wish to begin a search for project files for packaging and press enter. [$($defaultSearchDirectory)]"
    $consolePromptSearchDirectory = $($defaultSearchDirectory,$consolePromptSearchDirectory)[[bool]$consolePromptSearchDirectory]

$defaultPackageDirectory = "$env:USERPROFILE\Crestron\Temp-PackageProject"

$consolePromptPackageDirectory = Read-Host "Please enter the directory where you wish to copy the project files to and press enter. [$($defaultPackageDirectory)]"
    $consolePromptPackageDirectory = $($defaultPackageDirectory,$consolePromptPackageDirectory)[[bool]$consolePromptPackageDirectory]
   
$smwDestinationDirectory = "$consolePromptPackageDirectory\smw\" #Destination of program files
$vtpDestinationDirectory = "$consolePromptPackageDirectory\vtp\" #Destination of touch panel files

        New-Item "$defaultPackageDirectory" -Type container -Force

        # Capture latest file of type "*_compiled.zip" and copy to specified destination 
        $files = Get-ChildItem $consolePromptSearchDirectory -filter "*_complied.zip" -rec
            $files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} # Outputs file information to console
        $files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} | Copy-Item -Destination (New-Item "$smwDestinationDirectory\" -Type container -Force) -Force

        # Capture latest file of type "*_archive.zip" and copy to specified destination
        $files = Get-ChildItem $consolePromptSearchDirectory -filter "*_archive.zip" -rec
            #$files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} # Outputs file information to console
        $files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} | Copy-Item -Destination (New-Item "$smwDestinationDirectory\" -Type container -Force) -Force
        
        # Capture latest file of type "*.lpz" and copy to specified destination
        $files = Get-ChildItem $consolePromptSearchDirectory -filter "*.lpz" -rec
            #$files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} # Outputs file information to console
        $files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} | Copy-Item -Destination (New-Item "$smwDestinationDirectory\" -Type container -Force) -Force
        
        # Capture latest file of type "*_Project.zip" and copy to specified destination
        $files = Get-ChildItem $consolePromptSearchDirectory -filter "*_Project.zip" -rec
            #$files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} # Outputs file information to console
        $files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} | Copy-Item -Destination (New-Item "$vtpDestinationDirectory\" -Type container -Force) -Force

        # Capture latest file of type "*.vta" and copy to specified destination
        $files = Get-ChildItem $consolePromptSearchDirectory -filter "*.vta" -rec
            #$files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} # Outputs file information to console
        $files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} | Copy-Item -Destination (New-Item "$vtpDestinationDirectory\" -Type container -Force) -Force
        
        # Capture latest file of type "*.vtz" and copy to specified destination
        $files = Get-ChildItem $consolePromptSearchDirectory -filter "*.vtz" -rec
            #$files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} # Outputs file information to console
        $files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} | Copy-Item -Destination (New-Item "$vtpDestinationDirectory\" -Type container -Force) -Force

        # Capture latest directory of name "*.c3prj" and copy to specified destination
        $files = Get-ChildItem $consolePromptSearchDirectory -filter "*.c3prj" -rec
            #$files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} # Outputs file information to console
        $files | Group-Object directory | ForEach-Object {@($_.group | Sort-Object {[datetime]$_.LastWriteTime} -desc)[0]} | Copy-Item -Destination (New-Item "$vtpDestinationDirectory\" -Type container -Force) -Recurse -Force

#ToDo

function fZipReplace {
     param(
         [Parameter(Mandatory=$true, position=0)]
         [object]
         $pFolderName,
         [Parameter(position=1)]
         [object]
         $pConsolePromptPackageDirectory
     )
 
     $yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes', 'Deletes file'
     $no = New-Object System.Management.Automation.Host.ChoiceDescription '&No', 'Does not delete file'
     $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
     $result = $host.ui.PromptForChoice('WARNING!', 'Would you like to delete the file?', $options, 0)
 
     switch ($result)
         {
             0 {
                #write-host "Debug: Enter Try"
                try {
                    #write-host "Debug: Enter If"
                    if ((Test-path "$pConsolePromptPackageDirectory.zip")){
                         #write-host "Debug: fZipReplace: Delete Start $pConsolePromptPackageDirectory.zip"
                         Remove-Item "$pConsolePromptPackageDirectory.zip"
                         #write-host "Debug: fZipReplace: Delete Finish $pConsolePromptPackageDirectory.zip"
                     }
                     else {
                        #write-host "Debug: Else"
                        Write-Host "$pConsolePromptPackageDirectory.zip did not exist deletion not required."
                     }#write-host "Debug: Exit If"
                 }
                 catch {
                     writ-host "Debug: $Error[0].Exception"
                 }#write-host "Debug: Exit Try"
                 
                 #write-host "Debug: fZipReplace: Packaging"
                 Get-ChildItem $pConsolePromptPackageDirectory | Compress-Archive -DestinationPath $pConsolePromptPackageDirectory -Update
                 $message = "$($pFolderName).zip has been deleted and replaced with a new archive."
                 
             }
             1 {
                 $message = "$($pFolderName).zip has not been deleted or archived."
             }
         }
     Write-Output $message
 }

$folderName=$(get-item $consolePromptPackageDirectory).Name

fZipReplace $folderName $consolePromptPackageDirectory


#write-host "Debug: Clean Up Start"
Remove-Item "$consolePromptPackageDirectory" -Recurse | write-output
#Write-Host "Debug: Clean Up Finish, Temporary Directory $consolePromptPackageDirectory has been deleted"
