import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_ja.dart';
import 'l10n_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko')
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'World Calendar'**
  String get appName;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In en, this message translates to:
  /// **'NO'**
  String get commonNo;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @dialogSocketError.
  ///
  /// In en, this message translates to:
  /// **'A network error has occurred. Please check and try again.'**
  String get dialogSocketError;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference : '**
  String get reference;

  /// No description provided for @wikipedia.
  ///
  /// In en, this message translates to:
  /// **'Wikipedia'**
  String get wikipedia;

  /// No description provided for @countryEvents.
  ///
  /// In en, this message translates to:
  /// **'Holidays'**
  String get countryEvents;

  /// No description provided for @worldEvents.
  ///
  /// In en, this message translates to:
  /// **'World\nEvents'**
  String get worldEvents;

  /// No description provided for @emptyEvents.
  ///
  /// In en, this message translates to:
  /// **'Events does not exist.'**
  String get emptyEvents;

  /// No description provided for @drawerCountry.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get drawerCountry;

  /// No description provided for @drawerLicense.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get drawerLicense;

  /// No description provided for @drawerInfo.
  ///
  /// In en, this message translates to:
  /// **'Other information'**
  String get drawerInfo;

  /// No description provided for @licenseCount.
  ///
  /// In en, this message translates to:
  /// **'License:%s'**
  String get licenseCount;

  /// No description provided for @infoRelatedApp.
  ///
  /// In en, this message translates to:
  /// **'Other Apps by the Developer'**
  String get infoRelatedApp;

  /// No description provided for @dateFormatStringYM.
  ///
  /// In en, this message translates to:
  /// **'yMMMM'**
  String get dateFormatStringYM;

  /// No description provided for @dateFormatStringYMD.
  ///
  /// In en, this message translates to:
  /// **'dd MMMM yyyy'**
  String get dateFormatStringYMD;

  /// No description provided for @dateFormatStringWiki.
  ///
  /// In en, this message translates to:
  /// **'MMMM_d'**
  String get dateFormatStringWiki;

  /// No description provided for @dateWeekSun.
  ///
  /// In en, this message translates to:
  /// **'SUN'**
  String get dateWeekSun;

  /// No description provided for @dateWeekMon.
  ///
  /// In en, this message translates to:
  /// **'MON'**
  String get dateWeekMon;

  /// No description provided for @dateWeekTue.
  ///
  /// In en, this message translates to:
  /// **'TUE'**
  String get dateWeekTue;

  /// No description provided for @dateWeekWed.
  ///
  /// In en, this message translates to:
  /// **'WED'**
  String get dateWeekWed;

  /// No description provided for @dateWeekThu.
  ///
  /// In en, this message translates to:
  /// **'THU'**
  String get dateWeekThu;

  /// No description provided for @dateWeekFri.
  ///
  /// In en, this message translates to:
  /// **'FRI'**
  String get dateWeekFri;

  /// No description provided for @dateWeekSat.
  ///
  /// In en, this message translates to:
  /// **'SAT'**
  String get dateWeekSat;

  /// No description provided for @dateIntercalation.
  ///
  /// In en, this message translates to:
  /// **'Leap'**
  String get dateIntercalation;

  /// No description provided for @dateLunar.
  ///
  /// In en, this message translates to:
  /// **'Lunar'**
  String get dateLunar;

  /// No description provided for @dateSubstitute.
  ///
  /// In en, this message translates to:
  /// **'Substitute holiday'**
  String get dateSubstitute;

  /// No description provided for @countryUS.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get countryUS;

  /// No description provided for @countryCA.
  ///
  /// In en, this message translates to:
  /// **'Canada'**
  String get countryCA;

  /// No description provided for @countryFR.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get countryFR;

  /// No description provided for @countryIE.
  ///
  /// In en, this message translates to:
  /// **'Ireland'**
  String get countryIE;

  /// No description provided for @countryGBENG.
  ///
  /// In en, this message translates to:
  /// **'England'**
  String get countryGBENG;

  /// No description provided for @countryGBWLS.
  ///
  /// In en, this message translates to:
  /// **'Wales'**
  String get countryGBWLS;

  /// No description provided for @countryGBSCT.
  ///
  /// In en, this message translates to:
  /// **'Scotland'**
  String get countryGBSCT;

  /// No description provided for @countryGBNIR.
  ///
  /// In en, this message translates to:
  /// **'Northern Ireland'**
  String get countryGBNIR;

  /// No description provided for @countryDE.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get countryDE;

  /// No description provided for @countryAU.
  ///
  /// In en, this message translates to:
  /// **'Australia'**
  String get countryAU;

  /// No description provided for @countryJP.
  ///
  /// In en, this message translates to:
  /// **'Japan'**
  String get countryJP;

  /// No description provided for @countryKR.
  ///
  /// In en, this message translates to:
  /// **'South Korea'**
  String get countryKR;

  /// No description provided for @countryHK.
  ///
  /// In en, this message translates to:
  /// **'Hong Kong'**
  String get countryHK;

  /// No description provided for @countryCN.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get countryCN;

  /// No description provided for @countryTW.
  ///
  /// In en, this message translates to:
  /// **'Taiwan'**
  String get countryTW;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return L10nEn();
    case 'ja': return L10nJa();
    case 'ko': return L10nKo();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
