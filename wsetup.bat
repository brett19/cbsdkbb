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


echo Installing libcouchbase
CALL wsetup_lcb.bat 2.4.9 %ARCH%

echo Installing Node.js
CALL wsetup_njs.bat njs 0.10.38 %ARCH%
CALL wsetup_njs.bat njs 0.12.2 %ARCH%
CALL wsetup_njs.bat iojs 3.0.0 %ARCH%
CALL wsetup_njs.bat njs 4.0.0 %ARCH%

echo Installing PHP
CALL wsetup_php.bat 5.4 5.4.39 vc9 %ARCH%
CALL wsetup_php.bat 5.5 5.5.23 vc11 %ARCH%
CALL wsetup_php.bat 5.6 5.6.7 vc11 %ARCH%


echo Cleaning Up
rmdir /q /s tmp

ENDLOCAL
EXIT 0
