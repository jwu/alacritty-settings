@echo off
setlocal enabledelayedexpansion

echo ^>^>^> Starting Development Environment Setup for Windows...

:: Check for Winget
winget --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Winget not found. Please update App Installer from Microsoft Store.
    pause
    exit /b 1
)

:: 1. Visual Studio Build Tools (C++ Workload for Rust)
echo.
echo ^>^>^> Installing Visual Studio Build Tools (VCTools)...
echo This may take a while and require Admin privileges (UAC prompt).
winget install -e --id Microsoft.VisualStudio.2022.BuildTools --override "--passive --wait --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"

:: 2. Git
echo.
echo ^>^>^> Checking Git...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing Git...
    winget install -e --id Git.Git
) else (
    echo Git is already installed.
)

:: 3. Rust
echo.
echo ^>^>^> Installing Rust...
where rustup >nul 2>&1
if %errorlevel% neq 0 (
    echo Downloading rustup-init...
    curl -sSf -o "%TEMP%\rustup-init.exe" https://win.rustup.rs/x86_64
    echo Running rustup-init...
    "%TEMP%\rustup-init.exe" -y
    del "%TEMP%\rustup-init.exe"
) else (
    echo Rust is already installed. Updating...
    rustup update
)

:: 4. uv
echo.
echo ^>^>^> Installing uv...
powershell -Command "irm https://astral.sh/uv/install.ps1 | iex"

:: 5. Bun
echo.
echo ^>^>^> Installing Bun...
powershell -Command "irm bun.sh/install.ps1 | iex"

:: 6. NVM for Windows
echo.
echo ^>^>^> Installing NVM for Windows...
where nvm >nul 2>&1
if %errorlevel% neq 0 (
    winget install -e --id CoreyButler.NVMforWindows
    echo.
    echo NVM installed. You may need to open a NEW terminal to use 'nvm'.
    echo After restarting terminal, run:
    echo   nvm install lts
    echo   nvm use lts
) else (
    echo NVM for Windows is already installed.
)

echo.
echo ^>^>^> Development Setup Complete!
echo Please restart your terminal to ensure all PATH changes take effect.
pause
