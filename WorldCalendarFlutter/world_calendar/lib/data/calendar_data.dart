import 'package:json_annotation/json_annotation.dart';

part 'calendar_data.g.dart';

@JsonSerializable(explicitToJson: true)
class CalendarData {
  @JsonKey(name: 'date')
  final String date;
  @JsonKey(name: 'summary')
  String summary;
  @JsonKey(name: 'search')
  final String search;
  @JsonKey(name: 'search_lang')
  final String? searchLang;
  @JsonKey(name: 'text')
  final String? text;
  @JsonKey(name: 'replace', defaultValue: '')
  final String replace;
  @JsonKey(name: 'lunar', defaultValue: false)
  final bool lunar;
  @JsonKey(name: 'holiday', defaultValue: false)
  final bool holiday;
  @JsonKey(name: 'first_year', defaultValue: 0)
  final int firstYear;
  @JsonKey(name: 'last_year', defaultValue: 10000)
  final int lastYear;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool _isSubstitute = false;
  bool get isSubstitute => _isSubstitute;

  CalendarData({
    required this.date,
    required this.summary,
    required this.search,
    required this.searchLang,
    required this.text,
    required this.replace,
    required this.lunar,
    required this.holiday,
    required this.firstYear,
    required this.lastYear,
  });

  factory CalendarData.fromJson(Map<String,dynamic> json) {
    return CalendarData(
      date: json['date'] as String,
      summary: json['summary'] as String,
      search: json['search'] as String? ?? json['summary'] as String,
      searchLang: json['search_lang'] as String?,
      text: json['text'] as String?,
      replace: json['replace'] as String? ?? '',
      lunar: json['lunar'] as bool? ?? false,
      holiday: json['holiday'] as bool? ?? false,
      firstYear: json['first_year'] as int? ?? 0,
      lastYear: json['last_year'] as int? ?? 10000,
    );
  }
  Map<String, dynamic> toJson() => _$CalendarDataToJson(this);

  void setIsSubstitute(bool isSubstitute) {
    _isSubstitute = isSubstitute;
  }
}