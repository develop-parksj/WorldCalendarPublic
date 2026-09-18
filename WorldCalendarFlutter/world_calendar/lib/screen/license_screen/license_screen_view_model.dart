import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/const/enum.dart';
import 'package:world_calendar/model/license_model.dart';

final ChangeNotifierProvider<LicenseScreenViewModel> licenseScreenViewModelProvider = ChangeNotifierProvider((ref) => LicenseScreenViewModel());

class LicenseScreenViewModel extends ChangeNotifier {
  Map<String,List<String>> get licenses => LicenseModel.instance.licenses;

  LicenseScreenViewModel();

  void goToTop(BuildContext context) {
    pushScreen(context, ScreenType.topScreen);
  }
}