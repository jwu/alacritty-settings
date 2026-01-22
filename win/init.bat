@echo off

:: init start
:: ========================================

set __INIT_START__=%time%

:: debug config
set __DBG_INFO__=0

:: cmd config
:: ========================================

:: change lang to utf8
set LANG=en_US.utf8

:: change chcp to utf8
chcp 65001
cls

:: find root dir
if not defined MY_ROOT (
  for /f "delims=" %%i in ("%~dp0\..") do (
    set "MY_ROOT=%%~fi"
  )
)
:: remove trailing '\' from %MY_ROOT%
if "%MY_ROOT:~-1%" == "\" set "MY_ROOT=%MY_ROOT:~0,-1%"

set "MY_SETTINGS=%MY_ROOT%\win"
set "MY_VENDOR=%MY_ROOT%\vendor"

:: add aliases
:: ========================================

call "%MY_SETTINGS%\cmds\aliases.cmd"

:: add vendor\bin\ to environment path
:: ========================================

if exist "%MY_VENDOR%\bin" (
  set "PATH=%PATH%;%MY_VENDOR%\bin"
)

:: add git-for-windows to environment path
:: ========================================

if exist "%MY_VENDOR%\git" (
  set "MY_GIT_ROOT=%MY_VENDOR%\git"
  goto :CONFIG_GIT
) else (
  goto :NO_GIT
)

:CONFIG_GIT

:: add {git}\cmd\ to environment path
if exist "%MY_GIT_ROOT%\cmd\git.exe" (
  set "PATH=%PATH%;%MY_GIT_ROOT%\cmd"
)

:: add {git}\usr\bin to environment path
if exist "%MY_GIT_ROOT%\usr\bin" (
  set "PATH=%PATH%;%MY_GIT_ROOT%\usr\bin"
)

:: add {git}\mingw{??}\bin to environment path
if exist "%MY_GIT_ROOT%\mingw32" (
  set "PATH=%PATH%;%MY_GIT_ROOT%\mingw32\bin"
) else if exist "%MY_GIT_ROOT%\mingw64" (
  set "PATH=%PATH%;%MY_GIT_ROOT%\mingw64\bin"
)

goto :END_CONFIG_GIT

:: print error if git not found
:NO_GIT
echo Error: git not found!

:END_CONFIG_GIT

:: set starship config path before clink
:: ========================================

set "STARSHIP_CONFIG=%MY_SETTINGS%\starship.toml"

:: set fzf option before clink
:: ========================================

set "FZF_COMPLETE_OPTS=-e"

:: inject clink
:: ========================================

:: pick right version of clink
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
  set CLINK_ARCH=x86
) else (
  set CLINK_ARCH=x64
)

"%MY_VENDOR%\clink\clink_%CLINK_ARCH%.exe" inject --quiet --profile "%MY_SETTINGS%\clink_profile" --scripts "%MY_SETTINGS%\clink_scripts"

:: init end
:: ========================================

set __INIT_END__=%time%

:: show debug info
if %__DBG_INFO__% gtr 0 (
  "%MY_SETTINGS%\cmds\timer.cmd" "%__INIT_START__%" "%__INIT_END__%"
  echo ----------------------------------------
  echo PROCESSOR_ARCHITECTURE = %PROCESSOR_ARCHITECTURE%
  echo LANG = %LANG%
  echo MY_ROOT = %MY_ROOT%
  echo MY_SETTINGS = %MY_SETTINGS%
  echo MY_VENDOR = %MY_VENDOR%
  echo MY_GIT_ROOT = %MY_GIT_ROOT%
)

exit /b
