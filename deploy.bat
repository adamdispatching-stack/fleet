@echo off
setlocal EnableDelayedExpansion
title CMJ Fleet Masterclass - Deploy
cd /d "%~dp0"

echo ============================================
echo   CMJ FLEET MASTERCLASS - ONE-CLICK DEPLOY
echo ============================================
echo.

where git >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Git is not installed. Get it from https://git-scm.com/download/win
    pause
    exit /b 1
)

REM --- first-time setup ---
if not exist ".git" (
    echo [SETUP] First time - connecting this folder to GitHub...
    git init >nul
    git branch -M main
    git remote add origin https://github.com/adamdispatching-stack/fleet.git
)

REM --- quiet the line-ending warnings, keep files exactly as they are ---
git config core.autocrlf false >nul 2>nul
git config core.safecrlf false >nul 2>nul

set "msg=%*"
if "!msg!"=="" set "msg=App update %date% %time:~0,8%"

echo [1/3] Saving your changes...
git add -A
git commit -m "!msg!" >nul 2>nul
if errorlevel 1 (
    echo        Nothing new to save - files unchanged since last deploy.
) else (
    echo        Saved: "!msg!"
)

echo [2/3] Syncing with GitHub (your folder wins any conflict)...
git fetch origin main >nul 2>nul
git merge origin/main --allow-unrelated-histories --no-edit -X ours >nul 2>nul
if errorlevel 1 (
    REM merge could not run cleanly - abort any half-merge and take ours entirely
    git merge --abort >nul 2>nul
    git merge origin/main --allow-unrelated-histories --no-edit -s ours >nul 2>nul
)

echo [3/3] Pushing to GitHub...
git push -u origin main
if errorlevel 1 (
    echo.
    echo [FAILED] Push did not go through.
    echo  - If a login window appeared, finish logging in and run this again.
    echo  - Check your internet connection, then run this again.
    echo  - Still stuck? Screenshot this window and send it to Claude.
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
