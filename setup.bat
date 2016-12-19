@echo off

set startdir=%~dp0

set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

title "SpigotMC Updater v.%v% | Setup"

if exist Git\bin\bash.exe (
	powershell.exe -command write-host "%startdir%Git\bin\bash.exe already exists. Skipping check." -f yellow
	@echo [WARNING] %startdir%Git\bin\bash.exe already exists. Skipping check. >> log.txt
	goto skip
)

@echo Downloading Custom Git for this script...
@echo [Info] Downloading Custom Git for this script... >> log.txt
powershell -command Invoke-WebRequest -Uri https://thegearmc.net/spigotmc-updater/Git.zip -OutFile Git.zip
powershell -command Start-Sleep -s 10
if exist Git.zip (
	powershell.exe -command write-host "Sucessfully generated %startdir%Git.zip from https://thegearmc.net/spigotmc-updater/Git.zip" -f green
	@echo [Info] Sucessfully generated %startdir%Git.zip from https://thegearmc.net/spigotmc-updater/Git.zip >> log.txt
	powershell -command Start-Sleep -s 10
	cls
	@echo Extracting %startdir%Git.zip...
	@echo [Info] Extracting %startdir%Git.zip... >> log.txt
	powershell -command Expand-Archive Git.zip
) else (
	powershell.exe -command write-host "Failed to download %startdir%Git.zip. Make sure you have an Internet Connection or Read and Write Access." -f red
	@echo [ERROR] Failed to download %startdir%Git.zip. Make sure you have an Internet Connection or Read and Write Access. >> log.txt
	goto error
)

powershell -command Start-Sleep -s 5
cls
@echo Making sure %startdir%Git\bin\bash.exe is found...
@echo [Info] Making sure %startdir%Git\bin\bash.exe is found... >> log.txt
if exist Git\bin\bash.exe (
	powershell.exe -command write-host "%startdir%Git\bin\bash.exe has been found." -f green
	@echo [Info] %startdir%Git\bin\bash.exe has been found. >> log.txt
) else (
	powershell.exe -command write-host "%startdir%Git\bin\bash.exe could not be found." -f red
	@echo [ERROR] %startdir%Git\bin\bash.exe could not be found. >> log.txt
	goto error
)

powershell -command Start-Sleep -s 5
cls
@echo Deleting %startdir%Git.zip...
@echo [Info] Deleting %startdir%Git.zip... >> log.txt
del /f Git.zip
powershell -command Start-Sleep -s 5
if not exist Git.zip (
	powershell.exe -command write-host "%startdir%Git.zip was removed Succesfully." -f green
	@echo [Info] %startdir%Git.zip was removed Succesfully. >> log.txt
) else (
	powershell.exe -command write-host "Failed to remove %startdir%Git\bin\bash.exe. Make sure %startdir% has Read and Write Access" -f red
	@echo [ERROR] Failed to remove %startdir%Git\bin\bash.exe. Make sure %startdir% has Read and Write Access. >> log.txt
	goto error
)

powershell -command Start-Sleep -s 5
:skip

if exist config/ (
	powershell.exe -command write-host "%startdir%config\ already exists. Skipping check." -f yellow
	@echo [WARNING] %startdir%config\ already exists. Skipping check. >> log.txt
	goto skip2
)

cls
@echo Creating the config folder...
@echo [Info] Creating the config folder... >> log.txt
md config
if exist config/ (
	powershell.exe -command write-host "Sucessfully generated %startdir%config" -f green
	@echo [Info] Sucessfully generated %startdir%config >> log.txt
) else (
	powershell.exe -command write-host "Failed to generate %startdir%config. Make sure your have read and write access." -f red
	@echo [ERROR] Failed to generate %startdir%config. Make sure your have read and write access. >> log.txt
	goto error
)
Git\bin\bash.exe --login -i -c "sleep 5s"

:skip2
if exist config/plugin.txt (
	powershell.exe -command write-host "%startdir%config\plugin.txt already exists. Skipping check." -f yellow
	@echo [WARNING] %startdir%config\plugin.txt already exists. Skipping check. >> log.txt
	goto skip3
)

cls
@echo Generating plugin.txt...
@echo [Info] Generating plugin.txt... >> log.txt
powershell -command Invoke-WebRequest -Uri https://thegearmc.net/spigotmc-updater/plugin.txt -OutFile config/plugin.txt
if exist config/plugin.txt (
	powershell.exe -command write-host "Sucessfully generated %startdir%config\plugin.txt" -f green
	@echo [Info] Sucessfully generated %startdir%config\plugin.txt >> log.txt
) else (
	powershell.exe -command write-host "Failed to generate %startdir%config\plugin.txt. Make sure your have read and write access." -f red
	@echo [ERROR] Failed to generate %startdir%config\plugin.txt. Make sure your have read and write access. >> log.txt
	goto error
)
Git\bin\bash.exe --login -i -c "sleep 5s"

:skip3
if exist config/version.txt (
	powershell.exe -command write-host "%startdir%config\version.txt already exists. Skipping check." -f yellow
	@echo [WARNING] %startdir%config\version.txt already exists. Skipping check. >> log.txt
	goto skip4
)

cls
@echo Generating version.txt...
@echo [Info] Generating version.txt... >> log.txt
powershell -command Invoke-WebRequest -Uri https://thegearmc.net/spigotmc-updater/version.txt -OutFile config/version.txt
if exist config/version.txt (
	powershell.exe -command write-host "Sucessfully generated %startdir%config\version.txt" -f green
	@echo [Info] Sucessfully generated %startdir%config\version.txt >> log.txt
) else (
	powershell.exe -command write-host "Failed to generate %startdir%config\version.txt. Make sure your have read and write access." -f red
	@echo [ERROR] Failed to generate %startdir%config\version.txt. Make sure your have read and write access. >> log.txt
	goto error
)

