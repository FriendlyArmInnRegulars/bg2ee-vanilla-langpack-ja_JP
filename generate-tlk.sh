#!/bin/bash
# Script to generate TLK files from TRA files using WeiDU

set -e

echo "Generating Japanese TLK files..."

# Download WeiDU if not present
if [ ! -f "weidu" ]; then
    echo "Downloading WeiDU..."
    curl -L -o weidu-linux.tar.gz https://github.com/WeiDUorg/weidu/releases/download/v249.00/weidu-linux-amd64.tar.gz
    tar -xzf weidu-linux-amd64.tar.gz
    chmod +x weidu
    rm weidu-linux-amd64.tar.gz
fi

# Generate dialog.tlk
echo "Generating dialog.tlk..."
echo "1" | ./weidu --make-tlk v2.6.6.0/lang/ja_JP/dialog.tra --out v2.6.6.0/lang/ja_JP

# Generate dialogF.tlk
echo "Generating dialogF.tlk..."
echo "1" | ./weidu --make-tlk v2.6.6.0/lang/ja_JP/dialogF.tra --out v2.6.6.0/lang/ja_JP --ftlkout dialogF.tlk

echo "TLK files generated successfully!"
echo "Files created:"
ls -lh v2.6.6.0/lang/ja_JP/*.tlk
