import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:world_calendar/model/file_model.dart';

part 'related_app_data.g.dart';

@JsonSerializable(explicitToJson: true)
class RelatedAppData {
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'title_ja')
  final String titleJa;
  @JsonKey(name: 'title_ko')
  final String titleKo;
  @JsonKey(name: 'detail')
  final String detail;
  @JsonKey(name: 'detail_ja')
  final String detailJa;
  @JsonKey(name: 'detail_ko')
  final String detailKo;
  @JsonKey(name: 'icon')
  final String icon;
  @JsonKey(name: 'package')
  final String package;
  @JsonKey(includeToJson: false, includeFromJson: false)
  late File _iconFile;
  File get iconFile => _iconFile;

  RelatedAppData({
    required this.title,
    required this.titleJa,
    required this.titleKo,
    required this.detail,
    required this.detailJa,
    required this.detailKo,
    required this.icon,
    required this.package,
  }) {
    _setIconFile();
  }

  factory RelatedAppData.fromJson(Map<String,dynamic> json,) => _$RelatedAppDataFromJson(json);
  Map<String, dynamic> toJson() => _$RelatedAppDataToJson(this);

  String getTitle() {
    final String languageCode = Platform.localeName.split('_')[0].toLowerCase();
    switch (languageCode) {
      case 'ja':
        return titleJa;
      case 'ko':
        return titleKo;
      default:
        return title;
    }
  }

  String getDetail() {
    final String languageCode = Platform.localeName.split('_')[0].toLowerCase();
    switch (languageCode) {
      case 'ja':
        return detailJa;
      case 'ko':
        return detailKo;
      default:
        return detail;
    }
  }

  Future<void> _setIconFile() async {
    _iconFile = await FileModel.instance.getIconFile(icon);
  }

  String getStoreUrl() {
    return 'https://play.google.com/store/apps/details?id=$package';
  }
}