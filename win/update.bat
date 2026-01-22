@echo off
setlocal enabledelayedexpansion
:: ========================================

:: version setup
set "AL_VER=v0.16.1"
set "FONT_VER=v3.4.0"
set "STARSHIP_VER=v1.24.2"
set "CLINK_URL=https://github.com/chrisant996/clink/releases/download/v1.9.9/clink.1.9.9.3fd236.zip"
set "CLINK_COMP_VER=0.6.7"
set "GIT_VER=2.52.0"
set "GIT_VER_WIN=2.52.0.windows.1"
set "FZF_VER=0.67.0"
set "Z_VER=0.9.8"

:: error handling
set "ERROR_COUNT=0"

:: find root dir
for /f "delims=" %%i in ("%~dp0") do (
  set "MY_ROOT=%%~fi"
)
:: remove trailing '\' from %MY_ROOT%
if "%MY_ROOT:~-1%" == "\" set "MY_ROOT=%MY_ROOT:~0,-1%"
set "MY_VENDOR=%MY_ROOT%\vendor"

:: create vendor directory
call :CREATE_DIR_IF_NOT_EXISTS "%MY_VENDOR%"

:: ========================================
:: DEBUG
:: ========================================

call :UPDATE_ALACRITTY
call :UPDATE_NERD_FONT
call :UPDATE_STARSHIP
call :UPDATE_CLINK
call :UPDATE_GIT
call :UPDATE_FZF
call :UPDATE_Z
goto:END

:: ========================================
:UPDATE_ALACRITTY
:: ========================================

echo download alacritty.exe
curl https://github.com/alacritty/alacritty/releases/download/%AL_VER%/Alacritty-%AL_VER%-portable.exe ^
  -L --progress-bar ^
  -o alacritty.exe
goto:eof

:: ========================================
:UPDATE_NERD_FONT
:: ========================================

:: create NerdFont directory
set "MY_NERD_FONT=%MY_VENDOR%\NerdFont"
call :CREATE_DIR_IF_NOT_EXISTS "%MY_NERD_FONT%"
call :CREATE_DIR_IF_NOT_EXISTS "%MY_NERD_FONT%\FiraMono"

call :DOWNLOAD_AND_EXTRACT "https://github.com/ryanoasis/nerd-fonts/releases/download/%FONT_VER%/FiraMono.zip" "%MY_NERD_FONT%\FiraMono.zip" "%MY_NERD_FONT%\FiraMono\"

echo install FiraMono fonts
call cmds\addfonts.cmd %MY_NERD_FONT%\FiraMono\
goto:eof

:: ========================================
:UPDATE_STARSHIP
:: ========================================

call :DOWNLOAD_AND_EXTRACT "https://github.com/starship/starship/releases/download/%STARSHIP_VER%/starship-x86_64-pc-windows-msvc.zip" "%MY_VENDOR%\starship.zip" "%MY_VENDOR%"
goto:eof

:: ========================================
:UPDATE_CLINK
:: ========================================

call :CREATE_DIR_IF_NOT_EXISTS "%MY_VENDOR%\clink"
call :DOWNLOAD_AND_EXTRACT "%CLINK_URL%" "%MY_VENDOR%\clink.zip" "%MY_VENDOR%\clink"

echo download clink-completions
curl https://github.com/vladimir-kotikov/clink-completions/archive/refs/tags/v%CLINK_COMP_VER%.zip ^
  -L --progress-bar ^
  -o %MY_VENDOR%\clink-completions.zip

echo extract clink-completions.zip to vendor\clink-completions
tar -xf %MY_VENDOR%\clink-completions.zip -C %MY_VENDOR%\
del %MY_VENDOR%\clink-completions.zip

cd %MY_VENDOR%
if exist clink-completions (
  echo remove existing clink-completions directory
  rd /s /q clink-completions
)
if exist clink-completions-%CLINK_COMP_VER% (
  ren clink-completions-%CLINK_COMP_VER% clink-completions
) else (
  echo clink-completions-%CLINK_COMP_VER% directory not found after extraction
  set /a "ERROR_COUNT+=1"
)
cd ..
goto:eof

:: ========================================
:UPDATE_GIT
:: ========================================

call :CREATE_DIR_IF_NOT_EXISTS "%MY_VENDOR%\git"
call :DOWNLOAD_AND_EXTRACT "https://github.com/git-for-windows/git/releases/download/v%GIT_VER_WIN%/MinGit-%GIT_VER%-64-bit.zip" "%MY_VENDOR%\git.zip" "%MY_VENDOR%\git"

goto:eof

:: ========================================
:UPDATE_FZF
:: ========================================

call :CREATE_DIR_IF_NOT_EXISTS "%MY_VENDOR%\bin"
call :DOWNLOAD_AND_EXTRACT "https://github.com/junegunn/fzf/releases/download/v%FZF_VER%/fzf-%FZF_VER%-windows_amd64.zip" "%MY_VENDOR%\fzf.zip" "%MY_VENDOR%\bin"

goto:eof

:: ========================================
:UPDATE_Z
:: ========================================

call :DOWNLOAD_AND_EXTRACT "https://github.com/ajeetdsouza/zoxide/releases/download/v%Z_VER%/zoxide-%Z_VER%-x86_64-pc-windows-msvc.zip" "%MY_VENDOR%\zoxide.zip" "%MY_VENDOR%\bin"

goto:eof

:: ========================================
:UTILITY_FUNCTIONS
:: ========================================

:CREATE_DIR_IF_NOT_EXISTS
if not exist "%~1" (
  echo create dir %~1
  mkdir "%~1" || (
    echo Failed to create directory: %~1
    set /a "ERROR_COUNT+=1"
    exit /b 1
  )
)
exit /b 0

:DOWNLOAD_AND_EXTRACT
set "URL=%~1"
set "ZIP_FILE=%~2"
set "EXTRACT_DIR=%~3"

echo download from %URL%
curl "%URL%" -L --progress-bar -o "%ZIP_FILE%" || (
  echo Failed to download: %URL%
  set /a "ERROR_COUNT+=1"
  exit /b 1
)

echo extract %ZIP_FILE% to %EXTRACT_DIR%
tar -xf "%ZIP_FILE%" -C "%EXTRACT_DIR%" || (
  echo Failed to extract: %ZIP_FILE%
  set /a "ERROR_COUNT+=1"
  exit /b 1
)

del "%ZIP_FILE%"
exit /b 0

:: ========================================
:END
:: ========================================

if %ERROR_COUNT% equ 0 (
  echo Done!
) else (
  echo Update completed with %ERROR_COUNT% error(s)!
)
exit /b %ERROR_COUNT%
