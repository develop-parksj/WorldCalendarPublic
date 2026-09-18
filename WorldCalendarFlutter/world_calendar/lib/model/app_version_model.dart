import 'package:package_info_plus/package_info_plus.dart';

class AppVersionModel {
  static final AppVersionModel _model = AppVersionModel();
  static AppVersionModel get instance => _model;

  String _appVersion = '';
  String get appVersion => _appVersion;

  AppVersionModel();

  Future<void> initialize() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
  }
}