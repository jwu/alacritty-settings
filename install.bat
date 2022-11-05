:: find root dir
for /f "delims=" %%i in ("%~dp0\..") do (
  set "AL_ROOT=%%~fi"
)
:: remove trailing '\' from %AL_ROOT%
if "%AL_ROOT:~-1%" == "\" set "AL_ROOT=%AL_ROOT:~0,-1%"

set "AL_SETTINGS=%AL_ROOT%\settings"
set "AL_VENDOR=%AL_ROOT%\vendor"

:: download alacritty.exe
curl -L -o alacritty.exe https://github.com/alacritty/alacritty/releases/download/v0.11.0/Alacritty-v0.11.0-portable.exe

:: create alacritty directory
if not exist "~\AppData\Roaming\alacritty" (
  mkdir "~\AppData\Roaming\alacritty"
)

:: copy alacritty.yml
copy %AL_SETTINGS%\alacritty.yml ~\AppData\Roaming\alacritty\alacritty.yml
