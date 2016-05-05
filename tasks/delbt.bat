@echo off

If exist tasks/delbt.bat (goto pass) else (exit)

:pass

set startdir=%~dp0

@echo Deleting old Buildtools.jar
.echo
if exist tasks\BuildTools.jar (del /f tasks\BuildTools.jar) else (@echo Buildtools.jar isnt located in tasks folder. Skipping this step and Downloading Buildtools.jar
goto exit)
.echo
if exist tasks\BuildTools.jar (@echo Failed to delete old version. Make sure you have Read, Write, and Execute allowed in your directory) else (@echo Deleted old BuildTools.jar Sucessfully)
.echo
@echo Updating Buildtools.jar ;)
.echo

:exit
exit
