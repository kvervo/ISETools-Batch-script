@echo off

set device=

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
echo EnumerateDevices
call:enumerate EnumerateDevices
set /p d=Select device to get Isolated Storage from:
set device=deviceindex:%d%

:home
cls
echo.
echo Device Index :: %device%
echo Project Name :: %title%
echo Product ID   :: %id%
echo.
echo Select a task:
echo =============
echo t) Take snapshot
echo r) Restore snapshot 
echo l) Emulator Storage - List files/directories
echo e) Exit
echo.
set /p query=Type option:
if "%query%"=="t" goto tsxd
if "%query%"=="r" goto rsxd
if "%query%"=="l" goto dirxd
if "%query%"=="e" exit
goto home

:tsxd
call:exec ts %id% %savepath%
goto gohome

:rsxd
set /P  restorepath=Please, enter path to restore^>
call:exec rs %id% %restorepath%
goto gohome

:dirxd
call:exec dir %id%
goto gohome

:dirde
call:exec dir %id%
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

:enumerate
if "%programfiles(x86)%XXX"=="XXX" (
"C:\Program Files\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" EnumerateDevices
) else (
"C:\Program Files (x86)\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" EnumerateDevices
)
goto:eof

:exec
if "%programfiles(x86)%XXX"=="XXX" (
"C:\Program Files\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" %~1 %device% %~2 %~3
) else (
"C:\Program Files (x86)\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" %~1 %device% %~2 %~3
)
goto:eof