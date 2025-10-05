@echo off
REM One-click installation script for bg2ee-vanilla-langpack-ja_JP
REM This script generates TLK files and installs the mod
REM Run this script from the mod directory (bg2ee-vanilla-langpack-ja_JP)

setlocal EnableDelayedExpansion

set MOD_NAME=bg2ee-vanilla-langpack-ja_JP
set VERSION=v2.6.6.0

echo ========================================
echo BG2:EE Japanese Language Pack Installer
echo ========================================
echo.

REM Check if we're in the mod directory

if not exist "..\chitin.key" (
    echo ERROR: chitin.key not found in parent directory.
    echo This script must be run from the mod directory inside the BG2:EE game directory.
    echo.
    echo Current directory: %CD%
    echo Expected: [BG2:EE game directory]\bg2ee-vanilla-langpack-ja_JP
    echo.
    pause
    exit /b 1
)


REM Check if setup-*.exe exists in parent directory
if not exist "..\setup-%MOD_NAME%.exe" (
    echo ERROR: setup-%MOD_NAME%.exe not found in parent directory.
    echo Please make sure you extracted all files correctly.
    echo.
    pause
    exit /b 1
)

REM Check if lang\ja_JP exists in game directory, if not copy from mod directory
if not exist "..\lang\ja_JP" (
    echo Creating lang\ja_JP directory in game directory...
    xcopy /E /I /Y "%VERSION%\lang\ja_JP" "..\lang\ja_JP" > nul
    if errorlevel 1 (
        echo ERROR: Failed to copy lang\ja_JP directory
        echo.
        pause
        exit /b 1
    )
    echo lang\ja_JP directory created successfully.
    echo.
)


REM Check if version directory exists
if not exist "%VERSION%" (
    echo ERROR: Version directory not found.
    echo Expected: %VERSION%
    echo.
    pause
    exit /b 1
)


REM Check if TRA files exist
if not exist "%VERSION%\lang\ja_JP\dialog.tra" (
    echo ERROR: dialog.tra not found.
    echo Expected: %VERSION%\lang\ja_JP\dialog.tra
    echo.
    pause
    exit /b 1
)


if not exist "%VERSION%\lang\ja_JP\dialogF.tra" (
    echo ERROR: dialogF.tra not found.
    echo Expected: %VERSION%\lang\ja_JP\dialogF.tra
    echo.
    pause
    exit /b 1
)


REM Change to game directory (parent directory)
echo Changing to game directory...
cd ..
echo Current directory: %CD%
echo.


echo Step 1: Generating TLK files from TRA files...
echo This may take several minutes. Please wait...
echo.

REM Copy setup-*.exe to mod directory as WeiDU.exe
echo Copying WeiDU executable to mod directory...
copy /Y "setup-%MOD_NAME%.exe" "%MOD_NAME%\WeiDU.exe" > nul
if errorlevel 1 (
    echo ERROR: Failed to copy WeiDU executable
    echo.
    pause
    exit /b 1
)

REM Generate dialog.tlk (from game directory root)
echo Generating dialog.tlk (male protagonist)...
"%MOD_NAME%\WeiDU.exe" --make-tlk "lang\ja_JP\dialog.tra" --tlkout "lang\ja_JP\dialog.tlk" --use-lang en_US
if errorlevel 1 (
    echo ERROR: Failed to generate dialog.tlk
    echo.
    pause
    exit /b 1
)


REM Generate dialogF.tlk (from game directory root)
echo Generating dialogF.tlk (female protagonist)...
"%MOD_NAME%\WeiDU.exe" --make-tlk "lang\ja_JP\dialogF.tra" --tlkout "lang\ja_JP\dialogF.tlk" --use-lang en_US
if errorlevel 1 (
    echo ERROR: Failed to generate dialogF.tlk
    echo.
    pause
    exit /b 1
)


echo.
echo TLK files generated successfully!
echo   - lang\ja_JP\dialog.tlk
echo   - lang\ja_JP\dialogF.tlk
echo.


echo Step 2: Installing the Japanese language pack...
echo.
echo WeiDU will now install the mod.
echo Please follow the on-screen instructions:
echo   - Select language: 1 (English)
echo   - Install component: i (Install)
echo.
pause


REM Install the mod
"setup-%MOD_NAME%.exe"


REM Clean up temporary TRA files
echo.
echo Cleaning up temporary files...
if exist "lang\ja_JP\dialog.tra" del /Q "lang\ja_JP\dialog.tra"
if exist "lang\ja_JP\dialogF.tra" del /Q "lang\ja_JP\dialogF.tra"
if exist "lang\ja_JP\setup.tra" del /Q "lang\ja_JP\setup.tra"
echo Cleanup complete.

echo.
echo ========================================
echo Installation complete!
echo ========================================
echo.
echo Next steps:
echo 1. Launch Baldur's Gate II: Enhanced Edition
echo 2. Go to Settings and change Language to "Japanese"
echo 3. Restart the game and enjoy playing in Japanese!
echo.
pause
