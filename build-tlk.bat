@echo off
REM TLK generation script for bg2ee-vanilla-langpack-ja_JP
REM This script only generates TLK files from TRA files
REM Run this script from the mod directory (bg2ee-vanilla-langpack-ja_JP)

setlocal EnableDelayedExpansion

set MOD_NAME=bg2ee-vanilla-langpack-ja_JP
set VERSION=v2.6.6.0
set WEIDU_VERSION=249.00
set WEIDU_URL=https://github.com/WeiDUorg/weidu/releases/download/v%WEIDU_VERSION%/WeiDU-Windows-249-amd64.zip

echo ========================================
echo BG2:EE Japanese TLK File Generator
echo ========================================
echo.

REM Check if we're in the mod directory
if not exist "..\chitin.key" (
    echo ERROR: chitin.key not found in parent directory.
    echo This script must be run from the mod directory inside the BG2:EE game directory.
    echo.
    pause
    exit /b 1
)

REM Check if TRA files exist
if not exist "%VERSION%\lang\ja_JP\dialog.tra" (
    echo ERROR: dialog.tra not found.
    echo.
    pause
    exit /b 1
)

if not exist "%VERSION%\lang\ja_JP\dialogF.tra" (
    echo ERROR: dialogF.tra not found.
    echo.
    pause
    exit /b 1
)

REM Check for setup-*.exe first, otherwise download WeiDU
if exist "..\setup-%MOD_NAME%.exe" (
    echo Using existing setup-%MOD_NAME%.exe...
    copy /Y "..\setup-%MOD_NAME%.exe" "WeiDU.exe" > nul
) else (
    echo Downloading WeiDU %WEIDU_VERSION%...
    curl -L -o weidu-temp.zip "%WEIDU_URL%"

    echo Extracting WeiDU...
    tar -xf weidu-temp.zip 2>nul
    if errorlevel 1 (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('weidu-temp.zip', '.')}"
    )

    if exist "weidu.exe" (
        echo Found weidu.exe
    ) else if exist "WeiDU.exe" (
        ren WeiDU.exe weidu.exe
    ) else if exist "WeiDU-Windows\weidu.exe" (
        move "WeiDU-Windows\weidu.exe" weidu.exe
        rmdir /s /q "WeiDU-Windows"
    )

    del weidu-temp.zip
)

echo.
echo Generating TLK files from TRA files...
echo This may take several minutes. Please wait...
echo.

REM Generate dialog.tlk
echo Generating dialog.tlk (male protagonist)...
WeiDU.exe --make-tlk "%VERSION%\lang\ja_JP\dialog.tra" --tlkout "%VERSION%\lang\ja_JP\dialog.tlk" --use-lang en_US
if errorlevel 1 (
    echo ERROR: Failed to generate dialog.tlk
    echo.
    pause
    exit /b 1
)

REM Generate dialogF.tlk
echo Generating dialogF.tlk (female protagonist)...
WeiDU.exe --make-tlk "%VERSION%\lang\ja_JP\dialogF.tra" --tlkout "%VERSION%\lang\ja_JP\dialogF.tlk" --use-lang en_US
if errorlevel 1 (
    echo ERROR: Failed to generate dialogF.tlk
    echo.
    pause
    exit /b 1
)

REM Clean up WeiDU.exe
del WeiDU.exe

echo.
echo ========================================
echo TLK files generated successfully!
echo ========================================
echo   - %VERSION%\lang\ja_JP\dialog.tlk
echo   - %VERSION%\lang\ja_JP\dialogF.tlk
echo.
echo You can now run setup-%MOD_NAME%.exe to install the mod.
echo.
pause
