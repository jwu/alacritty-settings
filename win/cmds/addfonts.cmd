:: http://www.msfn.org/board/topic/119612-how-to-install-a-font-via-the-command-line/

@echo off
title Adding Fonts..
:: Filename: ADD_Fonts.cmd
:: Script to ADD TrueType and OpenType Fonts for Windows
:: By Islam Adel
:: 2012-01-16

:: How to use:
:: Place the batch file inside the folder of the font files OR:
:: Optional Add source folder as parameter with ending backslash and dont use quotes, spaces are allowed
:: example "ADD_fonts.cmd" C:\Folder 1\Folder 2\

if not "%*"=="" set SRC=%*
echo.
echo Adding Fonts..
echo.
for /f "delims=" %%i in ('dir /b /s "%SRC%*.*tf"') do (
  call :FONT "%%i"
)

goto:END

:FONT
echo.
:: ECHO FILE=%~f1
set FFILE=%~n1%~x1
set FNAME=%~n1
set FNAME=%FNAME:-= %
if "%~x1"==".otf" set FTYPE=(OpenType)
if "%~x1"==".ttf" set FTYPE=(TrueType)

echo FILE=%FFILE%
echo NAME=%FNAME%
echo TYPE=%FTYPE%

copy /Y "%SRC%%~n1%~x1" "%SystemRoot%\Fonts\"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%FNAME% %FTYPE%" /t REG_SZ /d "%FFILE%" /f
goto:eof

:END
:: OPTIONAL REBOOT
:: shutdown -r -f -t 10 -c "Reboot required for Fonts installation"
echo.
echo Done!
