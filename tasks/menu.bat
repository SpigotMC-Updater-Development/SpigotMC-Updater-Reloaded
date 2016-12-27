@echo off

if exist tasks/menu.bat (
	@echo [Info] Loading Menu Module... >> log.txt
) else (
	exit
)

set startdir=%~dp0

cls

set content=Git\bin\bash.exe

set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

title SpigotMC Updater v.%v%

echo MSGBOX "Make sure to always backup your files incase an update breaks" >> %temp%\TEMPmessage.vbs
%content% --login -i -c "sleep 5s"
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q

goto load

:start
title SpigotMC Updater v.%v%

:load
cls

powershell.exe -command write-host "Welcome to SpigotMC Updater v.%v% `r`n `r`noOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOo `r`n What task do you want to run? Must use numbers and press enter. `r`n 1. Update Buildtools `r`n 2. Run Buildtools `r`n 3. Cleans BuildTools Folder `r`n 4. Repair a plugin with the Spigot Special Recipe `r`n 5. Grab BungeeCord `r`n 6. Grabs PaperSpigot `r`n 7. Grabs Nukkit `r`n 8. Report a bug in this script `r`n 9. Close this script safely `r`noOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOo" -f darkyellow

CHOICE /C 123456789 /N /M "> "
IF ERRORLEVEL 9 GOTO exit
IF ERRORLEVEL 8 GOTO bug
IF ERRORLEVEL 7 GOTO nukkit
IF ERRORLEVEL 6 GOTO paper
IF ERRORLEVEL 5 GOTO bungee
IF ERRORLEVEL 4 GOTO plugin
IF ERRORLEVEL 3 GOTO clean
IF ERRORLEVEL 2 GOTO run
IF ERRORLEVEL 1 GOTO update

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

:nukkit
cls
start /b /wait tasks\nukkit.bat
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
