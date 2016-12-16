@echo off

if exist tasks\session.txt (
    del /f tasks\session.txt
)

if exist log.old.txt (
    del /f log.old.txt
)

if exist log.txt (
    rename log.txt log.old.txt
)

set startdir=%~dp0

:setupcheck
set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

title "SpigotMC Updater v.%v% | Boot Session"
cls
if exist setup.bat (
    goto setup
) else (
    goto boot
)

:setup
@echo I am a dummy file xD >> tasks\session.txt
start /b /wait setup.bat
if exist error.txt (
   cls
   powershell.exe -command write-host "Setup has failed. Try running the setup again." -f red
   @echo [ERROR] Setup has failed. Try running the setup again. >> log.txt
   %content% --login -i -c "sleep 5s"
   exit
) else (
    cls
    del /f setup.bat
    cls
    powershell.exe -command write-host "Setup Completed." -f green
    @echo [Info] Setup Completed. >> log.txt
    %content% --login -i -c "sleep 5s"
)

cls

set content=Git\bin\bash.exe

@echo Thanks for Using SpigotMC Updater v.%v% by Legoman99573.
@echo Thanks for Using SpigotMC Updater v.%v% by Legoman99573. >> log.txt
%content% --login -i -c "sleep 5s"
echo.
@echo Do you want to Check for updates 
Set /P _2=(Y, N) || Set _2=NothingChosen
If "%_2%"=="NothingChosen" goto :startup
If /i "%_2%"=="Y" goto autoupdate
If /i "%_2%"=="y" goto autoupdate
If /i "%_2%"=="N" goto startup
If /i "%_2%"=="n" goto startup

:autoupdate
@echo I am a dummy file xD >> tasks\session.txt
start "SpigotMC Updater | Auto Update" update.bat

set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

title "SpigotMC Updater v.%v% | Boot Session"

:startup

cls

@echo Running check on all modules to make sure they are there and what shouldn't be there.
@echo [Info] Running check on all modules to make sure they are there and what shouldn't be there. >> log.txt

if exist menu.bat (
    powershell.exe -command write-host "Found %startdir%menu.bat." -f green
    @echo [Info] Found %startdir%menu.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%menu.bat." -f red
    @echo [ERROR] Cannot find %startdir%menu.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/delbt.bat (
    powershell.exe -command write-host "Found %startdir%tasks\delbt.bat." -f green
    @echo [Info] Found %startdir%tasks\delbt.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\delbt.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\delbt.bat. >> log.txt
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
