# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a WeiDU-based language pack mod for Baldur's Gate II: Enhanced Edition (BG2:EE) that provides Japanese (ja_JP) localization for the vanilla game content.

## WeiDU Mod Architecture

WeiDU is the standard modding framework for Infinity Engine games (Baldur's Gate, Icewind Dale, Planescape: Torment). A typical WeiDU mod structure consists of:

### Version Management
- Each BG2:EE version has its own directory (e.g., `v2.6.6.0/`)
- The TP2 file detects the game version and uses the appropriate directory
- Add new version directories as needed for future BG2:EE updates
- Current supported version: **v2.6.6.0**

## 仕様

- このリポジトリでは日本語化Modに必要な各ファイルの編集や更新を管理するとともに、releaseディレクトリも用意し、ビルドスクリプトを実行してユーザに配布可能なパッケージの生成も行えるようにする。
- ユーザに配布するパッケージとしてWeiDUのModで一般的以下の構成とする。
   - setup-(MODNAME).exe
   - (MODNAME) ディレクトリ
      - tp2 ファイル他必要なデータ
- 最終的な成果物としては以下のような挙動を想定している
   - 翻訳済みのテキストファイルから日本語化したtlkファイルを生成する
      - dialog.tra   -> dialog.tlk
      - dialogF.tra  -> dialogF.tlk
   - 日本語化したtlkファイルをゲームディレクトリの lang/ja_JP ディレクトリ内に配置する
   - 日本語メッセージの表示に必要な下記ファイルもそれぞれゲームディレクトリの適切なディレクトリ内に配置する
      - MSGOTHIC.bmp -> lang/ja_JP/fonts/MSGOTHIC.bmp
      - MSGOTHIC.FNT -> lang/ja_JP/fonts/MSGOTHIC.FNT
      - MEIRYO.ttf   -> override/MEIRYO.ttf
      - BGEE.LUA     -> override/BGEE.LUA















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
