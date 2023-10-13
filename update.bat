@echo off
:: ========================================

:: version setup
set "AL_VER=v0.12.3"
set "FONT_VER=v3.0.2"
set "STARSHIP_VER=v1.16.0"
set "CLINK_URL=https://github.com/chrisant996/clink/releases/download/v1.5.9/clink.1.5.9.411d0f.zip"
set "CLINK_COMP_VER=0.4.11"
set "GIT_VER=2.42.0.2"
set "GIT_VER_WIN=2.42.0.windows.2"
set "FZF_VER=0.42.0"
set "Z_VER=0.9.2"

:: find root dir
for /f "delims=" %%i in ("%~dp0") do (
  set "MY_ROOT=%%~fi"
)
:: remove trailing '\' from %MY_ROOT%
if "%MY_ROOT:~-1%" == "\" set "MY_ROOT=%MY_ROOT:~0,-1%"
set "MY_VENDOR=%MY_ROOT%\vendor"

:: create vendor directory
if not exist "%MY_VENDOR%" (
  echo create dir %MY_VENDOR%
  mkdir "%MY_VENDOR%"
)

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
if not exist "%MY_NERD_FONT%" (
  echo create dir %MY_NERD_FONT%
  mkdir "%MY_NERD_FONT%"
)

:: create NerdFont\FiraMono directory
if not exist "%MY_NERD_FONT%\FiraMono" (
  echo create dir %MY_NERD_FONT%\FiraMono
  mkdir "%MY_NERD_FONT%\FiraMono"
)

echo download NerdFont:FiraMono
curl https://github.com/ryanoasis/nerd-fonts/releases/download/%FONT_VER%/FiraMono.zip ^
  -L --progress-bar ^
  -o %MY_NERD_FONT%\FiraMono.zip

echo extract FiraMono.zip to vendor\NerdFont\FiraMono\
tar -xf %MY_NERD_FONT%\FiraMono.zip -C %MY_NERD_FONT%\FiraMono\
del %MY_NERD_FONT%\FiraMono.zip

echo install FiraMono fonts
call settings\cmds\addfonts.cmd %MY_NERD_FONT%\FiraMono\
goto:eof

:: ========================================
:UPDATE_STARSHIP
:: ========================================

echo download starship
curl https://github.com/starship/starship/releases/download/%STARSHIP_VER%/starship-x86_64-pc-windows-msvc.zip ^
  -L --progress-bar ^
  -o %MY_VENDOR%\starship.zip


echo extract starship.zip to vendor\starship.exe
tar -xf %MY_VENDOR%\starship.zip -C %MY_VENDOR%
del %MY_VENDOR%\starship.zip
goto:eof

:: ========================================
:UPDATE_CLINK
:: ========================================

:: create vendor\clink directory
if not exist "%MY_VENDOR%\clink" (
  echo create dir %MY_VENDOR%\clink
  mkdir "%MY_VENDOR%\clink"
)

echo download clink
curl %CLINK_URL% ^
  -L --progress-bar ^
  -o %MY_VENDOR%\clink.zip

echo extract clink.zip to vendor\clink
tar -xf %MY_VENDOR%\clink.zip -C %MY_VENDOR%\clink
del %MY_VENDOR%\clink.zip

:: create clink-completions directory
:: if not exist "%MY_VENDOR%\clink-completions" (
::   echo create dir %MY_VENDOR%\clink-completions
::   mkdir "%MY_VENDOR%\clink-completions"
:: )

echo download clink-completions
curl https://github.com/vladimir-kotikov/clink-completions/archive/refs/tags/v%CLINK_COMP_VER%.zip ^
  -L --progress-bar ^
  -o %MY_VENDOR%\clink-completions.zip

echo extract clink-completions.zip to vendor\clink-completions
tar -xf %MY_VENDOR%\clink-completions.zip -C %MY_VENDOR%\
del %MY_VENDOR%\clink-completions.zip

cd %MY_VENDOR%
ren clink-completions-%CLINK_COMP_VER% clink-completions
cd ..
goto:eof

:: ========================================
:UPDATE_GIT
:: ========================================

echo download git
curl https://github.com/git-for-windows/git/releases/download/v%GIT_VER_WIN%/MinGit-%GIT_VER%-64-bit.zip ^
  -L --progress-bar ^
  -o %MY_VENDOR%\git.zip

:: create vendor\git directory
if not exist "%MY_VENDOR%\git" (
  echo create dir %MY_VENDOR%\git
  mkdir "%MY_VENDOR%\git"
)

echo extract git.zip to vendor\git
tar -xf %MY_VENDOR%\git.zip -C %MY_VENDOR%\git
del %MY_VENDOR%\git.zip

goto:eof

:: ========================================
:UPDATE_FZF
:: ========================================

echo download fzf
curl https://github.com/junegunn/fzf/releases/download/%FZF_VER%/fzf-%FZF_VER%-windows_amd64.zip ^
  -L --progress-bar ^
  -o %MY_VENDOR%\fzf.zip

:: create vendor\bin directory
if not exist "%MY_VENDOR%\bin" (
  echo create dir %MY_VENDOR%\bin
  mkdir "%MY_VENDOR%\bin"
)

echo extract fzf.zip to vendor\bin
tar -xf %MY_VENDOR%\fzf.zip -C %MY_VENDOR%\bin
del %MY_VENDOR%\fzf.zip

goto:eof

:: ========================================
:UPDATE_Z
:: ========================================

echo download zoxide
curl https://github.com/ajeetdsouza/zoxide/releases/download/v%Z_VER%/zoxide-%Z_VER%-x86_64-pc-windows-msvc.zip ^
  -L --progress-bar ^
  -o %MY_VENDOR%\zoxide.zip

:: create vendor\bin directory
if not exist "%MY_VENDOR%\bin" (
  echo create dir %MY_VENDOR%\bin
  mkdir "%MY_VENDOR%\bin"
)

echo extract zoxide.zip to vendor\bin
tar -xf %MY_VENDOR%\zoxide.zip -C %MY_VENDOR%\bin
del %MY_VENDOR%\zoxide.zip

goto:eof

:: ========================================
:END
:: ========================================

echo Done!
