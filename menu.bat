@echo off

if exist tasks/session.txt (del /f tasks\session.txt
goto boot) else (exit)

:boot
set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

if exist %content% (goto start) else (goto error1)

:start
cls
title SpigotMC Updater v.%v%
@echo Welcome to SpigotMC Updater v.%v%
start /b /wait tasks\help.bat
:commanderror
Set /P "_1=>" || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :commandnotfound
If /i "%_1%"=="task update" goto update
If /i "%_1%"=="task run" goto run
If /i "%_1%"=="help" goto start
If /i "%_1%"=="task clean" goto clean
If /i "%_1%"=="task plugin" goto plugin
If /i "%_1%"=="task bungee" goto bungee
If /i "%_1%"=="task issues" goto issues
If /i "%_1%"=="program update" goto updatetool
If /i "%_1%"=="exit" goto exit

:commandnotfound
@echo Command not found. Try help for help menu
goto commanderror

:update
cls
start /b /wait %startdir%tasks\delbt.bat
%content% --login -i -c "sleep 3s"
%content% --login -i -c "curl -o tasks/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar"
if exist %startdir%tasks\BuildTools.jar (@echo Updated BuildTools) else (@echo An error has occured. Make sure folder has read, write, and execute access.)
goto start

:run
cls
@echo Warning: exiting while this is running may cause something to break, and not move buildtools files at the right time leaving a mess until you run this command again.
@pause
@echo getting Buildtools Ready
if exist %startdir%tasks\Buildtools_Files\apache-maven-3.2.5 (move %startdir%tasks\Buildtools_Files\apache-maven-3.2.5 %startdir%) else (echo.
echo Folder "apache-maven-3.2.5" doesnt exist may be ignored)
if exist %startdir%tasks\Buildtools_Files\BuildData (move %startdir%tasks\Buildtools_Files\BuildData %startdir%) else (echo.
echo Folder "BuildData" doesnt exist may be ignored)
if exist %startdir%tasks\Buildtools_Files\Bukkit (move %startdir%tasks\Buildtools_Files\Bukkit %startdir%) else (echo.
echo Folder "Bukkit" doesnt exist may be ignored)
if exist %startdir%tasks\Buildtools_Files\CraftBukkit (move %startdir%tasks\Buildtools_Files\CraftBukkit %startdir%) else (echo.
echo "Folder" CraftBukkit doesnt exist may be ignored)
if exist %startdir%tasks\Buildtools_Files\Spigot (move %startdir%tasks\Buildtools_Files\Spigot %startdir%) else (echo.
echo Folder "Spigot" doesnt exist may be ignored)
if exist %startdir%tasks\Buildtools_Files\work (move %startdir%tasks\Buildtools_Files\work %startdir%) else (echo.
echo Folder "work" doesnt exist may be ignored)

if exist tasks\BuildTools.jar (@echo Running BuildTools.jar) else (@echo Buildtools.jar is missing
echo.
@echo Grabbing BuildTools.jar from hub.spigotmc.org
echo.
%content% --login -i -c "curl -o tasks/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar"
echo.
@echo Grabbed, and will attempt to run BuildTools.jar
)
@echo I am a dummy file xD >> tasks\session.txt
cls
start /b /wait runbuildtools.bat
cls
@echo Moving Buildtools Folder back to its original spot
echo.
if exist %startdir%\apache-maven-3.2.5 ( move apache-maven-3.2.5 tasks\Buildtools_Files )
echo.
if exist %startdir%\BuildData ( move BuildData tasks\Buildtools_Files )
echo.
if exist %startdir%\Bukkit ( move Bukkit tasks\Buildtools_Files )
echo.
if exist %startdir%\CraftBukkit ( move CraftBukkit tasks\Buildtools_Files )
echo.
if exist %startdir%\Spigot ( move Spigot tasks\Buildtools_Files )
echo.
if exist %startdir%\Work ( move work tasks\Buildtools_Files )
echo.

set datetime=
for /f %%a in ('powershell -Command "Get-Date -format yyyy_MM_dd__HH_mm_ss"') do set datetime=%%a

if exist BuildTools.log.txt (rename BuildTools.log.txt Buildtools.log.%datetime%.txt
move BuildTools.log.*.txt %startdir%logs)

@echo Moving Server jars into folder %startdir%serverjars\
%content% --login -i -c "sleep 1s"
echo.
@echo Moving Spigot
%content% --login -i -c "sleep 3s"
echo.
if exist spigot-*.jar (move spigot-*.jar %startdir%serverjars
%content% --login -i -c "sleep 3s"
echo.
if exist spigot-*.jar (@echo Failed to move Spigot) else (@echo Moved Spigot service Successfully)
) else (@echo File doesnt exist)
echo.
%content% --login -i -c "sleep 2s"
@echo Moving Craftbukkit
%content% --login -i -c "sleep 1s"
echo.
if exist craftbukkit-*.jar (move craftbukkit-*.jar %startdir%serverjars
echo.
%content% --login -i -c "sleep 2s"
if exist craftbukkit-*.jar (@echo Failed to move Craftbukkit) else (@echo Moved Craftbukkit service Successfully)
) else (@echo File doesnt exist)
@echo.
@echo Copying Spigot API's to api folder
%content% --login -i -c "sleep 1s"
echo.
copy %startdir%tasks\Buildtools_Files\Spigot\Spigot-API\target\spigot-api-*.jar %startdir%api
cls
@echo Finished running BuildTools
%content% --login -i -c "sleep 3s"
goto start

