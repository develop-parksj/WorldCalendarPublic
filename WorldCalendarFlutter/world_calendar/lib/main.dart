import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/const/enum.dart';
import 'package:world_calendar/l10n/l10n.dart';
import 'package:world_calendar/model/firebase_model.dart';
import 'package:world_calendar/screen/info_screen/info_screen_view.dart';
import 'package:world_calendar/screen/license_screen/license_screen_view.dart';
import 'package:world_calendar/screen/splash_screen/splash_screen_view.dart';
import 'package:world_calendar/screen/top_screen/top_screen_view.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,//縦固定
    ]);

    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  }, (Object error, StackTrace stack) async {
    FirebaseModel.instance.recordError(error, stack);
  });
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          final currentLocale = Locale(locale.languageCode);
          if (supportedLocales.contains(currentLocale)) {
            return currentLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreenView(),
      routes: {
        getPageString(ScreenType.splashScreen): (_) => const SplashScreenView(),
        getPageString(ScreenType.topScreen): (_) => const TopScreenView(),
        getPageString(ScreenType.licenseScreen): (_) => const LicenseScreenView(),
        getPageString(ScreenType.infoScreen): (_) => const InfoScreenView(),
      },
    );
  }
}