@echo off

title Loading SpigotMC Updater...

if exist "%PROGRAMFILES(X86)%" (
	mode con: cols=180 lines=50
) else (
	mode con: cols=130 lines=40
)

@echo Resized for script :D
cls

powershell -command Start-Sleep -s 1
if exist tasks\session.txt (
    del /f tasks\session.txt
)

powershell -command Start-Sleep -s 1
if exist log.txt (
    del /f log.txt
)
powershell -command Start-Sleep -s 1

for /f %%j in ("java.exe") do (
    set JAVA_HOME=%%~dp$PATH:j
)

if %JAVA_HOME%.==. (
    powershell.exe -command write-host "You Do not have Java installed. Please install this dependency and try again." -f red
	@echo [ERROR] You Do not have Java installed. Please install this dependency and try again. >> log.txt
	explorer "http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html"
	powershell -command Start-Sleep -s 5
	exit
) else (
    goto foundjava
)

:foundjava

set startdir=%~dp0

:setupcheck
if not exist tasks/version.txt (
	powershell -command Invoke-WebRequest -Uri https://thegearmc.net/spigotmc-updater/beta.txt -OutFile tasks/version.txt
)
powershell -command Start-Sleep -s 5

set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

if "%v%"=="Beta-Build" (
	cls
	powershell.exe -command write-host "You are running a Beta Build. This means bugs are possible and alot of crashes are possible." -f yellow
	@echo [WARNING] You are running a Beta Build. This means bugs are possible and alot of crashes are possible. >> log.txt
	powershell -command Start-Sleep -s 15
	powershell -command Invoke-WebRequest -Uri https://github.com/SpigotMC-Updater-Development/SpigotMC-Updater-Reloaded/archive/master.zip -OutFile beta.zip
	powershell -command Start-Sleep -s 5
	
	if exist beta.zip (
		cls
		@echo Updating Beta Build to latest from GitHub
		@echo [Info] Updating Beta Build to latest from GitHub >> log.txt
		powershell -command Expand-Archive -Force beta.zip
		powershell -command Start-Sleep -s 5
		if exist beta/ (
			del /f beta.zip
			@echo [Info] Updating %startdir%SpigotMC_Updater.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\SpigotMC_Updater.bat %startdir%
			powershell -command Start-Sleep -s 5
			@echo [Info] Updated %startdir%SpigotMC_Updater.bat >> log.txt
			@echo [Info] Updating %startdir%setup.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\setup.bat %startdir%
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%setup.bat >> log.txt
			@echo [Info] Updating %startdir%tasks\bungee.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\bungee.bat %startdir%tasks
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%tasks\bungee.bat >> log.txt
			@echo [Info] Updating %startdir%tasks\glowstone.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\glowstone.bat %startdir%tasks
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%tasks\glowstone.bat >> log.txt
			@echo [Info] Updating %startdir%tasks\menu.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\menu.bat %startdir%tasks
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%tasks\menu.bat >> log.txt
			@echo [Info] Updating %startdir%tasks\nukkit.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\nukkit.bat %startdir%tasks
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%tasks\nukkit.bat >> log.txt
			@echo [Info] Updating %startdir%tasks\paper.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\paper.bat %startdir%tasks
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%tasks\paper.bat >> log.txt
			@echo [Info] Updating %startdir%tasks\plugin_repair_tool.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\plugin_repair_tool.bat %startdir%tasks
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%tasks\plugin_repair_tool.bat >> log.txt
			@echo [Info] Updating %startdir%tasks\reportbug.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\reportbug.bat %startdir%tasks
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%tasks\reportbug.bat >> log.txt
			@echo [Info] Updating %startdir%tasks\update.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\update.bat %startdir%tasks
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%tasks\reportbug.bat >> log.txt
			@echo [Info] Updating %startdir%tasks\update.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\updatebt.bat %startdir%tasks
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%tasks\updatebt.bat >> log.txt
			@echo [Info] Updating %startdir%tasks\Buildtools_Files\run.bat  >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\Buildtools_Files\run.bat %startdir%tasks\Buildtools_Files
			powershell -command Start-Sleep -s 1
			@echo [Info] Updated %startdir%tasks\Buildtools_Files\run.bat  >> log.txt
			@echo [Info] Updating %startdir%tasks\Buildtools_Files\cleanup.bat >> log.txt
			
			copy /y beta\SpigotMC-Updater-Reloaded-master\tasks\Buildtools_Files\cleanup.bat %startdir%tasks\Buildtools_Files
			powershell -command Start-Sleep -s 1
			@echo [Info] Updating %startdir%tasks\Buildtools_Files\cleanup.bat >> log.txt
			@echo [Info] Deleting Updating %startdir%beta\. >> log.txt
			rd /s /q %startdir%beta
		) else (
			cls
			powershell.exe -command write-host "Unable to extract %startdir%beta.zip. Make sure %startdir% has Read/Write access. Using the current beta you are on." -f red
			@echo [ERROR] Unable to extract %startdir%beta.zip. Make sure %startdir% has Read/Write access. Using the current beta you are on. >> log.txt
			del /f beta.zip
		)
		powershell -command Start-Sleep -s 5
	) else (
		cls
		powershell.exe -command write-host "Unable to get the beta build. You may not get the recommended fixes." -f yellow
		@echo [WARNING] Unable to get the beta build. You may not get the recommended fixes. >> log.txt
		powershell -command Start-Sleep -s 15
	)	
	@echo Do u Beta m8. >> tasks\beta.txt
)

