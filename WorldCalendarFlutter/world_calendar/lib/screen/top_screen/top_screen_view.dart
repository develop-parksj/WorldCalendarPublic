import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/model/app_version_model.dart';
import 'package:world_calendar/model/calendar_model.dart';
import 'package:world_calendar/model/mobile_ads_model.dart';
import 'package:world_calendar/screen/top_screen/top_screen_view_model.dart';
import 'package:world_calendar/style/color_style.dart';
import 'package:world_calendar/style/text_style.dart';
import 'package:world_calendar/widget/appbar.dart';
import 'package:world_calendar/widget/calendar_view.dart';
import 'package:world_calendar/widget/drawer_menu_item.dart';

class TopScreenView extends StatelessWidget {
  const TopScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final TopScreenViewModel viewModel = TopScreenViewModel.instance;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        exit(0);
      },
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: DefaultActionsAppBar(
          title: l10n.appName,
          actions: [
            IconButton(
              onPressed: () {
                preventMultiTapFunction(() async {
                  await viewModel.onShareTap();
                });
              },
              icon: const Icon(
                Icons.share,
                color: ColorStyle.designWhite,
              ),
            ),
            IconButton(
              onPressed: () {
                viewModel.scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: ColorStyle.designWhite,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: const [
                Expanded(
                  child: TopScreenViewBody(),
                ),
                TopScreenViewBottom(),
              ],
            ),
            const Positioned.fill(
              child: ProgressView(),
            ),
          ],
        ),
        endDrawer: const TopScreenViewDrawer(),
      ),
    );
  }
}

class ProgressView extends HookConsumerWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProgressNotifier progressNotifier = ref.watch(TopScreenViewModel.instance.progressProvider);

    return progressNotifier.isDisplay ? Container(
      alignment: Alignment.center,
      color: ColorStyle.designBlack12.withAlpha((255 * 0.5).toInt()),
      child: const SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    ) : const SizedBox.shrink();
  }
}

class TopScreenViewDrawer extends StatelessWidget {
  const TopScreenViewDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          Expanded(
            child: _bodyWidget(),
          ),
          _adMobWidget(),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return HookConsumer(
      builder: (context, ref, child) {
        final TopScreenViewModel viewModel = TopScreenViewModel.instance;

        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                DrawerMenuItem(
                  title: l10n.drawerCountry,
                  onTap: () async {
                    final CalendarNotifier calendarNotifier = ref.read(viewModel.calendarProvider);
                    final bool result = await viewModel.onDrawerSelectCountryTap(context);
                    if (result) {
                      calendarNotifier.setCalendarDataList(CalendarModel.instance.calendarDataList);
                    }
                    viewModel.scaffoldKey.currentState?.closeEndDrawer();
                  },
                ),
                DrawerMenuItem(
                  title: l10n.drawerLicense,
                  onTap: () async {
                    await viewModel.onDrawerLicenseTap(context);
                    viewModel.scaffoldKey.currentState?.closeEndDrawer();
                  },
                ),
                DrawerMenuItem(
                  title: l10n.drawerInfo,
                  onTap: () async {
                    await viewModel.onDrawerInfoTap(context);
                    viewModel.scaffoldKey.currentState?.closeEndDrawer();
                  },
                ),
                DrawerMenuItem(
                  title: '${l10n.appName} (${AppVersionModel.instance.appVersion})',
                ),
              ]),
            ),
          ],
        );
      },
    );
  }

  Widget _adMobWidget() {
    return HookConsumer(
      builder: (context, ref, child) {
        final DrawerMobileAdsNotifier drawerMobileAdsNotifier = ref.watch(MobileAdsModel.instance.drawerMobileAdsProvider);
        final NativeAd nativeAd = drawerMobileAdsNotifier.drawerNativeAd;

        return drawerMobileAdsNotifier.isAdLoaded ? Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 4 / 9,
          child: AdWidget(
            ad: nativeAd,
          ),
        ) : const SizedBox.shrink();
      },
    );
  }
}

class TopScreenViewBody extends HookConsumerWidget {
  const TopScreenViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: [
                      _selectYearMonthWidget(),
                      _displayDayWidget(),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _selectYearMonthWidget() {
    return HookConsumer(
      builder: (context, ref, child) {
        final TopScreenViewModel viewModel = TopScreenViewModel.instance;
        final DisplayTitleNotifier displayTitleNotifier = ref.watch(viewModel.displayTitleProvider);
        final String title = displayTitleNotifier.title;

        return GestureDetector(
          onTap: () {
            viewModel.pickDateTime(context);
            displayTitleNotifier.setTitle(viewModel.selectedDate);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: TextStyleBlack20(
                text: title,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _displayDayWidget() {
    return HookConsumer(
      builder: (context, ref, child) {
        final TopScreenViewModel viewModel = TopScreenViewModel.instance;
        final PageController pageController = viewModel.pageController..addListener(() {
          final DisplayTitleNotifier displayTitleNotifier = ref.read(viewModel.displayTitleProvider);
          displayTitleNotifier.setTitle(viewModel.selectedDate);
        });
        final List<DateTime> displayDateTimeList = viewModel.displayDateTimeList;
        final int calendarHeight = viewModel.calendarHeight;

        return SizedBox(
          height: calendarHeight.toDouble(),
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: displayDateTimeList.map((displayDateTime) {
              final CalendarNotifier calendarNotifier = ref.watch(viewModel.calendarProvider);

              return CalendarView(
                dateTime: displayDateTime,
                monthCalendarDataMap: calendarNotifier.getMonthCalendarDataMap(
                  displayDateTime.year,
                  displayDateTime.month,
                ),
                onDateTap: (dateDisplayData) async {
                  final ProgressNotifier progressNotifier = ref.watch(viewModel.progressProvider);
                  final DialogMobileAdsNotifier dialogMobileAdsNotifier = ref.watch(MobileAdsModel.instance.dialogMobileAdsProvider);
                  progressNotifier.setIsDisplay(true);
                  dialogMobileAdsNotifier.dialogNativeAd.load();
                  await viewModel.onDateTap(
                    context,
                    dateDisplayData,
                    progressNotifier,
                  );
                  dialogMobileAdsNotifier.isAdLoaded = false;
                  dialogMobileAdsNotifier.dialogNativeAd.dispose();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class TopScreenViewBottom extends HookConsumerWidget {
  const TopScreenViewBottom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TopMobileAdsNotifier topMobileAdsNotifier = ref.watch(MobileAdsModel.instance.topMobileAdsProvider);
    final NativeAd nativeAd = topMobileAdsNotifier.topNativeAd;

    return topMobileAdsNotifier.isAdLoaded ? Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      child: AdWidget(
        ad: nativeAd,
      ),
    ) : const SizedBox.shrink();
  }
}