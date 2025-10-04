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

以下のファイルを `bg2ee-vanilla-langpack-ja_JP/v2.6.6.0/override/` ディレクトリに配置してください：
- `BGEE.LUA` - 日本語表示用の設定ファイル
- `MEIRYO.ttf` - メイリオフォントファイル

### ファイルの入手方法

1. 日本語版BG2:EEがある場合: ゲームの `override/` ディレクトリから取得
2. コミュニティ提供のパックを使用

※ 著作権の関係でこれらのファイルはリポジトリに含まれていません

## インストール方法

1. [Releases](https://github.com/FriendlyArmInnRegulars/bg2ee-vanilla-langpack-ja_JP/releases) から最新版の `bg2ee-vanilla-langpack-ja_JP-v2.6.6.0.zip` をダウンロード
2. ZIPファイルを展開
3. **日本語フォントと設定ファイルを準備**（上記「日本語フォントと設定ファイルの準備」参照）
   - `BGEE.LUA` と `MEIRYO.ttf` を `bg2ee-vanilla-langpack-ja_JP/v2.6.6.0/override/` に配置
4. `bg2ee-vanilla-langpack-ja_JP` フォルダをBG2:EEのゲームディレクトリ（`chitin.key` があるフォルダ）にコピー
5. `setup-bg2ee-vanilla-langpack-ja_JP.exe` をゲームディレクトリにコピー
6. `setup-bg2ee-vanilla-langpack-ja_JP.exe` を実行してインストール
   - WeiDUが言語選択を求めたら `1` (English) を選択
   - インストールの確認で `i` (Install) を入力
7. インストールが完了したら、ゲームを起動
8. **ゲーム内の設定画面から言語を「日本語 (Japanese)」に変更**
9. ゲームを再起動して日本語でプレイ

### 注意事項
- このMODはBG2:EE v2.6.6.0専用です
- 他のバージョンでは動作しない可能性があります
- インストール前にゲームのセーブデータをバックアップすることを推奨します
- **インストール前に日本語フォントと設定ファイル（BGEE.LUA、MEIRYO.ttf）を準備する必要があります**
- インストール後、ゲーム内の設定で言語を「日本語」に変更する必要があります

## ファイル構成

```
bg2ee-vanilla-langpack-ja_JP/
├── setup-bg2ee-vanilla-langpack-ja_JP.tp2  # インストールスクリプト
├── v2.6.6.0/
│   ├── lang/
│   │   └── ja_JP/
│   │       ├── dialog.tra   # 男性主人公用翻訳 (103,214文字列)
│   │       ├── dialogF.tra  # 女性主人公用翻訳 (103,214文字列)
│   │       └── setup.tra    # インストールメッセージ
│   ├── override/            # 日本語フォント・設定ファイル配置場所
│   │   ├── BGEE.LUA        # (ユーザーが配置)
│   │   └── MEIRYO.ttf      # (ユーザーが配置)
│   └── backup/              # インストール時に自動生成
└── README.md
```

## 開発者向け情報

### TLKファイルの生成

TRAファイルからTLKファイルを生成するには：

#### Windows
```batch
generate-tlk.bat
```

#### Linux/macOS
```bash
chmod +x generate-tlk.sh
./generate-tlk.sh
```

このスクリプトは：
1. WeiDU v249.00 を自動ダウンロード
2. `v2.6.6.0/lang/ja_JP/dialog.tra` から `dialog.tlk` を生成
3. `v2.6.6.0/lang/ja_JP/dialogF.tra` から `dialogF.tlk` を生成

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

スクリプトは以下の処理を自動で行います：
1. WeiDU v249.00 を GitHub からダウンロード
2. 必要なファイルを `release/` ディレクトリにコピー
3. WeiDU を `setup-bg2ee-vanilla-langpack-ja_JP.exe` にリネーム
4. 配布用の ZIP アーカイブを作成

生成されるファイル: `release/bg2ee-vanilla-langpack-ja_JP-v2.6.6.0.zip`

### 必要なツール（開発用）
- **Windows**: PowerShell, curl
- **Linux/macOS**: bash, curl, zip, unzip, tar