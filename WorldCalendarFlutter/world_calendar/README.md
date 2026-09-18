# world_calendar

A world calendar project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Build
> [!IMPORTANT]
> **注意事項**
> このプロジェクトにはセキュリティ上の理由から `google-services.json` および `amplifyconfiguration.dart` が含まれていません。クローン後にアプリを動作させるには、これらのファイルを各自で作成して配置する必要があります。

1. flutter 更新
   flutter upgrade
2. package読み込み
   flutter pub get
3. 言語化設定
   flutter gen-l10n
4. json_serializable自動生成
　　flutter pub run build_runner build

Flutter Version : 3.29.0

### 参考
国アイコン
https://github.com/bytepark/country_icons/blob/master/icons/flags/png100px