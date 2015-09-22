SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

SET BBROOT=%~dp0
CALL common\env.bat

echo Preparing
mkdir tmp
mkdir src
mkdir lcb-files
mkdir php-files
mkdir php-files\deps
mkdir php-files\src
mkdir njs-files


if "%MACHINE_ARCH%"=="x64" (
  CALL wsetup_all.bat x64
  CALL wsetup_all.bat x86
)
if "%MACHINE_ARCH%"=="x86" (
  CALL wsetup_all.bat x86
)


echo Cleaning Up
rmdir /q /s tmp

ENDLOCAL
EXIT 0
