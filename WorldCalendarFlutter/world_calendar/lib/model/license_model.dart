import 'package:flutter/foundation.dart';

class LicenseModel {
  static final LicenseModel _model = LicenseModel();
  static LicenseModel get instance => _model;

  final Map<String,List<String>> _licenses = {};
  Map<String,List<String>> get licenses => _licenses;

  LicenseModel();

  void initialize() {
    setLicenseDataList();
  }

  Future<void> setLicenseDataList() async {
    if (_licenses.isNotEmpty) {
      return;
    }

    final List<LicenseEntry> licenses = await LicenseRegistry.licenses.toList();
    for (LicenseEntry license in licenses) {
      final packages = license.packages.toList();
      final paragraphs = license.paragraphs.toList();
      final paragraphText = paragraphs.map((e) => e.text).join('\n');
      for(final String packageName in packages){
        if(_licenses.containsKey(packageName)){
          _licenses[packageName]!.add(paragraphText);
        }
        else{
          _licenses.addAll({packageName : [paragraphText]});
        }
      }
    }
  }
}