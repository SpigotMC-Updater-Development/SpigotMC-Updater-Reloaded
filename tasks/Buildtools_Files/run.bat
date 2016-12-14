@echo off

if exist tasks\Buildtools_Files\run.bat (
	goto run
) else (
	exit
)

:run

set startdir=%~dp0

echo %startdir%
cls

set version=
for /f "delims=" %%i in ('type config\version.txt') do set version=%%i

set content=..\..\Git\Bin\Bash.exe

cd %startdir%

if exist BuildTools.jar (
	powershell.exe -command write-host "Starting BuildTools.jar" -f green
	@echo [Info] Starting BuildTools.jar >> ..\..\log.txt
	%content% --login -i -c "java -jar BuildTools.jar --rev %version%" >> ../../log.txt
) else (
	powershell.exe -command write-host "BuildTools.jar cannot be found. terminating the proccess." -f red
	@echo [Info] BuildTools.jar cannot be found. terminating the proccess. >> ../../log.txt
	exit
)

set datetime=
for /f %%a in ('powershell -Command "Get-Date -format yyyy_MM_dd__HH_mm_ss"') do set datetime=%%a

if exist BuildTools.log.txt (
	@echo Renaming BuildTools.log.txt to BuildTools.%datetime%.txt
	@echo [Info] Renaming BuildTools.log.txt to BuildTools.%datetime%.txt >> ../../log.txt
	rename BuildTools.log.txt Buildtools.%datetime%.txt
	move BuildTools.*.txt ..\temp
	echo.
	cls
	@echo These logs were renamed to help with reporting bugs on https://hub.spigotmc.org/jira/projects/BUILDTOOLS/issues
	echo.
	@echo Report server bugs on https://hub.spigotmc.org/jira/projects/SPIGOT/issues
	echo.
	@echo Need further assistance, just go to the IRC Channel to get support or just use our buildtools file cleaner
)

%content% --login -i -c "sleep 10s"
cd ..\..\

exit
