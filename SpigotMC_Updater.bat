@echo off

set startdir=%~dp0

if exist tasks\version.txt (goto setupcheck) else (powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/versions/2.0.txt -OutFile tasks/version.txt
goto setupcheck)

:setupcheck
set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

title "SpigotMC Updater v.%v% | Boot Session"
cls
if exist setup.bat (goto setup) else (goto boot)

:setup
@echo I am a dummy file xD >> tasks\session.txt
start /b /wait setup.bat
del /f setup.bat
cls
goto boot

:boot

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

@echo Thanks for Using SpigotMC Updater v.%v% by Legoman99573. Updated and maintained by ShadowCable.
@echo Do you want to Check for updates 
Set /P _2=(Y, N) || Set _2=NothingChosen
If "%_2%"=="NothingChosen" goto :startup
If /i "%_2%"=="Y" goto autoupdate
If /i "%_2%"=="y" goto autoupdate
If /i "%_2%"=="N" goto startup
If /i "%_2%"=="n" goto startup

:autoupdate
@echo I am a dummy file xD >> tasks\session.txt
start "SpigotMC Updater | Auto Update" tasks\update.bat

exit

:startup
cls
If exist %content% (goto boot2) else (@echo bash.exe was not found. Download, or configure gitlocation.txt
Goto error)

:boot2
echo MSGBOX "Make sure to always backup your files incase an update breaks" > %temp%\TEMPmessage.vbs
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q

:start
if Exist menu.bat (goto ready) else (goto error2)

:ready
if exist tasks\session.txt (del /f tasks\session.txt)

@echo I am a dummy file xD >> tasks\session.txt

start /Max /i menu.bat
goto exit

:error
@echo Current invalid location set: %content%
@pause
exit

:error2
@echo Directory or file is missing. Redownload the script.
@pause
exit

:exit
exit
