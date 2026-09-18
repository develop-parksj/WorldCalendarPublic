import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:world_calendar/model/log_model.dart';

class MobileAdsModel {
  static final MobileAdsModel _model = MobileAdsModel();
  static MobileAdsModel get instance => _model;

  final String testNativeAdUnitId = 'ca-app-pub-3940256099942544/2247696110';

  final ChangeNotifierProvider<TopMobileAdsNotifier> _topMobileAdsProvider = ChangeNotifierProvider((ref) => TopMobileAdsNotifier()..topNativeAd.load());
  ChangeNotifierProvider<TopMobileAdsNotifier> get topMobileAdsProvider => _topMobileAdsProvider;
  final ChangeNotifierProvider<DialogMobileAdsNotifier> _dialogMobileAdsProvider = ChangeNotifierProvider((ref) => DialogMobileAdsNotifier());
  ChangeNotifierProvider<DialogMobileAdsNotifier> get dialogMobileAdsProvider => _dialogMobileAdsProvider;
  final ChangeNotifierProvider<DrawerMobileAdsNotifier> _drawerMobileAdsProvider = ChangeNotifierProvider((ref) => DrawerMobileAdsNotifier()..drawerNativeAd.load());
  ChangeNotifierProvider<DrawerMobileAdsNotifier> get drawerMobileAdsProvider => _drawerMobileAdsProvider;

  MobileAdsModel();

  Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }
}

class TopMobileAdsNotifier extends ChangeNotifier {
  late final String _topNativeAdUnitId = Platform.isAndroid ? (
      kReleaseMode ? 'ca-app-pub-2706768567707804/7797698961' : MobileAdsModel.instance.testNativeAdUnitId
  ) : '';

  late final NativeAdListener _nativeAdListener = NativeAdListener(
    onAdLoaded: (Ad ad) {
      LogModel.instance.print('Ad loaded.');
      isAdLoaded = true;
      notifyListeners();
    },
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      LogModel.instance.print('Ad failed to load: $error');
    },
    onAdOpened: (Ad ad) => LogModel.instance.print('Ad opened.'),
    onAdClosed: (Ad ad) => LogModel.instance.print('Ad closed.'),
    onAdImpression: (Ad ad) => LogModel.instance.print('Ad impression.'),
  );

  late final NativeAd _topBannerAd = NativeAd(
    adUnitId: _topNativeAdUnitId,
    factoryId: 'TopNativeAdFactoryId',
    request: const AdRequest(),
    listener: _nativeAdListener,
  );
  NativeAd get topNativeAd => _topBannerAd;

  bool isAdLoaded = false;

  TopMobileAdsNotifier();
}

class DialogMobileAdsNotifier extends ChangeNotifier {
  late final String _dialogNativeAdUnitId = Platform.isAndroid ? (
      kReleaseMode ? 'ca-app-pub-2706768567707804/3734879613' : MobileAdsModel.instance.testNativeAdUnitId
  ) : '';

  late final NativeAdListener _nativeAdListener = NativeAdListener(
    onAdLoaded: (Ad ad) {
      LogModel.instance.print('Ad loaded.');
      isAdLoaded = true;
      notifyListeners();
    },
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      LogModel.instance.print('Ad failed to load: $error');
    },
    onAdOpened: (Ad ad) => LogModel.instance.print('Ad opened.'),
    onAdClosed: (Ad ad) => LogModel.instance.print('Ad closed.'),
    onAdImpression: (Ad ad) => LogModel.instance.print('Ad impression.'),
  );

  late final NativeAd _dialogBannerAd = NativeAd(
    adUnitId: _dialogNativeAdUnitId,
    factoryId: 'DialogNativeAdFactoryId',
    request: const AdRequest(),
    listener: _nativeAdListener,
  );
  NativeAd get dialogNativeAd => _dialogBannerAd;

  bool isAdLoaded = false;

  DialogMobileAdsNotifier();
}

class DrawerMobileAdsNotifier extends ChangeNotifier {
  late final String _drawerNativeAdUnitId = Platform.isAndroid ? (
      kReleaseMode ? 'ca-app-pub-2706768567707804/3734879613' : MobileAdsModel.instance.testNativeAdUnitId
  ) : '';

  late final NativeAdListener _nativeAdListener = NativeAdListener(
    onAdLoaded: (Ad ad) {
      LogModel.instance.print('Ad loaded.');
      isAdLoaded = true;
      notifyListeners();
    },
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      LogModel.instance.print('Ad failed to load: $error');
    },
    onAdOpened: (Ad ad) => LogModel.instance.print('Ad opened.'),
    onAdClosed: (Ad ad) => LogModel.instance.print('Ad closed.'),
    onAdImpression: (Ad ad) => LogModel.instance.print('Ad impression.'),
  );

  late final NativeAd _drawerBannerAd = NativeAd(
    adUnitId: _drawerNativeAdUnitId,
    factoryId: 'DrawerNativeAdFactoryId',
    request: const AdRequest(),
    listener: _nativeAdListener,
  );
  NativeAd get drawerNativeAd => _drawerBannerAd;

  bool isAdLoaded = false;

  DrawerMobileAdsNotifier();
}