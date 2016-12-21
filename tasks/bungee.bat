@echo off

if exist tasks/bungee.bat (
	@echo [Info] Successfully loaded the Bungee Module >> log.txt
) else (
	exit
)

set startdir=%~dp0

cd %startdir%

set content=..\Git\bin\bash.exe

set v=
for /f "delims=" %%i in ('type version.txt') do set v=%%i

title Running SpigotMC Updater v.%v% BungeeCord Module

@echo Updating BungeeCord and its modules.
@echo [Info] Updating BungeeCord and its modules. >> ..\log.txt

If not exist ../bungee/ (
	powershell.exe -command write-host "The bungee folder is missing. Creating directory..." -f yellow
	@echo [WARNING] The bungee folder is missing. Creating directory... >> ..\log.txt
	md bungee
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

If not exist ../bungee/modules/ (
	powershell.exe -command write-host "The modules folder is missing. Creating directory..." -f yellow
	@echo [WARNING] The modules folder is missing. Creating directory... >> ..\log.txt
	md bungee\modules
	%content% --login -i -c "sleep 5s"
	If exist ../bungee/modules/ (
		powershell.exe -command write-host "The modules folder has been sucessfully created." -f green
		@echo [Info] The modules folder has been sucessfully created. >> ..\log.txt
	) else (
		powershell.exe -command write-host "The modules folder was not created due to Read and Write not enabled. Terminating Bungee Module." -f red
		@echo [ERROR] The modules folder was not created due to Read and Write not enabled. Terminating Bungee Module. >> ..\log.txt
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

If exist ../bungee/modules/cmd_find.jar (
	del /f ..\bungee\modules\cmd_find.jar
	%content% --login -i -c "sleep 5s"
	If not exist ../bungee/modules/cmd_find.jar (
		powershell.exe -command write-host "Deleted the old cmd_find.jar." -f green
		@echo [Info] Deleted the old cmd_find.jar. >> ..\log.txt
	) else (
		powershell.exe -command write-host "Could not delete the old cmd_find.jar. Make sure you have read/write access in the modules folder." -f red
		@echo [ERROR] Could not delete the old cmd_find.jar. Make sure you have read/write access in the modules folder. >> ..\log.txt
		%content% --login -i -c "sleep 5s"
		goto error
	)
)
%content% --login -i -c "sleep 5s"

If exist ../bungee/modules/cmd_server.jar (
	del /f ..\bungee\modules\cmd_server.jar
	%content% --login -i -c "sleep 5s"
	If not exist ../bungee/modules/cmd_server.jar (
		powershell.exe -command write-host "Deleted the old cmd_server.jar." -f green
		@echo [Info] Deleted the old cmd_server.jar. >> ..\log.txt
	) else (
		powershell.exe -command write-host "Could not delete the old cmd_server.jar. Make sure you have read/write access in the modules folder." -f red
		@echo [ERROR] Could not delete the old cmd_server.jar. Make sure you have read/write access in the modules folder. >> ..\log.txt
		%content% --login -i -c "sleep 5s"
		goto error
	)
)
%content% --login -i -c "sleep 5s"

If exist bungee\modules\cmd_send.jar (del /f bungee\modules\cmd_send.jar)
%content% --login -i -c "sleep 1s"

If exist bungee\modules\cmd_list.jar (del /f bungee\modules\cmd_list.jar)
%content% --login -i -c "sleep 1s"

If exist bungee\modules\cmd_alert.jar (del /f bungee\modules\cmd_alert.jar)
%content% --login -i -c "sleep 1s"

If exist bungee\modules\reconnect_yaml.jar (del /f bungee\modules\reconnect_yaml.jar)
%content% --login -i -c "sleep 1s"

@echo Downloading BungeeCord.jar
%content% --login -i -c "sleep 5s"
%content% --login -i -c "curl -o bungee/BungeeCord.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/bootstrap/target/BungeeCord.jar"
%content% --login -i -c "sleep 1s"
@echo Downloading modules/cmd_alert.jar
%content% --login -i -c "curl -o bungee/modules/cmd_alert.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_alert.jar"
%content% --login -i -c "sleep 1s"
@echo Downloading modules/cmd_find.jar
%content% --login -i -c "curl -o bungee/modules/cmd_find.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_find.jar"
%content% --login -i -c "sleep 1s"
@echo Downloading modules/cmd_list.jar
%content% --login -i -c "curl -o bungee/modules/cmd_list.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_list.jar"
%content% --login -i -c "sleep 1s"
@echo Downloading modules/cmd_server.jar
%content% --login -i -c "curl -o bungee/modules/cmd_server.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_server.jar"
%content% --login -i -c "sleep 1s"
@echo Downloading modules/cmd_send.jar
%content% --login -i -c "curl -o bungee/modules/cmd_send.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_send.jar"
%content% --login -i -c "sleep 1s"
@echo Downloading modules/reconnect_yaml.jar
%content% --login -i -c "curl -o bungee/modules/reconnect_yaml.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/reconnect_yaml.jar"
%content% --login -i -c "sleep 5s"

cls
@echo Updated BungeeCord and all its Modules
%content% --login -i -c "sleep 10s"

cd ..\
exit

:error
powershell.exe -command write-host "Failed to Update Bungeecord and all its Modules." -f red
@echo [ERROR] Failed to Update Bungeecord and all its Modules. ..\log.txt
%content% --login -i -c "sleep 10s"

cd ..\
exit
