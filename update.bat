@echo off
:: ========================================

:: version setup
set "AL_VER=v0.11.0"
set "FONT_VER=v2.2.2"
set "STARSHIP_VER=v1.11.0"
set "CLINK_URL=https://github.com/chrisant996/clink/releases/download/v1.4.0/clink.1.4.0.74a8d2.zip"
set "CLINK_COMP_VER=0.4.1"

:: DEBUG
:: goto:UPDATE_CLINK

:: find root dir
for /f "delims=" %%i in ("%~dp0") do (
  set "AL_ROOT=%%~fi"
)
:: remove trailing '\' from %AL_ROOT%
if "%AL_ROOT:~-1%" == "\" set "AL_ROOT=%AL_ROOT:~0,-1%"

set "AL_SETTINGS=%AL_ROOT%\settings"
set "AL_VENDOR=%AL_ROOT%\vendor"

:UPDATE_ALACRITTY
:: download alacritty.exe
:: ========================================

echo download alacritty.exe
curl -L -o alacritty.exe https://github.com/alacritty/alacritty/releases/download/%AL_VER%/Alacritty-%AL_VER%-portable.exe

:: create vendor directory
:: ========================================

if not exist "%AL_VENDOR%" (
  echo create dir %AL_VENDOR%
  mkdir "%AL_VENDOR%"
)

:UPDATE_NERD_FONT
:: download NerdFont FiraMono
:: ========================================

set "NERD_FONT=%AL_VENDOR%\NerdFont"
if not exist "%NERD_FONT%" (
  echo create dir %NERD_FONT%
  mkdir "%NERD_FONT%"
)

if not exist "%NERD_FONT%\FiraMono" (
  echo create dir %NERD_FONT%\FiraMono
  mkdir "%NERD_FONT%\FiraMono"
)

echo download NerdFont:FiraMono
curl -L -o %NERD_FONT%\FiraMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/%FONT_VER%/FiraMono.zip

echo extract FiraMono.zip to vendor\NerdFont\FiraMono\
tar -xf %NERD_FONT%\FiraMono.zip -C %NERD_FONT%\FiraMono\

echo install FiraMono fonts
call settings\cmds\addfonts.cmd %NERD_FONT%\FiraMono\

:UPDATE_STARSHIP
:: download starship
:: ========================================

echo download starship
curl -L -o %AL_VENDOR%\starship.zip https://github.com/starship/starship/releases/download/%STARSHIP_VER%/starship-aarch64-pc-windows-msvc.zip

echo extract starship.zip to vendor\starship.exe
tar -xf %AL_VENDOR%\starship.zip -C %AL_VENDOR%

:UPDATE_CLINK
:: download clink
:: ========================================

:: clink
if not exist "%AL_VENDOR%\clink" (
  echo create dir %AL_VENDOR%\clink
  mkdir "%AL_VENDOR%\clink"
)

echo download clink
curl -L -o %AL_VENDOR%\clink.zip %CLINK_URL%

echo extract clink.zip to vendor\clink
tar -xf %AL_VENDOR%\clink.zip -C %AL_VENDOR%\clink

:: clink-completions
:: if not exist "%AL_VENDOR%\clink-completions" (
::   echo create dir %AL_VENDOR%\clink-completions
::   mkdir "%AL_VENDOR%\clink-completions"
:: )

echo download clink-completions
curl -L -o %AL_VENDOR%\clink-completions.zip https://github.com/vladimir-kotikov/clink-completions/archive/refs/tags/%CLINK_COMP_VER%.zip

echo extract clink-completions.zip to vendor\clink-completions
tar -xf %AL_VENDOR%\clink-completions.zip -C %AL_VENDOR%\

cd %AL_VENDOR%
ren clink-completions-%CLINK_COMP_VER% clink-completions
cd ..
