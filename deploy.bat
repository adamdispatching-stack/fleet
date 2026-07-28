@echo off
setlocal EnableDelayedExpansion
title CMJ Fleet Masterclass - Deploy
cd /d "%~dp0"
echo ============================================
echo   CMJ FLEET MASTERCLASS - ONE-CLICK DEPLOY
echo ============================================
echo.
where git >nul 2>nul || ( echo [ERROR] Install Git: https://git-scm.com/download/win & pause & exit /b 1 )
git symbolic-ref -q HEAD >nul 2>nul || git checkout -B main
git checkout -B main >nul 2>nul
git config core.autocrlf false >nul 2>nul
git remote remove origin >nul 2>nul
git remote add origin https://github.com/adamdispatching-stack/fleet.git
echo Repo:
git remote get-url origin
echo.
echo [1/2] Saving...
git add -A
git commit -m "Deploy %date% %time:~0,8%" >nul 2>nul
git commit --allow-empty -m "Deploy marker %time:~0,8%" >nul 2>nul
echo        Saved.
echo [2/2] Publishing (real output):
echo --------------------------------------------
git push --force -u origin main
echo --------------------------------------------
echo.
echo Look for 'main -^> main' above = SUCCESS. Railway builds in 1-2 min.
echo Red error? Screenshot this window for Claude.
pause