:clean
cls
@echo Are you sure you want to clear all of Buildtools Files
Set /P "_clear=(Y, N)" || Set _clear=NothingChosen
If "%_clear%"=="NothingChosen" goto start
If /i "%_clear%"=="Y" goto cleanrun
If /i "%_clear%"=="y" goto cleanrun
If /i "%_clear%"=="N" goto start
If /i "%_clear%"=="n" goto start
:cleanrun
@echo Deleting every folder in %startdir%Buildtools_Files\
rd /q tasks\Buildtools_Files
%content% --login -i -c "sleep 1s"
if exist %startdir%tasks\Buildtools_Files (@echo Cleaning of %startdir%Buildtools_Files\ Failed. Make sure the folder has read, write, and execute enabled.
goto start) else (@echo Cleaning of %startdir%Buildtools_Files\ was Successfuly)
%content% --login -i -c "sleep 1s"
md tasks\Buildtools_Files
%content% --login -i -c "sleep 1s"
echo.
@echo All Buildtools Files were removed.
%content% --login -i -c "sleep 3s"
goto start

:plugin
@echo I am a dummy file xD >> tasks\session.txt
cls
start /b /wait plugin_repair_tool.bat
@echo Finished using Plugin Repair Tool by SpigotMC Updater. Thanks to md_5 for making the original repair script as he does not endorse or maintains this script.
%content% --login -i -c "sleep 1s"
goto start

:bungee
cls
@echo Updating BungeeCord and its modules.
If not exist %startdir%bungee (md bungee)
If not exist %startdir%bungee\modules (md bungee\modules)

If exist bungee\BungeeCord.jar (del /f bungee\BungeeCord.jar)
%content% --login -i -c "sleep 1s"
If exist bungee\modules\cmd_find.jar (del /f bungee\modules\cmd_find.jar)
%content% --login -i -c "sleep 1s"
If exist bungee\modules\cmd_server.jar (del /f bungee\modules\cmd_server.jar)
%content% --login -i -c "sleep 1s"
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
@echo Updated BungeeCord and all its Modules

:rerun
start "bungeelocation Config Option" /wait config\bungeelocation.txt

set bungee=
for /f "delims=" %%i in ('type config\bungeelocation.txt') do set bungee=%%i

if exist %bungee% (goto bungeecopy) else (goto rerun)

:bungeecopy
cls
@echo Replacing old update(s) with new ones ;)

if exist %bungee%BungeeCord.jar (del /f %bungee%BungeeCord.jar
%content% --login -i -c "sleep 1s"
del /f %bungee%modules\cmd_find.jar
%content% --login -i -c "sleep 1s"
del /f %bungee%modules\cmd_server.jar
%content% --login -i -c "sleep 1s"
del /f %bungee%modules\cmd_send.jar
%content% --login -i -c "sleep 1s"
del /f %bungee%modules\cmd_list.jar
%content% --login -i -c "sleep 1s"
del /f %bungee%modules\cmd_alert.jar
%content% --login -i -c "sleep 1s"
del /f %bungee%modules\reconnect_yaml.jar
@echo Deleted old Updates) else (@echo Nothing to delete at all. This can be ignored)


%content% --login -i -c "sleep 1s"
cls

@echo Placing in new Updated jars into folder %bungee%
%content% --login -i -c "sleep 1s"

copy bungee\Bungeecord.jar %bungee% /v /-y
%content% --login -i -c "sleep 1s"
copy bungee\modules\cmd_find.jar %bungee%modules /v /-y
%content% --login -i -c "sleep 1s"
copy bungee\modules\cmd_server.jar %bungee%modules /v /-y
%content% --login -i -c "sleep 1s"
copy bungee\modules\cmd_send.jar %bungee%modules /v /-y
%content% --login -i -c "sleep 1s"
copy bungee\modules\cmd_list.jar %bungee%modules /v /-y
%content% --login -i -c "sleep 1s"
copy bungee\modules\cmd_alert.jar %bungee%modules /v /-y
%content% --login -i -c "sleep 1s"
copy bungee\modules\reconnect_yaml.jar %bungee%modules /v /-y

goto start

:error1

explorer "https://github.com/git-for-windows/git/releases/download/v2.7.2.windows.1/Git-2.7.2-64-bit.exe"

:exit
cls
@echo Thanks for using SpigotMC Updater v.%v% by Legoman99573. Updated by ShadowCable.
@pause
exit
