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
echo 1) Take snapshot from Emulator Storage
echo 2) Take snapshot from Device Storage
echo 3) List directories from Emulator Storage
echo 4) List directories from Device Storage
echo 5) Exit
echo.
set /p query=Type option:
if "%query%"=="1" goto tsxd
if "%query%"=="2" goto tsde
if "%query%"=="3" goto dirxd
if "%query%"=="4" goto dirde
if "%query%"=="5" exit
goto home

:tsde
if "%programfiles(x86)%XXX"=="XXX" (
"C:\Program Files\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" ts de %var% %savepath%
) else (
"C:\Program Files (x86)\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" ts de %var% %savepath%
)
goto gohome

:tsxd
if "%programfiles(x86)%XXX"=="XXX" (
"C:\Program Files\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" ts xd %var% %savepath%
) else (
"C:\Program Files (x86)\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" ts xd %var% %savepath%
)
goto gohome

:dirxd
if "%programfiles(x86)%XXX"=="XXX" (
"C:\Program Files\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" dir xd %var%
) else (
"C:\Program Files (x86)\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" dir xd %var%
)
goto gohome

:dirde
if "%programfiles(x86)%XXX"=="XXX" (
"C:\Program Files\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" dir xd %var%
) else (
"C:\Program Files (x86)\Microsoft SDKs\Windows Phone\v7.1\Tools\IsolatedStorageExplorerTool\ISETool.exe" dir xd %var%
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