import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/const/enum.dart';
import 'package:world_calendar/const/extension.dart';
import 'package:world_calendar/data/calendar_data.dart';
import 'package:world_calendar/data/date_display_data.dart';
import 'package:world_calendar/model/calendar_model.dart';
import 'package:world_calendar/model/event_model.dart';
import 'package:world_calendar/model/file_model.dart';
import 'package:world_calendar/model/in_app_review_model.dart';
import 'package:world_calendar/model/wikipedia_model.dart';
import 'package:world_calendar/style/dialog_style.dart';
import 'package:world_calendar/widget/date_display_dialog.dart';
import 'package:world_calendar/widget/select_country_dialog.dart';

class TopScreenViewModel {
  static final TopScreenViewModel _model = TopScreenViewModel();
  static TopScreenViewModel get instance => _model;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final ChangeNotifierProvider<DisplayTitleNotifier> displayTitleProvider = ChangeNotifierProvider((ref) => DisplayTitleNotifier(dateTime: DateTime.now()));
  final ChangeNotifierProvider<CalendarNotifier> calendarProvider = ChangeNotifierProvider((ref) => CalendarNotifier(calendarDataList: CalendarModel.instance.calendarDataList));
  final ChangeNotifierProvider<ProgressNotifier> progressProvider = ChangeNotifierProvider((ref) => ProgressNotifier(isDisplay: false));

  final DateTime _firstDateTime = DateTime(
    1980,
    1,
    1,
  );
  final DateTime _lastDateTime = DateTime(
    2050,
    12,
    31,
  );

