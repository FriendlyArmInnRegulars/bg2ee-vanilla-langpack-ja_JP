# bg2ee-vanilla-langpack-ja_JP

Baldur's Gate II: Enhanced Edition (BG2:EE) v2.6.6.0 用の日本語言語パック

## 必要なツール

### WeiDU
このMODのインストールには WeiDU が必要です。

- **Windows 64bit**: [WeiDU GitHub Releases](https://github.com/WeiDUorg/weidu/releases) から `WeiDU-Windows-amd64.zip` をダウンロードしてください
- **その他のOS**: 上記リンクから使用しているOSに対応したWeiDUをダウンロードし、適宜置き換えてください
  - Linux用、macOS用のバイナリも同じリリースページから入手可能です

### 対応バージョン
- BG2:EE v2.6.6.0

## 日本語フォントと設定ファイルの準備

**重要**: インストール前に、以下のファイルを準備する必要があります。

以下のフォントファイルを `bg2ee-vanilla-langpack-ja_JP/v2.6.6.0/lang/ja_JP/fonts/` ディレクトリに配置してください：
- `MSGOTHIC.bmp` - 日本語ビットマップフォント
- `MSGOTHIC.FNT` - フォント定義ファイル

以下の設定ファイルを `bg2ee-vanilla-langpack-ja_JP/v2.6.6.0/override/` ディレクトリに配置してください：
- `BGEE.LUA` - 日本語表示用の設定ファイル
- `MEIRYO.ttf` - メイリオフォントファイル

### ファイルの入手方法

1. 日本語版BG2:EEがある場合:
   - フォントファイル: ゲームの `lang/ja_JP/fonts/` ディレクトリから取得
   - 設定ファイル: ゲームの `override/` ディレクトリから取得
2. コミュニティ提供のパックを使用

※ 著作権の関係でこれらのファイルはリポジトリに含まれていません

## インストール方法

1. [Releases](https://github.com/FriendlyArmInnRegulars/bg2ee-vanilla-langpack-ja_JP/releases) から最新版の `bg2ee-vanilla-langpack-ja_JP-v2.6.6.0.zip` をダウンロード
2. ZIPファイルを展開
3. **日本語フォントと設定ファイルを準備**（上記「日本語フォントと設定ファイルの準備」参照）
   - `MSGOTHIC.bmp` と `MSGOTHIC.FNT` を `bg2ee-vanilla-langpack-ja_JP/v2.6.6.0/lang/ja_JP/fonts/` に配置
   - `BGEE.LUA` と `MEIRYO.ttf` を `bg2ee-vanilla-langpack-ja_JP/v2.6.6.0/override/` に配置
4. 展開したファイル一式（`setup-bg2ee-vanilla-langpack-ja_JP.exe` と `bg2ee-vanilla-langpack-ja_JP` フォルダ）をBG2:EEのゲームディレクトリ（`chitin.key` があるフォルダ）にコピー
5. ゲームディレクトリ内の `setup-bg2ee-vanilla-langpack-ja_JP.exe` を実行してインストール
   - WeiDUが言語選択を求めたら `1` (English) を選択
   - インストールの確認で `i` (Install) を入力
6. インストールが完了したら、ゲームを起動
7. **ゲーム内の設定画面から言語を「日本語 (Japanese)」に変更**
8. ゲームを再起動して日本語でプレイ

### 注意事項
- このMODはBG2:EE v2.6.6.0専用です
- 他のバージョンでは動作しない可能性があります
- インストール前にゲームのセーブデータをバックアップすることを推奨します
- **インストール前に日本語フォントと設定ファイル（MSGOTHIC.bmp、MSGOTHIC.FNT、BGEE.LUA、MEIRYO.ttf）を準備する必要があります**
- インストール後、ゲーム内の設定で言語を「日本語」に変更する必要があります

## ファイル構成

配布パッケージを展開すると以下の構成になります：

```
setup-bg2ee-vanilla-langpack-ja_JP.exe  # インストール実行ファイル
bg2ee-vanilla-langpack-ja_JP/           # Modデータディレクトリ
├── setup-bg2ee-vanilla-langpack-ja_JP.tp2  # インストールスクリプト
├── README.md
└── v2.6.6.0/
    ├── lang/
    │   └── ja_JP/
    │       ├── dialog.tra   # 男性主人公用翻訳 (103,214文字列)
    │       ├── dialogF.tra  # 女性主人公用翻訳 (103,214文字列)
    │       ├── setup.tra    # インストールメッセージ
    │       └── fonts/       # 日本語フォントファイル配置場所
    │           ├── MSGOTHIC.bmp  # (ユーザーが配置)
    │           └── MSGOTHIC.FNT  # (ユーザーが配置)
    ├── override/            # 日本語設定ファイル配置場所
    │   ├── BGEE.LUA        # (ユーザーが配置)
    │   └── MEIRYO.ttf      # (ユーザーが配置)
    └── backup/              # インストール時に自動生成
```

## 開発者向け情報

### リリースパッケージの作成

配布用のリリースパッケージを作成するには：

#### Windows
```batch
build-release.bat
```

#### Linux/macOS
```bash
./build-release.sh
```

ビルドスクリプトは以下の処理を自動で行います：
1. WeiDU v249.00 を GitHub からダウンロード
2. TRAファイルからTLKファイルを自動生成
   - `v2.6.6.0/lang/ja_JP/dialog.tra` → `dialog.tlk`
   - `v2.6.6.0/lang/ja_JP/dialogF.tra` → `dialogF.tlk`
3. 必要なファイルを `release/` ディレクトリにコピー
4. WeiDU を `setup-bg2ee-vanilla-langpack-ja_JP.exe` にリネーム
5. 配布用の ZIP アーカイブを作成

生成されるファイル: `release/bg2ee-vanilla-langpack-ja_JP-v2.6.6.0.zip`

**注意**: ビルドスクリプトがTLKファイルの生成も自動的に行うため、別途TLK生成スクリプトを実行する必要はありません。

### 必要なツール（開発用）
- **Windows**: PowerShell, curl
- **Linux/macOS**: bash, curl, zip, unzip, tar