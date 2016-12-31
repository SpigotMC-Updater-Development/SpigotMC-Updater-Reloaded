@echo off
if exist tasks/glowstone.bat (
	@echo [Info] Loading the Glowstone Module >> log.txt
) else (
	exit
)

set startdir=%~dp0

cd %startdir%

set content=..\Git\bin\bash.exe

set v=
for /f "delims=" %%i in ('type version.txt') do set v=%%i

title Running SpigotMC Updater v.%v% Glowstone Module

%content% --login -i -c "sleep 5s"

@echo Updating glowstone.jar
@echo [Info] Updating glowstone.jar >> ..\log.txt
If not exist ../glowstone/ (
	powershell.exe -command write-host "The glowstone folder is missing. Creating directory..." -f yellow
	@echo [WARNING] The glowstone folder is missing. Creating directory... >> ..\log.txt
	md ..\glowstone
	%content% --login -i -c "sleep 5s"
	If exist ../glowstone/ (
		powershell.exe -command write-host "The glowstone folder has been sucessfully created." -f green
		@echo [Info] The glowstone folder has been sucessfully created. >> ..\log.txt
	) else (
		powershell.exe -command write-host "The glowstone folder was not created due to Read and Write not enabled. Terminating Glowstone Module." -f red
		@echo [ERROR] The glowstone folder was not created due to Read and Write not enabled. Terminating Glowstone Module. >> ..\log.txt
		goto error
	)
)
%content% --login -i -c "sleep 5s"

cls

If exist ../glowstone/glowstone.jar (
	del /f ..\glowstone\glowstone.jar
	%content% --login -i -c "sleep 5s"
	If not exist ../glowstone/glowstone.jar (
		powershell.exe -command write-host "Deleted the old glowstone.jar." -f green
		@echo [Info] Deleted the old glowstone.jar. >> ..\log.txt
	) else (
		powershell.exe -command write-host "Could not delete the old glowstone.jar. Make sure you have read/write access in the glowstone folder." -f red
		@echo [ERROR] Could not delete the old glowstone.jar. Make sure you have read/write access in the glowstone folder. >> ..\log.txt
		%content% --login -i -c "sleep 5s"
		goto error
	)
)

%content% --login -i -c "sleep 5s"

cls

@echo Downloading glowstone.jar...
@echo [Info] Downloading glowstone.jar... >> ..\log.txt
%content% --login -i -c "curl -o ../glowstone/glowstone.jar https://bamboo.gserv.me/artifact/GSPP-SRV/shared/build-latestSuccessful/Version-Independent-Server-JAR/glowstone.jar"
%content% --login -i -c "sleep 5s"
If exist ../glowstone/glowstone.jar (
	powershell.exe -command write-host "Successfully downloaded glowstone.jar from https://bamboo.gserv.me/artifact/GSPP-SRV/shared/build-latestSuccessful/Version-Independent-Server-JAR/glowstone.jar." -f green
	@echo [Info] Successfully downloaded glowstone.jar from https://bamboo.gserv.me/artifact/GSPP-SRV/shared/build-latestSuccessful/Version-Independent-Server-JAR/glowstone.jar. >> ..\log.txt
) else (
	powershell.exe -command write-host "Failed to Download glowstone.jar from https://bamboo.gserv.me/artifact/GSPP-SRV/shared/build-latestSuccessful/Version-Independent-Server-JAR/glowstone.jar. Maybe you dont have Read and Write Access in the glowstone folder or bamboo.gserv.me is offline." -f red
	@echo [ERROR] Failed to Download glowstone.jar from https://bamboo.gserv.me/artifact/GSPP-SRV/shared/build-latestSuccessful/Version-Independent-Server-JAR/glowstone.jar. Maybe you dont have Read and Write Access in the glowstone folder or bamboo.gserv.me is offline. >> ..\log.txt
	goto error
)

cls
powershell.exe -command write-host "Updated Glowstone Successfully." -f green
@echo [Info] Updated Glowstone Successfully. >> ..\log.txt
%content% --login -i -c "sleep 10s"

cd ..\
exit

:error
cls
powershell.exe -command write-host "Failed to Update glowstone.jar" -f red
@echo [ERROR] Failed to Update glowstone.jar. >> ..\log.txt
%content% --login -i -c "sleep 10s"

cd ..\
exit
