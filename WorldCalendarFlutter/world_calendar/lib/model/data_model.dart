import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:world_calendar/data/calendar_data.dart';
import 'package:world_calendar/data/related_app_data.dart';
import 'package:world_calendar/model/aws_model.dart';
import 'package:world_calendar/model/file_model.dart';
import 'package:world_calendar/model/log_model.dart';

class DataModel {
  static final DataModel _model = DataModel();
  static DataModel get instance => _model;

  final MethodChannel _channel = MethodChannel('data_model_channel');

  final String _calendarJsonKey = 'data/calendar';
  final String _calendarDateKey = 'data/calendar/calendar_date.json';

  DataModel();

  Future<List<CalendarData>> getCalendarDataList(String code) async {
    final List<CalendarData> calendarDataList = [];

    try {
      final File dateFile = await FileModel.instance.getCacheFile(_calendarDateKey);
      if (dateFile.existsSync()) {
        dateFile.deleteSync();
      }

      await AWSModel.instance.downloadFile(
        _calendarDateKey,
        dateFile.path,
      );

      String calendarJsonKey = '$_calendarJsonKey/calendar_$code.json';
      File calendarJsonFile = await FileModel.instance.getCacheFile(calendarJsonKey);

      if (dateFile.existsSync()) {
        final String modifyDateString = dateFile.readAsStringSync().trim();
        final Map<String, dynamic> modifyDateMap = json.decode(modifyDateString);

        final DateTime modifyDate;
        if (modifyDateMap.containsKey('calendar_$code')) {
          modifyDate = DateTime.parse(modifyDateMap['calendar_$code']);
        } else {
          // まだサポートしていない国の場合
          modifyDate = DateTime.parse(modifyDateMap['calendar_us']);
          calendarJsonKey = '$_calendarJsonKey/calendar_us.json';
          calendarJsonFile = await FileModel.instance.getCacheFile(calendarJsonKey);
        }

        bool needDownload;
        if (calendarJsonFile.existsSync()) {
          if (modifyDate.isBefore(calendarJsonFile.lastModifiedSync())) {
            needDownload = false;
          } else {
            calendarJsonFile.deleteSync();
            needDownload = true;
          }
        } else {
          needDownload = true;
        }

        if (needDownload) {
          await AWSModel.instance.downloadFile(
            calendarJsonKey,
            calendarJsonFile.path,
          );
        }
      }

      if (calendarJsonFile.existsSync()) {
        final String calendarJsonString = calendarJsonFile.readAsStringSync();
        final List<dynamic> calendarJsonList = json.decode(calendarJsonString);
        calendarDataList
          ..clear()
          ..addAll(
            calendarJsonList.map((e) {
              return CalendarData.fromJson(e);
            }),
          );
      }
    } on Exception catch (e, stackTrace) {
      LogModel.instance.print('getCalendarDataList Code: $code Error: $e', stackTrace: stackTrace);
    }

    LogModel.instance.print('getCalendarDataList calendarDataList: ${calendarDataList.map((e) => e.toJson())}');

    return calendarDataList;
  }

  Future<List<RelatedAppData>> getRelatedAppDataList() async {
    final List<RelatedAppData> relatedAppDataList = [];

    try {
      final String relatedAppJsonString = await _channel.invokeMethod(
        'getRelatedAppJsonString',
        await AWSModel.instance.getCredentialMap(),
      );
      final List<dynamic> relatedAppJsonList = json.decode(relatedAppJsonString);
      relatedAppDataList
        ..clear()
        ..addAll(
          relatedAppJsonList.map((e) {
            return RelatedAppData.fromJson(e);
          }).toList(),
        );
      return relatedAppDataList;
    } on Exception catch (e, stackTrace) {
      LogModel.instance.print('getRelatedAppDataList Error: $e', stackTrace: stackTrace);
    }

    return relatedAppDataList;
  }
}