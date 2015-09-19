SET NJSVER=%1
SET NJSTAG=%NJSVER%-%ARCH%
SET NJSDIR=%~dp0..\njs-files\%NJSTAG%\

IF "%MSVSVER%"=="none" GOTO noVs
GOTO specificVs


:specificVs
SET GYP_MSVS_VERSION=%MSVSYEAR%
GOTO End

:noVs
SET GYP_MSVS_VERSION=none
GOTO End

:End
