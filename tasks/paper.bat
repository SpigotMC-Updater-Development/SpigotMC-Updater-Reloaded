@echo off
if exist tasks/paper.bat (
	@echo [Info] Loading the Paper Module >> log.txt
) else (
	exit
)

set startdir=%~dp0

cd %startdir%

set content=..\Git\bin\bash.exe

set v=
for /f "delims=" %%i in ('type version.txt') do set v=%%i

title Running SpigotMC Updater v.%v% Paper Module

%content% --login -i -c "sleep 5s"

@echo Updating paperclip.jar
@echo [Info] Updating paperclip.jar >> ..\log.txt
If not exist ../paper/ (
	powershell.exe -command write-host "The paper folder is missing. Creating directory..." -f yellow
	@echo [WARNING] The paper folder is missing. Creating directory... >> ..\log.txt
	md paper
	%content% --login -i -c "sleep 5s"
	If exist ../paper/ (
		powershell.exe -command write-host "The paper folder has been sucessfully created." -f green
		@echo [Info] The paper folder has been sucessfully created. >> ..\log.txt
	) else (
		powershell.exe -command write-host "The paper folder was not created due to Read and Write not enabled. Terminating Paper Module." -f red
		@echo [ERROR] The paper folder was not created due to Read and Write not enabled. Terminating Paper Module. >> ..\log.txt
		goto skip
	)
)
%content% --login -i -c "sleep 5s"

cls

If exist ../paper/paperclip.jar (
	del /f ..\paper\paperclip.jar
	%content% --login -i -c "sleep 5s"
	If not exist ../paper/paperclip.jar (
		powershell.exe -command write-host "Deleted the old paperclip.jar." -f green
		@echo [Info] Deleted the old paperclip.jar. >> ..\log.txt
	) else (
		powershell.exe -command write-host "Could not delete the old paperclip.jar. Make sure you have read/write access in the paper folder." -f red
		@echo [ERROR] Could not delete the old paperclip.jar. Make sure you have read/write access in the paper folder. >> ..\log.txt
		%content% --login -i -c "sleep 5s"
		goto error
	)
)

%content% --login -i -c "sleep 5s"
:skip
cls

@echo Downloading paperclip.jar...
@echo [Info] Downloading paperclip.jar... >> ..\log.txt
%content% --login -i -c "curl -o ../paper/paperclip.jar https://ci.destroystokyo.com/job/PaperSpigot/lastSuccessfulBuild/artifact/paperclip.jar"
%content% --login -i -c "sleep 5s"
If exist ../paper/paperclip.jar (
	powershell.exe -command write-host "Successfully downloaded paperclip.jar from https://ci.destroystokyo.com/job/PaperSpigot/lastSuccessfulBuild/artifact/paperclip.jar." -f green
	@echo [Info] Successfully downloaded paperclip.jar from https://ci.destroystokyo.com/job/PaperSpigot/lastSuccessfulBuild/artifact/paperclip.jar. >> ..\log.txt
) else (
	powershell.exe -command write-host "Failed to Download paperclip.jar from https://ci.destroystokyo.com/job/PaperSpigot/lastSuccessfulBuild/artifact/paperclip.jar. Maybe you dont have Read and Write Access in the bungee folder or ci.destroystokyo.com is offline." -f red
	@echo [ERROR] Failed to Download paperclip.jar from https://ci.destroystokyo.com/job/PaperSpigot/lastSuccessfulBuild/artifact/paperclip.jar. Maybe you dont have Read and Write Access in the bungee folder or ci.destroystokyo.com is offline. >> ..\log.txt
	goto error
)

cls
powershell.exe -command write-host "Updated PaperSpigot Successfully." -f green
@echo [Info] Updated PaperSpigot Successfully. >> ..\log.txt
%content% --login -i -c "sleep 10s"

cd ..\
exit

:error
cls
powershell.exe -command write-host "Failed to Update Bungeecord.jar" -f red
@echo [ERROR] Failed to Update Bungeecord.jar. >> ..\log.txt
%content% --login -i -c "sleep 10s"

cd ..\
exit
