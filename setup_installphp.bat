SETLOCAL

SET PHPMINVER=%1
SET PHPVER=%2
SET MSVSVER=%3
SET ARCH=%4

echo Installing PHP %1 %2 %3 %4

echo Installing dependencies
REM Disabled for now as it doesn't appear to be needed,
REM   and there are no prebuilds for anything but vc11
REM IF NOT EXIST php-files\deps\%PHPMINVER%-%MSVSVER%-x64 (
REM   tools\7za x -y -otmp\ src\php-deps-5.5-vc11-x64.7z
REM   move /Y tmp\deps php-files\deps\5.5-vc11-x64
REM )

echo Installing NTS
IF NOT EXIST php-files\src\%PHPVER%-nts-%MSVSVER%-%ARCH% (
  IF NOT EXIST tmp\php-src-%PHPVER%.tar (
    tools\7za x -y -otmp\ src\php-src-%PHPVER%.tar.bz2
  )
  tools\7za x -y -otmp\ tmp\php-src-%PHPVER%.tar
  move /Y tmp\php-%PHPVER% php-files\src\%PHPVER%-nts-%MSVSVER%-%ARCH%
)
echo Building NTS
IF NOT EXIST php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH% (
  CALL setup_buildphp.bat %PHPVER% nts %MSVSVER% %ARCH%
)
echo Adding NTS Helpers
IF NOT EXIST php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH%\phpunit.phar (
  xcopy src\php-phpunit.phar php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH%\phpunit.phar
)

echo Installing ZTS
IF NOT EXIST php-files\src\%PHPVER%-zts-%MSVSVER%-%ARCH% (
  IF NOT EXIST tmp\php-src-%PHPVER%.tar (
    tools\7za x -y -otmp\ src\php-src-%PHPVER%.tar.bz2
  )
  tools\7za x -y -otmp\ tmp\php-src-%PHPVER%.tar
  move /Y tmp\php-%PHPVER% php-files\src\%PHPVER%-zts-%MSVSVER%-%ARCH%
)
echo Building ZTS
IF NOT EXIST php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH% (
  CALL setup_buildphp.bat %PHPVER% zts %MSVSVER% %ARCH%
)
echo Adding ZTS Helpers
IF NOT EXIST php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpunit.phar (
  xcopy src\php-phpunit.phar php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpunit.phar
)

ENDLOCAL
