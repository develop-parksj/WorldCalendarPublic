import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/const/enum.dart';
import 'package:world_calendar/const/extension.dart';
import 'package:world_calendar/data/calendar_data.dart';
import 'package:world_calendar/model/calendar_model.dart';
import 'package:world_calendar/model/date_model.dart';

class EventModel {
  static final EventModel _model = EventModel();
  static EventModel get instance => _model;

  final int _firstDateYear = 1980;
  final int _lastDateYear = 2050;

  /// {
  ///    2023: {
  ///      1: {
  ///        1: [
  ///          CalendarData, ...
  ///        ],
  ///        2: [
  ///          CalendarData, ...
  ///        ],
  ///        ...
  ///      },
  ///      2: {
  ///        1: [
  ///          CalendarData, ...
  ///        ],
  ///        2: [
  ///          CalendarData, ...
  ///        ],
  ///        ...
  ///      },
  ///      ...
  ///    }
  /// }
  ///
  final Map<int, Map<int, Map<int, List<CalendarData>>>> _eventCalendarDataMap = {};

  void initialize() {
    final List<CalendarData> calendarDataList = CalendarModel.instance.calendarDataList;
    _eventCalendarDataMap.clear();

    final List<CalendarData> staticEventCalendarDataList = List<CalendarData>.from(calendarDataList).where((element) {
      final String date = element.date;
      return date.length == 8 && !date.contains('~') && !date.contains('-');
    }).toList();
    _setStaticEventDateTime(staticEventCalendarDataList);

    for (int year = _firstDateYear; year <= _lastDateYear; year++) {
      final List<CalendarData> dynamicEventCalendarDataList = List<CalendarData>.from(calendarDataList).where((element) {
        final String date = element.date;
        return !(date.length == 8 && !date.contains('~') && !date.contains('-')) && element.firstYear <= year && element.lastYear >= year;
      }).toList();
      _setDynamicEventDateTime(year, dynamicEventCalendarDataList);
    }
    _setHolidayEventDateTime();
  }

  Map<int, List<CalendarData>> getMonthEventCalendarDataMap(int year, int month) {
    final Map<int, List<CalendarData>> resultMap = {};
    if (!_eventCalendarDataMap.containsKey(year)) {
      return resultMap;
    }
    if (_eventCalendarDataMap[year]?.containsKey(month) != true) {
      return resultMap;
    }
    for (int day in _eventCalendarDataMap[year]![month]!.keys) {
      final List<CalendarData> calendarDataList = _eventCalendarDataMap[year]?[month]?[day] ?? [];
      resultMap[day] = calendarDataList;
    }
    return resultMap;
  }
  
  void _setStaticEventDateTime(List<CalendarData> calendarDataList) {
    for (CalendarData calendarData in calendarDataList) {
      final DateTime fullDate = DateTime.parse(calendarData.date);
      final DateModel dateModel = DateModel(
        dateTime: fullDate.getDateTimeString(DateTimeType.dateModel),
        isLunar: calendarData.lunar,
      );
      _eventCalendarDataMap.addEventCalendarData(
        dateModel.solarYear,
        dateModel.solarMonth,
        dateModel.solarDay,
        calendarData,
      );
    }
  }
  
