@echo off

title Loading SpigotMC Updater...

if exist tasks/version.txt (
	del /f tasks\version.txt
)

powershell -command Start-Sleep -m 2000
if exist tasks\session.txt (
    del /f tasks\session.txt
)

powershell -command Start-Sleep -m 2000
if exist log.txt (
    del /f log.txt
)

set startdir=%~dp0

:setupcheck
set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

if not exist tasks/version.txt (
	powershell -command Invoke-WebRequest -Uri https://thegearmc.net/spigotmc-updater/beta.txt -OutFile tasks/version.txt
)
%content% --login -i -c "sleep 5s"

if "%v%"=="Beta-Build" (
	cls
	powershell.exe -command write-host "You are running a Beta Build. This means bugs are possible and alot of crashes are possible." -f red
	@echo [WARNING] You are running a Beta Build. This means bugs are possible and alot of crashes are possible. >> log.txt
	powershell -command Start-Sleep -s 15
	powershell -command Invoke-WebRequest -Uri https://github.com/SpigotMC-Updater-Development/SpigotMC-Updater-Reloaded/archive/master.zip -OutFile beta.zip
	%content% --login -i -c "sleep 5s"
	
	if exist beta.zip (
		@echo Updating Beta Build to latest from GitHub
		powershell -command Expand-Archive -Force beta.zip
		powershell -command Start-Sleep -s 5
		copy beta\master\*.* ..\
		powershell -command Start-Sleep -s 5
		copy beta\master\tasks\*.* ..\tasks
		powershell -command Start-Sleep -s 5
		copy beta\master\tasks\Buildtools_Files\*.* ..tasks\Buildtools_Files
		powershell -command Start-Sleep -s 5
		rmdir master
		powershell -command Start-Sleep -s 5
	) else (
		powershell.exe -command write-host "Unable to get the beta build. You may not get the recommended fixes." -f yellow
		@echo [WARNING] Unable to get the beta build. You may not get the recommended fixes. >> log.txt
		powershell -command Start-Sleep -s 15
	)
)

title Loading SpigotMC Updater v.%v%...

@echo Starting SpigotMC Updater v.%v% in %startdir%. Please Wait...
@echo [Info] Starting SpigotMC Updater v.%v% in %startdir%. Please Wait... >> log.txt
powershell -command Start-Sleep -s 10
cls
if exist setup.bat (
    powershell.exe -command write-host "You are missing some files. Do not panic. You will recieve this Warning until Setup is complete." -f yellow
    @echo [WARNING] You are missing some files. Do not panic. You will recieve this Warning until Setup is complete >> log.txt
    powershell -command Start-Sleep -s 5
    goto setup
) else (
    @echo [WARNING] %startdir%setup.bat is missing. It is maybe due to you finishing the setup. This is not an error message, this is a check that happens when you start up. >> log.txt
    goto boot
)

:setup
@echo I am a dummy file xD >> tasks\session.txt
start /b /wait setup.bat
powershell -command Start-Sleep -s 5
if exist tasks/error.txt (
   title Closing SpigotMC Updater v.%v%...
   del /f tasks\error.txt
   cls
   powershell.exe -command write-host "Setup has failed. Try running the setup again." -f red
   @echo [ERROR] Setup has failed. Try running the setup again. >> log.txt
   powershell -command Start-Sleep -s 5
   exit
) else (
    title Loading SpigotMC Updater v.%v%...
	cls
    del /f setup.bat
    cls
    powershell.exe -command write-host "Setup Completed." -f green
    @echo [Info] Setup Completed. >> log.txt
    powershell -command Start-Sleep -s 5
)

cls

set content=Git\bin\bash.exe

@echo Thanks for Using SpigotMC Updater v.%v% by Legoman99573.
@echo Thanks for Using SpigotMC Updater v.%v% by Legoman99573. >> log.txt
%content% --login -i -c "sleep 5s"
echo.
@echo Do you want to Check for updates 
Set /P _2=(Y, N) || Set _2=NothingChosen
If "%_2%"=="NothingChosen" goto :skip
If /i "%_2%"=="Y" goto autoupdate
If /i "%_2%"=="y" goto autoupdate
If /i "%_2%"=="N" goto skip
If /i "%_2%"=="n" goto skip

:autoupdate
@echo I am a dummy file xD >> tasks\session.txt
start /b /wait tasks\update.bat

set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

title Booting SpigotMC Updater v.%v%...

goto startup

:skip
@echo [WARNING] Updater was skipped by user. Using an outdated version will not revieve support for older versions. >> log.txt

:startup

cls

