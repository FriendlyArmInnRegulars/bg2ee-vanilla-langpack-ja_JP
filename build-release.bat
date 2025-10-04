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
set PACKAGE_DIR=%RELEASE_DIR%
set MOD_SUBDIR=%PACKAGE_DIR%\%MOD_NAME%

echo === Building release package for %MOD_NAME% ===
echo Target version: %VERSION%
echo.

REM Step 1: Generate TLK files
echo Step 1: Generating TLK files from TRA files...
echo.

REM Download WeiDU for TLK generation if not present
if not exist "weidu.exe" (
    echo Downloading WeiDU for TLK generation...
    curl -L -o weidu-tlk.zip %WEIDU_URL%

    tar -xf weidu-tlk.zip 2>nul
    if errorlevel 1 (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('weidu-tlk.zip', '.')}"
    )

    if exist "weidu.exe" (
        echo Found weidu.exe
    ) else if exist "WeiDU.exe" (
        ren WeiDU.exe weidu.exe
    ) else if exist "WeiDU-Windows\weidu.exe" (
        move "WeiDU-Windows\weidu.exe" weidu.exe
        rmdir /s /q "WeiDU-Windows"
    )

    del weidu-tlk.zip
)

REM Create temporary lowercase directory for WeiDU
mkdir %VERSION%\lang\ja_jp 2>nul
copy %VERSION%\lang\ja_JP\dialog.tra %VERSION%\lang\ja_jp\ >nul
copy %VERSION%\lang\ja_JP\dialogF.tra %VERSION%\lang\ja_jp\ >nul
copy %VERSION%\lang\ja_jp\dialogF.tra %VERSION%\lang\ja_jp\dialogf.tra >nul

REM Generate dialog.tlk
echo Generating dialog.tlk...
echo 1| weidu.exe --nogame --make-tlk %VERSION%/lang/ja_jp/dialog.tra >nul 2>&1
for /f "delims=" %%f in ('dir /b "*.tlk" 2^>nul') do (
    move "%%f" %VERSION%\lang\ja_JP\dialog.tlk >nul 2>&1
)
if exist "%VERSION%\lang\ja_JP\dialog.tlk" (
    echo + dialog.tlk generated successfully
)

REM Generate dialogF.tlk
echo Generating dialogF.tlk...
echo 1| weidu.exe --nogame --make-tlk %VERSION%/lang/ja_jp/dialogf.tra --ftlkout dialogF.tlk >nul 2>&1
for /f "delims=" %%f in ('dir /b "*.tlk" 2^>nul') do (
    move "%%f" %VERSION%\lang\ja_JP\dialogF.tlk >nul 2>&1
)
if exist "%VERSION%\lang\ja_JP\dialogF.tlk" (
    echo + dialogF.tlk generated successfully
)

REM Clean up temporary files
rmdir /s /q %VERSION%\lang\ja_jp
del weidu.exe

echo.
echo Step 2: Creating release package...
echo.

REM Clean previous builds
if exist "%RELEASE_DIR%" (
    echo Cleaning previous release directory...
    rmdir /s /q "%RELEASE_DIR%"
)

REM Create release directory structure
echo Creating release directory structure...
mkdir "%MOD_SUBDIR%"

REM Copy mod files
echo Copying mod files...
xcopy /E /I /Q "%VERSION%" "%MOD_SUBDIR%\%VERSION%"
copy README.md "%MOD_SUBDIR%\"

REM Check if TP2 file exists
if not exist "setup-%MOD_NAME%.tp2" (
    echo WARNING: setup-%MOD_NAME%.tp2 not found. You need to create it before release.
) else (
    copy "setup-%MOD_NAME%.tp2" "%MOD_SUBDIR%\"
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

REM Rename WeiDU executable and place at root level
echo Renaming WeiDU executable...
if exist "weidu.exe" (
    move weidu.exe "setup-%MOD_NAME%.exe"
) else if exist "WeiDU.exe" (
    move WeiDU.exe "setup-%MOD_NAME%.exe"
) else if exist "WeiDU-Windows\weidu.exe" (
    move "WeiDU-Windows\weidu.exe" "setup-%MOD_NAME%.exe"
    rmdir /s /q "WeiDU-Windows"
) else (
    echo WARNING: Could not find weidu.exe in the archive
)

REM Clean up zip file
del weidu.zip

REM Create final archive using tar (built into Windows 10+)
echo Creating release archive...
set ARCHIVE_NAME=%MOD_NAME%-%VERSION%.zip
tar -a -cf "%ARCHIVE_NAME%" "setup-%MOD_NAME%.exe" "%MOD_NAME%" 2>nul
if errorlevel 1 (
    REM Fallback to PowerShell if tar fails
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$zip = [System.IO.Compression.ZipFile]::Open('%ARCHIVE_NAME%', 'Create'); $zip.CreateEntryFromFile('setup-%MOD_NAME%.exe', 'setup-%MOD_NAME%.exe'); Get-ChildItem -Path '%MOD_NAME%' -Recurse | ForEach-Object { if (-not $_.PSIsContainer) { $relativePath = $_.FullName.Substring((Get-Location).Path.Length + 1); [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $_.FullName, $relativePath) } }; $zip.Dispose()"
)

echo.
echo === Release package created successfully! ===
echo Location: %RELEASE_DIR%\%ARCHIVE_NAME%
echo.

cd ..
echo Done!
pause
