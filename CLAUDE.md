# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a WeiDU-based language pack mod for Baldur's Gate II: Enhanced Edition (BG2:EE) that provides Japanese (ja_JP) localization for the vanilla game content.

## WeiDU Mod Architecture

WeiDU is the standard modding framework for Infinity Engine games (Baldur's Gate, Icewind Dale, Planescape: Torment). A typical WeiDU mod structure consists of:

### Core Files
- **TP2 file** (`setup-<modname>.tp2`): The installation script that defines mod components and how they're installed
- **TRA files**: Translation files containing localized strings for different languages
- **README**: Documentation for users

### Directory Structure
```
bg2ee-vanilla-langpack-ja_JP/           # Main mod folder
├── setup-bg2ee-vanilla-langpack-ja_JP.tp2  # Installation script (detects game version)
├── v2.6.6.0/                            # BG2:EE v2.6.6.0 specific files
│   ├── lang/                            # Language-specific files
│   │   └── ja_JP/                      # Japanese translation files
│   │       ├── dialog.tra              # Male protagonist translations (~14MB)
│   │       ├── dialogF.tra             # Female protagonist translations (~14MB)
│   │       └── setup.tra               # Setup text translations (optional)
│   └── backup/                          # Backup directory for this version
├── v2.7.0.0/                            # Future version support (example)
│   ├── lang/
│   │   └── ja_JP/
│   └── backup/
└── README.md
```

### Version Management
- Each BG2:EE version has its own directory (e.g., `v2.6.6.0/`)
- The TP2 file detects the game version and uses the appropriate directory
- Add new version directories as needed for future BG2:EE updates
- Current supported version: **v2.6.6.0**

### TP2 File Structure
A basic TP2 file for a language pack should include:
- `BACKUP` directive: Specifies backup directory location
- `AUTHOR` directive: Contact information
- `README` directive: Points to documentation
- `LANGUAGE` directive: Defines supported languages
- `BEGIN` directive: Marks the start of a component
- Translation/installation commands

### Language Pack Specifics
Language packs for Enhanced Edition games work by:
1. Extending or modifying the game's `dialog.tlk` and `dialogF.tlk` files
2. Providing translated strings for game text
3. Ensuring compatibility with the BG2:EE engine's Unicode support

### Translation Files
- **dialog.tra**: Male protagonist dialogue translations (対応するdialog.tlk)
- **dialogF.tra**: Female protagonist dialogue translations (対応するdialogF.tlk)
- Both files use WeiDU's TRA format with `@string_reference` syntax
- Files are typically large (~14MB each) as they contain all game dialogue

## Development Workflow

### WeiDU Installation
1. Download WeiDU from https://github.com/WeiDUorg/weidu/releases
   - **Windows 64-bit**: Download `WeiDU-Windows-amd64.zip` (latest: v249.00)
   - **Linux/macOS**: Download the appropriate binary for your OS
2. Extract `weidu.exe` (or the appropriate binary for your OS)

### Testing the Mod
1. Copy the mod folder to your BG2:EE game directory (the one containing `chitin.key`)
2. Copy `weidu.exe` to the game directory and rename it to `setup-bg2ee-vanilla-langpack-ja_JP.exe`
   - On Linux/macOS, use the appropriate binary and ensure it has execute permissions
3. Run `setup-bg2ee-vanilla-langpack-ja_JP.exe` to install
4. Test in-game with language set to `ja_JP` in `Baldur.lua`

### Common WeiDU Commands
- Install: `./setup-<modname>.exe --language 0 --force-install 0`
- Uninstall: `./setup-<modname>.exe --uninstall`
- List components: `./setup-<modname>.exe --list-components`

### File Naming Conventions
- No spaces in folder/file names
- Use underscores or hyphens for word separation
- TP2 file must match the mod folder name: `setup-<foldername>.tp2`

## Japanese Localization Notes

### Character Encoding
- Use UTF-8 encoding for all translation files
- Ensure BOM (Byte Order Mark) handling is consistent with WeiDU requirements
- TRA files should use `@<number>` references for string lookups

### Font Requirements
- BG2:EE requires appropriate Japanese font support
- Game configuration may need font specification (e.g., `MSGOTHIC`)
- Verify text rendering in-game for long strings and special characters

## Building Release Packages

Two build scripts are provided to create distributable release packages:

### build-release.sh (Linux/macOS)
- Automatically downloads WeiDU v249.00 from GitHub
- Copies necessary files to `release/` directory
- Renames WeiDU to `setup-bg2ee-vanilla-langpack-ja_JP.exe`
- Creates a ZIP archive ready for distribution
- Output: `release/bg2ee-vanilla-langpack-ja_JP-v2.6.6.0.zip`

### build-release.bat (Windows)
- Same functionality as the shell script
- Uses PowerShell for ZIP operations
- Requires: PowerShell, curl

### Important Notes
- Scripts exclude backup folders to ensure clean releases
- Package only includes: mod files, README, TP2 file, and WeiDU executable
- Always run scripts from repository root directory
- Ensure TP2 file exists before building (warning issued if missing)

## WeiDU Documentation
- Official WeiDU docs: https://weidu.org/~thebigg/README-WeiDU.html
- WeiDU mod examples: https://github.com/topics/weidu