  late final PageController _pageController = PageController(
    initialPage: _getSelectedPage(),
  );
  PageController get pageController => _pageController;
  int get calendarHeight => (calendarViewHeight * 6 + 50).toInt();

  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );
  DateTime get selectedDate => _selectedDate;

  final List<DateTime> _displayDateTimeList = [];
  List<DateTime> get displayDateTimeList => _displayDateTimeList;

  // final WebViewController _controller = WebViewController()
  //   ..enableZoom(false)
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..setNavigationDelegate(
  //     NavigationDelegate(
  //       onProgress: (int progress) {
  //       },
  //       onPageStarted: (String url) {
  //       },
  //       onPageFinished: (String url) {
  //       },
  //       onWebResourceError: (WebResourceError error) {},
  //       onNavigationRequest: (NavigationRequest request) async {
  //         if (request.url.contains('wikipedia.org')) {
  //           if (await canLaunchUrlString(request.url)) {
  //             launchUrlString(
  //               request.url,
  //               mode: LaunchMode.externalApplication,
  //             );
  //           }
  //           return NavigationDecision.prevent;
  //         }
  //         return NavigationDecision.prevent;
  //       },
  //     ),
  //   );

  final String _storeUrl = 'https://play.google.com/store/apps/details?id=com.gyoheul.world_calendar';

  TopScreenViewModel();

  void initialize() {
    _initDisplayDateTimeList();
    _pageController.addListener(() {
      final index = _pageController.page! > _getSelectedPage() ? _pageController.page!.floor() : _pageController.page!.ceil();

      if (index == _getSelectedPage()) return;
      _selectedDate = _displayDateTimeList[index];
    });
  }

  void _initDisplayDateTimeList() {
    DateTime dateTime = _firstDateTime;
    _displayDateTimeList.clear();
    do {
      _displayDateTimeList.add(dateTime);
      dateTime = DateTime(
        dateTime.year,
        dateTime.month + 1,
        1,
      );
    } while (!dateTime.isAfter(_lastDateTime));
  }

  Future<void> onShareTap() async {
    final File iconFile = await FileModel.instance.getIconFile('world_calendar.png');
    await SharePlus.instance.share(
      ShareParams(
        title: l10n.appName,
        text: '${l10n.appName}\n$_storeUrl',
        previewThumbnail: XFile(
          iconFile.path,
        ),
        subject: _storeUrl,
      ),
    );
  }

  Future<bool> onDrawerSelectCountryTap(BuildContext context) async {
    final String? resultCode = await showDialog(
      context: context,
      builder: (context) {
        return SelectCountryDialog();
      },
    );
    if (resultCode != null && resultCode != '${languageCode}_$countryCode') {
      languageCode = resultCode.split('_')[0];
      countryCode = resultCode.split('_')[1];
      await CalendarModel.instance.setCalendarDataList();
      EventModel.instance.initialize();
      return true;
    }
    return false;
  }

  Future<void> onDrawerLicenseTap(BuildContext context) async {
    pushScreen(context, ScreenType.licenseScreen);
  }

  Future<void> onDrawerInfoTap(BuildContext context) async {
    pushScreen(context, ScreenType.infoScreen);
  }

  int _getSelectedPage() {
    final int yearDiff = _selectedDate.year - _firstDateTime.year;
    final int monthDiff = _selectedDate.month - _firstDateTime.month;
    return yearDiff * 12 + monthDiff;
  }

  Future<void> pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(
        _selectedDate.year,
        _selectedDate.month,
      ),
      firstDate: _firstDateTime,
      lastDate: _lastDateTime,
    );
    if (pickedDate != null) {
      _selectedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        1,
      );
      _pageController.jumpToPage(_getSelectedPage());
    }
  }

  Future<void> onDateTap(BuildContext context, DateDisplayData dateDisplayData, ProgressNotifier progressNotifier) async {
    try {
      final WikipediaModel wikipediaModel = WikipediaModel.instance;
      final String dateDetailHtml = await wikipediaModel.getDateDetailHtml(dateDisplayData.dateSearchDataList);
      final String worldDetailHtml = await wikipediaModel.getWorldDetailHtml(dateDisplayData.solarDateTime);

      if (context.mounted) {
        progressNotifier.setIsDisplay(false);
        await showDialog(
          context: context,
          builder: (context) {
            return DateDisplayDialog(
              dateDisplayData: dateDisplayData,
              dateDetailHtml: dateDetailHtml,
              worldDetailHtml: worldDetailHtml,
            );
          },
        );
      }
      InAppReviewModel.instance.requestReview();
    } catch (e) {
      progressNotifier.setIsDisplay(false);
      if (e is SocketException) {
        if (context.mounted) {
          await showDialog(
            context: context,
            builder: (context) {
              return DefaultDialog(
                title: l10n.dialogSocketError,
              );
            },
          );
        }
      }
    }
  }
}

class CalendarNotifier extends ChangeNotifier {
  List<CalendarData> calendarDataList;

  CalendarNotifier({required this.calendarDataList});

  void setCalendarDataList(List<CalendarData> value) {
    calendarDataList = value;
    notifyListeners();
  }

  Map<int, Map<int, List<CalendarData>>> getMonthCalendarDataMap(int year, int month) {
    final List<DateTime> searchDateTimeList = [
      DateTime(year, month - 1, 1),
      DateTime(year, month, 1),
      DateTime(year, month + 1, 1),
    ];
    final Map<int, Map<int, List<CalendarData>>> resultMap = {};
    for (DateTime searchDateTime in searchDateTimeList) {
      resultMap[searchDateTime.month] = EventModel.instance.getMonthEventCalendarDataMap(searchDateTime.year, searchDateTime.month);
    }
    return resultMap;
  }
}

class DisplayTitleNotifier extends ChangeNotifier {
  String title;

  DisplayTitleNotifier({
    required DateTime dateTime
  }):
        title = dateTime.getDateTimeString(DateTimeType.string);

  void setTitle(DateTime dateTime) {
    final String value = dateTime.getDateTimeString(DateTimeType.string);
    if (title != value) {
      title = value;
      notifyListeners();
    }
  }
}

class ProgressNotifier extends ChangeNotifier {
  bool isDisplay;

  ProgressNotifier({required this.isDisplay});

  void setIsDisplay(bool value) {
    isDisplay = value;
    notifyListeners();
  }
}