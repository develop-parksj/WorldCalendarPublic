import 'package:intl/intl.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/const/extension.dart';

class DateModel {
  final int _koreanLunarMinValue = 13910101;
  final int _koreanLunarMaxValue = 20501118;
  final int _koreanSolarMinValue = 13910205;
  final int _koreanSolarMaxValue = 20501231;

  final int _koreanLunarBaseYear = 1391;
  final int _solarLunarDayDiff = 35;

  final int _lunarSmallMonthDay = 29;
  final int _lunarBigMonthDay = 30;
  final int _solarSmallYearDay = 365;
  final int _solarBigYearDay = 366;

  int _lunarYear = 0;
  int get lunarYear => _lunarYear;
  int _lunarMonth = 0;
  int get lunarMonth => _lunarMonth;
  int _lunarDay = 0;
  int get lunarDay => _lunarDay;
  bool _isIntercalation = false;
  bool get isIntercalation => _isIntercalation;

  int _solarYear = 0;
  int get solarYear => _solarYear;
  int _solarMonth = 0;
  int get solarMonth => _solarMonth;
  int _solarDay = 0;
  int get solarDay => _solarDay;

  final List<int> _gapjaYearInx = [0, 0, 0];
  final List<int> _gapjaMonthInx = [0, 0, 1];
  final List<int> _gapjaDayInx = [0, 0, 2];

