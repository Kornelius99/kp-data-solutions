@echo off
cd /d "%~dp0"
git status --short
set /p msg=Commit message (press Enter for Website update): 
if "%msg%"=="" set msg=Website update
git add .
git commit -m "%msg%"
if errorlevel 1 (
  echo Nothing to commit or commit failed.
  pause
  exit /b
)
git push origin main
if errorlevel 1 (echo Push failed. & pause & exit /b)
echo Website published successfully.
pause
