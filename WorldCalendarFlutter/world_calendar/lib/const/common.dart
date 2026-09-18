import 'dart:io';

import 'package:flutter/material.dart';
import 'package:world_calendar/const/enum.dart';
import 'package:world_calendar/l10n/l10n.dart';
import 'package:world_calendar/model/multi_tap_prevent_model.dart';

late L10n l10n;
String languageCode = Platform.localeName.split('_')[0].toLowerCase();
String countryCode = Platform.localeName.split('_')[1].toLowerCase();
bool get isBeforeReplace => countryCode == 'us' || countryCode == 'tw';
bool get isDisplayLunar => true;
const double calendarViewHeight = 85;

String sprintf(String format, List<String> inputList) {
  String resultString = format;
  for (String input in inputList) {
    resultString = resultString.replaceFirst(RegExp('%s'), input);
  }
  return resultString;
}

Future<Map<String, dynamic>?> pushScreen(BuildContext context, ScreenType screen, {Map<String, dynamic>? arguments}) async {
  return await Navigator.pushNamed(context, getPageString(screen), arguments: arguments) as Map<String, dynamic>?;
}

void popScreen(BuildContext context, {Map<String, dynamic>? arguments}) {
  Navigator.pop(context, arguments);
}

String getPageString(ScreenType page) {
  return '/${page.name}';
}

String getAssetsImagePath(String name) {
  return 'assets/images/$name.png';
}

String getCountryImagePath(String countryCodeName) {
  return 'assets/images/country/$countryCodeName.png';
}

String getAssetsFilePath(String fileName) {
  return 'assets/$fileName';
}

String getMobileLanguageCode() {
  return Platform.localeName.split('_')[0].toLowerCase();
}

String getMobileCountryCode() {
  return Platform.localeName.split('_')[1].toLowerCase();
}

void preventMultiTapFunction(Function function) async {
  final MultiTapPreventModel multiTapPreventModel = MultiTapPreventModel.instance;
  final bool isTapped = multiTapPreventModel.isTapped;
  multiTapPreventModel.setIsTapped(false);
  if (!isTapped) {
    multiTapPreventModel.setIsTapped(true);
    await function();
    multiTapPreventModel.setIsTapped(false);
  }
}
