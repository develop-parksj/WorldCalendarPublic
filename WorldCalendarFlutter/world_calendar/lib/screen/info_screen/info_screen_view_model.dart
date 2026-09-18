import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/const/enum.dart';
import 'package:world_calendar/data/related_app_data.dart';
import 'package:world_calendar/model/data_model.dart';

class InfoScreenViewModel {
  static final InfoScreenViewModel _model = InfoScreenViewModel();
  static InfoScreenViewModel get instance => _model;

  final List<RelatedAppData> _relatedAppDataList = [];
  List<RelatedAppData> get relatedAppDataList => _relatedAppDataList;

  InfoScreenViewModel();

  Future<void> initialize() async {
    _relatedAppDataList
      ..clear()
      ..addAll(
        await DataModel.instance.getRelatedAppDataList(),
      );
  }

  Future<void> onRelatedAppTap(String url) async {
    if (await canLaunchUrlString(url)) {
      launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void goToTop(BuildContext context) {
    pushScreen(context, ScreenType.topScreen);
  }
}