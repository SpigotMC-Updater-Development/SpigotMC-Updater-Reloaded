@echo off

if exist tasks/session.txt (
	del /f tasks\session.txt
) else (
	exit
)

set startdir=%~dp0

cd %startdir%

set v=
for /f "delims=" %%i in ('type version.txt') do set v=%%i

set content=..\Git\bin\bash.exe

@echo Checking for Updates...

powershell -command Invoke-WebRequest -Uri http://thegearmc.net/spigotmc-updater/update.txt -OutFile version_dummy.txt
%content% --login -i -c "sleep 5s"

@echo Current Version
findstr /c:"%v%" /i version.txt
set RESULT1=%ERRORLEVEL%
echo.
%content% --login -i -c "sleep 3s"
@echo Current Update Version.
findstr /c:"%v%" /i version_dummy.txt
set RESULT2=%ERRORLEVEL%
set v2=
for /f "delims=" %%i in ('type version_dummy.txt') do set v2=%%i
%content% --login -i -c "sleep 5s"
cls
if %RESULT1%==%RESULT2% (
	powershell.exe -command write-host "You are using. v.%v%. Latest Version v.%v2%. `r`nNo Updates available." -f yellow
    @echo [Info] You are using. v.%v%. Latest Version v.%v2%. >> ..\log.txt
	@echo [WARNING] No Updates available. >> ..\log.txt
    del /f tasks\version_dummy.txt
) else (
    powershell.exe -command write-host "You are using. v.%v%. Latest Version v.%v2%. `r1nUpdate Available." -f green
    @echo [Info] You are using. v.%v%. Latest Version v.%v2%. ..\log.txt
	@echo [Info] Update Available. >> ..\log.txt
	
	powershell -command Invoke-WebRequest -Uri http://thegearmc.net/spigotmc-updater/update.zip -OutFile Update-v.%v2%.zip
	%content% --login -i -c "sleep 5s"
	
	if exist Update-v.%v2%.zip (
		%content% --login -i -c "unzip -o Update-v.%v2%.zip -d ../"
	) else (
		powershell.exe -command write-host "Update to v.%v2% Failed. It could be due to no Read/Write access or https://thegearmc.net/spigotmc-updater/update.zip is being updated itself." -f red
		@echo [ERROR] Update to v.%v2% Failed. It could be due to no Read/Write access or https://thegearmc.net/spigotmc-updater/update.zip is being updated itself.
		del /f version_dummy.txt
		%content% --login -i -c "sleep 5s"
		cd ..\
		exit
	)
	
	%content% --login -i -c "sleep 5s"
    cls
    @echo Making version_dummy.txt merge to version.txt
	@echo [Info] Making version_dummy.txt merge to version.txt >> ..\log.txt
    del /f version.txt
	%content% --login -i -c "sleep 5s"
    rename version_dummy.txt version.txt
	%content% --login -i -c "sleep 5s"
	set v=
	for /f "delims=" %%i in ('type version.txt') do set v=%%i
    cls
    @echo Finished Updating to v.%v%. Resuming script...
	@echo [Info] Finished Updating to v.%v%. Resuming script... >> ..\log.txt
)
%content% --login -i -c "sleep 10s"
cd ..\
exit
