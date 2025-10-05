#!/bin/bash
# TLK generation script for bg2ee-vanilla-langpack-ja_JP
# This script only generates TLK files from TRA files
# Run this script from the mod directory (bg2ee-vanilla-langpack-ja_JP)

set -e

MOD_NAME="bg2ee-vanilla-langpack-ja_JP"
VERSION="v2.6.6.0"
WEIDU_VERSION="249.00"
WEIDU_URL="https://github.com/WeiDUorg/weidu/releases/download/v${WEIDU_VERSION}/WeiDU-Windows-249-amd64.zip"

echo "========================================"
echo "BG2:EE Japanese TLK File Generator"
echo "========================================"
echo ""

# Check if we're in the mod directory
if [ ! -f "../chitin.key" ]; then
    echo "ERROR: chitin.key not found in parent directory."
    echo "This script must be run from the mod directory inside the BG2:EE game directory."
    echo ""
    exit 1
fi

# Check if lang/ja_JP exists in game directory, if not copy from mod directory
if [ ! -d "../lang/ja_JP" ]; then
    echo "Creating lang/ja_JP directory in game directory..."
    cp -r "${VERSION}/lang/ja_JP" "../lang/"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to copy lang/ja_JP directory"
        echo ""
        exit 1
    fi
    echo "lang/ja_JP directory created successfully."
    echo ""
fi

# Check if TRA files exist
if [ ! -f "${VERSION}/lang/ja_JP/dialog.tra" ]; then
    echo "ERROR: dialog.tra not found."
    echo ""
    exit 1
fi

if [ ! -f "${VERSION}/lang/ja_JP/dialogF.tra" ]; then
    echo "ERROR: dialogF.tra not found."
    echo ""
    exit 1
fi

# Change to game directory
cd ..
echo "Current directory: $(pwd)"
echo ""

# Check for setup-*.exe first, otherwise download WeiDU
if [ -f "setup-${MOD_NAME}.exe" ]; then
    echo "Using existing setup-${MOD_NAME}.exe..."
    cp "setup-${MOD_NAME}.exe" "${MOD_NAME}/WeiDU.exe"
else
    echo "Downloading WeiDU ${WEIDU_VERSION}..."
    curl -L -o weidu-temp.zip "${WEIDU_URL}"

    echo "Extracting WeiDU..."
    if command -v unzip >/dev/null 2>&1; then
        unzip -q weidu-temp.zip
    elif command -v python3 >/dev/null 2>&1; then
        python3 -c "import zipfile; zipfile.ZipFile('weidu-temp.zip').extractall('.')"
    fi

    if [ -f "weidu.exe" ]; then
        mv weidu.exe "${MOD_NAME}/WeiDU.exe"
    elif [ -f "WeiDU.exe" ]; then
        mv WeiDU.exe "${MOD_NAME}/WeiDU.exe"
    elif [ -f "WeiDU-Windows/weidu.exe" ]; then
        mv WeiDU-Windows/weidu.exe "${MOD_NAME}/WeiDU.exe"
        rm -rf WeiDU-Windows
    fi

    rm -f weidu-temp.zip
fi

# Make WeiDU.exe executable
chmod +x "${MOD_NAME}/WeiDU.exe"

echo ""
echo "Generating TLK files from TRA files..."
echo "This may take several minutes. Please wait..."
echo ""

# Generate dialog.tlk
echo "Generating dialog.tlk (male protagonist)..."
wine "${MOD_NAME}/WeiDU.exe" --make-tlk "lang/ja_JP/dialog.tra" --tlkout "lang/ja_JP/dialog.tlk" --use-lang en_US
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to generate dialog.tlk"
    echo ""
    exit 1
fi

# Generate dialogF.tlk
echo "Generating dialogF.tlk (female protagonist)..."
wine "${MOD_NAME}/WeiDU.exe" --make-tlk "lang/ja_JP/dialogF.tra" --tlkout "lang/ja_JP/dialogF.tlk" --use-lang en_US
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to generate dialogF.tlk"
    echo ""
    exit 1
fi

echo ""
echo "========================================"
echo "TLK files generated successfully!"
echo "========================================"
echo "  - lang/ja_JP/dialog.tlk"
echo "  - lang/ja_JP/dialogF.tlk"
echo ""
echo "You can now run setup-${MOD_NAME}.exe to install the mod."
echo ""
