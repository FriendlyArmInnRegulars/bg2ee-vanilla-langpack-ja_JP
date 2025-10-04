#!/bin/bash
# Build script for bg2ee-vanilla-langpack-ja_JP release package

set -e

# Configuration
MOD_NAME="bg2ee-vanilla-langpack-ja_JP"
VERSION="v2.6.6.0"
WEIDU_VERSION="249.00"
WEIDU_URL="https://github.com/WeiDUorg/weidu/releases/download/v${WEIDU_VERSION}/WeiDU-Windows-249-amd64.zip"

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

# Check if unzip is available, otherwise use Python
if command -v unzip >/dev/null 2>&1; then
    unzip -q weidu.zip
elif command -v python3 >/dev/null 2>&1; then
    echo "Using Python to extract archive..."
    python3 -c "import zipfile; zipfile.ZipFile('weidu.zip').extractall('.')"
else
    echo "ERROR: Neither unzip nor python3 is available. Cannot extract WeiDU archive."
    exit 1
fi

# Rename WeiDU executable
echo "Renaming WeiDU executable..."
if [ -f "weidu.exe" ]; then
    mv weidu.exe "${MOD_NAME}/setup-${MOD_NAME}.exe"
elif [ -f "WeiDU.exe" ]; then
    mv WeiDU.exe "${MOD_NAME}/setup-${MOD_NAME}.exe"
elif [ -f "WeiDU-Windows/weidu.exe" ]; then
    mv WeiDU-Windows/weidu.exe "${MOD_NAME}/setup-${MOD_NAME}.exe"
    rm -rf WeiDU-Windows
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

# Use zip if available, otherwise use Python
if command -v zip >/dev/null 2>&1; then
    zip -r "${ARCHIVE_NAME}" "${MOD_NAME}"
elif command -v python3 >/dev/null 2>&1; then
    echo "Using Python to create archive..."
    python3 -c "import shutil; shutil.make_archive('${MOD_NAME}-${VERSION}', 'zip', '.', '${MOD_NAME}')"
else
    echo "ERROR: Neither zip nor python3 is available. Cannot create release archive."
    exit 1
fi

echo ""
echo "=== Release package created successfully! ==="
echo "Location: ${RELEASE_DIR}/${ARCHIVE_NAME}"
echo ""
echo "Package contents:"
if command -v unzip >/dev/null 2>&1; then
    unzip -l "${ARCHIVE_NAME}" | head -20
elif command -v python3 >/dev/null 2>&1; then
    python3 -c "import zipfile; z = zipfile.ZipFile('${ARCHIVE_NAME}'); print('\n'.join(z.namelist()[:20]))"
fi

cd ..
echo ""
echo "Done!"