@echo Running check on all modules to make sure they are there and what shouldn't be there.
@echo [Info] Running check on all modules to make sure they are there and what shouldn't be there. >> log.txt

if exist tasks/bungee.bat (
    powershell.exe -command write-host "Found %startdir%tasks/bungee.bat." -f green
    @echo [Info] Found %startdir%tasks/bungee.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks/bungee.bat." -f red
    @echo [ERROR] Cannot find %startdir%bungee/menu.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/menu.bat (
    powershell.exe -command write-host "Found %startdir%tasks/menu.bat." -f green
    @echo [Info] Found %startdir%tasks/menu.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks/menu.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks/menu.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/paper.bat (
    powershell.exe -command write-host "Found %startdir%tasks/paper.bat." -f green
    @echo [Info] Found %startdir%tasks/paper.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks/paper.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks/paper.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/updatebt.bat (
    powershell.exe -command write-host "Found %startdir%tasks\updatebt.bat." -f green
    @echo [Info] Found %startdir%tasks\updatebt.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\updatebt.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\updatebt.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/plugin_repair_tool.bat (
    powershell.exe -command write-host "Found %startdir%tasks\plugin_repair_tool.bat." -f green
    @echo [Info] Found %startdir%tasks\plugin_repair_tool.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\plugin_repair_tool.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\plugin_repair_tool.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/reportbug.bat (
    powershell.exe -command write-host "Found %startdir%tasks\reportbug.bat." -f green
    @echo [Info] Found %startdir%tasks\reportbug.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\reportbug.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\reportbug.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/update.bat (
    powershell.exe -command write-host "Found %startdir%tasks\update.bat." -f green
    @echo [Info] Found %startdir%tasks\update.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\update.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\update.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/updatebt.bat (
    powershell.exe -command write-host "Found %startdir%tasks\updatebt.bat." -f green
    @echo [Info] Found %startdir%tasks\updatebt.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\updatebt.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\updatebt.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/Buildtools_Files/run.bat (
    powershell.exe -command write-host "Found %startdir%tasks\Buildtools_Files\run.bat." -f green
    @echo [Info] Found %startdir%tasks\Buildtools_Files\run.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\Buildtools_Files\run.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\Buildtools_Files\run.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/Buildtools_Files/cleanup.bat (
    powershell.exe -command write-host "Found %startdir%tasks\Buildtools_Files\cleanup.bat." -f green
    @echo [Info] Found %startdir%tasks\Buildtools_Files\cleanup.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\Buildtools_Files\cleanup.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\Buildtools_Files\cleanup.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/help.bat (
    powershell.exe -command write-host "%startdir%tasks\help.bat is deprecated. Removing the module." -f yellow
    @echo [Warning] %startdir%tasks\help.bat is deprecated. Removing the module. >> log.txt
    rename tasks\help.bat help.bat.deprecated
    %content% --login -i -c "sleep 5s"
    if exist tasks/help.bat.deprecated (
        powershell.exe -command write-host "%startdir%tasks\update.bat was removed successfully." -f green
        @echo [Info] %startdir%tasks\update.bat was removed successfully. >> log.txt
    ) else (
        powershell.exe -command write-host "%startdir%tasks\update.bat could not be removed. Make sure %startdir%tasks has Read and Write access." -f red
        @echo [ERROR] %startdir%tasks\update.bat could not be removed. Make sure %startdir%tasks has Read and Write access. >> log.txt
        %content% --login -i -c "sleep 5s"
        exit
    )
    %content% --login -i -c "sleep 5s"
)

if exist config/gitlocation.txt (
    powershell.exe -command write-host "%startdir%config\gitlocation.txt is deprecated. Removing the module." -f yellow
    @echo [Warning] %startdir%config\gitlocation.txt is deprecated. Removing the module. >> log.txt
    rename config\gitlocation.txt gitlocation.txt.deprecated
    %content% --login -i -c "sleep 5s"
    if exist config/gitlocation.txt.deprecated (
        powershell.exe -command write-host "%startdir%config\gitlocation.txt was removed successfully." -f green
        @echo [Info] %startdir%config\gitlocation.txt was removed successfully. >> log.txt
    ) else (
        powershell.exe -command write-host "%startdir%config\gitlocation.txt could not be removed. Make sure %startdir%config has Read and Write access." -f red
        @echo [ERROR] %startdir%config\gitlocation.txt could not be removed. Make sure %startdir%config has Read and Write access. >> log.txt
        %content% --login -i -c "sleep 5s"
        exit
    )
    %content% --login -i -c "sleep 5s"
)

:ready

@echo U wot m8 >> tasks\session.txt

start /b /wait menu.bat
goto exit

:exit
exit
