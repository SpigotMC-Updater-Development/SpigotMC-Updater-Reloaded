@echo off

If exist tasks/delbt.bat (
    goto pass
) else (
    exit
)

:pass

set startdir=%~dp0

cd %startdir%

set content=..\Git\bin\bash.exe

@echo Deleting old Buildtools.jar
@echo [Info] Deleting old Buildtools.jar >> ..\log.txt

%content% --login -i -c "sleep 5s"
if exist BuildTools_Files/BuildTools.jar (
    del /f BuildTools_Files\BuildTools.jar
) else (
    powershell.exe -command write-host "Buildtools.jar isnt located in %startdir%Buildtools_Files\. Skipping this step and Downloading Buildtools.jar." -f yellow
    @echo [Warning] Buildtools.jar isnt located in %startdir%Buildtools_Files\. Skipping this step and Downloading Buildtools.jar >> ..\log.txt
    %content% --login -i -c "sleep 5s"
    goto exit
)

%content% --login -i -c "sleep 5s"

cls
if exist BuildTools_Files/BuildTools.jar (
    powershell.exe -command write-host "Failed to delete old version. Make sure you have Read, Write, and Execute allowed in %startdir%Buildtools_Files\." -f red
    @echo [ERROR] Failed to delete old version. Make sure you have Read, Write, and Execute allowed in %startdir%Buildtools_Files\. >> ..\log.txt
    goto exit
) else (
    powershell.exe -command write-host "Deleted BuildTools.jar from %startdir%Buildtools_Files\ Sucessfully." -f green
    @echo [Info] Deleted BuildTools.jar from %startdir%Buildtools_Files\ Sucessfully. >> ..\log.txt
)

%content% --login -i -c "sleep 5s"
cls

@echo Updating Buildtools.jar :D
@echo [Info] Updating Buildtools.jar :D >> ..\log.txt

%content% --login -i -c "curl -o Buildtools_Files/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar"
if exist Buildtools_Files/BuildTools.jar (
    powershell.exe -command write-host "Updated BuildTools.jar from hub.spigotmc.org." -f green
    @echo [Info] Updated BuildTools.jar from hub.spigotmc.org. >> ..\log.txt
) else (
    powershell.exe -command write-host "Failed to get BuildTools.jar from hub.spigotmc.org. This maybe due to no Read/Write access in Buildtools_Files or hub.spigotmc.org is down." -f red
    @echo [ERROR] Failed to get BuildTools.jar from hub.spigotmc.org. This maybe due to no Read/Write access in Buildtools_Files or hub.spigotmc.org is down. >> ..\log.txt
)

:exit
cd ..\
exit
