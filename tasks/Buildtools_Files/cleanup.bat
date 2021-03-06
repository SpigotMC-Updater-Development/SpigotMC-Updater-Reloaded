@echo off

if exist tasks/Buildtools_Files/cleanup.bat (
	@echo [Info] Loading Cleanup Module... >> log.txt
) else (
	exit
)

set startdir=%~dp0

set v=
for /f "delims=" %%i in ('type tasks\version.txt') do set v=%%i

title Running SpigotMC Updater v.%v% Cleanup Module

cd %startdir%

set content=..\..\Git\bin\bash.exe

if exist BuildTools.jar (

	@echo Deleting every folder in %startdir% that was generated by BuildTools.jar
	@echo [Info] Deleting every folder in %startdir% that was generated by BuildTools.jar >> ..\..\log.txt

	if exist mvn.zip (
		del /f mvn.zip
		%content% --login -i -c "sleep 5s"

		if exist mvn.zip (
			powershell.exe -command write-host "Cleaning of %startdir%mvn.zip Failed. Make sure %startdir% has Read/Write enabled." -f red
			@echo [ERROR] Cleaning of %startdir%mvn.zip Failed. Make sure %startdir% has Read/Write enabled. >> ..\..\log.txt
		) else (
			powershell.exe -command write-host "Cleaning of %startdir%mvn.zip was Successful" -f green
			@echo [Info] Cleaning of %startdir%mvn.zip was Successful >> ..\..\log.txt
		)
	)

	if exist apache-maven-3.2.5/ (
		rmdir /q /s apache-maven-3.2.5
		%content% --login -i -c "sleep 5s"
		if exist apache-maven-3.2.5/ (
			powershell.exe -command write-host "Cleaning of %startdir%apache-maven-3.2.5 Failed. Make sure %startdir% has Read/Write enabled." -f red
			@echo [ERROR] Cleaning of %startdir%apache-maven-3.2.5 Failed. Make sure %startdir% has Read/Write enabled. >> ..\..\log.txt
		) else (
			powershell.exe -command write-host "Cleaning of %startdir%apache-maven-3.2.5 was Successful" -f green
			@echo [Info] Cleaning of %startdir%apache-maven-3.2.5 was Successful >> ..\..\log.txt
		)
	) else (
		powershell.exe -command write-host "%startdir%apache-maven-3.2.5 was not found. Skipping Check." -f yellow
		@echo [WARNING] %startdir%apache-maven-3.2.5 was not found. Skipping Check. >> ..\..\log.txt
	)


	if exist BuildData/ (
		rmdir /q /s BuildData
		%content% --login -i -c "sleep 5s"
		if exist BuildData/ (
			powershell.exe -command write-host "Cleaning of %startdir%BuildData Failed. Make sure %startdir% has Read/Write enabled." -f red
			@echo [ERROR] Cleaning of %startdir%BuildData Failed. Make sure %startdir% has Read/Write enabled. >> ..\..\log.txt
		) else (
			powershell.exe -command write-host "Cleaning of %startdir%BuildData was Successful" -f green
			@echo [Info] Cleaning of %startdir%BuildData was Successful >> ..\..\log.txt
		)
	) else (
		powershell.exe -command write-host "%startdir%BuildData was not found. Skipping Check." -f yellow
		@echo [WARNING] %startdir%BuildData was not found. Skipping Check. >> ..\..\log.txt
	)

	if exist Bukkit/ (
		rmdir /q /s Bukkit
		%content% --login -i -c "sleep 5s"
		if exist Bukkit/ (
			powershell.exe -command write-host " Cleaning of %startdir%Buildtools_Files\Bukkit Failed. Make sure %startdir% has Read/Write enabled." -f red
			@echo [ERROR] Cleaning of %startdir%Buildtools_Files\Bukkit Failed. Make sure %startdir% has Read/Write enabled. >> ..\..\log.txt
		) else (
			powershell.exe -command write-host "Cleaning of %startdir%Buildtools_Files\Bukkit was Successful" -f green
			@echo [Info] Cleaning of %startdir%Buildtools_Files\Bukkit was Successful >> ..\..\log.txt
		)
	) else (
		powershell.exe -command write-host "%startdir%Bukkit was not found. Skipping Check." -f yellow
		@echo [WARNING] %startdir%Bukkit was not found. Skipping Check. >> ..\..\log.txt
	)

	if exist CraftBukkit/ (
		rmdir /q /s CraftBukkit
		%content% --login -i -c "sleep 5s"
		if exist CraftBukkit/ (
			powershell.exe -command write-host "Cleaning of %startdir%CraftBukkit Failed. Make sure %startdir% has Read/Write enabled." -f red
			@echo [ERROR] Cleaning of %startdir%CraftBukkit Failed. Make sure %startdir% has Read/Write enabled. >> ..\..\log.txt
		) else (
			powershell.exe -command write-host "Cleaning of %startdir%CraftBukkit was Successful" -f green
			@echo [Info] Cleaning of %startdir%CraftBukkit was Successful >> ..\..\log.txt
		)
	) else (
		powershell.exe -command write-host "%startdir%CraftBukkit was not found. Skipping Check." -f yellow
		@echo [WARNING] %startdir%CraftBukkit was not found. Skipping Check. >> ..\..\log.txt
	)

	if exist Spigot/ (
		rmdir /q /s Spigot
		%content% --login -i -c "sleep 5s"
		if exist Spigot/ (
			powershell.exe -command write-host "Cleaning of %startdir%Spigot Failed. Make sure %startdir% has Read/Write enabled." -f red
			@echo [ERROR] Cleaning of %startdir%Spigot Failed. Make sure %startdir% has Read/Write enabled. >> ..\..\log.txt
		) else (
			powershell.exe -command write-host "Cleaning of %startdir%Spigot was Successful" -f green
			@echo [Info] Cleaning of %startdir%Spigot was Successful >> ..\..\log.txt
		)
	) else (
		powershell.exe -command write-host "%startdir%Spigot was not found. Skipping Check." -f yellow
		@echo [WARNING] %startdir%Spigot was not found. Skipping Check. >> ..\..\log.txt
	)

	if exist work/ (
		rmdir /q /s work
		%content% --login -i -c "sleep 5s"
		if exist work/ (
			powershell.exe -command write-host "Cleaning of %startdir%work Failed. Make sure %startdir% has Read/Write enabled." -f red
			@echo [ERROR] Cleaning of %startdir%work Failed. Make sure %startdir% has Read/Write enabled. >> ..\..\log.txt
		) else (
			powershell.exe -command write-host "Cleaning of %startdir%work was Successful" -f green
			@echo [Info] Cleaning of %startdir%work was Successful >> ..\..\log.txt
		)
	) else (
		powershell.exe -command write-host "%startdir%work was not found. Skipping Check." -f yellow
		@echo [WARNING] %startdir%work was not found. Skipping Check. >> ..\..\log.txt
	)
	
	%content% --login -i -c "sleep 5s"
	
	cls
	
	powershell.exe -command write-host "Finished cleanup BuildTools.jar. Make sure to check log.txt for errors if you have any." -f green
	@echo [Info] Finished cleanup BuildTools.jar. Make sure to check log.txt for errors if you have any. >> ..\..\log.txt
) else (
	powershell.exe -command write-host "You are missing BuildTools.jar in %startdir%. Make sure you have pressed 1 or 2 options to get the jar." -f red
	@echo [ERROR] You are missing BuildTools.jar in %startdir%. Make sure you have pressed 1 or 2 options to get the jar. >> ..\..\log.txt
)
%content% --login -i -c "sleep 10s"

cd ..\..\
exit
