@echo off

:: init start
:: ========================================

set __INIT_START__=%time%

:: debug config
set __DBG_INFO__=0

:: cmd config
set LANG=en_US.utf8

:: find root dir
if not defined AL_ROOT (
  for /f "delims=" %%i in ("%~dp0\..") do (
    set "AL_ROOT=%%~fi"
  )
)
:: remove trailing '\' from %AL_ROOT%
if "%AL_ROOT:~-1%" == "\" set "AL_ROOT=%AL_ROOT:~0,-1%"

set "AL_SETTINGS=%AL_ROOT%\settings"
set "AL_VENDOR=%AL_ROOT%\vendor"

:: add aliases
:: ========================================

call "%AL_SETTINGS%\cmds\aliases.cmd"

:: add git-for-windows to environment path
:: ========================================

if exist "%AL_VENDOR%\git_portable" (
  set "AL_GIT_ROOT=%AL_VENDOR%\git_portable"
  goto :CONFIG_GIT
) else (
  goto :NO_GIT
)

:CONFIG_GIT

:: add git to environment path
if exist "%AL_GIT_ROOT%\cmd\git.exe" (
  set "PATH=%PATH%;%AL_GIT_ROOT%\cmd"
)

:: add usr\bin to environment path
if exist "%AL_GIT_ROOT%\usr\bin" (
  set "PATH=%PATH%;%AL_GIT_ROOT%\usr\bin"
)

:: add mingw to environment path
if exist "%AL_GIT_ROOT%\mingw32" (
  set "PATH=%PATH%;%AL_GIT_ROOT%\mingw32\bin"
) else if exist "%AL_GIT_ROOT%\mingw64" (
  set "PATH=%PATH%;%AL_GIT_ROOT%\mingw64\bin"
)

goto :END_CONFIG_GIT

:: print error if git not found
:NO_GIT
echo Error: git not found!

:END_CONFIG_GIT

:: set starship config path before clink
:: ========================================

set "STARSHIP_CONFIG=%AL_SETTINGS%\starship.toml"

:: inject clink
:: ========================================

:: pick right version of clink
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
  set CLINK_ARCH=x86
) else (
  set CLINK_ARCH=x64
)

"%AL_VENDOR%\clink\clink_%CLINK_ARCH%.exe" inject --quiet --profile "%AL_SETTINGS%\clink_profile" --scripts "%AL_SETTINGS%\clink_scripts"

:: init end
:: ========================================

set __INIT_END__=%time%

:: show debug info
if %__DBG_INFO__% gtr 0 (
  "%AL_SETTINGS%\cmds\timer.cmd" "%__INIT_START__%" "%__INIT_END__%"
  echo ----------------------------------------
  echo PROCESSOR_ARCHITECTURE = %PROCESSOR_ARCHITECTURE%
  echo LANG = %LANG%
  echo AL_ROOT = %AL_ROOT%
  echo AL_SETTINGS = %AL_SETTINGS%
  echo AL_VENDOR = %AL_VENDOR%
  echo AL_GIT_ROOT = %AL_GIT_ROOT%
)

exit /b
