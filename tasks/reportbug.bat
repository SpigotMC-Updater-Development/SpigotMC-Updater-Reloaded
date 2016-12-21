@echo off

if exist tasks/reportbug.bat (
	@echo Loading the ReportBug Module... >> log.txt
) else (
	exit
)

set startdir=%~dp0

cd %strtdir%

set v=
for /f "delims=" %%i in ('type version.txt') do set v=%%i

title Running SpigotMC Updater v.%v% ReportBug Module

set content=..\Git\bin\bash.exe

cls

powershell.exe -command write-host "Use this only if you catch a bug. Snapshots and or descriptions will be more helpful." -f yellow
@echo [WARNING] Use this only if you catch a bug. Snapshots and or descriptions will be more helpful. >> ..\log.txt
%content% --login -i -c "sleep 15s"

@echo Launching your Browser and going back to menu.
@echo [Info] Launching your Browser and going back to menu. >> ..\log.txt
explorer "https://github.com/SpigotMC-Updater-Development/SpigotMC-Updater-Reloaded/issues"
%content% --login -i -c "sleep 5s"

cd ..\
exit
