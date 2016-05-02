@echo off

If exist tasks/help.bat (goto run) else (exit)

:run

echo.
@echo ================ {Command List} =================
echo.
echo.
echo.
@echo ============= {Task Command List} ===============
echo.
@echo task copy: Will be implemented later
echo.
@echo -------------------------------------------------
echo.
@echo task update: Updates Buildtools to latest version
echo.
@echo -------------------------------------------------
echo.
@echo task run: Runs Buildtools and saves APIs
echo.
@echo -------------------------------------------------
echo.
@echo task bungee: Updates BungeeCord and its modules
echo.
@echo -------------------------------------------------
echo.
@echo task clean: Deletes Buildtools files
echo.
@echo -------------------------------------------------
echo.
@echo task plugin: Runs Plugin-Fixer
echo.
@echo =================================================
echo.
echo.
echo.
@echo ============ {Program Command List} =============
echo.
@echo program changelog: Shows Changelogs
echo.
@echo -------------------------------------------------
echo.
@echo program update: Updates this script
echo.
@echo =================================================
echo.
echo.
echo.
@echo =========== {Standalone Command List} ===========
echo.
@echo help: Just added it if you want to spam it lol
echo.
@echo -------------------------------------------------
echo.
@echo exit: Shuts Down Program
echo.
@echo =================================================
echo.
exit
