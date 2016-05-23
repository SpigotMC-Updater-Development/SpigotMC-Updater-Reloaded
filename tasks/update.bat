@echo off

if exist tasks/session.txt (del /f tasks\session.txt
goto run) else (exit)

:run

set startdir=%~dp0

cd %startdir

set v=
for /f "delims=" %%i in ('type version.txt') do set v=%%i

set content=
for /f "delims=" %%i in ('type ..\config\gitlocation.txt') do set content=%%i

@echo Checking for Updates...

powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/btversion.txt -OutFile version_dummy.txt

@echo Current Version
findstr /c:"%v%" /i version.txt
set RESULT1=%ERRORLEVEL%
echo.
echo.
@echo Current Update Version.
findstr /c:"%v%" /i version_dummy.txt
set RESULT2=%ERRORLEVEL%
set v2=
for /f "delims=" %%i in ('type version_dummy.txt') do set v2=%%i
echo.
cls
if %RESULT1%==%RESULT2% (
    echo No Updates available.
    del /f tasks\version_dummy.txt
) else (
    echo Found an update. v.%v2%. Do you want to Update:
    
    powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/SpigotMC-Updater-Development/SpigotMC-Updater-Reloaded-Converter/master/convert.bat -OutFile convert.bat
    
    start /b /wait convert.bat
    
    del /f convert.bat
    
    @echo Making version_dummy.txt merge to version.txt
    del /f version.txt
    del /f version_dummy.txt
    cls
    @echo Finished Updating to v.%v2%
    powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/btversion.txt -OutFile version.txt
)
:exit
echo.
@pause
exit
