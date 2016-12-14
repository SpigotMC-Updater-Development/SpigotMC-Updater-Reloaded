@echo off

set startdir=%~dp0

powershell -command Invoke-WebRequest -Uri https://thegearmc.net/spigotmc-updater/Git.zip -OutFile Git.zip
if exist Git.zip (
	powershell.exe -command write-host "Sucessfully generated %startdir%Git.zip from https://thegearmc.net/spigotmc-updater/Git.zip" -f green
	Expand-ZIPFile –File “Git.zip”
	del /f Git.zip
) else (
	powershell.exe -command write-host "Failed to download %startdir%Git.zip. Make sure you have an Internet Connection or Read and Write Access." -f red
	@echo [ERROR] Failed to download %startdir%Git.zip. Make sure you have an Internet Connection or Read and Write Access. >> log.txt
	goto error
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

cls
@echo Generating bungeelocation.txt...
@echo [Info] Generating bungeelocation.txt... >> log.txt
powershell -command Invoke-WebRequest -Uri https://thegearmc.net/spigotmc-updater/bungeelocation.txt -OutFile config/bungeelocation.txt
if exist config/bungeelocation.txt (
	powershell.exe -command write-host "Sucessfully generated %startdir%config\bungeelocation.txt" -f green
	@echo [Info] Sucessfully generated %startdir%config\bungeelocation.txt >> log.txt
) else (
	powershell.exe -command write-host "Failed to generate %startdir%config\bungeelocation.txt. Make sure your have read and write access." -f red
	@echo [ERROR] Failed to generate %startdir%config\bungeelocation.txt. Make sure your have read and write access. >> log.txt
	goto error
)
Git\bin\bash.exe --login -i -c "sleep 5s"

cls
@echo Generating necessary Folders...
@echo [Info] Generating necessary Folders... >> log.txt
cls
Git\bin\bash.exe --login -i -c "sleep 5s"

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
Git\bin\bash.exe --login -i -c "sleep 5s"
exit
