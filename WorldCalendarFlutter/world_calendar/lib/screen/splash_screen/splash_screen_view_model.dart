import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/const/enum.dart';
import 'package:world_calendar/model/app_version_model.dart';
import 'package:world_calendar/model/aws_model.dart';
import 'package:world_calendar/model/calendar_model.dart';
import 'package:world_calendar/model/event_model.dart';
import 'package:world_calendar/model/firebase_model.dart';
import 'package:world_calendar/model/license_model.dart';
import 'package:world_calendar/model/mobile_ads_model.dart';
import 'package:world_calendar/model/wikipedia_model.dart';
import 'package:world_calendar/screen/info_screen/info_screen_view_model.dart';
import 'package:world_calendar/screen/top_screen/top_screen_view_model.dart';

final ChangeNotifierProvider<SplashScreenViewModel> splashScreenViewModelProvider = ChangeNotifierProvider((ref) => SplashScreenViewModel());
late FutureProvider<void> splashInitializeProvider;

class SplashScreenViewModel extends ChangeNotifier {
  SplashScreenViewModel();

  Future<void> initialize(BuildContext context) async {
    await AWSModel.instance.initialize();
    await FirebaseModel.instance.initialize();
    await MobileAdsModel.instance.initialize();
    AppVersionModel.instance.initialize();
    LicenseModel.instance.initialize();
    await CalendarModel.instance.initialize();
    EventModel.instance.initialize();
    if (context.mounted) {
      WikipediaModel.instance.initialize(context);
    }
  }

  void goToTop(BuildContext context) {
    TopScreenViewModel.instance.initialize();
    InfoScreenViewModel.instance.initialize();
    pushScreen(context, ScreenType.topScreen);
  }
}