title Loading SpigotMC Updater v.%v%...

cls

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

:boot

set content=Git\bin\bash.exe

@echo Thanks for Using SpigotMC Updater v.%v% by Legoman99573.
@echo Thanks for Using SpigotMC Updater v.%v% by Legoman99573. >> log.txt
%content% --login -i -c "sleep 5s"

if exist tasks/beta.txt (
	del /f tasks\beta.txt
	powershell.exe -command write-host "%startdir%tasks\update.bat does not work in beta. Going straight to startup. To get out of beta, edit %startdir%tasks\version.txt and Change line from %v% to none." -f yellow
	@echo [WARNING] %startdir%tasks\update.bat does not work in beta. Going straight to startup. To get out of beta, edit %startdir%tasks\version.txt and Change line from %v% to none. >> log.txt
	%content% --login -i -c "sleep 15s"
	goto startup
)

powershell -command Invoke-WebRequest -Uri http://thegearmc.net/spigotmc-updater/update.txt -OutFile tasks\version2.txt

set v2=
for /f "delims=" %%i in ('type tasks\version2.txt') do set v2=%%i
%content% --login -i -c "sleep 3s"

if "%v%"=="%v2%" (
	@echo [Info] No Updates found >> log.txt
	del /f tasks\version2.txt
) else (
	powershell.exe -command write-host "You are running an outdated version of SpigotMC Updater. We recommend Updating to get support." -f yellow
	del /f tasks\version2.txt
	%content% --login -i -c "sleep 5s"
)

cls

@echo Do you want to Check for updates... [y or n]
CHOICE /C yn /N /M "> "
if ERRORLEVEL 2 goto skip
if ERRORLEVEL 1 goto autoupdate

:autoupdate

start /b /wait tasks\update.bat

set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

if exist setup.bat (
    powershell.exe -command write-host "You have updated, so we are running setup to make sure nothing has changed." -f yellow
    @echo [WARNING] You have updated, so we are running setup to make sure nothing has changed. >> log.txt
    powershell -command Start-Sleep -s 5
    goto setup2
) else (
    @echo [WARNING] %startdir%setup.bat is missing. It is maybe due to no updates. This is not an error message, this is a check that happens when you dont get an update. >> log.txt
    goto startup
)

:setup2
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

title Booting SpigotMC Updater v.%v%...

goto startup

:skip
@echo [WARNING] Updater was skipped by user. Using an outdated version will not revieve support for older versions. >> log.txt

:startup

cls

@echo Running check on all modules to make sure they are there and what shouldn't be there.
@echo [Info] Running check on all modules to make sure they are there and what shouldn't be there. >> log.txt

