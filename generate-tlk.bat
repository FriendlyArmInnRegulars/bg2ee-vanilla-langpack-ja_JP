@echo off
REM Script to generate TLK files from TRA files using WeiDU

echo Generating Japanese TLK files...

REM Download WeiDU if not present
if not exist "weidu.exe" (
    echo Downloading WeiDU...
    curl -L -o weidu-windows.zip https://github.com/WeiDUorg/weidu/releases/download/v249.00/WeiDU-Windows-249-amd64.zip
    tar -xf weidu-windows.zip 2>nul || powershell -NoProfile -ExecutionPolicy Bypass -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('weidu-windows.zip', '.')}"

    REM Find and rename weidu executable
    if exist "weidu.exe" (
        echo Found weidu.exe
    ) else if exist "WeiDU.exe" (
        move WeiDU.exe weidu.exe
    ) else if exist "WeiDU-Windows\weidu.exe" (
        move "WeiDU-Windows\weidu.exe" weidu.exe
        rmdir /s /q WeiDU-Windows
    )

    del weidu-windows.zip
)

REM Generate dialog.tlk
echo Generating dialog.tlk...
echo 1| weidu.exe --make-tlk v2.6.6.0/lang/ja_JP/dialog.tra --out v2.6.6.0/lang/ja_JP

REM Generate dialogF.tlk
echo Generating dialogF.tlk...
echo 1| weidu.exe --make-tlk v2.6.6.0/lang/ja_JP/dialogF.tra --out v2.6.6.0/lang/ja_JP --ftlkout dialogF.tlk

echo.
echo TLK files generated successfully!
echo Files created:
dir /b v2.6.6.0\lang\ja_JP\*.tlk

pause
