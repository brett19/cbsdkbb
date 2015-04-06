SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

SET BBROOT=%~dp0
CALL common\env.bat

mkdir tmp
mkdir src
mkdir lcb-files
mkdir php-files
mkdir php-files\deps
mkdir php-files\src
mkdir njs-files

echo "downloading libcouchbase files..."
if "%ARCH%"=="x86" (
  tools\wget -nc "http://packages.couchbase.com/clients/c/libcouchbase-2.4.8_x86_vc9.zip" -O src\lcb-2.4.8-vc9-x86.zip
  tools\wget -nc "http://packages.couchbase.com/clients/c/libcouchbase-2.4.8_x86_vc10.zip" -O src\lcb-2.4.8-vc10-x86.zip
  tools\wget -nc "http://packages.couchbase.com/clients/c/libcouchbase-2.4.8_x86_vc11.zip" -O src\lcb-2.4.8-vc11-x86.zip
)
if "%ARCH%"=="x64" (
  tools\wget -nc "http://packages.couchbase.com/clients/c/libcouchbase-2.4.8_amd64_vc9.zip" -O src\lcb-2.4.8-vc9-x64.zip
  tools\wget -nc "http://packages.couchbase.com/clients/c/libcouchbase-2.4.8_amd64_vc10.zip" -O src\lcb-2.4.8-vc10-x64.zip
  tools\wget -nc "http://packages.couchbase.com/clients/c/libcouchbase-2.4.8_amd64_vc11.zip" -O src\lcb-2.4.8-vc11-x64.zip
)


echo "downloading nodejs files..."
if "%ARCH%"=="x86" (
  tools\wget -nc "http://nodejs.org/dist/v0.10.38/node.exe" -O src\node-0.10.38-x86.exe
  tools\wget -nc "http://nodejs.org/dist/v0.12.2/node.exe" -O src\node-0.12.2-x86.exe
)
if "%ARCH%"=="x64" (
  tools\wget -nc "http://nodejs.org/dist/v0.10.38/x64/node.exe" -O src\node-0.10.38-x64.exe
  tools\wget -nc "http://nodejs.org/dist/v0.12.2/x64/node.exe" -O src\node-0.12.2-x64.exe
)


echo "downloading php files..."
if "%ARCH%"=="x86" (
  tools\wget -nc "http://php.net/get/php-5.4.39.tar.bz2/from/this/mirror" -O src\php-src-5.4.39.tar.bz2
)
tools\wget -nc "http://php.net/get/php-5.5.23.tar.bz2/from/this/mirror" -O src\php-src-5.5.23.tar.bz2
tools\wget -nc "http://php.net/get/php-5.6.7.tar.bz2/from/this/mirror" -O src\php-src-5.6.7.tar.bz2
tools\wget -nc "http://windows.php.net/downloads/php-sdk/php-sdk-binary-tools-20110915.zip" -O src\php-sdk.zip
tools\wget -nc "https://phar.phpunit.de/phpunit.phar" -O src\php-phpunit.phar
tools\wget -nc "http://phpdoc.org/phpDocumentor.phar" -O src\php-phpdoc.phar





echo "installing lcb files..."
if "%ARCH%"=="x86" (
  if not exist lcb-files\2.4.8-vc9-x86 (
    tools\7za x -y -otmp\ src\lcb-2.4.8-vc9-x86.zip
    move /Y tmp\libcouchbase-2.4.8_x86_vc9 lcb-files\2.4.8-vc9-x86
  )
  if not exist lcb-files\2.4.8-vc10-x86 (
    tools\7za x -y -otmp\ src\lcb-2.4.8-vc10-x86.zip
    move /Y tmp\libcouchbase-2.4.8_x86_vc10 lcb-files\2.4.8-vc10-x86
  )
  if not exist lcb-files\2.4.8-vc11-x86 (
    tools\7za x -y -otmp\ src\lcb-2.4.8-vc11-x86.zip
    move /Y tmp\libcouchbase-2.4.8_x86_vc11 lcb-files\2.4.8-vc11-x86
  )
)
if "%ARCH%"=="x64" (
  if not exist lcb-files\2.4.8-vc9-x64 (
    tools\7za x -y -otmp\ src\lcb-2.4.8-vc9-x64.zip
    move /Y tmp\libcouchbase-2.4.8_amd64_vc9 lcb-files\2.4.8-vc9-x64
  )
  if not exist lcb-files\2.4.8-vc10-x64 (
    tools\7za x -y -otmp\ src\lcb-2.4.8-vc10-x64.zip
    move /Y tmp\libcouchbase-2.4.8_amd64_vc10 lcb-files\2.4.8-vc10-x64
  )
  if not exist lcb-files\2.4.8-vc11-x64 (
    tools\7za x -y -otmp\ src\lcb-2.4.8-vc11-x64.zip
    move /Y tmp\libcouchbase-2.4.8_amd64_vc11 lcb-files\2.4.8-vc11-x64
  )
)


