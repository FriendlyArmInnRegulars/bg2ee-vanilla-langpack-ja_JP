#!/bin/bash
# One-click installation script for bg2ee-vanilla-langpack-ja_JP
# This script generates TLK files and installs the mod
# Run this script from the mod directory (bg2ee-vanilla-langpack-ja_JP)

set -e

MOD_NAME="bg2ee-vanilla-langpack-ja_JP"
VERSION="v2.6.6.0"

echo "========================================"
echo "BG2:EE Japanese Language Pack Installer"
echo "========================================"
echo ""

# Check if we're in the mod directory
if [ ! -f "../chitin.key" ]; then
    echo "ERROR: chitin.key not found in parent directory."
    echo "This script must be run from the mod directory inside the BG2:EE game directory."
    echo ""
    echo "Current directory: $(pwd)"
    echo "Expected: [BG2:EE game directory]/bg2ee-vanilla-langpack-ja_JP"
    echo ""
    exit 1
fi

# Check if setup-*.exe exists in parent directory
if [ ! -f "../setup-${MOD_NAME}.exe" ]; then
    echo "ERROR: setup-${MOD_NAME}.exe not found in parent directory."
    echo "Please make sure you extracted all files correctly."
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

# Check if version directory exists
if [ ! -d "${VERSION}" ]; then
    echo "ERROR: Version directory not found."
    echo "Expected: ${VERSION}"
    echo ""
    exit 1
fi

# Check if TRA files exist
if [ ! -f "${VERSION}/lang/ja_JP/dialog.tra" ]; then
    echo "ERROR: dialog.tra not found."
    echo "Expected: ${VERSION}/lang/ja_JP/dialog.tra"
    echo ""
    exit 1
fi

if [ ! -f "${VERSION}/lang/ja_JP/dialogF.tra" ]; then
    echo "ERROR: dialogF.tra not found."
    echo "Expected: ${VERSION}/lang/ja_JP/dialogF.tra"
    echo ""
    exit 1
fi

# Change to game directory (parent directory)
echo "Changing to game directory..."
cd ..
echo "Current directory: $(pwd)"
echo ""

echo "Step 1: Generating TLK files from TRA files..."
echo "This may take several minutes. Please wait..."
echo ""

# Copy setup-*.exe to mod directory as WeiDU.exe
echo "Copying WeiDU executable to mod directory..."
cp "setup-${MOD_NAME}.exe" "${MOD_NAME}/WeiDU.exe"
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to copy WeiDU executable"
    echo ""
    exit 1
fi

# Make WeiDU.exe executable (for Wine on Linux/macOS)
chmod +x "${MOD_NAME}/WeiDU.exe"

# Generate dialog.tlk (from game directory root)
echo "Generating dialog.tlk (male protagonist)..."
wine "${MOD_NAME}/WeiDU.exe" --make-tlk "lang/ja_JP/dialog.tra" --tlkout "lang/ja_JP/dialog.tlk" --use-lang en_US
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to generate dialog.tlk"
    echo ""
    exit 1
fi

# Generate dialogF.tlk (from game directory root)
echo "Generating dialogF.tlk (female protagonist)..."
wine "${MOD_NAME}/WeiDU.exe" --make-tlk "lang/ja_JP/dialogF.tra" --tlkout "lang/ja_JP/dialogF.tlk" --use-lang en_US
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to generate dialogF.tlk"
    echo ""
    exit 1
fi

echo ""
echo "TLK files generated successfully!"
echo "  - lang/ja_JP/dialog.tlk"
echo "  - lang/ja_JP/dialogF.tlk"
echo ""

echo "Step 2: Installing the Japanese language pack..."
echo ""
echo "WeiDU will now install the mod."
echo "Please follow the on-screen instructions:"
echo "  - Select language: 1 (English)"
echo "  - Install component: i (Install)"
echo ""
read -p "Press Enter to continue..."

# Install the mod
wine "setup-${MOD_NAME}.exe"

# Clean up temporary TRA files
echo ""
echo "Cleaning up temporary files..."
rm -f "lang/ja_JP/dialog.tra"
rm -f "lang/ja_JP/dialogF.tra"
rm -f "lang/ja_JP/setup.tra"
echo "Cleanup complete."

echo ""
echo "========================================"
echo "Installation complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Launch Baldur's Gate II: Enhanced Edition"
echo "2. Go to Settings and change Language to \"Japanese\""
echo "3. Restart the game and enjoy playing in Japanese!"
echo ""
