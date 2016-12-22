@echo off

if exist tasks/menu.bat (
	@echo [Info] Loading Menu Module... >> log.txt
) else (
	exit
)

set startdir=%~dp0

set content=Git\bin\bash.exe

set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

echo MSGBOX "Make sure to always backup your files incase an update breaks" >> %temp%\TEMPmessage.vbs
%content% --login -i -c "sleep 5s"
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q

:start
cls
title SpigotMC Updater v.%v%

powershell.exe -command write-host "Welcome to SpigotMC Updater v.%v% `r`n `r`noOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOo `r`n What task do you want to run? Must use numbers and press enter. `r`n 1. Update Buildtools `r`n 2. Run Buildtools `r`n 3. Cleans BuildTools Folder `r`n 4. Repair a plugin with the Spigot Special Recipe `r`n 5. Grab BungeeCord `r`n 6. Grabs PaperSpigot `r`n 7. Report a bug in this script `r`n 8. Close this script safely `r`noOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOo" -f darkyellow

Set /P "_1=>" || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :commandnotfound
If /i "%_1%"=="1" goto update
If /i "%_1%"=="2" goto run
If /i "%_1%"=="3" goto clean
If /i "%_1%"=="4" goto plugin
If /i "%_1%"=="5" goto bungee
If /i "%_1%"=="6" goto paper
If /i "%_1%"=="7" goto bug
If /i "%_1%"=="8" goto exit

:commandnotfound
@echo Command not found. Try help for help menu
%content% --login -i -c "sleep 5s"
goto start

:update
cls
start /b /wait tasks\updatebt.bat
goto start

:run
cls
start /b /wait tasks\Buildtools_Files\run.bat
goto start

:clean
cls
start /b /wait tasks\Buildtools_Files\cleanup.bat
goto start

:bungee
cls
start /b /wait tasks\bungee.bat
goto start

:paper
cls
start /b /wait tasks\paper.bat
goto start

:bug
cls
start /b /wait tasks\reportbug.bat
goto start

:exit
cls

@echo Thanks for using SpigotMC Updater v.%v% by Legoman99573.

%content% --login -i -c "sleep 15s"

exit