echo "installing nodejs files..."
IF "%ARCH%"=="x86" (
  IF NOT EXIST njs-files\0.10.38-x86 (
    mkdir njs-files\0.10.38-x86
  )
  IF NOT EXIST njs-files\0.10.38-x86\node.exe (
    copy /Y src\node-0.10.38-x86.exe njs-files\0.10.38-x86\node.exe
  )
  IF NOT EXIST njs-files\0.10.38-x86\npm.cmd (
    tools\nvmw\nvmw install 0.10.38
    move /Y tools\nvmw\v0.10.38\node_modules njs-files\0.10.38-x86\node_modules
    copy /Y tools\nvmw\v0.10.38\npm.cmd njs-files\0.10.38-x86\npm.cmd
    rmdir /S /Q tools\nvmw\v0.10.38
  )
  IF NOT EXIST njs-files\0.12.2-x86 (
    mkdir njs-files\0.12.2-x86
  )
  IF NOT EXIST njs-files\0.12.2-x86\node.exe (
    copy /Y src\node-0.12.2-x86.exe njs-files\0.12.2-x86\node.exe
  )
  IF NOT EXIST njs-files\0.12.2-x86\npm.cmd (
    tools\nvmw\nvmw install 0.12.2
    move /Y tools\nvmw\v0.12.2\node_modules njs-files\0.12.2-x86\node_modules
    copy /Y tools\nvmw\v0.12.2\npm.cmd njs-files\0.12.2-x86\npm.cmd
    rmdir /S /Q tools\nvmw\v0.12.2
  )
)
IF "%ARCH%"=="x64" (
  IF NOT EXIST njs-files\0.10.38-x64 (
    mkdir njs-files\0.10.38-x64
  )
  IF NOT EXIST njs-files\0.10.38-x64\node.exe (
    copy /Y src\node-0.10.38-x64.exe njs-files\0.10.38-x64\node.exe
  )
  IF NOT EXIST njs-files\0.10.38-x64\npm.cmd (
    tools\nvmw\nvmw install 0.10.38
    move /Y tools\nvmw\v0.10.38\node_modules njs-files\0.10.38-x64\node_modules
    copy /Y tools\nvmw\v0.10.38\npm.cmd njs-files\0.10.38-x64\npm.cmd
    rmdir /S /Q tools\nvmw\v0.10.38
  )
  IF NOT EXIST njs-files\0.12.2-x64 (
    mkdir njs-files\0.12.2-x64
  )
  IF NOT EXIST njs-files\0.12.2-x64\node.exe (
    copy /Y src\node-0.12.2-x64.exe njs-files\0.12.2-x64\node.exe
  )
  IF NOT EXIST njs-files\0.12.2-x64\npm.cmd (
    tools\nvmw\nvmw install 0.12.2
    move /Y tools\nvmw\v0.12.2\node_modules njs-files\0.12.2-x64\node_modules
    copy /Y tools\nvmw\v0.12.2\npm.cmd njs-files\0.12.2-x64\npm.cmd
    rmdir /S /Q tools\nvmw\v0.12.2
  )
)

echo "installing php files..."
IF NOT EXIST php-files\sdk (
  tools\7za x -y -ophp-files\sdk\ src\php-sdk.zip
)

if "%ARCH%"=="x86" (
  CALL setup_installphp.bat 5.6 5.6.7 vc9 x86
  CALL setup_installphp.bat 5.5 5.5.23 vc11 x86
  CALL setup_installphp.bat 5.4 5.4.39 vc9 x86
)
if "%ARCH%"=="x64" (
  CALL setup_installphp.bat 5.6 5.6.7 vc9 x86
  CALL setup_installphp.bat 5.5 5.5.23 vc11 x64
)


rmdir /q /s tmp

ENDLOCAL
