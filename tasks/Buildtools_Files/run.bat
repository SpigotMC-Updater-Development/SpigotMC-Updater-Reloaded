@echo off

if exist tasks\Buildtools_Files\run.bat (goto run) else (exit)

set startdir=%~dp0

echo %startdir%
cls

set version=
for /f "delims=" %%i in ('type config\version.txt') do set version=%%i

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i


cd %startdir%

%content% --login -i -c "java -jar BuildTools.jar --rev %version%"

exit
