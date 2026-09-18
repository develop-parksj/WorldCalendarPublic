import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/const/enum.dart';
import 'package:world_calendar/data/calendar_data.dart';
import 'package:world_calendar/model/wikipedia_model.dart';

extension StringExtension on String {
  String removeLinkData() {
    return replaceAll(RegExp(r'<sup[^>]*>(.*?)<\/sup>'), '')
        .replaceAllMapped(RegExp(r'<a[^>]*>(.*?)<\/a>'), (match) {
      return '${match.group(0)}'.replaceAll(RegExp(r'<a[^>]*>'), '').replaceAll(RegExp(r'<\/a>'), '');
    });
  }

  String addWikiReference(String url) {
    return url.isNotEmpty ? '$this<br><div>${l10n.reference}<a href="' '$url' '">${l10n.wikipedia}</a></div><br>' : '$this<br><div>${l10n.reference}${l10n.wikipedia}</div><br>';
  }

  bool isUrlString() {
    return indexOf(RegExp('https://')) == 0;
  }
}

extension WebViewControllerExtension on WebViewController {
  void loadString(String data) {
    data.isNotEmpty ? data.isUrlString() ? loadRequest(Uri.parse(data)) : loadHtmlString(data) : loadHtmlString(WikipediaModel.instance.emptyHtml);
  }
}

extension EventCalendarDataMapExtension on Map<int, Map<int, Map<int, List<CalendarData>>>> {
  void addEventCalendarData(int year, int month, int day, CalendarData data) {
    if (!containsKey(year)) {
      this[year] = {};
    }
    if (this[year]?.containsKey(month) != true) {
      this[year]?[month] = {};
    }
    if (this[year]?[month]?.containsKey(day) == true) {
      this[year]?[month]?[day]?.add(data);
    } else {
      this[year]?[month]?[day] = [data];
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime getPrevMonth() {
    return DateTime(
      year,
      month - 1,
      1,
    );
  }

  DateTime getNextMonth() {
    return DateTime(
      year,
      month + 1,
      1,
    );
  }

  int get weekOfMonth {
    if (day % 7 == 0) {
      return day ~/ 7;
    } else {
      return day ~/ 7 + 1;
    }
  }

  String getDateTimeString(DateTimeType type) {
    String ret = '';
    switch (type) {
      case DateTimeType.string:
        ret = _getDateStringString();
        break;
      case DateTimeType.not:
        ret = _getDateStringNot();
        break;
      case DateTimeType.slash:
        ret = _getDateStringSlash();
        break;
      case DateTimeType.dateModel:
      case DateTimeType.hyphen:
        ret = _getDateStringHyphen();
        break;
      case DateTimeType.calendar:
        ret = _getDateStringCalendar();
        break;
      case DateTimeType.wiki:
        ret = _getDateStringWiki();
        break;
    }
    return ret;
  }

  String _getDateStringString() {
    return DateFormat(l10n.dateFormatStringYM).format(this).toString();
  }

  String _getDateStringNot() {
    return DateFormat('yyyyMMdd').format(this).toString();
  }

  String _getDateStringSlash() {
    return DateFormat('yyyy/MM/dd').format(this).toString();
  }

  String _getDateStringHyphen() {
    return DateFormat('yyyy-MM-dd').format(this).toString();
  }

  String _getDateStringCalendar() {
    return DateFormat('MMdd').format(this).toString();
  }

  String _getDateStringWiki() {
    return DateFormat(l10n.dateFormatStringWiki).format(this).toString();
  }
}

extension IntExtension on int {
  String getDigitsNumberString(int digits) {
    String result = toString();
    while (result.length < digits) {
      result = '0$result';
    }
    return result;
  }
}