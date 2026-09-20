@echo off
cd /d "%~dp0"
echo.
echo KP Data Solutions - Publish Website
echo -----------------------------------
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
  echo ERROR: This folder is not the Git repository.
  echo Copy these website files into E:\kp-data-solutions and run publish.bat there.
  pause
  exit /b 1
)
git status --short
echo.
set /p msg=Commit message (press Enter for Website update): 
if "%msg%"=="" set msg=Website update
git add .
git commit -m "%msg%"
if errorlevel 1 echo No new changes to commit.
git push origin main
if errorlevel 1 (
  echo Push failed. Review the message above.
  pause
  exit /b 1
)
echo.
echo Published successfully.
pause
