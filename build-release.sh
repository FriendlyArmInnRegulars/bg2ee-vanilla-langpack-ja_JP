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
PACKAGE_DIR="${RELEASE_DIR}"
MOD_SUBDIR="${PACKAGE_DIR}/${MOD_NAME}"

echo "=== Building release package for ${MOD_NAME} ==="
echo "Target version: ${VERSION}"
echo ""

# Step 1: Generate TLK files
echo "Step 1: Generating TLK files from TRA files..."
echo ""

# Download WeiDU for TLK generation if not present
if [ ! -f "weidu" ]; then
    echo "Downloading WeiDU for TLK generation..."
    curl -L -o weidu-linux.zip https://github.com/WeiDUorg/weidu/releases/download/v${WEIDU_VERSION}/WeiDU-Linux-249-amd64.zip

    if command -v unzip >/dev/null 2>&1; then
        unzip -q weidu-linux.zip
    elif command -v python3 >/dev/null 2>&1; then
        python3 -c "import zipfile; zipfile.ZipFile('weidu-linux.zip').extractall('.')"
    fi

    if [ -d "WeiDU-Linux" ]; then
        mv WeiDU-Linux/weidu .
        rm -rf WeiDU-Linux
    fi

    chmod +x weidu
    rm -f weidu-linux.zip
fi

# Create temporary lowercase directory for WeiDU (it lowercases paths)
mkdir -p ${VERSION}/lang/ja_jp
cp ${VERSION}/lang/ja_JP/dialog.tra ${VERSION}/lang/ja_jp/
cp ${VERSION}/lang/ja_JP/dialogF.tra ${VERSION}/lang/ja_jp/
ln -sf dialogF.tra ${VERSION}/lang/ja_jp/dialogf.tra

# Generate dialog.tlk
echo "Generating dialog.tlk..."
echo "1" | ./weidu --nogame --make-tlk ${VERSION}/lang/ja_jp/dialog.tra 2>&1 | grep -v "ERROR:" | grep -v "FATAL ERROR:" | grep -v "Press ENTER" || true
if [ -f "-- no dialog.tlk --" ]; then
    mv "-- no dialog.tlk --" ${VERSION}/lang/ja_JP/dialog.tlk
    echo "✓ dialog.tlk generated successfully"
fi

# Generate dialogF.tlk
echo "Generating dialogF.tlk..."
echo "1" | ./weidu --nogame --make-tlk ${VERSION}/lang/ja_jp/dialogf.tra --ftlkout dialogF.tlk 2>&1 | grep -v "ERROR:" | grep -v "FATAL ERROR:" | grep -v "Press ENTER" || true
find . -maxdepth 1 -type f -iname "*dialog*tlk*" ! -name "dialog.tlk" -exec mv {} ${VERSION}/lang/ja_JP/dialogF.tlk \; 2>/dev/null
if [ -f "${VERSION}/lang/ja_JP/dialogF.tlk" ]; then
    echo "✓ dialogF.tlk generated successfully"
fi

# Clean up temporary files
rm -rf ${VERSION}/lang/ja_jp
rm -f weidu

echo ""
echo "Step 2: Creating release package..."
echo ""

# Clean previous builds
if [ -d "${RELEASE_DIR}" ]; then
    echo "Cleaning previous release directory..."
    rm -rf "${RELEASE_DIR}"
fi

# Create release directory structure
echo "Creating release directory structure..."
mkdir -p "${MOD_SUBDIR}"

# Copy mod files to subdirectory
echo "Copying mod files..."
cp -r "${VERSION}" "${MOD_SUBDIR}/"
cp README.md "${MOD_SUBDIR}/"

# Check if TP2 file exists, if not warn user
if [ ! -f "setup-${MOD_NAME}.tp2" ]; then
    echo "WARNING: setup-${MOD_NAME}.tp2 not found. You need to create it before release."
else
    cp "setup-${MOD_NAME}.tp2" "${MOD_SUBDIR}/"
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

# Rename WeiDU executable and place at root level
echo "Renaming WeiDU executable..."
if [ -f "weidu.exe" ]; then
    mv weidu.exe "setup-${MOD_NAME}.exe"
elif [ -f "WeiDU.exe" ]; then
    mv WeiDU.exe "setup-${MOD_NAME}.exe"
elif [ -f "WeiDU-Windows/weidu.exe" ]; then
    mv WeiDU-Windows/weidu.exe "setup-${MOD_NAME}.exe"
    rm -rf WeiDU-Windows
else
    echo "WARNING: Could not find weidu.exe in the archive"
fi

# Clean up zip file
rm weidu.zip

# Create final archive
echo "Creating release archive..."
# Clean up any backup folders that might have been accidentally included
find . -type d -name "backup" -exec rm -rf {} + 2>/dev/null || true

ARCHIVE_NAME="${MOD_NAME}-${VERSION}.zip"

# Use zip if available, otherwise use Python
if command -v zip >/dev/null 2>&1; then
    zip -r "${ARCHIVE_NAME}" "setup-${MOD_NAME}.exe" "${MOD_NAME}"
elif command -v python3 >/dev/null 2>&1; then
    echo "Using Python to create archive..."
    python3 -c "import zipfile, os; z = zipfile.ZipFile('${ARCHIVE_NAME}', 'w', zipfile.ZIP_DEFLATED); z.write('setup-${MOD_NAME}.exe'); [z.write(os.path.join(r,f), os.path.join(r,f)) for r,d,fs in os.walk('${MOD_NAME}') for f in fs]; z.close()"
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
