
import 'package:world_calendar/data/date_search_data.dart';

class DateDisplayData {
  final DateTime solarDateTime;
  final String solarDate;
  final String lunarDate;
  final List<DateSearchData> dateSearchDataList;

  DateDisplayData({
    required this.solarDateTime,
    required this.solarDate,
    required this.lunarDate,
    required this.dateSearchDataList,
  });
}