  void _setDynamicEventDateTime(int year, List<CalendarData> calendarDataList) {
    for (CalendarData calendarData in calendarDataList) {
      final DateModel dateModel;
      if (calendarData.date.contains('~')) {
        final List<String> eventDateList = calendarData.date.split('~');
        final String daySummary = eventDateList[1];
        final DateTime targetDate;
        if (daySummary == 'Lichun') {
          targetDate = _getLichunDateTime(year);
        } else if (daySummary == 'Setsubun') {
          targetDate = _getSetsubunDateTime(year);
        } else if (daySummary == 'Chunfen') {
          targetDate = _getChunfenDateTime(year);
        } else if (daySummary == 'Qiufen') {
          targetDate = _getQiufenDateTime(year);
        } else if (daySummary == 'Mardi Gras') {
          targetDate = _getMardiGrasDateTime(year);
        } else if (daySummary == 'Carl Garner Federal Lands Cleanup Day') {
          targetDate = _getCarlGarnerFederalLandsCleanupDayDateTime(year);
        } else if (daySummary == 'Grandparents\' Day') {
          targetDate = _getGrandparentsDayDateTime(year);
        } else if (daySummary == 'Qingming') {
          targetDate = _getQingmingDateTime(year);
        } else if (daySummary == 'Easter') {
          targetDate = _getEasterDateTime(year);
        } else if (daySummary == 'Easter Monday') {
          targetDate = _getEasterMondayDateTime(year);
        } else if (daySummary == 'Holy Saturday') {
          targetDate = _getHolySaturdayDateTime(year);
        } else if (daySummary == 'Good Friday') {
          targetDate = _getGoodFridayDateTime(year);
        } else if (daySummary == 'Winter solstice') {
          targetDate = _getWinterSolsticeDateTime(year);
        } else if (daySummary == 'Victoria Day') {
          targetDate = _getVictoriaDayDateTime(year);
        } else if (daySummary == 'Mothering Sunday') {
          targetDate = _getMotheringSundayDateTime(year);
        } else if (daySummary == 'Advent Sunday') {
          targetDate = _getAdventSundayDateTime(year);
        } else if (daySummary == 'Feast of the Ascension') {
          targetDate = _getFeastOfTheAscensionDateTime(year);
        } else if (daySummary == 'Whit Monday') {
          targetDate = _getWhitMondayDateTime(year);
        } else if (daySummary == 'Whit Sunday') {
          targetDate = _getWhitSundayDateTime(year);
        } else if (daySummary == 'Mothers Day France') {
          targetDate = _getMothersDayFranceDateTime(year);
        } else {
          continue;
        }
        dateModel = DateModel(
          dateTime: targetDate.getDateTimeString(DateTimeType.dateModel),
          isLunar: calendarData.lunar,
        );
      } else if (calendarData.date.contains('-')) {
        final List<String> eventDateList = calendarData.date.split('-');
        final int eventMonth = int.parse(eventDateList[0]);
        int eventWeekOfMonth = int.parse(eventDateList[1]);
        final int eventWeekday = int.parse(eventDateList[2]);
        if (eventWeekOfMonth == 10) {
          DateTime targetDate = DateTime(
              year,
              eventMonth + 1,
              0
          );
          do {
            targetDate = targetDate.add(const Duration(days: -1));
          } while (targetDate.weekday != eventWeekday);
          dateModel = DateModel(
            dateTime: targetDate.getDateTimeString(DateTimeType.dateModel),
            isLunar: calendarData.lunar,
          );
        } else {
          DateTime targetDate = DateTime(
            year,
            eventMonth,
            1,
          );
          final int firstDateWeekDay = targetDate.weekday;
          final int firstDateWeekOfMonth = firstDateWeekDay > eventWeekday ? 0 : 1;
          targetDate = DateTime(
            targetDate.year,
            targetDate.month,
            targetDate.day + (eventWeekday - firstDateWeekDay) + (eventWeekOfMonth - firstDateWeekOfMonth) * 7,
          );
          dateModel = DateModel(
            dateTime: targetDate.getDateTimeString(DateTimeType.dateModel),
            isLunar: calendarData.lunar,
          );
        }
      } else {
        final int month = int.parse(calendarData.date.substring(0, 2));
        final int day = int.parse(calendarData.date.substring(2, 4));
        final DateTime fullDate = DateTime(
          year,
          month,
          day,
        );
        dateModel = DateModel(
          dateTime: fullDate.getDateTimeString(DateTimeType.dateModel),
          isLunar: calendarData.lunar,
        );
      }
      _eventCalendarDataMap.addEventCalendarData(
        dateModel.solarYear,
        dateModel.solarMonth,
        dateModel.solarDay,
        calendarData,
      );
    }
  }

