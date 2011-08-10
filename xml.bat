@echo off

title ISETool Batch Menu
:start
cls
echo.
echo ISETool Batch Script:
echo =====================
echo Please enter your project name and path 
echo where you would like to save the isolated storage snapshots
echo If you do not provide a saving path. 
echo The default value will be used C:\YOUR_PROJECT_NAME.Storage
echo =====================
echo.

set /P  mypath=Please, enter your Project Name^>
set /P  savepath=Please, enter where to save snapshots^>
if %savepath%.==. set savepath=C:\%mypath%.Storage

if not exist %mypath%\Properties\WMAppManifest.xml goto error

xml sel -T -t -m "//App" -v "@ProductID" -n %mypath%\Properties\WMAppManifest.xml > productID.txt
set /p var= < productID.txt
set var=%var:{=%
set var=%var:}=%
del productID.txt

:home
cls
echo.
echo Project Name %mypath%
echo Product ID %var%
echo.
echo Select a task:
echo =============
echo.
echo 1) Emulator Storage - Take snapshot
echo 2) Emulator Storage - Restore snapshot 
echo 3) Emulator Storage - List files/directories
echo 4) Device Storage - Take snapshot
echo 5) Device Storage - Restore snapshot
echo 6) Device Storage - List files/directories
echo 7) Exit
echo.
set /p query=Type option:
if "%query%"=="1" goto tsxd
if "%query%"=="2" goto tsde
if "%query%"=="3" goto rsxd
if "%query%"=="4" goto rsde
if "%query%"=="5" goto dirxd
if "%query%"=="6" goto dirde
if "%query%"=="7" exit
goto home

:tsde
call:exec ts de %var% %savepath%
goto gohome

:tsxd
call:exec ts xd %var% %savepath%
goto gohome

:rsde
set /P  restorepath=Please, enter path to restore^>
call:exec rs de %var% %restorepath%
goto gohome

:rsxd
set /P  restorepath=Please, enter path to restore^>
call:exec rs xd %var% %restorepath%
goto gohome

:dirxd
call:exec dir xd %var%
goto gohome

:dirde
call:exec dir de %var%
goto gohome

:exec
if "%programfiles(x86)%XXX"=="XXX" (
"C:\Program Files\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" %~1 %~2 %~3 %~4
) else (
"C:\Program Files (x86)\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" %~1 %~2 %~3 %~4
)
goto gohome

:gohome
pause
goto home

:error
echo.
echo WMAppManifest not found. 
echo Please, check that you entered the correct name for your project
echo.
pause
goto start

pause