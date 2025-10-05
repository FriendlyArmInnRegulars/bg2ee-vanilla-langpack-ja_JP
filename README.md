# bg2ee-vanilla-langpack-ja_JP

Baldur's Gate II: Enhanced Edition (BG2:EE) v2.6.6.0 用の日本語言語パックMOD

## 概要

このMODは、Baldur's Gate II: Enhanced Edition (BG2:EE) v2.6.6.0に日本語翻訳を追加します。ゲーム内のダイアログ、アイテム説明、UI要素など103,214個の文字列を日本語化します。

### 主な特徴

- **完全な日本語翻訳**: 男性主人公用・女性主人公用の2つのダイアログファイルを提供
- **簡単インストール**: ワンクリックで自動インストール（`install.bat` / `install.sh`）
- **日本語フォント対応**: MSゴシックフォントとメイリオフォントを使用
- **WeiDU準拠**: 標準的なWeiDUフレームワークを使用し、他のMODとの互換性を確保

### 対応バージョン

- BG2:EE v2.6.6.0 専用

## システム要件

- **ゲーム**: Baldur's Gate II: Enhanced Edition (BG2:EE) v2.6.6.0
- **OS**: Windows / Linux / macOS
- **その他**: Linux/macOSではWineが必要（WeiDU実行ファイルの実行用）

## インストール方法

### 方法1: ワンクリックインストール（推奨）

最も簡単なインストール方法です。

#### Windows

