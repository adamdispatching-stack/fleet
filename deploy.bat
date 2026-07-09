@echo off
setlocal EnableDelayedExpansion
title CMJ Fleet Masterclass - Deploy
cd /d "%~dp0"

echo ============================================
echo   CMJ FLEET MASTERCLASS - ONE-CLICK DEPLOY
echo ============================================
echo.

REM --- check git is installed ---
where git >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Git is not installed on this computer.
    echo Download it from: https://git-scm.com/download/win
    echo Install with default options, then run this file again.
    echo.
    pause
    exit /b 1
)

REM --- first-time setup: turn this folder into the repo ---
if not exist ".git" (
    echo [SETUP] First time - connecting this folder to GitHub...
    git init >nul
    git branch -M main
    git remote add origin https://github.com/adamdispatching-stack/fleet.git
    echo [SETUP] Done. A browser window may open asking you to log in to GitHub - that is normal, log in once and Windows remembers it.
    echo.
)

REM --- commit message: use whatever you type after deploy.bat, or a timestamp ---
set "msg=%*"
if "!msg!"=="" set "msg=App update %date% %time:~0,8%"

echo [1/3] Saving your changes...
git add -A
git commit -m "!msg!" >nul 2>nul
if errorlevel 1 (
    echo        Nothing new to save - files are unchanged since last deploy.
) else (
    echo        Saved: "!msg!"
)

echo [2/3] Syncing with GitHub...
git pull --rebase origin main >nul 2>nul

echo [3/3] Pushing to GitHub...
git push -u origin main
if errorlevel 1 (
    echo.
    echo [FAILED] Push did not go through.
    echo  - If a login window appeared, finish logging in and run this again.
    echo  - Check your internet connection.
    echo.
) else (
    echo.
    echo ============================================
    echo   DEPLOYED. Railway is building it now -
    echo   your site updates in about 1-2 minutes.
    echo ============================================
    echo.
)
pause
