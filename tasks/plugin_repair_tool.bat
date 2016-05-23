@echo off

if exist tasks/session.txt (del /f tasks\session.txt
goto boot) else (exit)

:boot
%content% --login -i -c "cd /tasks/"

set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type ..\config\gitlocation.txt') do set content=%%i

@echo Welcome to Plugin Fixer.
%content% --login -i -c "sleep 1s"
:again
cls
@echo Currently Editing plugin.txt
start "SpigotMC Updater | Plugin Configuration" /wait ../config/plugin.txt
%content% --login -i -c "sleep 5s"
cls
set plugin=
for /f "delims=" %%i in ('type ..\config\plugin.txt') do set plugin=%%i

echo.
if exist %plugin%.jar (@echo Found %plugin%.jar. Using Special Mapping Methods.
%content% --login -i -c "java -jar Buildtools_Files/BuildData/bin/SpecialSource-2.jar map -m Buildtools_Files/CraftBukkit/deprecation-mappings.csrg -i ../plugin/%plugin%.jar -o ../plugin/%plugin%-fixed.jar"
@echo Moving %plugin%.jar to plugin\plugin-dump
%content% --login -i -c "sleep 5s"
move ..\plugin\%plugin%.jar ..\plugin\plugin-dump) else (@echo Could not find %plugin%.jar in folder plugin)
echo.
@echo Do you want to run this again: (Y, N)
Set /P "_1=" || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :stop
If /i "%_1%"=="Y" goto again
If /i "%_1%"=="y" goto again
If /i "%_1%"=="N" goto stop
If /i "%_1%"=="n" goto stop

:stop
exit
