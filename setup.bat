@echo off

echo.
@echo Creating the config folder...
echo.
md config
@echo Generating plugin.txt...
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/plugin.txt -OutFile config/plugin.txt
echo.
@echo Generating gitlocation.txt...
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/gitlocation.txt.txt -OutFile config/gitlocation.txt
@echo Opening gitlocation.txt config option to configure the script...
start "SpigotMC Updater | gitlocation.txt" /wait config\gitlocation.txt
echo.
@echo Generating bungeelocation.txt...
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/bungeelocation.txt -OutFile config/bungeelocation.txt
echo.
echo.
echo.
@echo Generating necessary Folders...
echo.
@echo Generating folder api...
md api
echo.
@echo Generating folder plugin-pending...
md plugin-pending
echo.
@echo Generating folder plugin-fixed...
md plugin-fixed
echo.
@echo Generating folder tasks/Buildtools_Files...
md tasks/Buildtools_Files
@echo Finished Generating all files.

rem #######################################
rem Place converter code here in the future
rem once I finish the code
rem #######################################

echo.
@echo Closing and deleting setup.bat...
echo.
exit