  void _setHolidayEventDateTime() {
    for (int year in List.from(_eventCalendarDataMap.keys)) {
      for (int month in List.from(_eventCalendarDataMap[year]!.keys)) {
        for (int day in List.from(_eventCalendarDataMap[year]![month]!.keys)) {
          final DateTime dateTime = DateTime(
            year,
            month,
            day,
          );
          if (dateTime.weekday < 6) {
            continue;
          }
          final List<CalendarData> calendarDataList = _eventCalendarDataMap[year]?[month]?[day] ?? [];
          for (CalendarData calendarData in List<CalendarData>.from(calendarDataList).where((element) {
            final bool isHoliday = element.holiday;
            final bool isSubstitute = element.isSubstitute;
            final bool isReplace = element.replace.isNotEmpty;
            final bool isSunOnlyHoliday = !element.replace.contains('sat') && element.replace.contains('sun');
            return !isSubstitute && (isSunOnlyHoliday ? isHoliday && isReplace && dateTime.weekday == 7 : isHoliday && isReplace);
          })) {
            bool isSubstitute = false;
            final int addedDays = isBeforeReplace && dateTime.weekday == 6 ? -1 : 1;
            DateTime substituteDate = dateTime;
            do {
              substituteDate = substituteDate.add(Duration(days: addedDays));
              if (substituteDate.weekday < 6) {
                final List<CalendarData> currentCalendarDataList = _eventCalendarDataMap[substituteDate.year]?[substituteDate.month]?[substituteDate.day] ?? [];
                isSubstitute = currentCalendarDataList.isNotEmpty ? !currentCalendarDataList.any((displayCalendarData) {
                  return displayCalendarData.holiday;
                }) : true;
              }
            } while (!isSubstitute);
            _eventCalendarDataMap.addEventCalendarData(
              substituteDate.year,
              substituteDate.month,
              substituteDate.day,
              CalendarData.fromJson(calendarData.toJson())
                ..setIsSubstitute(true),
            );
          }
        }
      }
    }
  }

  DateTime _getLichunDateTime(int year) {
    final int day;
    if (year >= 1901) {
      day = (4.8693 + 0.242713 * (year - 1901)).toInt() - (year - 1901) ~/ 4;
    } else {
      day = 4;
    }
    return DateTime(
      year,
      2,
      day,
    );
  }

  DateTime _getSetsubunDateTime(int year) {
    final DateTime lichunDateTime = _getLichunDateTime(year);
    return lichunDateTime.add(const Duration(days: -1));
  }

  DateTime _getChunfenDateTime(int year) {
    final int day;
    if (year >= 1980) {
      day = (20.8431 + 0.242194 * (year - 1980)).toInt() - (year - 1980) ~/ 4;
    } else {
      day = 20;
    }
    return DateTime(
      year,
      3,
      day,
    );
  }

  DateTime _getQiufenDateTime(int year) {
    final int day;
    if (year >= 1980) {
      day = (23.2488 + 0.242194 * (year - 1980)).toInt() - (year - 1980) ~/ 4;
    } else {
      day = 23;
    }
    return DateTime(
      year,
      9,
      day,
    );
  }

  DateTime _getMardiGrasDateTime(int year) {
    final DateTime easterDateTime = _getEasterDateTime(year);
    final DateTime mardiGrasDateTime = easterDateTime.add(const Duration(days: -47));
    return mardiGrasDateTime;
  }

  DateTime _getCarlGarnerFederalLandsCleanupDayDateTime(int year) {
    DateTime laborDateTime = DateTime(
      year,
      9,
      1,
    );
    while (laborDateTime.weekday != 1) {
      laborDateTime = laborDateTime.add(const Duration(days: 1));
    }
    final DateTime targetDate = laborDateTime.add(const Duration(days: 5));
    return targetDate;
  }

  DateTime _getGrandparentsDayDateTime(int year) {
    DateTime laborDateTime = DateTime(
      year,
      9,
      1,
    );
    while (laborDateTime.weekday != 1) {
      laborDateTime = laborDateTime.add(const Duration(days: 1));
    }
    final DateTime targetDate = laborDateTime.add(const Duration(days: 6));
    return targetDate;
  }

