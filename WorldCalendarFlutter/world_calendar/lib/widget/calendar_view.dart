import 'dart:math';

import 'package:flutter/material.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/const/enum.dart';
import 'package:world_calendar/const/extension.dart';
import 'package:world_calendar/data/calendar_data.dart';
import 'package:world_calendar/data/date_display_data.dart';
import 'package:world_calendar/data/date_search_data.dart';
import 'package:world_calendar/model/date_model.dart';
import 'package:world_calendar/style/color_style.dart';
import 'package:world_calendar/style/text_style.dart';

class CalendarView extends StatelessWidget {
  final DateTime _selectedDateTime;
  final Map<int, Map<int, List<CalendarData>>> _monthCalendarDataMap;
  final List<String> _weekTitleList = [
    l10n.dateWeekSun,
    l10n.dateWeekMon,
    l10n.dateWeekTue,
    l10n.dateWeekWed,
    l10n.dateWeekThu,
    l10n.dateWeekFri,
    l10n.dateWeekSat,
  ];
  final List<List<DateTime>> _weekDayList = [];
  final Function(DateDisplayData dateDisplayData) _onDateTap;

  CalendarView({
    super.key,
    required Map<int, Map<int, List<CalendarData>>> monthCalendarDataMap,
    required DateTime dateTime,
    required Function(DateDisplayData dateDisplayData) onDateTap,
  }):
      _monthCalendarDataMap = monthCalendarDataMap,
      _selectedDateTime = dateTime,
      _onDateTap = onDateTap {
    _initWeekDayList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: _weekTitleList.asMap().keys.map((index) {
                final Color color;
                if (index == 0) {
                  color = ColorStyle.designRed;
                } else if (index == _weekTitleList.length - 1) {
                  color = ColorStyle.designBlue;
                } else {
                  color = ColorStyle.designBlack;
                }
                return Center(
                  child: TextStyleColor18w(
                    text: _weekTitleList[index],
                    color: color,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(
            color: ColorStyle.designBlack45,
          ),
          children: _weekDayList.map((dayList) {
            return TableRow(
              children: dayList.asMap().keys.map((index) {
                final Color color;
                if (index == 0) {
                  color = ColorStyle.designRed;
                } else if (index == dayList.length - 1) {
                  color = ColorStyle.designBlue;
                } else {
                  color = ColorStyle.designBlack;
                }
                return _dayWidget(
                  dayList[index],
                  color,
                );
              }).toList(),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _initWeekDayList() {
    final int startWeekday = DateTime(
      _selectedDateTime.year,
      _selectedDateTime.month,
      1,
    ).weekday;
    final int startDay = -(startWeekday % 7) + 1;
    final int finalDay = DateTime(
      _selectedDateTime.year,
      _selectedDateTime.month + 1,
      0,
    ).day;
    final int weekCount = ((startWeekday % 7 + finalDay) / 7).ceil();
    final List<DateTime> allDayList = [];
    for (int day = startDay; day < weekCount * 7 + startDay; day++) {
      final DateTime inputDateTime = DateTime(
        _selectedDateTime.year,
        _selectedDateTime.month,
        day,
      );
      allDayList.add(inputDateTime);
    }

    _weekDayList.clear();
    const int weekSize = 7;
    int count = 0;
    do {
      _weekDayList.add(allDayList.skip(count).take(weekSize).toList());
      count += weekSize;
    } while (count < allDayList.length);
  }

  Widget _dayWidget(DateTime dateTime, Color color) {
    final DateModel dateModel = DateModel(
      dateTime: dateTime.getDateTimeString(DateTimeType.hyphen),
      isLunar: false,
    );
    final DateTime displayDateTime = DateTime.parse(dateModel.getSolarIsoFormat());
    if (!dateModel.isValid) {
      return Container(
        height: calendarViewHeight,
        decoration: const BoxDecoration(
          color: ColorStyle.designBlack12,
        ),
      );
    }
    final String intercalationDayString = dateModel.isIntercalation ? l10n.dateIntercalation : '';
    final bool isDisplay = displayDateTime.year == _selectedDateTime.year && displayDateTime.month == _selectedDateTime.month;
    final List<CalendarData> displayCalendarDateList = _monthCalendarDataMap[dateModel.solarMonth]?[dateModel.solarDay] ?? [];

    return GestureDetector(
      onTap: () {
        final DateDisplayData dateDisplayData = DateDisplayData(
          solarDateTime: dateModel.getSolarDateTime(),
          solarDate: dateModel.getSolarStringFormat(),
          lunarDate: '${dateModel.getLunarStringFormat()} $intercalationDayString',
          dateSearchDataList: displayCalendarDateList.map((e) {
            return DateSearchData(
              title: e.summary,
              text: e.text,
              search: e.text != null ? e.summary != e.search ? e.search : '' : e.search,
              searchLang: e.searchLang,
            );
          }).toList(),
        );
        _onDateTap(dateDisplayData);
      },
      child: Container(
        height: calendarViewHeight,
        decoration: BoxDecoration(
          color: isDisplay ? ColorStyle.designWhite : ColorStyle.designBlack12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                isDisplayLunar && getIsLunarDisplay(dateModel) ? TextStyleGrey9(
                  text: '${dateModel.lunarMonth}.${dateModel.lunarDay}$intercalationDayString',
                ) : const SizedBox.shrink(),
                TextStyleColor18w(
                  text: displayDateTime.day.toString(),
                  color: isDisplay ? displayCalendarDateList.any((monthCalendarData) => monthCalendarData.holiday) ? ColorStyle.designRed : color : ColorStyle.designGrey,
                ),
              ],
            ),
            displayCalendarDateList.isNotEmpty ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: displayCalendarDateList.sublist(0, min(3, displayCalendarDateList.length)).map((calendarData) {
                return TextStyleColor9(
                  text: !calendarData.isSubstitute ? calendarData.summary.toString() : l10n.dateSubstitute,
                  color: isDisplay ? displayCalendarDateList.any((monthCalendarData) => monthCalendarData.holiday) ? ColorStyle.designRed : ColorStyle.designBlack : ColorStyle.designGrey,
                );
              }).toList(),
            ) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  bool getIsLunarDisplay(DateModel dateModel) {
    final int day = dateModel.lunarDay;
    return day == 1 || day == 15;
  }
}