Git\bin\bash.exe --login -i -c "sleep 5s"
:skip4
if exist config/bungeelocation.txt (
	powershell.exe -command write-host "%startdir%config\bungeelocation.txt already exists. Skipping check." -f yellow
	@echo [WARNING] %startdir%config\bungeelocation.txt already exists. Skipping check. >> log.txt
	goto skip5
)

cls
@echo Generating bungeelocation.txt...
@echo [Info] Generating bungeelocation.txt... >> log.txt
powershell -command Invoke-WebRequest -Uri https://thegearmc.net/spigotmc-updater/bungeelocation.txt -OutFile config/bungeelocation.txt
Git\bin\bash.exe --login -i -c "sleep 5s"
if exist config/bungeelocation.txt (
	powershell.exe -command write-host "Sucessfully generated %startdir%config\bungeelocation.txt" -f green
	@echo [Info] Sucessfully generated %startdir%config\bungeelocation.txt >> log.txt
) else (
	powershell.exe -command write-host "Failed to generate %startdir%config\bungeelocation.txt. Make sure your have read and write access." -f red
	@echo [ERROR] Failed to generate %startdir%config\bungeelocation.txt. Make sure your have read and write access. >> log.txt
	goto error
)
Git\bin\bash.exe --login -i -c "sleep 5s"

:skip5

cls
@echo Generating necessary Folders...
@echo [Info] Generating necessary Folders... >> log.txt
cls
Git\bin\bash.exe --login -i -c "sleep 5s"

if exist api/ (
	powershell.exe -command write-host "%startdir%api\ already exists. Skipping check." -f yellow
	@echo [WARNING] %startdir%api\ already exists. Skipping check. >> log.txt
	goto skip6
)

@echo Generating folder api...
@echo [Info] Generating folder api... >> log.txt
md api
if exist api/ (
	powershell.exe -command write-host "Sucessfully generated %startdir%api" -f green
	@echo [Info] Sucessfully generated %startdir%api >> log.txt
) else (
	powershell.exe -command write-host "Failed to generate %startdir%api. Make sure your have read and write access." -f red
	@echo [ERROR] Failed to generate %startdir%api. Make sure your have read and write access. >> log.txt
	goto error
)
Git\bin\bash.exe --login -i -c "sleep 5s"

:skip6
if exist plugin/ (
	powershell.exe -command write-host "%startdir%plugin\ already exists. Skipping check." -f yellow
	@echo [WARNING] %startdir%plugin\ already exists. Skipping check. >> log.txt
	goto skip7
)

cls
@echo Generating folder plugin...
@echo [Info] Generating folder plugin... >> log.txt
md plugin
if exist plugin/ (
	powershell.exe -command write-host "Sucessfully generated %startdir%plugin" -f green
	@echo [Info] Sucessfully generated %startdir%plugin >> log.txt
) else (
	powershell.exe -command write-host "Failed to generate %startdir%plugin. Make sure your have read and write access." -f red
	@echo [ERROR] Failed to generate %startdir%plugin. Make sure your have read and write access. >> log.txt
	goto error
)
Git\bin\bash.exe --login -i -c "sleep 5s"

:skip7
if exist plugin/plugin-dump (
	powershell.exe -command write-host "%startdir%plugin\plugin-dump already exists. Skipping check." -f yellow
	@echo [WARNING] %startdir%plugin\plugin-dump already exists. Skipping check. >> log.txt
	goto skip8
)

cls
@echo Generating folder plugin-dump...
@echo [Info] Generating folder plugin-dump... >> log.txt
md plugin\plugin-dump
if exist plugin/plugin-dump/ (
	powershell.exe -command write-host "Sucessfully generated %startdir%plugin\plugin-dump" -f green
	@echo [Info] Sucessfully generated %startdir%plugin\plugin-dump >> log.txt
) else (
	powershell.exe -command write-host "Failed to generate %startdir%plugin\plugin-dump. Make sure your have read and write access." -f red
	@echo [ERROR] Failed to generate %startdir%plugin\plugin-dump. Make sure your have read and write access. >> log.txt
	goto error
)
Git\bin\bash.exe --login -i -c "sleep 5s"

:skip8
if exist serverjars/ (
	powershell.exe -command write-host "%startdir%serverjars\ already exists. Skipping check." -f yellow
	@echo [WARNING] %startdir%serverjars\ already exists. Skipping check. >> log.txt
	goto skip9
)

cls
@echo Generating folder serverjars...
@echo [Info] Generating folder serverjars... >> log.txt
md serverjars
if exist serverjars/ (
	powershell.exe -command write-host "Sucessfully generated %startdir%serverjars" -f green
	@echo [Info] Sucessfully generated %startdir%serverjars >> log.txt
) else (
	powershell.exe -command write-host "Failed to generate %startdir%serverjars. Make sure your have read and write access." -f red
	@echo [ERROR] Failed to generate %startdir%serverjars. Make sure your have read and write access. >> log.txt
	goto error
)
Git\bin\bash.exe --login -i -c "sleep 5s"

:skip9

cls
powershell.exe -command write-host "Finished Setting up. Now will delete setup.bat and you should never see the not found error again." -f green
@echo [Info] Finished Setting up. Now will delete setup.bat and you should never see the not found error again. >> log.txt
Git\bin\bash.exe --login -i -c "sleep 5s"
exit

:error
cls
powershell.exe -command write-host "An error has occured in the setup. Terminating the program." -f green
@echo [ERROR] An error has occured in the setup. Terminating the program. >> log.txt
@echo error >> tasks\error.txt
powershell -command Start-Sleep -s 5
exit
