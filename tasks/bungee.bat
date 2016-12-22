@echo off

if exist tasks/bungee.bat (
	@echo [Info] Loading the Bungee module... >> log.txt
) else (
	exit
)

set startdir=%~dp0

cd %startdir%

set content=..\Git\bin\bash.exe

set v=
for /f "delims=" %%i in ('type version.txt') do set v=%%i

title Running SpigotMC Updater v.%v% BungeeCord Module

powershell.exe -command write-host "We removed downloading modules due to BungeeCord automatically generating them for the right version." -f yellow
@echo [WARNING] We removed downloading modules due to BungeeCord automatically generating them for the right version. >> ..\log.txt
%content% --login -i -c "sleep 15s"

cls

@echo Updating BungeeCord.jar
@echo [Info] Updating BungeeCord.jar >> ..\log.txt

If not exist ../bungee/ (
	powershell.exe -command write-host "The bungee folder is missing. Creating directory..." -f yellow
	@echo [WARNING] The bungee folder is missing. Creating directory... >> ..\log.txt
	md ..\bungee
	%content% --login -i -c "sleep 5s"
	If exist ../bungee/ (
		powershell.exe -command write-host "The bungee folder has been sucessfully created." -f green
		@echo [Info] The bungee folder has been sucessfully created. >> ..\log.txt
	) else (
		powershell.exe -command write-host "The bungee folder was not created due to Read and Write not enabled. Terminating Bungee Module." -f red
		@echo [ERROR] The bungee folder was not created due to Read and Write not enabled. Terminating Bungee Module. >> ..\log.txt
		goto error
	)
)
%content% --login -i -c "sleep 5s"

cls

If exist ../bungee/BungeeCord.jar (
	del /f ..\bungee\BungeeCord.jar
	%content% --login -i -c "sleep 5s"
	If not exist ../bungee/BungeeCord.jar (
		powershell.exe -command write-host "Deleted the old BungeeCord.jar." -f green
		@echo [Info] Deleted the old BungeeCord.jar. >> ..\log.txt
	) else (
		powershell.exe -command write-host "Could not delete the old BungeeCord.jar. Make sure you have read/write access in the bungee folder." -f red
		@echo [ERROR] Could not delete the old BungeeCord.jar. Make sure you have read/write access in the bungee folder. >> ..\log.txt
		%content% --login -i -c "sleep 5s"
		goto error
	)
)

%content% --login -i -c "sleep 5s"

cls

@echo Downloading BungeeCord.jar
%content% --login -i -c "curl -o ../bungee/BungeeCord.jar http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar"
%content% --login -i -c "sleep 5s"
If exist ../bungee/BungeeCord.jar (
	powershell.exe -command write-host "Successfully downloaded BungeCord.jar from http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar." -f green
	@echo [Info] Successfully downloaded BungeCord.jar from http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar. >> ..\log.txt
) else (
	powershell.exe -command write-host "Failed to Download BungeeCord.jar from http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar. Maybe you dont have Read and Write Access in the bungee folder or ci.md-5.net is offline." -f red
	@echo [ERROR] Failed to Download BungeeCord.jar from http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar. Maybe you dont have Read and Write Access in the bungee folder or ci.md-5.net is offline. >> ..\log.txt
	goto error
)

cls
powershell.exe -command write-host "Updated BungeeCord Successfully." -f green
@echo [Info] Updated BungeeCord Successfully. >> ..\log.txt
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
