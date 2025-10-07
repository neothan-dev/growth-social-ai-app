# Growth Social AI App

<div align="center">
  <img src="../assets/app_icon.png" alt="Growth Social AI App Logo" width="240" height="240">
  
  <h3>あなたのパーソナルAI駆動成長・ソーシャルプラットフォーム</h3>

  <a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/README.md"><img alt="README in English" src="https://img.shields.io/badge/English-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-CN.md"><img alt="简体中文操作指南" src="https://img.shields.io/badge/简体中文-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-JP.md"><img alt="日本語のREADME" src="https://img.shields.io/badge/日本語-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-KR.md"><img alt="README in 한국어" src="https://img.shields.io/badge/한국어-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-ES.md"><img alt="README en Español" src="https://img.shields.io/badge/Español-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-FR.md"><img alt="README en Français" src="https://img.shields.io/badge/Français-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-IT.md"><img alt="README in Italiano" src="https://img.shields.io/badge/Italiano-lightgrey"></a>
  
  [![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
  [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=for-the-badge)](https://opensource.org/licenses/Apache-2.0)
  [![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-green?style=for-the-badge)](https://flutter.dev/)
</div>

## 🌟 概要

Growth Social AI Appは、あなたのインテリジェントな成長・ソーシャルコンパニオンとして機能する、Flutterベースの包括的なクロスプラットフォームアプリケーションです。個人成長追跡、データ分析、ソーシャルコミュニティ機能、友達チャット、AI音声会話機能を単一の強力なプラットフォームに統合しています。

## ✨ 主要機能

### 🏥 健康・ウェルネス
- **個人成長追跡**：日々の健康指標を記録・監視
- **健康データ分析**：ウェルネスジャーニーへの包括的な分析と洞察
- **進捗可視化**：時間の経過とともに改善を追跡する美しいグラフとチャート
- **健康目標**：パーソナライズされた健康目標を設定・達成

### 🤖 AI駆動機能
- **AI音声チャット**：AI健康アシスタントとの自然言語会話
- **インテリジェント推奨**：データに基づくパーソナライズされた健康アドバイス
- **音声スタイルカスタマイズ**：選択可能な複数のAI音声パーソナリティ
- **リアルタイム健康コーチング**：即座のフィードバックとガイダンス

### 👥 ソーシャル・コミュニティ
- **ソーシャルハブ**：健康ジャーニーで志を同じくする人々とつながる
- **コミュニティシェア**：進捗と成果をシェア
- **友達システム**：友達を追加して一緒に進捗を追跡
- **モーメントシェア**：健康ジャーニーについてのアップデートを投稿
- **専門家記事**：キュレートされた健康・ウェルネスコンテンツにアクセス

### 💬 コミュニケーション
- **リアルタイムチャット**：友達やコミュニティメンバーとのインスタントメッセージング
- **音声メッセージ**：音声ノートの送受信
- **グループ会話**：健康に焦点を当てたグループディスカッションに参加
- **通知システム**：重要な健康リマインダーで最新情報を維持

### 🌍 国際化
- **多言語サポート**：複数の言語で利用可能
- **ローカライズコンテンツ**：地域固有の健康情報と推奨事項
- **文化的適応**：異なる文化的文脈に合わせた健康アドバイス

## 🚀 はじめに

### 前提条件

- Flutter SDK (3.10.0以上)
- Dart SDK
- Android Studio / Xcode (モバイル開発用)
- VS Code (推奨IDE)

### インストール

1. **リポジトリをクローン**
   ```bash
   git clone https://github.com/neothan-dev/growth-social-ai-app.git
   cd growth-social-ai-app
   ```

2. **依存関係をインストール**
   ```bash
   flutter pub get
   ```

3. **アプリケーションを実行**
   ```bash
   flutter run
   ```

### プラットフォーム固有のセットアップ

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

#### デスクトップ (Windows/macOS/Linux)
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```


## 🏗️ アーキテクチャ

### プロジェクト構造
```
lib/
├── config/           # 設定ファイル
├── models/           # データモデル
├── screens/          # UI画面
├── services/         # ビジネスロジックサービス
├── widgets/          # 再利用可能なUIコンポーネント
├── theme/            # アプリテーマ
├── utils/            # ユーティリティ関数
└── localization/     # 国際化
```

### 主要コンポーネント

- **AIサービス**：AI会話と推奨を処理
- **健康データサービス**：健康指標と分析を管理
- **ソーシャルサービス**：コミュニティと友達の相互作用を処理
- **音声サービス**：音声認識と合成を管理
- **認証サービス**：ユーザー認証と管理
- **ナビゲーションマネージャー**：アプリナビゲーションとルーティング

## 🛠️ 使用技術

- **Flutter**：クロスプラットフォームUIフレームワーク
- **Dart**：プログラミング言語
- **SQLite**：ローカルデータベースストレージ
- **HTTP**：ネットワーク通信
- **WebSocket**：リアルタイム通信
- **Lottie**：アニメーション
- **Provider**：状態管理
- **Shared Preferences**：ローカルストレージ
- **Permission Handler**：デバイス権限
- **Path Provider**：ファイルシステムアクセス

## 📊 詳細機能

### 健康追跡
- 日々の健康指標記録
- チャートによる進捗可視化
- 目標設定と達成追跡
- 健康トレンド分析
- パーソナライズされた推奨事項

### AIアシスタント
- 自然言語処理
- 音声認識と合成
- コンテキスト健康アドバイス
- パーソナライズされたコーチング
- 複数のAIパーソナリティ

### ソーシャル機能
- ユーザープロフィールとアバター
- 友達接続
- コミュニティ投稿とシェア
- グループディスカッション
- 成果シェア

### データ管理
- ローカルSQLiteデータベース
- クラウド同期
- データエクスポート/インポート
- プライバシーコントロール
- バックアップと復元

## 🔧 設定

### 環境設定
ルートディレクトリに `.env` ファイルを作成：
```env
API_BASE_URL=your_api_url
AI_SERVICE_URL=your_ai_service_url
VOICE_SERVICE_URL=your_voice_service_url
```

### ネットワーク設定
`lib/config/network_config.dart` でAPIエンドポイントを更新。

### 音声設定
`lib/config/voice_config.dart` で音声設定を構成。

## 🤝 貢献

貢献を歓迎します！詳細は[貢献ガイドライン](CONTRIBUTING.md)をご覧ください。

### 開発ワークフロー
1. リポジトリをフォーク
2. 機能ブランチを作成
3. 変更を加える
4. 該当する場合はテストを追加
5. プルリクエストを送信

## 📝 ライセンス

このプロジェクトはApache License 2.0の下でライセンスされています - 詳細は[LICENSE](LICENSE)ファイルをご覧ください。

## 🆘 サポート

- **ドキュメント**：[Wiki](https://github.com/neothan-dev/growth-social-ai-app/wiki)
- **問題**：[GitHub Issues](https://github.com/neothan-dev/growth-social-ai-app/issues)
- **ディスカッション**：[GitHub Discussions](https://github.com/neothan-dev/growth-social-ai-app/discussions)
- **メール**：neothan7@hotmail.com

## 🗺️ ロードマップ

- [ ] 高度なAI健康コーチング
- [ ] ウェアラブルデバイス統合
- [ ] 遠隔医療機能
- [ ] 高度な分析ダッシュボード
- [ ] マルチテナントサポート
- [ ] サードパーティ統合API

## 🙏 謝辞

- 素晴らしいフレームワークを提供してくれたFlutterチーム
- 様々なパッケージを提供してくれたオープンソースコミュニティ
- ドメイン専門知識を提供してくれた健康専門家
- 貴重なフィードバックを提供してくれたベータテスター

## 📈 統計

![GitHub stars](https://img.shields.io/github/stars/neothan-dev/growth-social-ai-app?style=social)
![GitHub forks](https://img.shields.io/github/forks/neothan-dev/growth-social-ai-app?style=social)
![GitHub issues](https://img.shields.io/github/issues/neothan-dev/growth-social-ai-app)
![GitHub pull requests](https://img.shields.io/github/issues-pr/neothan-dev/growth-social-ai-app)

---

<div align="center">
  <p>Growth Social AIチームが❤️で作成</p>
  <p>⭐ このリポジトリが役立つと思ったら、スターを付けてください！</p>
</div>
