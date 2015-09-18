SETLOCAL

SET NJSMODE=%1
SET NJSVER=%2
SET ARCH=%3


echo Downloading NJS %1% %2 %3

if "%NJSMODE%"=="njs" (
  if "%ARCH%"=="x86" (
    tools\wget -nc "http://nodejs.org/dist/v%NJSVER%/node.exe" -O src\node-%NJSVER%-x86.exe
  )
  if "%ARCH%"=="x64" (
    tools\wget -nc "http://nodejs.org/dist/v%NJSVER%/x64/node.exe" -O src\node-%NJSVER%-x64.exe
  )
)
if "%NJSMODE%"=="iojs" (
  tools\wget -nc "http://iojs.org/dist/v%NJSVER%/win-%ARCH%/iojs.exe" -O src\node-%NJSVER%-%ARCH%.exe
)
if "%NJSMODE%"=="njsx" (
  tools\wget -nc "http://nodejs.org/dist/v%NJSVER%/win-%ARCH%/node.exe" -O src\node-%NJSVER%-%ARCH%.exe
)


echo Installing NJS %1 %2 %3

IF NOT EXIST njs-files\%NJSVER%-%ARCH% (
  mkdir njs-files\%NJSVER%-%ARCH%
)
IF NOT EXIST njs-files\%NJSVER%-%ARCH%\node.exe (
  copy /Y src\node-%NJSVER%-%ARCH%.exe njs-files\%NJSVER%-%ARCH%\node.exe
)
IF NOT EXIST njs-files\%NJSVER%-%ARCH%\npm.cmd (
  tools\nvmw\nvmw install %NJSVER%
  move /Y tools\nvmw\v%NJSVER%\node_modules njs-files\%NJSVER%-%ARCH%\node_modules
  copy /Y tools\nvmw\v%NJSVER%\npm.cmd njs-files\%NJSVER%-%ARCH%\npm.cmd
  rmdir /S /Q tools\nvmw\v%NJSVER%
)