  DateTime _getQingmingDateTime(int year) {
    final int day;
    if (year >= 1980) {
      day = (4.9687 + 0.242194 * (year - 1980)).toInt() - (year - 1980) ~/ 4;
    } else {
      day = 5;
    }
    return DateTime(
      year,
      4,
      day,
    );
  }

  DateTime _getEasterDateTime(int year) {
    final DateTime springDateTime = _getChunfenDateTime(year);
    DateModel targetDateModel = DateModel(
      dateTime: springDateTime.getDateTimeString(DateTimeType.hyphen),
      isLunar: false,
    );
    do {
      final String nextDateString = targetDateModel.getSolarDateTime().add(const Duration(days: 1)).getDateTimeString(DateTimeType.hyphen);
      targetDateModel = DateModel(
        dateTime: nextDateString,
        isLunar: false,
      );
    } while (targetDateModel.lunarDay != 15);
    final DateTime fullMoonDateTime = targetDateModel.getSolarDateTime();
    final int easterDuration;
    if (fullMoonDateTime.weekday > 5) {
      easterDuration = 14 - fullMoonDateTime.weekday;
    } else {
      easterDuration = 7 - fullMoonDateTime.weekday;
    }
    final DateTime easterDateTime = fullMoonDateTime.add(Duration(days: easterDuration));
    return easterDateTime;
  }

  DateTime _getEasterMondayDateTime(int year) {
    final DateTime easterDateTime = _getEasterDateTime(year);
    return easterDateTime.add(const Duration(days: 1));
  }

  DateTime _getHolySaturdayDateTime(int year) {
    final DateTime easterDateTime = _getEasterDateTime(year);
    return easterDateTime.add(const Duration(days: -1));
  }

  DateTime _getGoodFridayDateTime(int year) {
    final DateTime easterDateTime = _getEasterDateTime(year);
    return easterDateTime.add(const Duration(days: -2));
  }

  DateTime _getWinterSolsticeDateTime(int year) {
    final int day;
    if (year >= 1980) {
      day = (22.0389 + 0.242194 * (year - 1980)).toInt() - (year - 1980) ~/ 4;
    } else {
      day = 21;
    }
    return DateTime(
      year,
      12,
      day,
    );
  }

  DateTime _getVictoriaDayDateTime(int year) {
    DateTime targetDateTime = DateTime(
      year,
      5,
      24,
    );
    targetDateTime = targetDateTime.add(Duration(days: -(targetDateTime.weekday - 1)));
    return targetDateTime;
  }

  DateTime _getMotheringSundayDateTime(int year) {
    final DateTime easterDateTime = _getEasterDateTime(year);
    return easterDateTime.add(const Duration(days: -21));
  }

  DateTime _getAdventSundayDateTime(int year) {
    DateTime targetDateTime = DateTime(
      year,
      12,
      25,
    );
    targetDateTime = targetDateTime.add(Duration(days: -(targetDateTime.weekday + 21)));
    return targetDateTime;
  }

  DateTime _getFeastOfTheAscensionDateTime(int year) {
    final DateTime easterDateTime = _getEasterDateTime(year);
    return easterDateTime.add(const Duration(days: 39));
  }

  DateTime _getWhitMondayDateTime(int year) {
    final DateTime easterDateTime = _getEasterDateTime(year);
    return easterDateTime.add(const Duration(days: 50));
  }

  DateTime _getWhitSundayDateTime(int year) {
    final DateTime easterDateTime = _getEasterDateTime(year);
    return easterDateTime.add(const Duration(days: 49));
  }

  DateTime _getMothersDayFranceDateTime(int year) {
    DateTime targetDateTime = DateTime(year, 6, 0);
    targetDateTime = targetDateTime.add(Duration(days: -targetDateTime.weekday));
    final DateTime whitSundayDateTime = _getWhitSundayDateTime(year);
    if (targetDateTime.getDateTimeString(DateTimeType.dateModel) == whitSundayDateTime.getDateTimeString(DateTimeType.dateModel)) {
      targetDateTime = targetDateTime.add(const Duration(days: 7));
    }
    return targetDateTime;
  }
}