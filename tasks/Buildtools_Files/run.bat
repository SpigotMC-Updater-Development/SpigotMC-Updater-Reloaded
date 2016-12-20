@echo off

if exist tasks\Buildtools_Files\run.bat (
	goto run
) else (
	exit
)

:run

set startdir=%~dp0

cls

set version=
for /f "delims=" %%i in ('type ..\..\config\version.txt') do set version=%%i

set content=..\..\Git\Bin\Bash.exe


cls
powershell.exe -command write-host "We recommend not closing the program while BuildTools.jar is running. Doing so can corrupt the files it generates and cause cleaning it out and starting over." -f yellow
@echo [WARNING] We recommend not closing the program while BuildTools.jar is running. Doing so can corrupt the files it generates and cause cleaning it out and starting over. >> ..\..\log.txt
%content% --login -i -c "sleep 15s"

if exist tasks\Buildtools_Files\BuildTools.jar (
	powershell.exe -command write-host "Running BuildTools.jar" -f green
	@echo [Info] Running BuildTools.jar >> ..\..\log.txt
) else (
	powershell.exe -command write-host "Buildtools.jar is missing. Grabbing BuildTools.jar from hub.spigotmc.org" -f yellow
	@echo [WARNING] Buildtools.jar is missing. Grabbing BuildTools.jar from hub.spigotmc.org >> ..\..\log.txt
	%content% --login -i -c "curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar"
)

%content% --login -i -c "sleep 5s"

cls

if exist BuildTools.jar (
	powershell.exe -command write-host "Starting BuildTools.jar" -f green
	@echo [Info] Starting BuildTools.jar >> ..\..\log.txt
	%content% --login -i -c "java -jar BuildTools.jar --rev %version%"
) else (
	powershell.exe -command write-host "BuildTools.jar cannot be found. terminating the proccess." -f red
	@echo [Info] BuildTools.jar cannot be found. terminating the proccess. >> ../../log.txt
	exit
)

%content% --login -i -c "sleep 5s"

set datetime=
for /f %%a in ('powershell -Command "Get-Date -format yyyy_MM_dd__HH_mm_ss"') do set datetime=%%a

if exist BuildTools.log.txt (
	@echo Renaming BuildTools.log.txt to BuildTools.%datetime%.txt
	@echo [Info] Renaming BuildTools.log.txt to BuildTools.%datetime%.txt >> ../../log.txt
	rename BuildTools.log.txt Buildtools.%datetime%.txt
	%content% --login -i -c "sleep 5s"
	if exist Buildtools.%datetime%.txt (
		@echo Moving to temp folder...
		@echo [Info] Moving to temp folder... >> ..\..\log.txt
		move BuildTools.*.txt ..\temp
		%content% --login -i -c "sleep 5s"
		if exist ../temp/Buildtools.%datetime%.txt (
			powershell.exe -command write-host "%startdir%Buildtools.%datetime%.txt has been moved to the temp folder in tasks successfully." -f green
			@echo [Info] %startdir%Buildtools.%datetime%.txt has been moved to the temp folder in tasks successfully. >> ..\..\log.txt
		) else (
			powershell.exe -command write-host "Failed to move %startdir%Buildtools.%datetime%.txt to the temp folder. You can still find Buildtools.%datetime%.txt in %startdir%." -f yellow
			@echo [WARNING] Failed to move %startdir%Buildtools.%datetime%.txt to the temp folder. You can still find Buildtools.%datetime%.txt in %startdir%. >> ..\..\log.txt
		)
		
	) else (
		powershell.exe -command write-host "Could not rename BuildTools.log.txt to BuildTools.%datetime%.txt. You can still find the log in %startdir%." -f yellow
		@echo [WARNING] Could not rename BuildTools.log.txt to BuildTools.%datetime%.txt. You can still find the log in %startdir%. >>..\..\log.txt
	)
	%content% --login -i -c "sleep 5s"
	cls
	@echo These logs were renamed to help with reporting bugs on https://hub.spigotmc.org/jira/projects/BUILDTOOLS/issues
	@echo [Info] These logs were renamed to help with reporting bugs on https://hub.spigotmc.org/jira/projects/BUILDTOOLS/issues >> ..\..\log.txt
	echo.
	@echo [Info] >> ..\..\log.txt
	@echo Report server bugs on https://hub.spigotmc.org/jira/projects/SPIGOT/issues
	@echo [Info] Report server bugs on https://hub.spigotmc.org/jira/projects/SPIGOT/issues >> ..\..\log.txt
	echo.
	@echo [Info] >> ..\..\log.txt
	@echo Need further assistance, just go to the IRC Channel to get support of the error or just use our buildtools file cleaner.
	@echo [Info] Need further assistance, just go to the IRC Channel to get support of the error or just use our buildtools file cleaner. >> ..\..\log.txt
)


%content% --login -i -c "sleep 20s"
cd ..\..\

exit
