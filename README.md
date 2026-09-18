# WorldCalendar (世界カレンダー)

Flutterを用いたAndroid向けの世界カレンダーアプリケーションです。世界各国の祝日情報、旧暦（太陰太陽暦）変換、およびWikipedia連携による歴史的情報の提供を行います。

## 🚀 プロジェクトの概要
このプロジェクトは、実用的なカレンダー機能の提供に加え、AWS AmplifyやFirebaseを活用したクラウド連携、および複雑な日付計算アルゴリズムの実装を目的として開発されました。

### 主な機能
- **グローバル祝日対応**: 世界各国の主要な祝日を表示。
- **旧暦変換エンジン**: 高精度な旧暦・陽暦変換アルゴリズムを実装。
- **Wikipedia連携**: 該当日の歴史的な出来事や詳細情報をWikipedia APIから取得し表示。
- **ダイナミックデータ同期**: AWS S3を活用し、アプリのアップデートなしでカレンダー情報を更新可能。
- **多言語対応**: 日本語、韓国語、英語に完全対応。

## 🛠 技術スタック
- **Framework**: Flutter 3.29.0
- **State Management**: Riverpod (hooks_riverpod)
- **Backend**: AWS Amplify (Auth, S3), Firebase (Analytics, Crashlytics)
- **Architecture**: モジュール化されたクリーンな設計
- **Libraries**: Google Mobile Ads, WebView Flutter, JSON Serializable

## 💡 技術的な特徴と挑戦
1. **日付計算アルゴリズム**: 複雑な旧暦計算や閏月の処理を実装し、正確な日付データを提供しています。
2. **効率的なデータ同期**: AWS Amplify Storageを利用し、大規模なJSONデータの効率的なキャッシュと更新ロジックを構築しました。
3. **柔軟なローカライズ**: `l10n`パッケージを活用し、言語ごとに最適化されたUI/UXを提供しています。

## 📦 セットアップと実行
> [!IMPORTANT]
> セキュリティ上の理由から、`google-services.json` および `amplifyconfiguration.dart` はリポジトリに含まれていません。各自でプロジェクトを作成し、配置する必要があります。

1. `flutter pub get`
2. `flutter gen-l10n`
3. `flutter pub run build_runner build`
4. `flutter run`
