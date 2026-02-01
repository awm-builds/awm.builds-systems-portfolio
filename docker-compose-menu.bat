@echo off
setlocal enabledelayedexpansion

:menu
cls
echo.
echo ========================================
echo     Docker Compose Management
echo ========================================
echo.
echo 1) Run containers (START)
echo    Command: docker compose up --build
echo.
echo 2) Stop containers (SAFE - keeps data)
echo    Command: docker compose down
echo.
echo 3) Reset database (DANGEROUS - deletes data)
echo    Command: docker compose down -v
echo.
echo 4) Exit
echo.
echo ========================================

set /p choice="Select option (1, 2, 3, or 4): "

if "!choice!"=="1" goto run_start
if "!choice!"=="2" goto stop_safe
if "!choice!"=="3" goto reset_dangerous
if "!choice!"=="4" goto exit_menu
goto invalid_choice

:run_start
echo.
echo Starting containers...
docker compose up --build
echo.
echo SUCCESS: Containers started.
pause
goto menu

:stop_safe
echo.
echo Stopping containers (keeping data)...
docker compose down
echo.
echo SUCCESS: Containers stopped. Data preserved.
pause
goto menu

:reset_dangerous
echo.
echo ========================================
echo            !! WARNING !!
echo ========================================
echo This will PERMANENTLY DELETE your database!
echo All data in the pgdata volume will be lost.
echo ========================================
echo.
set /p confirm="Type 'DELETE' to confirm (all caps): "

if /i not "!confirm!"=="DELETE" (
    echo Cancelled. Database preserved.
    pause
    goto menu
)

echo.
echo Deleting database volume...
docker compose down -v

if errorlevel 1 (
    echo.
    echo ERROR: Database reset FAILED
    pause
    goto menu
)

echo.
echo SUCCESS: Database reset complete.
pause
goto menu

:invalid_choice
echo.
echo Invalid selection. Please enter 1, 2, 3, or 4.
pause
goto menu

:exit_menu
exit /b 0