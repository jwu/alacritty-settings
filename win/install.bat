@echo off
setlocal enabledelayedexpansion
:: ========================================

:: version setup
set "AL_VER=v0.16.1"
set "FONT_VER=v3.4.0"
set "CLINK_URL=https://github.com/chrisant996/clink/releases/download/v1.9.9/clink.1.9.9.3fd236.zip"
set "CLINK_COMP_VER=0.6.7"
set "GIT_VER=2.52.0"
set "GIT_VER_WIN=2.52.0.windows.1"
set "STARSHIP_VER=v1.24.2"
set "FZF_VER=0.67.0"
set "Z_VER=0.9.8"
set "FD_VER=10.2.0"
set "BAT_VER=0.24.0"
set "RIPGREP_VER=15.1.0"
set "LSD_VER=1.1.2"
set "COREUTILS_VER=0.5.0"

:: error handling
set "ERROR_COUNT=0"

:: target directory
set "TARGET_DIR=%USERPROFILE%\bin"

:: find root dir
for /f "delims=" %%i in ("%~dp0") do (
  set "MY_ROOT=%%~fi"
)
:: remove trailing '\' from %MY_ROOT%
if "%MY_ROOT:~-1%" == "\" set "MY_ROOT=%MY_ROOT:~0,-1%"

:: create target directory
call :CREATE_DIR_IF_NOT_EXISTS "%TARGET_DIR%"

:: ========================================
:: DEBUG
:: ========================================

call :UPDATE_ALACRITTY
call :UPDATE_NERD_FONT
call :UPDATE_CLINK
call :UPDATE_STARSHIP
call :UPDATE_FZF
call :UPDATE_Z
call :UPDATE_FD
call :UPDATE_LSD
call :UPDATE_COREUTILS
call :UPDATE_BAT
call :UPDATE_RIPGREP
goto:END

:: ========================================
:UPDATE_ALACRITTY
:: ========================================

echo download alacritty.exe
curl https://github.com/alacritty/alacritty/releases/download/%AL_VER%/Alacritty-%AL_VER%-portable.exe ^
  -L --progress-bar ^
  -o %TARGET_DIR%\alacritty.exe
echo alacritty installed successfully
echo ========================================
goto:eof

:: ========================================
:UPDATE_NERD_FONT
:: ========================================

:: create NerdFont directory
set "MY_NERD_FONT=%TARGET_DIR%\NerdFont"
call :CREATE_DIR_IF_NOT_EXISTS "%MY_NERD_FONT%"
call :CREATE_DIR_IF_NOT_EXISTS "%MY_NERD_FONT%\FiraMono"

call :DOWNLOAD_AND_EXTRACT "https://github.com/ryanoasis/nerd-fonts/releases/download/%FONT_VER%/FiraMono.zip" "%MY_NERD_FONT%\FiraMono.zip" "%MY_NERD_FONT%\FiraMono"

echo install FiraMono fonts
call cmds\addfonts.cmd %MY_NERD_FONT%\FiraMono\
echo FiraMono fonts installed successfully
echo ========================================
goto:eof

:: ========================================
:UPDATE_CLINK
:: ========================================

call :CREATE_DIR_IF_NOT_EXISTS "%TARGET_DIR%\clink"
call :DOWNLOAD_AND_EXTRACT "%CLINK_URL%" "%TARGET_DIR%\clink.zip" "%TARGET_DIR%\clink"
call :DOWNLOAD_AND_EXTRACT "https://github.com/vladimir-kotikov/clink-completions/archive/refs/tags/v%CLINK_COMP_VER%.zip" "%TARGET_DIR%\clink-completions.zip" "%TARGET_DIR%"

cd %TARGET_DIR%
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
echo clink and clink-completions installed successfully
echo ========================================
goto:eof

:: ========================================
:UPDATE_STARSHIP
:: ========================================

call :DOWNLOAD_AND_EXTRACT "https://github.com/starship/starship/releases/download/%STARSHIP_VER%/starship-x86_64-pc-windows-msvc.zip" "%TARGET_DIR%\starship.zip" "%TARGET_DIR%"

echo starship installed successfully
echo ========================================
goto:eof

:: ========================================
:UPDATE_FZF
:: ========================================

call :DOWNLOAD_AND_EXTRACT "https://github.com/junegunn/fzf/releases/download/v%FZF_VER%/fzf-%FZF_VER%-windows_amd64.zip" "%TARGET_DIR%\fzf.zip" "%TARGET_DIR%"

echo fzf installed successfully
echo ========================================
goto:eof

:: ========================================
:UPDATE_Z
:: ========================================

call :DOWNLOAD_AND_EXTRACT "https://github.com/ajeetdsouza/zoxide/releases/download/v%Z_VER%/zoxide-%Z_VER%-x86_64-pc-windows-msvc.zip" "%TARGET_DIR%\zoxide.zip" "%TARGET_DIR%"

echo zoxide installed successfully
echo ========================================
goto:eof

:: ========================================
:UPDATE_FD
:: ========================================

set "FD_ZIP_URL=https://github.com/sharkdp/fd/releases/download/v%FD_VER%/fd-v%FD_VER%-x86_64-pc-windows-msvc.zip"
set "FD_DIR_NAME=fd-v%FD_VER%-x86_64-pc-windows-msvc"

echo download fd
curl "%FD_ZIP_URL%" -L --progress-bar -o "%TARGET_DIR%\fd.zip"

