// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class L10nKo extends L10n {
  L10nKo([String locale = 'ko']) : super(locale);

  @override
  String get helloWorld => 'こんにちは世界！';

  @override
  String get appName => '세계의 달력';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => '예';

  @override
  String get commonNo => '아니오';

  @override
  String get commonCancel => '취소';

  @override
  String get commonDone => '확인';

  @override
  String get dialogSocketError => '네트워크 에러가 발생했습니다. 확인 후 다시 시도해 주세요.';

  @override
  String get reference => '출처 : ';

  @override
  String get wikipedia => '위키백과';

  @override
  String get countryEvents => '기념일';

  @override
  String get worldEvents => '세계의\n사건';

  @override
  String get emptyEvents => '기념일이 존재하지 않습니다.';

  @override
  String get drawerCountry => '국가 선택';

  @override
  String get drawerLicense => '라이센스';

  @override
  String get drawerInfo => '이외의 정보';

  @override
  String get licenseCount => '라이센스:%s건';

  @override
  String get infoRelatedApp => '개발자의 다른 앱';

  @override
  String get dateFormatStringYM => 'yyyy년 MM월';

  @override
  String get dateFormatStringYMD => 'yyyy년 MM월 dd일';

  @override
  String get dateFormatStringWiki => 'M월_d일';

  @override
  String get dateWeekSun => '일';

  @override
  String get dateWeekMon => '월';

  @override
  String get dateWeekTue => '화';

  @override
  String get dateWeekWed => '수';

  @override
  String get dateWeekThu => '목';

  @override
  String get dateWeekFri => '금';

  @override
  String get dateWeekSat => '토';

  @override
  String get dateIntercalation => '윤';

  @override
  String get dateLunar => '음력';

  @override
  String get dateSubstitute => '대체공휴일';

  @override
  String get countryUS => '미국';

  @override
  String get countryCA => '캐나다';

  @override
  String get countryFR => '프랑스';

  @override
  String get countryIE => '아일랜드';

  @override
  String get countryGBENG => '잉글랜드';

  @override
  String get countryGBWLS => '웨일스';

  @override
  String get countryGBSCT => '스코틀랜드';

  @override
  String get countryGBNIR => '북아일랜드';

  @override
  String get countryDE => '독일';

  @override
  String get countryAU => '호주';

  @override
  String get countryJP => '일본';

  @override
  String get countryKR => '대한민국';

  @override
  String get countryHK => '홍콩';

  @override
  String get countryCN => '중국';

  @override
  String get countryTW => '대만';
}
