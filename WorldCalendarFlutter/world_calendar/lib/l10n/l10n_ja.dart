// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get helloWorld => 'こんにちは世界！';

  @override
  String get appName => '世界のカレンダー';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'はい';

  @override
  String get commonNo => 'いいえ';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonDone => '決定';

  @override
  String get dialogSocketError => 'ネットワークエラーが発生しました。確認の上、やり直してください。';

  @override
  String get reference => 'レファレンス：';

  @override
  String get wikipedia => 'ウィキペディア';

  @override
  String get countryEvents => '記念日';

  @override
  String get worldEvents => '世界の\nできごと';

  @override
  String get emptyEvents => '記念日が存在しません。';

  @override
  String get drawerCountry => '国選択';

  @override
  String get drawerLicense => 'ライセンス';

  @override
  String get drawerInfo => 'その他の情報';

  @override
  String get licenseCount => 'ライセンス:%s件';

  @override
  String get infoRelatedApp => '開発者の他のアプリ';

  @override
  String get dateFormatStringYM => 'yyyy年MM月';

  @override
  String get dateFormatStringYMD => 'yyyy年MM月dd日';

  @override
  String get dateFormatStringWiki => 'M月d日';

  @override
  String get dateWeekSun => '日';

  @override
  String get dateWeekMon => '月';

  @override
  String get dateWeekTue => '火';

  @override
  String get dateWeekWed => '水';

  @override
  String get dateWeekThu => '木';

  @override
  String get dateWeekFri => '金';

  @override
  String get dateWeekSat => '土';

  @override
  String get dateIntercalation => '閏';

  @override
  String get dateLunar => '旧暦';

  @override
  String get dateSubstitute => '振替休日';

  @override
  String get countryUS => 'アメリカ';

  @override
  String get countryCA => 'カナダ';

  @override
  String get countryFR => 'フランス';

  @override
  String get countryIE => 'アイルランド';

  @override
  String get countryGBENG => 'イングランド';

  @override
  String get countryGBWLS => 'ウェールズ';

  @override
  String get countryGBSCT => 'スコットランド';

  @override
  String get countryGBNIR => '北アイルランド';

  @override
  String get countryDE => 'ドイツ';

  @override
  String get countryAU => 'オーストラリア';

  @override
  String get countryJP => '日本';

  @override
  String get countryKR => '大韓民国';

  @override
  String get countryHK => '香港';

  @override
  String get countryCN => '中国';

  @override
  String get countryTW => '台湾';
}
