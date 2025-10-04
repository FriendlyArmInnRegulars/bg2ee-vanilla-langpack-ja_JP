@echo off
REM Build script for bg2ee-vanilla-langpack-ja_JP release package (Windows)

setlocal EnableDelayedExpansion

REM Configuration
set MOD_NAME=bg2ee-vanilla-langpack-ja_JP
set VERSION=v2.6.6.0
set WEIDU_VERSION=249.00
set WEIDU_URL=https://github.com/WeiDUorg/weidu/releases/download/v%WEIDU_VERSION%/WeiDU-Windows-249-amd64.zip

REM Directory setup
set RELEASE_DIR=release
set PACKAGE_DIR=%RELEASE_DIR%\%MOD_NAME%

echo === Building release package for %MOD_NAME% ===
echo Target version: %VERSION%
echo.

REM Clean previous builds
if exist "%RELEASE_DIR%" (
    echo Cleaning previous release directory...
    rmdir /s /q "%RELEASE_DIR%"
)

REM Create release directory structure
echo Creating release directory structure...
mkdir "%PACKAGE_DIR%"

REM Copy mod files
echo Copying mod files...
xcopy /E /I /Q "%VERSION%" "%PACKAGE_DIR%\%VERSION%"
copy README.md "%PACKAGE_DIR%\"

REM Check if TP2 file exists
if not exist "setup-%MOD_NAME%.tp2" (
    echo WARNING: setup-%MOD_NAME%.tp2 not found. You need to create it before release.
) else (
    copy "setup-%MOD_NAME%.tp2" "%PACKAGE_DIR%\"
)

REM Download WeiDU
echo Downloading WeiDU %WEIDU_VERSION%...
cd "%RELEASE_DIR%"
curl -L -o weidu.zip "%WEIDU_URL%"

REM Extract WeiDU using tar (built into Windows 10+)
echo Extracting WeiDU...
tar -xf weidu.zip 2>nul
if errorlevel 1 (
    REM Fallback to PowerShell if tar fails
    powershell -NoProfile -ExecutionPolicy Bypass -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('weidu.zip', '.')}"
)

REM Rename WeiDU executable
echo Renaming WeiDU executable...
if exist "weidu.exe" (
    move weidu.exe "%MOD_NAME%\setup-%MOD_NAME%.exe"
) else if exist "WeiDU.exe" (
    move WeiDU.exe "%MOD_NAME%\setup-%MOD_NAME%.exe"
) else if exist "WeiDU-Windows\weidu.exe" (
    move "WeiDU-Windows\weidu.exe" "%MOD_NAME%\setup-%MOD_NAME%.exe"
    rmdir /s /q "WeiDU-Windows"
) else (
    echo WARNING: Could not find weidu.exe in the archive
)

REM Clean up zip file
del weidu.zip

REM Create final archive using tar (built into Windows 10+)
echo Creating release archive...
set ARCHIVE_NAME=%MOD_NAME%-%VERSION%.zip
cd "%MOD_NAME%"
tar -a -cf "..\%ARCHIVE_NAME%" * 2>nul
cd ..
if errorlevel 1 (
    REM Fallback to PowerShell if tar fails
    powershell -NoProfile -ExecutionPolicy Bypass -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('%MOD_NAME%', '%ARCHIVE_NAME%')}"
)

echo.
echo === Release package created successfully! ===
echo Location: %RELEASE_DIR%\%ARCHIVE_NAME%
echo.

cd ..
echo Done!
pause
