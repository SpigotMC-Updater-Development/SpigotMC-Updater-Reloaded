@echo off
if exist tasks/nukkit.bat (
	@echo [Info] Loading the Nukkit Module >> log.txt
) else (
	exit
)

set startdir=%~dp0

cd %startdir%

set content=..\Git\bin\bash.exe

set v=
for /f "delims=" %%i in ('type version.txt') do set v=%%i

title Running SpigotMC Updater v.%v% Nukkit Module

%content% --login -i -c "sleep 5s"

@echo Updating nukkit.jar
@echo [Info] Updating nukkit.jar >> ..\log.txt
If not exist ../nukkit/ (
	powershell.exe -command write-host "The nukkit folder is missing. Creating directory..." -f yellow
	@echo [WARNING] The nukkit folder is missing. Creating directory... >> ..\log.txt
	md ..\nukkit
	%content% --login -i -c "sleep 5s"
	If exist ../nukkit/ (
		powershell.exe -command write-host "The nukkit folder has been sucessfully created." -f green
		@echo [Info] The nukkit folder has been sucessfully created. >> ..\log.txt
	) else (
		powershell.exe -command write-host "The nukkit folder was not created due to Read and Write not enabled. Terminating Nukkit Module." -f red
		@echo [ERROR] The nukkit folder was not created due to Read and Write not enabled. Terminating Nukkit Module. >> ..\log.txt
		goto error
	)
)
%content% --login -i -c "sleep 5s"

cls

If exist ../nukkit/nukkit-1.*.jar (
	del /f ..\nukkit/nukkit-1.*.jar
	%content% --login -i -c "sleep 5s"
	If not exist ../nukkit/nukkit-1.*.jar (
		powershell.exe -command write-host "Deleted the old nukkit.jar." -f green
		@echo [Info] Deleted the old nukkit.jar. >> ..\log.txt
	) else (
		powershell.exe -command write-host "Could not delete the old nukkit.jar. Make sure you have read/write access in the nukkit folder." -f red
		@echo [ERROR] Could not delete the old nukkit.jar. Make sure you have read/write access in the nukkit folder. >> ..\log.txt
		%content% --login -i -c "sleep 5s"
		goto error
	)
)

%content% --login -i -c "sleep 5s"

cls

@echo Downloading nukkit.jar...
@echo [Info] Downloading nukkit.zip... >> ..\log.txt
%content% --login -i -c "curl -o ../nukkit/nukkit.zip http://ci.mengcraft.com:8080/job/nukkit/lastStableBuild/artifact/target/*zip*/target.zip"
%content% --login -i -c "sleep 5s"
If exist ../nukkit/nukkit.zip (
	powershell.exe -command write-host "Successfully downloaded nukkit.zip from http://ci.mengcraft.com:8080/job/nukkit/lastStableBuild/artifact/target/*zip*/target.zip" -f green
	@echo [Info] Successfully downloaded nukkit.zip from http://ci.mengcraft.com:8080/job/nukkit/lastStableBuild/artifact/target/*zip*/target.zip >> ..\log.txt
	%content% --login -i -c "sleep 5s"
	cls
	@echo Extracting nukkit.zip...
	@echo [Info] Extracting nukkit.zip... ..\log.txt
	%content% --login -i -c "unzip -o ../nukkit/nukkit.zip -d ../nukkit"
	%content% --login -i -c "sleep 5s"
	if exist ../nukkit/target/nukkit-1.*.jar (
		powershell.exe -command write-host "Successfully extracted nukkit.zip. Deleting zip and finishing up..." -f green
		@echo [Info] Successfully extracted nukkit.zip. Deleting zip and finishing up... >> ..\log.txt
		del /f ..\nukkit\nukkit.zip
		%content% --login -i -c "sleep 5s"
		move ..\nukkit\target\nukkit-1.*.jar ..\nukkit
		%content% --login -i -c "sleep 5s"
		rd /s /q ..\nukkit\target
		if exist ../nukkit/nukkit-1.*.jar (
			powershell.exe -command write-host "Successfully extracted grabbed nukkit.jar." -f green
			@echo [Info] Successfully extracted grabbed nukkit.jar. >> ..\log.txt
			%content% --login -i -c "sleep 5s"
		) else (
			goto error
		)
		
	) else (
		powershell.exe -command write-host "Unable to extract nukkit.zip. Make sure the folder nukkit has Read and Write access." -f red
		del /f ..\nukkit\nukkit.zip
		%content% --login -i -c "sleep 5s"
		goto error
	)
	
) else (
	powershell.exe -command write-host "Failed to Download nukkit.zip from http://ci.mengcraft.com:8080/job/nukkit/lastStableBuild/artifact/target/*zip*/target.zip. Maybe you dont have Read and Write Access in the bungee folder or ci.mengcraft.com:8080 is offline." -f red
	@echo [ERROR] Failed to Download nukkit.zip from http://ci.mengcraft.com:8080/job/nukkit/lastStableBuild/artifact/target/*zip*/target.zip. Maybe you dont have Read and Write Access in the bungee folder or ci.mengcraft.com:8080 is offline. >> ..\log.txt
	%content% --login -i -c "sleep 5s"
	goto error
)

cls
powershell.exe -command write-host "Updated Nukkit Successfully." -f green
@echo [Info] Updated Nukkit Successfully. >> ..\log.txt
%content% --login -i -c "sleep 10s"

cd ..\
exit

:error
cls
powershell.exe -command write-host "Failed to Update nukkit.jar" -f red
@echo [ERROR] Failed to Update nukkit.jar. >> ..\log.txt
%content% --login -i -c "sleep 10s"

cd ..\
exit