if exist tasks/bungee.bat (
    powershell.exe -command write-host "Found %startdir%tasks\bungee.bat." -f green
    @echo [Info] Found %startdir%tasks\bungee.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\bungee.bat." -f red
    @echo [ERROR] Cannot find %startdir%bungee\menu.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/glowstone.bat (
    powershell.exe -command write-host "Found %startdir%tasks\glowstone.bat." -f green
    @echo [Info] Found %startdir%tasks\glowstone.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\glowstone.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\glowstone.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/menu.bat (
    powershell.exe -command write-host "Found %startdir%tasks\menu.bat." -f green
    @echo [Info] Found %startdir%tasks\menu.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\menu.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\menu.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/nukkit.bat (
    powershell.exe -command write-host "Found %startdir%tasks\nukkit.bat." -f green
    @echo [Info] Found %startdir%tasks\nukkit.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\nukkit.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\nukkit.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
    exit
)

if exist tasks/paper.bat (
    powershell.exe -command write-host "Found %startdir%tasks\paper.bat." -f green
    @echo [Info] Found %startdir%tasks\paper.bat. >> log.txt
    %content% --login -i -c "sleep 5s"
) else (
    powershell.exe -command write-host "Cannot find %startdir%tasks\paper.bat." -f red
    @echo [ERROR] Cannot find %startdir%tasks\paper.bat. >> log.txt
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

if exist menu.bat (
    powershell.exe -command write-host "%startdir%menu.bat is deprecated. Removing the module." -f yellow
    @echo [Warning] %startdir%menu.bat is deprecated. Removing the module. >> log.txt
    rename menu.bat menu.bat.deprecated
    %content% --login -i -c "sleep 5s"
    if exist menu.bat.deprecated (
        powershell.exe -command write-host "%startdir%menu.bat was removed successfully." -f green
        @echo [Info] %startdir%menu.bat was removed successfully. >> log.txt
    ) else (
        powershell.exe -command write-host "%startdir%menu.bat could not be removed. Make sure %startdir% has Read and Write access." -f red
        @echo [ERROR] %startdir%menu.bat could not be removed. Make sure %startdir% has Read and Write access. >> log.txt
        %content% --login -i -c "sleep 5s"
        exit
    )
    %content% --login -i -c "sleep 5s"
)

if exist tasks/help.bat (
    powershell.exe -command write-host "%startdir%tasks\help.bat is deprecated. Removing the module." -f yellow
    @echo [Warning] %startdir%tasks\help.bat is deprecated. Removing the module. >> log.txt
    rename tasks\help.bat help.bat.deprecated
    %content% --login -i -c "sleep 5s"
    if exist tasks/help.bat.deprecated (
        powershell.exe -command write-host "%startdir%tasks\help.bat was removed successfully." -f green
        @echo [Info] %startdir%tasks\help.bat was removed successfully. >> log.txt
    ) else (
        powershell.exe -command write-host "%startdir%tasks\uhelp.bat could not be removed. Make sure %startdir%tasks has Read and Write access." -f red
        @echo [ERROR] %startdir%tasks\help.bat could not be removed. Make sure %startdir%tasks has Read and Write access. >> log.txt
        %content% --login -i -c "sleep 5s"
        exit
    )
    %content% --login -i -c "sleep 5s"
)

if exist tasks/delbt.bat (
    powershell.exe -command write-host "%startdir%tasks\delbt.bat is deprecated. Removing the module." -f yellow
    @echo [Warning] %startdir%tasks\delbt.bat is deprecated. Removing the module. >> log.txt
    rename tasks\delbt.bat delbt.bat.deprecated
    %content% --login -i -c "sleep 5s"
    if exist tasks/delbt.bat.deprecated (
        powershell.exe -command write-host "%startdir%tasks\delbt.bat was removed successfully." -f green
        @echo [Info] %startdir%tasks\delbt.bat was removed successfully. >> log.txt
    ) else (
        powershell.exe -command write-host "%startdir%tasks\delbt.bat could not be removed. Make sure %startdir%tasks has Read and Write access." -f red
        @echo [ERROR] %startdir%tasks\delbt.bat could not be removed. Make sure %startdir%tasks has Read and Write access. >> log.txt
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

if exist config/bungeelocation.txt (
    powershell.exe -command write-host "%startdir%config\bungeelocation.txt is deprecated. Removing the module." -f yellow
    @echo [Warning] %startdir%config\bungeelocation.txt is deprecated. Removing the module. >> log.txt
    rename config\bungeelocation.txt bungeelocation.txt.deprecated
    %content% --login -i -c "sleep 5s"
    if exist config/bungeelocation.txt.deprecated (
        powershell.exe -command write-host "%startdir%config\bungeelocation.txt was removed successfully." -f green
        @echo [Info] %startdir%config\bungeelocation.txt was removed successfully. >> log.txt
    ) else (
        powershell.exe -command write-host "%startdir%config\bungeelocation.txt could not be removed. Make sure %startdir%config has Read and Write access." -f red
        @echo [ERROR] %startdir%config\bungeelocation.txt could not be removed. Make sure %startdir%config has Read and Write access. >> log.txt
        %content% --login -i -c "sleep 5s"
        exit
    )
    %content% --login -i -c "sleep 5s"
)

:ready

start /b /wait tasks\menu.bat
goto exit

:exit
exit
