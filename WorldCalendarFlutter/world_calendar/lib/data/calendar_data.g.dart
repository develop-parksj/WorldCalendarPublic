// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarData _$CalendarDataFromJson(Map<String, dynamic> json) => CalendarData(
      date: json['date'] as String,
      summary: json['summary'] as String,
      search: json['search'] as String,
      searchLang: json['search_lang'] as String?,
      text: json['text'] as String?,
      replace: json['replace'] as String? ?? '',
      lunar: json['lunar'] as bool? ?? false,
      holiday: json['holiday'] as bool? ?? false,
      firstYear: (json['first_year'] as num?)?.toInt() ?? 0,
      lastYear: (json['last_year'] as num?)?.toInt() ?? 10000,
    );

Map<String, dynamic> _$CalendarDataToJson(CalendarData instance) =>
    <String, dynamic>{
      'date': instance.date,
      'summary': instance.summary,
      'search': instance.search,
      'search_lang': instance.searchLang,
      'text': instance.text,
      'replace': instance.replace,
      'lunar': instance.lunar,
      'holiday': instance.holiday,
      'first_year': instance.firstYear,
      'last_year': instance.lastYear,
    };
