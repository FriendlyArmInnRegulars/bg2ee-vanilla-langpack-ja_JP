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

## ファイル構成

```
v2.6.6.0/
├── lang/
│   └── ja_JP/
│       ├── dialog.tra   # 男性主人公用翻訳
│       └── dialogF.tra  # 女性主人公用翻訳
└── backup/              # インストール時に自動生成
```

## リリースパッケージの作成

開発者向け：配布用のリリースパッケージを作成するには以下のスクリプトを実行してください。

### Windows
```batch
build-release.bat
```

### Linux/macOS
```bash
./build-release.sh
```

スクリプトは以下の処理を自動で行います：
1. WeiDU v249.00 を GitHub からダウンロード
2. 必要なファイルを `release/` ディレクトリにコピー
3. WeiDU を `setup-bg2ee-vanilla-langpack-ja_JP.exe` にリネーム
4. 配布用の ZIP アーカイブを作成

生成されるファイル: `release/bg2ee-vanilla-langpack-ja_JP-v2.6.6.0.zip`

### 必要なツール（ビルド用）
- **Windows**: PowerShell, curl
- **Linux/macOS**: bash, curl, zip, unzip