echo extract fd
tar -xf "%TARGET_DIR%\fd.zip" -C "%TARGET_DIR%"

if exist "%TARGET_DIR%\%FD_DIR_NAME%\fd.exe" (
  echo move fd.exe to bin
  move /y "%TARGET_DIR%\%FD_DIR_NAME%\fd.exe" "%TARGET_DIR%\"
  echo clean up fd dir
  rd /s /q "%TARGET_DIR%\%FD_DIR_NAME%"
) else (
  echo Error: fd.exe not found in extracted directory
  set /a "ERROR_COUNT+=1"
)
del "%TARGET_DIR%\fd.zip"
echo fd installed successfully
echo ========================================
goto:eof

:: ========================================
:UPDATE_LSD
:: ========================================

set "LSD_DIR_NAME=lsd-v%LSD_VER%-x86_64-pc-windows-msvc"

call :DOWNLOAD_AND_EXTRACT "https://github.com/Peltoche/lsd/releases/download/v%LSD_VER%/lsd-v%LSD_VER%-x86_64-pc-windows-msvc.zip" "%TARGET_DIR%\lsd.zip" "%TARGET_DIR%"

if exist "%TARGET_DIR%\%LSD_DIR_NAME%\lsd.exe" (
  move /y "%TARGET_DIR%\%LSD_DIR_NAME%\lsd.exe" "%TARGET_DIR%\"
  rd /s /q "%TARGET_DIR%\%LSD_DIR_NAME%"
) else (
  echo Error: lsd.exe not found in extracted directory
  set /a "ERROR_COUNT+=1"
)
echo lsd installed successfully
echo ========================================
goto:eof

:: ========================================
:UPDATE_COREUTILS
:: ========================================

set "COREUTILS_DIR_NAME=coreutils-%COREUTILS_VER%-x86_64-pc-windows-msvc"

call :DOWNLOAD_AND_EXTRACT "https://github.com/uutils/coreutils/releases/download/%COREUTILS_VER%/coreutils-%COREUTILS_VER%-x86_64-pc-windows-msvc.zip" "%TARGET_DIR%\coreutils.zip" "%TARGET_DIR%"

if exist "%TARGET_DIR%\%COREUTILS_DIR_NAME%\coreutils.exe" (
  move /y "%TARGET_DIR%\%COREUTILS_DIR_NAME%\coreutils.exe" "%TARGET_DIR%\"
  rd /s /q "%TARGET_DIR%\%COREUTILS_DIR_NAME%"
) else (
  echo Error: coreutils.exe not found in extracted directory
  set /a "ERROR_COUNT+=1"
)
echo coreutils installed successfully
echo ========================================
goto:eof

:: ========================================
:UPDATE_BAT
:: ========================================

set "BAT_ZIP_URL=https://github.com/sharkdp/bat/releases/download/v%BAT_VER%/bat-v%BAT_VER%-x86_64-pc-windows-msvc.zip"
set "BAT_DIR_NAME=bat-v%BAT_VER%-x86_64-pc-windows-msvc"

echo download bat
curl "%BAT_ZIP_URL%" -L --progress-bar -o "%TARGET_DIR%\bat.zip"

echo extract bat
tar -xf "%TARGET_DIR%\bat.zip" -C "%TARGET_DIR%"

if exist "%TARGET_DIR%\%BAT_DIR_NAME%\bat.exe" (
  echo move bat.exe to bin
  move /y "%TARGET_DIR%\%BAT_DIR_NAME%\bat.exe" "%TARGET_DIR%\"
  echo clean up bat dir
  rd /s /q "%TARGET_DIR%\%BAT_DIR_NAME%"
) else (
  echo Error: bat.exe not found in extracted directory
  set /a "ERROR_COUNT+=1"
)
del "%TARGET_DIR%\bat.zip"
echo bat installed successfully
echo ========================================
goto:eof

:: ========================================
:UPDATE_RIPGREP
:: ========================================

set "RIPGREP_ZIP_URL=https://github.com/BurntSushi/ripgrep/releases/download/%RIPGREP_VER%/ripgrep-%RIPGREP_VER%-x86_64-pc-windows-msvc.zip"
set "RIPGREP_DIR_NAME=ripgrep-%RIPGREP_VER%-x86_64-pc-windows-msvc"

echo download ripgrep
curl "%RIPGREP_ZIP_URL%" -L --progress-bar -o "%TARGET_DIR%\ripgrep.zip"

echo extract ripgrep
tar -xf "%TARGET_DIR%\ripgrep.zip" -C "%TARGET_DIR%"

if exist "%TARGET_DIR%\%RIPGREP_DIR_NAME%\rg.exe" (
  echo move rg.exe to bin
  move /y "%TARGET_DIR%\%RIPGREP_DIR_NAME%\rg.exe" "%TARGET_DIR%\"
  echo clean up ripgrep dir
  rd /s /q "%TARGET_DIR%\%RIPGREP_DIR_NAME%"
) else (
  echo Error: rg.exe not found in extracted directory
  set /a "ERROR_COUNT+=1"
)
del "%TARGET_DIR%\ripgrep.zip"
echo ripgrep installed successfully
echo ========================================
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
  echo Done
) else (
  echo Update completed with %ERROR_COUNT% error(s)
)
exit /b %ERROR_COUNT%

