@echo off
setlocal EnableDelayedExpansion
title CMJ Fleet Masterclass - Deploy
cd /d "%~dp0"

echo ============================================
echo   CMJ FLEET MASTERCLASS - ONE-CLICK DEPLOY
echo   Rule: THIS folder is the boss of the site
echo ============================================
echo.

where git >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Git is not installed. Get it from https://git-scm.com/download/win
    pause
    exit /b 1
)

if not exist ".git" (
    echo [SETUP] Connecting this folder to GitHub...
    git init >nul
    git branch -M main
    git remote add origin https://github.com/adamdispatching-stack/fleet.git >nul 2>nul
)
git config core.autocrlf false >nul 2>nul
git config core.safecrlf false >nul 2>nul

set "msg=%*"
if "!msg!"=="" set "msg=App update %date% %time:~0,8%"

echo [1/2] Saving your changes...
git add -A
git commit -m "!msg!" >nul 2>nul
if errorlevel 1 (
    echo        Nothing new to save - files unchanged since last deploy.
) else (
    echo        Saved: "!msg!"
)

echo [2/2] Publishing this folder to GitHub...
git push --force -u origin main
if errorlevel 1 (
    echo.
    echo [FAILED] Could not publish.
    echo  - If a login window appeared, finish logging in and run this again.
    echo  - Check your internet connection, then run this again.
    echo  - Still stuck? Screenshot this window and send it to Claude.
    echo.
) else (
    echo.
    echo ============================================
    echo   DEPLOYED. This folder is now EXACTLY what
    echo   is on GitHub. Railway builds in 1-2 min.
    echo ============================================
    echo.
)
pause
