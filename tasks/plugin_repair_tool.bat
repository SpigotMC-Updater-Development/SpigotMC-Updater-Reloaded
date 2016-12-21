@echo off

if exist tasks/plugin_repair_tool.bat (
	@echo [Info] Loading PluginRepairTool Module...
) else (
	exit
)

set startdir=%~dp0

cd %startdir%

set v=
for /f "delims=" %%i in ('type version.txt') do set v=%%i

title Running SpigotMC Updater v.%v% PluginRepairTool Module

set content= ..\Git\bin\bash.exe

set plugin=
for /f "delims=" %%i in ('type ..\config\plugin.txt') do set plugin=%%i

powershell.exe -command write-host "This tool may not fix all jar issues. We recommend updating your code manually or find alternates of the plugin that does not work." -f yellow
@echo [WARNING] This tool may not fix all jar issues. We recommend updating your code manually or find alternates of the plugin that does not work. >> ..\log.txt
%content% --login -i -c "sleep 15s"

cls

if exist Buildtools_Files/BuildData/bin/SpecialSource-2.jar (
	powershell.exe -command write-host "Found SpecialSource-2.jar." -f green
	@echo [Info] Found SpecialSource-2.jar. >> ..\log.txt
) else (
	powershell.exe -command write-host "SpecialSource-2.jar was not found. Maybe you have not ran BuildTools.jar before or Spigot no longer supports it." -f red
	@echo [ERROR] SpecialSource-2.jar was not found. Maybe you have not ran BuildTools.jar before or Spigot no longer supports it. >> ..\log.txt
)

%content% --login -i -c "sleep 5s"
if exist Buildtools_Files/CraftBukkit/deprecation-mappings.csrg (
	powershell.exe -command write-host "Found deprecation-mappings.csrg." -f green
	@echo [Info] Found deprecation-mappings.csrg. >> ..\log.txt
) else (
	powershell.exe -command write-host "deprecation-mappings.csrg was not found. Maybe you have not ran BuildTools.jar before or Spigot no longer supports it." -f red
	@echo [ERROR] deprecation-mappings.csrg was not found. Maybe you have not ran BuildTools.jar before or Spigot no longer supports it. >> ..\log.txt
)

if exist %plugin%.jar (
	powershell.exe -command write-host "Found %plugin%.jar. Using Special Mapping Methods." -f green
	@echo [Info] Found %plugin%.jar. Using Special Mapping Methods. >> ..\log.txt
	%content% --login -i -c "java -jar Buildtools_Files/BuildData/bin/SpecialSource-2.jar map -m Buildtools_Files/CraftBukkit/deprecation-mappings.csrg -i ../plugin/%plugin%.jar -o ../plugin/%plugin%-fixed.jar"
	%content% --login -i -c "sleep 5s"
	
	if exist ../plugin/%plugin%-fixed.jar (
		@echo Moving %plugin%.jar to plugin\plugin-dump
		%content% --login -i -c "sleep 5s"
		move ..\plugin\%plugin%.jar ..\plugin\plugin-dump
		
		%content% --login -i -c "sleep 5s"
		if exist ../plugin/plugin-dump/%plugin%.jar (
			powershell.exe -command write-host "%plugin%.jar was moved succesfully." -f green
			@echo [Info] %plugin%.jar was moved succesfully. >> ..\log.txt
		) else (
			powershell.exe -command write-host "Failed to move %plugin%.jar. Make sure you have read and write access to the plugin and plugin-dump folders." -f red
			@echo [ERROR] Failed to move %plugin%.jar. Make sure you have read and write access to the plugin and plugin-dump folders. >> ..\log.txt
		)
		
	) else (
		powershell.exe -command write-host "The program has failed to fix the jar using SpecialSource jar. Would recommend checking your code and edit it manually." -f yellow
		@echo [WARNING] The program has failed to fix the jar using SpecialSource jar. Would recommend checking your code and edit it manually. >> ..\log.txt
	)
	
) else (
	@echo [ERROR] Could not find %plugin%.jar in folder plugin. >> ..\log.txt
)

%content% --login -i -c "sleep 5s"

cd ..\
exit
