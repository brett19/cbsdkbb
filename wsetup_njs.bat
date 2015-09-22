SETLOCAL

SET NJSMODE=%1
SET NJSVER=%2
SET ARCH=%3

echo Installing NJS %1 %2 %3

SET NVMARCH=""
if "%ARCH%"=="x86" (
  SET NVMARCH="-x32"
)

SET NVMVER=v%NJSVER%
SET NVMPATH=v%NJSVER%%NVMARCH%
if "%NJSMODE%"=="iojs" (
  SET NVMVER=iojs-v%NJSVER%
  SET NVMPATH=iojs\v%NJSVER%%NVMARCH%
)

SET NEEDINSTALL=0
IF NOT EXIST njs-files\%NJSVER%-%ARCH%\node.exe (
  IF NOT EXIST njs-files\%NJSVER%-%ARCH%\node.cmd (
    SET NEEDINSTALL=1
  )
)
IF NOT EXIST njs-files\%NJSVER%-%ARCH%\npm.cmd (
  SET NEEDINSTALL=1
)

IF "%NEEDINSTALL%"=="1" (
  rmdir /S /Q njs-files\%NJSVER%-%ARCH%

  rmdir /S /Q tools\nvmw\v*
  rmdir /S /Q tools\nvmw\iojs

  tools\nvmw\nvmw install %NVMVER% %ARCH%
  del /Q tools\nvmw\%NVMPATH%\npm.zip

  move /Y tools\nvmw\%NVMPATH% njs-files\%NJSVER%-%ARCH%

  rmdir /S /Q tools\nvmw\%NVMPATH%
  rmdir /S /Q tools\nvmw\iojs
)

rmdir /S /Q "%UserProfile%\.node-gyp"

ENDLOCAL
