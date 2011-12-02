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


if not exist Properties\WMAppManifest.xml goto error

xml sel -T -t -m "//App" -v "@ProductID" -n Properties\WMAppManifest.xml > productID.txt
xml sel -T -t -m "//App" -v "@Title" -n Properties\WMAppManifest.xml > title.txt
set /p id= < productID.txt
set /p title= < title.txt
set id=%id:{=%
set id=%id:}=%
set title=%title: =_%
del productID.txt
del title.txt

set /P  savepath=Please, enter where to save snapshots^>
if %savepath%.==. set savepath=C:\%title%.Storage

:home
cls
echo.
echo Project Name %title%
echo Product ID %id%
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
if "%query%"=="2" goto rsxd
if "%query%"=="3" goto dirxd
if "%query%"=="4" goto tsde
if "%query%"=="5" goto rsde
if "%query%"=="6" goto dirde
if "%query%"=="7" exit
goto home

:tsde
call:exec ts de %id% %savepath%
goto gohome

:tsxd
call:exec ts xd %id% %savepath%
goto gohome

:rsde
set /P  restorepath=Please, enter path to restore^>
call:exec rs de %id% %restorepath%
goto gohome

:rsxd
set /P  restorepath=Please, enter path to restore^>
call:exec rs xd %id% %restorepath%
goto gohome

:dirxd
call:exec dir xd %id%
goto gohome

:dirde
call:exec dir de %id%
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