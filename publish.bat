@echo off
setlocal
cd /d "%~dp0"

echo ==========================================
echo   KP Data Solutions - Publish Website
echo ==========================================
echo.

where git >nul 2>nul
if errorlevel 1 (
  echo ERROR: Git is not installed or is not available in PATH.
  echo Install Git for Windows, then try again.
  pause
  exit /b 1
)

if not exist ".git" (
  echo ERROR: This folder is not connected to Git yet.
  echo.
  echo Put publish.bat inside your existing kp-data-solutions Git repository,
  echo or open Git Bash here and connect this folder to your GitHub repository first.
  pause
  exit /b 1
)

echo Checking website changes...
git status --short

git diff --quiet && git diff --cached --quiet
if not errorlevel 1 (
  echo.
  echo No website changes found. Nothing to publish.
  pause
  exit /b 0
)

echo.
set /p MESSAGE=Commit message [Update KP Data Solutions website]: 
if "%MESSAGE%"=="" set "MESSAGE=Update KP Data Solutions website"

echo.
echo Adding files...
git add .
if errorlevel 1 goto :failed

echo Creating commit...
git commit -m "%MESSAGE%"
if errorlevel 1 goto :failed

echo Publishing to GitHub...
git push origin main
if errorlevel 1 goto :failed

echo.
echo ==========================================
echo SUCCESS: Website published to GitHub.
echo GitHub Pages will update the live website shortly.
echo ==========================================
pause
exit /b 0

:failed
echo.
echo ==========================================
echo PUBLISH FAILED.
echo Read the Git message above for the reason.
echo Your local website files have not been deleted.
echo ==========================================
pause
exit /b 1
