import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/data/calendar_data.dart';
import 'package:world_calendar/model/data_model.dart';

class CalendarModel {
  static final CalendarModel _model = CalendarModel();
  static CalendarModel get instance => _model;

  final List<CalendarData> _calendarDataList = [];
  List<CalendarData> get calendarDataList => List.from(_calendarDataList);

  Future<void> initialize() async {
    await setCalendarDataList();
  }

  Future<void> setCalendarDataList() async {
    _calendarDataList
      ..clear()
      ..addAll(
        await DataModel.instance.getCalendarDataList(countryCode),
      );
  }
}