1. [Releases](https://github.com/FriendlyArmInnRegulars/bg2ee-vanilla-langpack-ja_JP/releases)から最新版の `bg2ee-vanilla-langpack-ja_JP-v2.6.6.0.zip` をダウンロード
2. ZIPファイルをBG2:EEのゲームディレクトリ（`chitin.key`があるフォルダ）に展開
   - `setup-bg2ee-vanilla-langpack-ja_JP.exe` がゲームディレクトリに配置されます
   - `bg2ee-vanilla-langpack-ja_JP/` フォルダもゲームディレクトリに配置されます
3. `bg2ee-vanilla-langpack-ja_JP/` フォルダ内の `install.bat` をダブルクリック
4. スクリプトが自動的に以下を実行します：
   - TLKファイルの生成（数分かかります）
   - WeiDUによるMODのインストール
5. WeiDUの質問に回答：
   - 言語選択: `1` (English) を入力してEnter
   - インストール確認: `i` (Install) を入力してEnter
6. インストール完了後、BG2:EEを起動
7. ゲーム内の設定画面で言語を「Japanese (日本語)」に変更
8. ゲームを再起動して日本語でプレイ開始

#### Linux / macOS

1. [Releases](https://github.com/FriendlyArmInnRegulars/bg2ee-vanilla-langpack-ja_JP/releases)から最新版の `bg2ee-vanilla-langpack-ja_JP-v2.6.6.0.zip` をダウンロード
2. ZIPファイルをBG2:EEのゲームディレクトリ（`chitin.key`があるフォルダ）に展開
3. ターミナルで以下を実行：

```bash
cd [BG2:EEゲームディレクトリ]/bg2ee-vanilla-langpack-ja_JP
chmod +x install.sh
./install.sh
```

4. WeiDUの質問に回答：
   - 言語選択: `1` (English) を入力してEnter
   - インストール確認: `i` (Install) を入力してEnter
5. インストール完了後、BG2:EEを起動
6. ゲーム内の設定画面で言語を「Japanese (日本語)」に変更
7. ゲームを再起動して日本語でプレイ開始

**注意**: Linux/macOSでは、Windowsバイナリ（`setup-*.exe`）を実行するためにWineが必要です。`install.sh`は自動的にWineを使用します。

### 方法2: 手動インストール（上級者向け）

TLKファイルの生成とMODのインストールを分けて実行したい場合の方法です。

#### ステップ1: TLKファイルの生成

**Windows:**
```batch
cd [BG2:EEゲームディレクトリ]\bg2ee-vanilla-langpack-ja_JP
build-tlk.bat
```

**Linux/macOS:**
```bash
cd [BG2:EEゲームディレクトリ]/bg2ee-vanilla-langpack-ja_JP
chmod +x build-tlk.sh
./build-tlk.sh
```

このスクリプトは以下を実行します：
- TRAファイルからTLKファイルを生成（`dialog.tlk`、`dialogF.tlk`）
- 必要に応じてWeiDUを自動ダウンロード

#### ステップ2: MODのインストール

**Windows:**
```batch
cd [BG2:EEゲームディレクトリ]
setup-bg2ee-vanilla-langpack-ja_JP.exe
```

**Linux/macOS:**
```bash
cd [BG2:EEゲームディレクトリ]
wine setup-bg2ee-vanilla-langpack-ja_JP.exe
```

WeiDUの質問に回答してインストールを完了してください。

## アンインストール方法

1. BG2:EEゲームディレクトリで `setup-bg2ee-vanilla-langpack-ja_JP.exe` を実行
2. 言語選択: `1` (English)
3. アンインストール: `u` (Uninstall) を入力

または、以下のファイル・フォルダを手動で削除：

```
lang/ja_JP/dialog.tlk
lang/ja_JP/dialogF.tlk
lang/ja_JP/fonts/MSGOTHIC.bmp
lang/ja_JP/fonts/MSGOTHIC.FNT
override/BGEE.LUA
override/MEIRYO.ttf
bg2ee-vanilla-langpack-ja_JP/
setup-bg2ee-vanilla-langpack-ja_JP.exe
```

## トラブルシューティング

### インストール時のエラー

#### 「TLK files not found」エラー

**原因**: TLKファイルが生成されていません。

**解決方法**:
1. `install.bat`（または`install.sh`）を使用している場合は、必ずMODディレクトリ内から実行してください
2. 手動でTLKファイルを生成する場合は、`build-tlk.bat`（または`build-tlk.sh`）を実行してください

#### ゲーム内で日本語が表示されない

**原因**: ゲーム設定で言語が日本語に変更されていません。

**解決方法**: ゲーム内の設定画面で言語を「Japanese (日本語)」に変更し、ゲームを再起動してください。

### Linux/macOS特有の問題

#### 「Wine not found」エラー

**解決方法**: Wineをインストールしてください。

**Ubuntu/Debian:**
```bash
sudo apt-get install wine
```

**macOS (Homebrew):**
```bash
brew install --cask wine-stable
```

## ファイル構成

### 配布パッケージの構成

```
bg2ee-vanilla-langpack-ja_JP-v2.6.6.0.zip
├── setup-bg2ee-vanilla-langpack-ja_JP.exe  # WeiDUインストーラー
└── bg2ee-vanilla-langpack-ja_JP/           # MODディレクトリ
    ├── setup-bg2ee-vanilla-langpack-ja_JP.tp2  # WeiDUインストールスクリプト
    ├── install.bat                         # ワンクリックインストーラー (Windows)
    ├── install.sh                          # ワンクリックインストーラー (Linux/macOS)
    ├── build-tlk.bat                       # TLK生成スクリプト (Windows)
    ├── build-tlk.sh                        # TLK生成スクリプト (Linux/macOS)
    ├── README.md                           # このファイル
    └── v2.6.6.0/                           # バージョン別データ
        ├── lang/ja_JP/
        │   ├── dialog.tra                  # 男性主人公用翻訳ソース (103,214文字列)
        │   ├── dialogF.tra                 # 女性主人公用翻訳ソース (103,214文字列)
        │   ├── setup.tra                   # インストールメッセージ
        │   ├── dialog.tlk                  # 生成される男性用TLKファイル
        │   ├── dialogF.tlk                 # 生成される女性用TLKファイル
        │   └── fonts/                      # フォントディレクトリ
        │       ├── MSGOTHIC.bmp            # 日本語ビットマップフォント
        │       └── MSGOTHIC.FNT            # フォント定義ファイル
        ├── override/                       # 設定ファイルディレクトリ
        │   ├── BGEE.LUA                    # 日本語表示設定スクリプト
        │   └── MEIRYO.ttf                  # メイリオTrueTypeフォント
        └── backup/                         # WeiDUバックアップ (インストール時に自動生成)
```

### インストール後のゲームディレクトリ構成

```
[BG2:EEゲームディレクトリ]/
├── chitin.key
├── setup-bg2ee-vanilla-langpack-ja_JP.exe
├── bg2ee-vanilla-langpack-ja_JP/           # MODディレクトリ
│   ├── setup-bg2ee-vanilla-langpack-ja_JP.tp2
│   ├── install.bat                         # インストールスクリプト
│   ├── install.sh                          # インストールスクリプト
│   ├── build-tlk.bat                       # TLK生成スクリプト
│   ├── build-tlk.sh                        # TLK生成スクリプト
│   ├── README.md
│   └── v2.6.6.0/
│       ├── lang/ja_JP/
│       │   ├── dialog.tra
│       │   ├── dialogF.tra
│       │   ├── setup.tra
│       │   ├── dialog.tlk                  # インストール時に生成
│       │   ├── dialogF.tlk                 # インストール時に生成
│       │   └── fonts/
│       │       ├── MSGOTHIC.bmp
│       │       └── MSGOTHIC.FNT
│       ├── override/
│       │   ├── BGEE.LUA
│       │   └── MEIRYO.ttf
│       └── backup/                         # インストール後に作成
├── lang/ja_JP/                             # ゲーム用日本語データ
│   ├── dialog.tlk                          # MODからコピーされたファイル
│   ├── dialogF.tlk                         # MODからコピーされたファイル
│   └── fonts/
│       ├── MSGOTHIC.bmp                    # MODからコピーされたファイル
│       └── MSGOTHIC.FNT                    # MODからコピーされたファイル
└── override/
    ├── BGEE.LUA                            # MODからコピーされたファイル
    └── MEIRYO.ttf                          # MODからコピーされたファイル
```

## 技術情報

### WeiDUについて

このMODは[WeiDU](https://weidu.org/)を使用しています。WeiDUはInfinity Engineゲーム（Baldur's Gate、Icewind Dale、Planescape: Tormentなど）の標準的なMODフレームワークです。

### TLKファイルについて

TLK（Talk）ファイルは、ゲーム内のすべてのテキスト（ダイアログ、アイテム説明、UI要素など）を格納するデータベースファイルです。このMODでは：

- **dialog.tlk**: 男性主人公用のダイアログファイル
- **dialogF.tlk**: 女性主人公用のダイアログファイル

TRAファイル（翻訳ソース）からWeiDUの`--make-tlk`コマンドを使用してTLKファイルを生成します。

### バージョン管理

このMODはBG2:EEのバージョンごとにディレクトリを分けています（現在は`v2.6.6.0/`）。将来のBG2:EEアップデートに対応する際は、新しいバージョンディレクトリを追加することで対応可能です。

## 開発者向け情報

### リポジトリ構造

```
bg2ee-vanilla-langpack-ja_JP/
├── src/                                    # MODソースファイル
│   ├── v2.6.6.0/                           # バージョン別データ
│   ├── setup-bg2ee-vanilla-langpack-ja_JP.tp2
│   ├── install.bat / install.sh
│   └── build-tlk.bat / build-tlk.sh
├── build-release.bat                       # リリースビルドスクリプト (Windows)
├── build-release.sh                        # リリースビルドスクリプト (Linux/macOS)
├── README.md
└── CLAUDE.md                               # AI開発支援用ドキュメント
```

### リリースパッケージのビルド

配布用のZIPパッケージを作成するには：

**Windows:**
```batch
build-release.bat
```

**Linux/macOS:**
```bash
./build-release.sh
```

ビルドスクリプトは以下を自動実行します：

1. WeiDU v249.00をGitHubからダウンロード
2. `src/`ディレクトリからMODファイルをコピー
3. WeiDU実行ファイルを`setup-bg2ee-vanilla-langpack-ja_JP.exe`にリネーム
4. `release/bg2ee-vanilla-langpack-ja_JP-v2.6.6.0.zip`を作成

**注意**: ビルドスクリプトはTLKファイルを配布パッケージから除外します。TLKファイルはエンドユーザーがインストール時に生成します。

### 必要なツール（開発用）

- **Windows**: PowerShell、curl
- **Linux/macOS**: bash、curl、zip、unzip

### TLKファイルの手動生成（開発用）

```bash
# dialog.tlk の生成
setup-bg2ee-vanilla-langpack-ja_JP.exe --make-tlk src/v2.6.6.0/lang/ja_JP/dialog.tra --out src/v2.6.6.0/lang/ja_JP/dialog.tlk --use-lang en_US

# dialogF.tlk の生成
setup-bg2ee-vanilla-langpack-ja_JP.exe --make-tlk src/v2.6.6.0/lang/ja_JP/dialogF.tra --out src/v2.6.6.0/lang/ja_JP/dialogF.tlk --use-lang en_US
```

## ライセンスと著作権

### MODコンテンツ

このMODの翻訳データ（TRAファイル）およびスクリプトは、BG2:EEコミュニティによって作成されています。

### 日本語フォントファイル

このMODには、BG2:EE日本語版から抽出した以下のファイルが含まれています：

- `MSGOTHIC.bmp` / `MSGOTHIC.FNT`: 日本語ビットマップフォント
- `MEIRYO.ttf`: メイリオTrueTypeフォント
- `BGEE.LUA`: 日本語表示設定スクリプト

これらのファイルは、正規のBG2:EE日本語版に含まれるものと同等です。

### WeiDU

[WeiDU](https://weidu.org/)は、Westley Weimer氏とコミュニティによって開発されたオープンソースソフトウェアです。

## サポートとコントリビューション

### 問題報告

バグや問題を発見した場合は、[GitHub Issues](https://github.com/FriendlyArmInnRegulars/bg2ee-vanilla-langpack-ja_JP/issues)で報告してください。

### コントリビューション

プルリクエストを歓迎します。大きな変更の場合は、まずIssueで議論してください。

## クレジット

- **翻訳**: BG2:EE日本語翻訳コミュニティの皆様
- **MOD作成**: FriendlyArmInnRegulars
- **WeiDU**: Westley Weimer & WeiDU Community
- **ゲーム**: Beamdog / Overhaul Games

## リンク

- **GitHubリポジトリ**: https://github.com/FriendlyArmInnRegulars/bg2ee-vanilla-langpack-ja_JP
- **WeiDU公式サイト**: https://weidu.org/
- **BG2:EE公式サイト**: https://www.beamdog.com/games/baldurs-gate-2-enhanced/
- **日本語訳データの共有サイト**
   - [日本語化ファイル置き場 | uploader.jp](https://ux.getuploader.com/game_gate/)
   - [BGx:EE 非公式パッチ公開所 | uploader.jp](https://ux.getuploader.com/BGxEE_UnOfficialPatch/)
   - [BG2_EE翻訳シート_EE - Google スプレッドシート](https://docs.google.com/spreadsheets/d/1uPPxG1kB5tO-TzbO63I3gzuRDHpwwOxd2d3_lOF0LTM/edit?usp=sharing)