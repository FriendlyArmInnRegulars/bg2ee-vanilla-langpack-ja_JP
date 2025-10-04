#!/bin/bash
# Build script for bg2ee-vanilla-langpack-ja_JP release package

set -e

# Configuration
MOD_NAME="bg2ee-vanilla-langpack-ja_JP"
VERSION="v2.6.6.0"
WEIDU_VERSION="249.00"
WEIDU_URL="https://github.com/WeiDUorg/weidu/releases/download/v${WEIDU_VERSION}/WeiDU-Windows-amd64.zip"

# Directory setup
RELEASE_DIR="release"
PACKAGE_DIR="${RELEASE_DIR}/${MOD_NAME}"

echo "=== Building release package for ${MOD_NAME} ==="
echo "Target version: ${VERSION}"
echo ""

# Clean previous builds
if [ -d "${RELEASE_DIR}" ]; then
    echo "Cleaning previous release directory..."
    rm -rf "${RELEASE_DIR}"
fi

# Create release directory structure
echo "Creating release directory structure..."
mkdir -p "${PACKAGE_DIR}"

# Copy mod files
echo "Copying mod files..."
cp -r "${VERSION}" "${PACKAGE_DIR}/"
cp README.md "${PACKAGE_DIR}/"

# Check if TP2 file exists, if not warn user
if [ ! -f "setup-${MOD_NAME}.tp2" ]; then
    echo "WARNING: setup-${MOD_NAME}.tp2 not found. You need to create it before release."
else
    cp "setup-${MOD_NAME}.tp2" "${PACKAGE_DIR}/"
fi

# Download WeiDU
echo "Downloading WeiDU ${WEIDU_VERSION}..."
cd "${RELEASE_DIR}"
curl -L -o weidu.zip "${WEIDU_URL}"
unzip -q weidu.zip

# Rename WeiDU executable
echo "Renaming WeiDU executable..."
if [ -f "weidu.exe" ]; then
    mv weidu.exe "${MOD_NAME}/setup-${MOD_NAME}.exe"
elif [ -f "WeiDU.exe" ]; then
    mv WeiDU.exe "${MOD_NAME}/setup-${MOD_NAME}.exe"
else
    echo "WARNING: Could not find weidu.exe in the archive"
fi

# Clean up zip file
rm weidu.zip

# Create final archive
echo "Creating release archive..."
cd "${MOD_NAME}"
# Clean up any backup folders that might have been accidentally included
find . -type d -name "backup" -exec rm -rf {} + 2>/dev/null || true
cd ..

ARCHIVE_NAME="${MOD_NAME}-${VERSION}.zip"
zip -r "${ARCHIVE_NAME}" "${MOD_NAME}"

echo ""
echo "=== Release package created successfully! ==="
echo "Location: ${RELEASE_DIR}/${ARCHIVE_NAME}"
echo ""
echo "Package contents:"
unzip -l "${ARCHIVE_NAME}" | head -20

cd ..
echo ""
echo "Done!"