  final List<int> _solarDayS = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 29];
  final List<int> _koreanCheongan = [0xac11, 0xc744, 0xbcd1, 0xc815, 0xbb34, 0xae30, 0xacbd, 0xc2e0, 0xc784, 0xacc4];
  final List<int> _koreanGanji = [0xc790, 0xcd95, 0xc778, 0xbb18, 0xc9c4, 0xc0ac, 0xc624, 0xbbf8, 0xc2e0, 0xc720, 0xc220, 0xd574];
  final List<int> _koreanGapjaUnit = [0xb144, 0xc6d4, 0xc77c];

  final List<int> _chineseCheongan = [0x7532, 0x4e59, 0x4e19, 0x4e01, 0x620a, 0x5df1, 0x5e9a, 0x8f9b, 0x58ec, 0x7678];
  final List<int> _chineseGanji = [0x5b50, 0x4e11, 0x5bc5, 0x536f, 0x8fb0, 0x5df3, 0x5348, 0x672a, 0x7533, 0x9149, 0x620c, 0x4ea5];
  final List<int> _chineseGapjaUnit = [0x5e74, 0x6708, 0x65e5];

  final List<int> _intercalationStr = [0xc724, 0x958f];

  final List<int> _koreanLunarData = [
    0x82c40653,
    0xc301c6a9,
    0x82c405aa,
    0x82c60ab5,
    0x830092bd,
    0xc2c402b6,
    0x82c60c37,
    0x82fe552e,
    0x82c40c96,
    0xc2c60e4b,
    0x82fe3752,
    0x82c60daa,
    0x8301b5b4,
    0xc2c6056d,
    0x82c402ae,
    0x83007a3d,
    0x82c40a2d,
    0xc2c40d15,
    0x83004d95,
    0x82c40b52,
    0x8300cb69,
    0xc2c60ada,
    0x82c6055d,
    0x8301925b,
    0x82c4045b,
    0xc2c40a2b,
    0x83005aab,
    0x82c40a95,
    0x82c40b52,
    0xc3001eaa,
    0x82c60ab6,
    0x8300c55b,
    0x82c604b7,
    0xc2c40457,
    0x83007537,
    0x82c4052b,
    0x82c40695,
    0xc3014695,
    0x82c405aa,
    0x8300c9b5,
    0x82c60a6e,
    0xc2c404ae,
    0x83008a5e,
    0x82c40a56,
    0x82c40d2a,
    0xc3006eaa,
    0x82c60d55,
    0x82c4056a,
    0x8301295a,
    0xc2c6095e,
    0x8300b4af,
    0x82c4049b,
    0x82c40a4d,
    0xc3007d2e,
    0x82c40b2a,
    0x82c60b55,
    0x830045d5,
    0xc2c402da,
    0x82c6095b,
    0x83011157,
    0x82c4049b,
    0xc3009a4f,
    0x82c4064b,
    0x82c406a9,
    0x83006aea,
    0xc2c606b5,
    0x82c402b6,
    0x83002aae,
    0x82c60937,
    0xc2ffb496,
    0x82c40c96,
    0x82c60e4b,
    0x82fe76b2,
    0xc2c60daa,
    0x82c605ad,
    0x8300336d,
    0x82c4026e,
    0xc2c4092e,
    0x83002d2d,
    0x82c40c95,
    0x83009d4d,
    0xc2c40b4a,
    0x82c60b69,
    0x8301655a,
    0x82c6055b,
    0xc2c4025d,
    0x83002a5b,
    0x82c4092b,
    0x8300aa97,
    0xc2c40695,
    0x82c4074a,
    0x83008b5a,
    0x82c60ab6,
    0xc2c6053b,
    0x830042b7,
    0x82c40257,
    0x82c4052b,
    0xc3001d2b,
    0x82c40695,
    0x830096ad,
    0x82c405aa,
    0xc2c60ab5,
    0x830054ed,
    0x82c404ae,
    0x82c60a57,
    0xc2ff344e,
    0x82c40d2a,
    0x8301bd94,
    0x82c60b55,
    0xc2c4056a,
    0x8300797a,
    0x82c6095d,
    0x82c404ae,
    0xc3004a9b,
    0x82c40a4d,
    0x82c40d25,
    0x83011aaa,
    0xc2c60b55,
    0x8300956d,
    0x82c402da,
    0x82c6095b,
    0xc30054b7,
    0x82c40497,
    0x82c40a4b,
    0x83004b4b,
    0xc2c406a9,
    0x8300cad5,
    0x82c605b5,
    0x82c402b6,
    0xc300895e,
    0x82c6092f,
    0x82c40497,
    0x82fe4696,
    0xc2c40d4a,
    0x8300cea5,
    0x82c60d69,
    0x82c6056d,
    0xc301a2b5,
    0x82c4026e,
    0x82c4052e,
    0x83006cad,
    0xc2c40c95,
    0x82c40d4a,
    0x83002f4a,
    0x82c60b59,
    0xc300c56d,
    0x82c6055b,
    0x82c4025d,
    0x8300793b,
    0xc2c4092b,
    0x82c40a95,
    0x83015b15,
    0x82c406ca,
    0xc2c60ad5,
    0x830112b6,
    0x82c604bb,
    0x8300925f,
    0xc2c40257,
    0x82c4052b,
    0x82fe6aaa,
    0x82c60e95,
    0xc2c406aa,
    0x83003baa,
    0x82c60ab5,
    0x8300b4b7,
    0xc2c404ae,
    0x82c60a57,
    0x82fe752d,
    0x82c40d26,
    0xc2c60d95,
    0x830055d5,
    0x82c4056a,
    0x82c6096d,
    0xc300255d,
    0x82c404ae,
    0x8300aa4f,
    0x82c40a4d,
    0xc2c40d25,
    0x83006d69,
    0x82c60b55,
    0x82c4035a,
    0xc3002aba,
    0x82c6095b,
    0x8301c49b,
    0x82c40497,
    0xc2c40a4b,
    0x83008b2b,
    0x82c406a5,
    0x82c406d4,
    0xc3034ab5,
    0x82c402b6,
    0x82c60937,
    0x8300252f,
    0xc2c40497,
    0x82fe964e,
    0x82c40d4a,
    0x82c60ea5,
    0xc30166a9,
    0x82c6056d,
    0x82c402b6,
    0x8301385e,
    0xc2c4092e,
    0x8300bc97,
    0x82c40a95,
    0x82c40d4a,
    0xc3008daa,
    0x82c60b4d,
    0x82c6056b,
    0x830042db,
    0xc2c4025d,
    0x82c4092d,
    0x83002d33,
    0x82c40a95,
    0xc3009b4d,
    0x82c406aa,
    0x82c60ad5,
    0x83006575,
    0xc2c604bb,
    0x82c4025b,
    0x83013457,
    0x82c4052b,
    0xc2ffba94,
    0x82c60e95,
    0x82c406aa,
    0x83008ada,
    0xc2c609b5,
    0x82c404b6,
    0x83004aae,
    0x82c60a4f,
    0xc2c20526,
    0x83012d26,
    0x82c60d55,
    0x8301a5a9,
    0xc2c4056a,
    0x82c6096d,
    0x8301649d,
    0x82c4049e,
    0xc2c40a4d,
    0x83004d4d,
    0x82c40d25,
    0x8300bd53,
    0xc2c40b54,
    0x82c60b5a,
    0x8301895a,
    0x82c6095b,
    0xc2c4049b,
    0x83004a97,
    0x82c40a4b,
    0x82c40aa5,
    0xc3001ea5,
    0x82c406d4,
    0x8302badb,
    0x82c402b6,
    0xc2c60937,
    0x830064af,
    0x82c40497,
    0x82c4064b,
    0xc2fe374a,
    0x82c60da5,
    0x8300b6b5,
    0x82c6056d,
    0xc2c402ba,
    0x8300793e,
    0x82c4092e,
    0x82c40c96,
    0xc3015d15,
    0x82c40d4a,
    0x82c60da5,
    0x83013555,
    0xc2c4056a,
    0x83007a7a,
    0x82c60a5d,
    0x82c4092d,
    0xc3006aab,
    0x82c40a95,
    0x82c40b4a,
    0x83004baa,
    0xc2c60ad5,
    0x82c4055a,
    0x830128ba,
    0x82c60a5b,
    0xc3007537,
    0x82c4052b,
    0x82c40693,
    0x83015715,
    0xc2c406aa,
    0x82c60ad9,
    0x830035b5,
    0x82c404b6,
    0xc3008a5e,
    0x82c40a4e,
    0x82c40d26,
    0x83006ea6,
    0xc2c40d52,
    0x82c60daa,
    0x8301466a,
    0x82c6056d,
    0xc2c404ae,
    0x83003a9d,
    0x82c40a4d,
    0x83007d2b,
    0xc2c40b25,
    0x82c40d52,
    0x83015d54,
    0x82c60b5a,
    0xc2c6055d,
    0x8300355b,
    0x82c4049d,
    0x83007657,
    0x82c40a4b,
    0x82c40aa5,
    0x83006b65,
    0x82c406d2,
    0xc2c60ada,
    0x830045b6,
    0x82c60937,
    0x82c40497,
    0xc3003697,
    0x82c40a4d,
    0x82fe76aa,
    0x82c60da5,
    0xc2c405aa,
    0x83005aec,
    0x82c60aae,
    0x82c4092e,
    0xc3003d2e,
    0x82c40c96,
    0x83018d45,
    0x82c40d4a,
    0xc2c60d55,
    0x83016595,
    0x82c4056a,
    0x82c60a6d,
    0xc300455d,
    0x82c4052d,
    0x82c40a95,
    0x83003e95,
    0xc2c40b4a,
    0x83017b4a,
    0x82c609d5,
    0x82c4055a,
    0xc3015a3a,
    0x82c60a5b,
    0x82c4052b,
    0x83014a17,
    0xc2c40693,
    0x830096ab,
    0x82c406aa,
    0x82c60ab5,
    0xc30064f5,
    0x82c404b6,
    0x82c60a57,
    0x82fe452e,
    0xc2c40d16,
    0x82c60e93,
    0x82fe3752,
    0x82c60daa,
    0xc30175aa,
    0x82c6056d,
    0x82c404ae,
    0x83015a1b,
    0xc2c40a2d,
    0x82c40d15,
    0x83004da5,
    0x82c40b52,
    0xc3009d6a,
    0x82c60ada,
    0x82c6055d,
    0x8301629b,
    0xc2c4045b,
    0x82c40a2b,
    0x83005b2b,
    0x82c40a95,
    0xc2c40b52,
    0x83012ab2,
    0x82c60ad6,
    0x83017556,
    0xc2c60537,
    0x82c40457,
    0x83005657,
    0x82c4052b,
    0xc2c40695,
    0x83003795,
    0x82c405aa,
    0x8300aab6,
    0xc2c60a6d,
    0x82c404ae,
    0x8300696e,
    0x82c40a56,
    0xc2c40d2a,
    0x83005eaa,
    0x82c60d55,
    0x82c405aa,
    0xc3003b6a,
    0x82c60a6d,
    0x830074bd,
    0x82c404ab,
    0xc2c40a8d,
    0x83005d55,
    0x82c40b2a,
    0x82c60b55,
    0xc30045d5,
    0x82c404da,
    0x82c6095d,
    0x83002557,
    0xc2c4049b,
    0x83006a97,
    0x82c4064b,
    0x82c406a9,
    0x83004baa,
    0x82c606b5,
    0x82c402ba,
    0x83002ab6,
    0xc2c60937,
    0x82fe652e,
    0x82c40d16,
    0x82c60e4b,
    0xc2fe56d2,
    0x82c60da9,
    0x82c605b5,
    0x8300336d,
    0xc2c402ae,
    0x82c40a2e,
    0x83002e2d,
    0x82c40c95,
    0xc3006d55,
    0x82c40b52,
    0x82c60b69,
    0x830045da,
    0xc2c6055d,
    0x82c4025d,
    0x83003a5b,
    0x82c40a2b,
    0xc3017a8b,
    0x82c40a95,
    0x82c40b4a,
    0x83015b2a,
    0xc2c60ad5,
    0x82c6055b,
    0x830042b7,
    0x82c40257,
    0xc300952f,
    0x82c4052b,
    0x82c40695,
    0x830066d5,
    0xc2c405aa,
    0x82c60ab5,
    0x8300456d,
    0x82c404ae,
    0xc2c60a57,
    0x82ff3456,
    0x82c40d2a,
    0x83017e8a,
    0xc2c60d55,
    0x82c405aa,
    0x83005ada,
    0x82c6095d,
    0xc2c404ae,
    0x83004aab,
    0x82c40a4d,
    0x83008d2b,
    0xc2c40b29,
    0x82c60b55,
    0x83007575,
    0x82c402da,
    0xc2c6095d,
    0x830054d7,
    0x82c4049b,
    0x82c40a4b,
    0xc3013a4b,
    0x82c406a9,
    0x83008ad9,
    0x82c606b5,
    0xc2c402b6,
    0x83015936,
    0x82c60937,
    0x82c40497,
    0xc2fe4696,
    0x82c40e4a,
    0x8300aea6,
    0x82c60da9,
    0xc2c605ad,
    0x830162ad,
    0x82c402ae,
    0x82c4092e,
    0xc3005cad,
    0x82c40c95,
    0x82c40d4a,
    0x83013d4a,
    0xc2c60b69,
    0x8300757a,
    0x82c6055b,
    0x82c4025d,
    0xc300595b,
    0x82c4092b,
    0x82c40a95,
    0x83004d95,
    0xc2c40b4a,
    0x82c60b55,
    0x830026d5,
    0x82c6055b,
    0xc3006277,
    0x82c40257,
    0x82c4052b,
    0x82fe5aaa,
    0xc2c60e95,
    0x82c406aa,
    0x83003baa,
    0x82c60ab5,
    0x830084bd,
    0x82c404ae,
    0x82c60a57,
    0x82fe554d,
    0xc2c40d26,
    0x82c60d95,
    0x83014655,
    0x82c4056a,
    0xc2c609ad,
    0x8300255d,
    0x82c404ae,
    0x83006a5b,
    0xc2c40a4d,
    0x82c40d25,
    0x83005da9,
    0x82c60b55,
    0xc2c4056a,
    0x83002ada,
    0x82c6095d,
    0x830074bb,
    0xc2c4049b,
    0x82c40a4b,
    0x83005b4b,
    0x82c406a9,
    0xc2c40ad4,
    0x83024bb5,
    0x82c402b6,
    0x82c6095b,
    0xc3002537,
    0x82c40497,
    0x82fe6656,
    0x82c40e4a,
    0xc2c60ea5,
    0x830156a9,
    0x82c605b5,
    0x82c402b6,
    0xc30138ae,
    0x82c4092e,
    0x83017c8d,
    0x82c40c95,
    0xc2c40d4a,
    0x83016d8a,
    0x82c60b69,
    0x82c6056d,
    0xc301425b,
    0x82c4025d,
    0x82c4092d,
    0x83002d2b,
    0xc2c40a95,
    0x83007d55,
    0x82c40b4a,
    0x82c60b55,
    0xc3015555,
    0x82c604db,
    0x82c4025b,
    0x83013857,
    0xc2c4052b,
    0x83008a9b,
    0x82c40695,
    0x82c406aa,
    0xc3006aea,
    0x82c60ab5,
    0x82c404b6,
    0x83004aae,
    0xc2c60a57,
    0x82c40527,
    0x82fe3726,
    0x82c60d95,
    0xc30076b5,
    0x82c4056a,
    0x82c609ad,
    0x830054dd,
    0xc2c404ae,
    0x82c40a4e,
    0x83004d4d,
    0x82c40d25,
    0xc3008d59,
    0x82c40b54,
    0x82c60d6a,
    0x8301695a,
    0xc2c6095b,
    0x82c4049b,
    0x83004a9b,
    0x82c40a4b,
    0xc300ab27,
    0x82c406a5,
    0x82c406d4,
    0x83026b75,
    0xc2c402b6,
    0x82c6095b,
    0x830054b7,
    0x82c40497,
    0xc2c4064b,
    0x82fe374a,
    0x82c60ea5,
    0x830086d9,
    0xc2c605ad,
    0x82c402b6,
    0x8300596e,
    0x82c4092e,
    0xc2c40c96,
    0x83004e95,
    0x82c40d4a,
    0x82c60da5,
    0xc3002755,
    0x82c4056c,
    0x83027abb,
    0x82c4025d,
    0xc2c4092d,
    0x83005cab,
    0x82c40a95,
    0x82c40b4a,
    0xc3013b4a,
    0x82c60b55,
    0x8300955d,
    0x82c404ba,
    0xc2c60a5b,
    0x83005557,
    0x82c4052b,
    0x82c40a95,
    0xc3004b95,
    0x82c406aa,
    0x82c60ad5,
    0x830026b5,
    0xc2c404b6,
    0x83006a6e,
    0x82c60a57,
    0x82c40527,
    0xc2fe56a6,
    0x82c60d93,
    0x82c405aa,
    0x83003b6a,
    0xc2c6096d,
    0x8300b4af,
    0x82c404ae,
    0x82c40a4d,
    0xc3016d0d,
    0x82c40d25,
    0x82c40d52,
    0x83005dd4,
    0xc2c60b6a,
    0x82c6096d,
    0x8300255b,
    0x82c4049b,
    0xc3007a57,
    0x82c40a4b,
    0x82c40b25,
    0x83015b25,
    0xc2c406d4,
    0x82c60ada,
    0x830138b6
  ];

  late final bool _isValid;
  bool get isValid => _isValid;

  DateModel({
    required String dateTime,
    required bool isLunar,
  }) {
    final List<String> dateTimeList = dateTime.split('-');
    final int year = int.parse(dateTimeList[0]);
    final int month = int.parse(dateTimeList[1]);
    final int day = int.parse(dateTimeList[2]);
    if (isLunar) {
      _lunarYear = year;
      _lunarMonth = month;
      _lunarDay = day;
      _isValid = _setLunarDate(
        year,
        month,
        day,
        false,
      );
    } else {
      _solarYear = year;
      _solarMonth = month;
      _solarDay = day;
      _isValid = _setSolarDate(
        year,
        month,
        day,
      );
    }
  }

  int _getLunarData(int year) {
    return _koreanLunarData[year - _koreanLunarBaseYear];
  }

  int _getLunarIntercalationMonth(int lunarData) {
    return (lunarData >> 12) & 0x000F;
  }

  int _shiftLunarDays(int year) {
    final int lunarData = _getLunarData(year);

    return (lunarData >> 17) & 0x01FF;
  }

  int _getLunarDays(int year, int month, bool isIntercalation) {
    int days = 0;
    final int lunarData = _getLunarData(year);

    if (isIntercalation && _getLunarIntercalationMonth(lunarData) == month) {
      if (((lunarData >> 16) & 0x01) > 0) {
        days = _lunarBigMonthDay;
      } else {
        days = _lunarSmallMonthDay;
      }
    } else {
      if (((lunarData >> (12 - month)) & 0x01) > 0) {
        days = _lunarBigMonthDay;
      } else {
        days = _lunarSmallMonthDay;
      }
    }

    return days;
  }

  int _getLunarDaysBeforeBaseYear(int year) {
    int days = 0;

    for (int baseYear = _koreanLunarBaseYear; baseYear < year + 1; baseYear++) {
      days += _shiftLunarDays(baseYear);
    }
    return days;
  }

  int _getLunarDaysBeforeBaseMonth(int year, int month, bool isIntercalation) {
    int days = 0;

    if (year >= _koreanLunarBaseYear && month > 0) {
      for (int baseMonth = 1; baseMonth < month + 1; baseMonth++) {
        days += _getLunarDays(year, baseMonth, false);
      }

      if (isIntercalation) {
        final intercalationMonth = _getLunarIntercalationMonth(_getLunarData(year));

        if (intercalationMonth > 0 && intercalationMonth < month + 1) {
          days += _getLunarDays(year, intercalationMonth, true);
        }
      }
    }

    return days;
  }

  int _getLunarAbsDays(int year, int month, int day, bool isIntercalation) {
    int days = _getLunarDaysBeforeBaseYear(year - 1) + _getLunarDaysBeforeBaseMonth(year, month - 1, true) + day;

    if (isIntercalation && _getLunarIntercalationMonth(_getLunarData(year)) == month) {
      days += _getLunarDays(year, month, false);
    }

    return days;
  }

  bool _isSolarIntercalationYear(int lunarData) {
    return ((lunarData >> 30) & 0x01) > 0;
  }

  int _shiftSolarDays(int year) {
    int days = 0;
    final int lunarData = _getLunarData(year);

    if (_isSolarIntercalationYear(lunarData)) {
      days = _solarBigYearDay;
    } else {
      days = _solarSmallYearDay;
    }

    if (year == 1582) {
      days -= 10;
    }

    return days;
  }

  int _getSolarDays(int year, int month) {
    int days = 0;
    final int lunarData = _getLunarData(year);

    if (month == 2 && _isSolarIntercalationYear(lunarData)) {
      days = _solarDayS[12];
    } else {
      days = _solarDayS[month - 1];
    }

    if (year == 1582 && month == 10) {
      days -= 10;
    }

    return days;
  }

  int _getSolarDayBeforeBaseYear(int year) {
    int days = 0;

    for (int baseYear = _koreanLunarBaseYear; baseYear < year + 1; baseYear++) {
      days += _shiftSolarDays(baseYear);
    }

    return days;
  }

  int _getSolarDaysBeforeBaseMonth(int year, int month) {
    int days = 0;

    for (int baseMonth = 1; baseMonth < month + 1; baseMonth++) {
      days += _getSolarDays(year, baseMonth);
    }

    return days;
  }

  int _getSolarAbsDays(int year, int month, int day) {
    int days = _getSolarDayBeforeBaseYear(year - 1) + _getSolarDaysBeforeBaseMonth(year, month - 1) + day;
    days -= _solarLunarDayDiff;

    return days;
  }

  void _setSolarDateByLunarDate(int lunarYear, int lunarMonth, int lunarDay, bool isIntercalation) {
    var absDays = _getLunarAbsDays(lunarYear, lunarMonth, lunarDay, isIntercalation);

    if (absDays < _getSolarAbsDays(lunarYear + 1, 1, 1)) {
      _solarYear = lunarYear;
    } else {
      _solarYear = lunarYear + 1;
    }

    for (int month = 12; month > 0; month--) {
      final int absDaysByMonth = _getSolarAbsDays(solarYear, month, 1);

      if (absDays >= absDaysByMonth) {
        _solarMonth = month;
        _solarDay = absDays - absDaysByMonth + 1;

        break;
      }
    }

    if (solarYear == 1582 && solarMonth == 10 && solarDay > 4) {
      _solarDay += 10;
    }
  }

  void _setLunarDateBySolarDate(int solarYear, int solarMonth, int solarDay) {
    final int absDays = _getSolarAbsDays(solarYear, solarMonth, solarDay);

    _isIntercalation = false;

    if (absDays >= _getLunarAbsDays(solarYear, 1, 1, false)) {
      _lunarYear = solarYear;
    } else {
      _lunarYear = solarYear - 1;
    }

    for (int month = 12; month > 0; month--) {
      final int absDaysByMonth = _getLunarAbsDays(_lunarYear, month, 1, false);

      if (absDays >= absDaysByMonth) {
        _lunarMonth = month;

        if (_getLunarIntercalationMonth(_getLunarData(_lunarYear)) == month) {
          _isIntercalation = absDays >= _getLunarAbsDays(_lunarYear, month, 1, true);
        }

        _lunarDay = absDays - _getLunarAbsDays(_lunarYear, _lunarMonth, 1, _isIntercalation) + 1;

        break;
      }
    }
  }

  bool _isValidMin(bool isLunar, int dateValue) {
    if (isLunar) {
      return _koreanLunarMinValue <= dateValue;
    } else {
      return _koreanSolarMinValue <= dateValue;
    }
  }

  bool _isValidMax(bool isLunar, int dateValue) {
    if (isLunar) {
      return _koreanLunarMaxValue >= dateValue;
    } else {
      return _koreanSolarMaxValue >= dateValue;
    }
  }

  bool _checkValidDate(bool isLunar, bool isIntercalation, int year, int month, int day) {
    bool isValid = false;
    final int dateValue = year * 10000 + month * 100 + day;

    //1582. 10. 5 ~ 1582. 10. 14 is not enable
    if (_isValidMin(isLunar, dateValue) && _isValidMax(isLunar, dateValue)) {
      int dayLimit = 0;

      if (month > 0 && month < 13 && day > 0) {
        if (isLunar) {
          dayLimit = _getLunarDays(year, month, isIntercalation);
        } else {
          dayLimit = _getSolarDays(year, month);
        }

        if (!isLunar && year == 1582 && month == 10) {
          if (day > 4 && day < 15) {
            return false;
          } else {
            dayLimit += 10;
          }
        }

        if (day <= dayLimit) {
          isValid = true;
        }
      }
    }

    return isValid;
  }

  bool _setLunarDate(int lunarYear, int lunarMonth, int lunarDay, bool isIntercalation) {
    var isValid = false;

    if (_checkValidDate(true, isIntercalation, lunarYear, lunarMonth, lunarDay)) {
      isIntercalation = isIntercalation && (_getLunarIntercalationMonth(_getLunarData(lunarYear)) == lunarMonth);
      _setSolarDateByLunarDate(lunarYear, lunarMonth, lunarDay, isIntercalation);
      isValid = true;
    }

    return isValid;
  }

  bool _setSolarDate(int solarYear, int solarMonth, int solarDay) {
    bool isValid = false;

    if (_checkValidDate(false, false, solarYear, solarMonth, solarDay)) {
      _setLunarDateBySolarDate(solarYear, solarMonth, solarDay);
      isValid = true;
    }

    return isValid;
  }

  getGapJa() {
    final int absDays = _getLunarAbsDays(_lunarYear, _lunarMonth, _lunarDay, _isIntercalation);

    if (absDays > 0) {
      _gapjaYearInx[0] = ((_lunarYear + 7) - _koreanLunarBaseYear) % _koreanCheongan.length;
      _gapjaYearInx[1] = ((_lunarYear + 7) - _koreanLunarBaseYear) % _koreanGanji.length;

      int monthCount = _lunarMonth;
      monthCount += 12 * (_lunarYear - _koreanLunarBaseYear);
      _gapjaMonthInx[0] = (monthCount + 5) % _koreanCheongan.length;
      _gapjaMonthInx[1] = (monthCount + 1) % _koreanGanji.length;

      _gapjaDayInx[0] = (absDays + 4) % _koreanCheongan.length;
      _gapjaDayInx[1] = absDays % _koreanGanji.length;
    }
  }

  String getGapjaString() {
    getGapJa();

    String gapjaString = "";
    gapjaString += String.fromCharCode(_koreanCheongan[_gapjaYearInx[0]]);
    gapjaString += String.fromCharCode(_koreanGanji[_gapjaYearInx[1]]);
    gapjaString += String.fromCharCode(_koreanGapjaUnit[_gapjaYearInx[2]]);
    gapjaString += " ";
    gapjaString += String.fromCharCode(_koreanCheongan[_gapjaMonthInx[0]]);
    gapjaString += String.fromCharCode(_koreanGanji[_gapjaMonthInx[1]]);
    gapjaString += String.fromCharCode(_koreanGapjaUnit[_gapjaMonthInx[2]]);
    gapjaString += " ";
    gapjaString += String.fromCharCode(_koreanCheongan[_gapjaDayInx[0]]);
    gapjaString += String.fromCharCode(_koreanGanji[_gapjaDayInx[1]]);
    gapjaString += String.fromCharCode(_koreanGapjaUnit[_gapjaDayInx[2]]);

    if (_isIntercalation) {
      gapjaString += " (";
      gapjaString += String.fromCharCode(_intercalationStr[0]);
      gapjaString += String.fromCharCode(_koreanGapjaUnit[1]);
      gapjaString += ")";
    }

    return gapjaString;
  }

  String getChineseGapJaString() {
    getGapJa();

    String gapjaString = "";
    gapjaString += String.fromCharCode(_chineseCheongan[_gapjaYearInx[0]]);
    gapjaString += String.fromCharCode(_chineseGanji[_gapjaYearInx[1]]);
    gapjaString += String.fromCharCode(_chineseGapjaUnit[_gapjaYearInx[2]]);
    gapjaString += " ";
    gapjaString += String.fromCharCode(_chineseCheongan[_gapjaMonthInx[0]]);
    gapjaString += String.fromCharCode(_chineseGanji[_gapjaMonthInx[1]]);
    gapjaString += String.fromCharCode(_chineseGapjaUnit[_gapjaMonthInx[2]]);
    gapjaString += " ";
    gapjaString += String.fromCharCode(_chineseCheongan[_gapjaDayInx[0]]);
    gapjaString += String.fromCharCode(_chineseGanji[_gapjaDayInx[1]]);
    gapjaString += String.fromCharCode(_chineseGapjaUnit[_gapjaDayInx[2]]);

    if (_isIntercalation) {
      gapjaString += " (";
      gapjaString += String.fromCharCode(_intercalationStr[1]);
      gapjaString += String.fromCharCode(_chineseGapjaUnit[1]);
      gapjaString += ")";
    }

    return gapjaString;
  }

  String getLunarIsoFormat() {
    final String lunarYearString = _lunarYear.getDigitsNumberString(4);
    final String lunarMonthString = _lunarMonth.getDigitsNumberString(2);
    final String lunarDayString = _lunarDay.getDigitsNumberString(2);
    final String isoStr = '$lunarYearString-$lunarMonthString-$lunarDayString';

    return isoStr;
  }

  String getSolarIsoFormat() {
    final String solarYearString = _solarYear.getDigitsNumberString(4);
    final String solarMonthString = _solarMonth.getDigitsNumberString(2);
    final String solarDayString = _solarDay.getDigitsNumberString(2);
    final String isoStr = '$solarYearString-$solarMonthString-$solarDayString';

    return isoStr;
  }

  String getLunarDateTimeStringCalendar() {
    final String lunarMonthString = _lunarMonth.getDigitsNumberString(2);
    final String lunarDayString = _lunarDay.getDigitsNumberString(2);
    return '$lunarMonthString$lunarDayString';
  }

  String getSolarDateTimeStringCalendar() {
    final String solarMonthString = _solarMonth.getDigitsNumberString(2);
    final String solarDayString = _solarDay.getDigitsNumberString(2);
    return '$solarMonthString$solarDayString';
  }

  DateTime getSolarDateTime() {
    return DateTime(
      _solarYear,
      _solarMonth,
      _solarDay,
    );
  }

  String getLunarStringFormat() {
    switch (getMobileLanguageCode()) {
      case 'ko':
      case 'ja':
        return '${l10n.dateLunar} ${l10n.dateFormatStringYMD
          .replaceAll('yyyy', _lunarYear.toString())
          .replaceAll('MM', _lunarMonth.toString())
          .replaceAll('dd', _lunarDay.toString())}';
      default:
        return '${l10n.dateLunar} ${l10n.dateFormatStringYMD
            .replaceAll('yyyy', _lunarYear.toString())
            .replaceAll('MMMM', _getEngMonthFromNumber(_lunarMonth))
            .replaceAll('dd', _lunarDay.toString())}';
    }
  }

  String getSolarStringFormat() {
    return DateFormat(l10n.dateFormatStringYMD).format(getSolarDateTime());
  }

  String _getEngMonthFromNumber(int number) {
    switch (number) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}