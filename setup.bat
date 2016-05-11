@echo off

echo.
@echo Creating the config folder...
echo.
md config
@echo Generating plugin.txt...
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/plugin.txt -OutFile config/plugin.txt
if exist config/plugin.txt (@echo plugin.txt was added sucessfully) else (@echo plugin.txt failed to download. Make sure your have read and write access.
goto error)
echo.
@echo Generating gitlocation.txt...
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/gitlocation.txt -OutFile config/gitlocation.txt
if exist config/gitlocation.txt (@echo gitlocation.txt was added sucessfully) else (@echo gitlocation.txt failed to download. Make sure your have read and write access.
goto error)
echo.
@echo Generating bungeelocation.txt...
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/bungeelocation.txt -OutFile config/bungeelocation.txt
if exist config/bungeelocation.txt (@echo bungeelocation.txt was added sucessfully) else (@echo bungeelocation.txt failed to download. Make sure your have read and write access.
goto error)
echo.
echo.
echo.
@echo Generating necessary Folders...
echo.
@echo Generating folder api...
md api
if exist api/ (@echo Successfully created folder api) else (@echo Failed to generate folder api. Please make sure you have read and write access.
goto error) 
echo.
@echo Generating folder plugin...
md plugin
if exist plugin/ (@echo Successfully created folder plugin) else (@echo Failed to generate folder plugin. Please make sure you have read and write access.
goto error) 
echo.
@echo Generating folder plugin-dump...
md plugin\plugin-dump
if exist plugin/plugin-dump/ (@echo Successfully created folder plugin\plugin-dump) else (@echo Failed to generate folder plugin\plugin-dump. Please make sure you have read and write access.
goto error)
echo.
@echo Generating folder tasks/Buildtools_Files...
md tasks\Buildtools_Files
if exist tasks/Buildtools_Files/ (@echo Successfully created folder tasks/Buildtools_Files) else (@echo Failed to generate folder tasks/Buildtools_Files. Please make sure you have read and write access.
goto error)
echo.
@echo Generating tasks/changelog.bat
powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/SpigotMC-Updater-Development/SpigotMC-Updater-Reloaded-Converter/master/tasks/changelog.bat -OutFile tasks/changelog.bat
if exist tasks/changelog.bat (@echo changelog.bat was added sucessfully) else (@echo changelog.bat failed to download. Make sure your have read and write access.
goto error)
@echo Finished Generating all files.

rem #######################################
rem Place converter code here in the future
rem once I finish the code
rem #######################################

echo.
@echo Closing and deleting setup.bat...
echo.
exit

:error

@echo Error 15 has occured. Generating error message then closing script.
@echo An error had occured while adding the files. Make sure you have read and write access. >> tasks\error.txt
start "SpigotMC Updater | Error 15" /wait tasks\error.txt
exit
