import 'package:json_annotation/json_annotation.dart';

part 'wiki_data.g.dart';

@JsonSerializable(explicitToJson: true)
class SiteLinkData {
  @JsonKey(name: 'site', defaultValue: '', fromJson: _getLanguageCode)
  final String lang;
  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'url', defaultValue: '')
  final String url;

  SiteLinkData({
    required this.lang,
    required this.title,
    required this.url,
  });

  static _getLanguageCode(dynamic value) {
    if (value == null) return '';
    return (value as String).replaceAll('wiki', '');
  }

  factory SiteLinkData.fromJson(Map<String,dynamic> json,) => _$SiteLinkDataFromJson(json);
  Map<String, dynamic> toJson() => _$SiteLinkDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LangLinksData {
  @JsonKey(name: 'lang', defaultValue: '')
  final String lang;
  @JsonKey(name: 'url', defaultValue: '')
  final String url;
  @JsonKey(name: 'langname', defaultValue: '')
  final String langName;
  @JsonKey(name: 'autonym', defaultValue: '')
  final String autoNym;
  @JsonKey(name: '*', defaultValue: '')
  final String titleName;

  LangLinksData({
    required this.lang,
    required this.url,
    required this.langName,
    required this.autoNym,
    required this.titleName,
  });

  factory LangLinksData.fromJson(Map<String,dynamic> json,) => _$LangLinksDataFromJson(json);
  Map<String, dynamic> toJson() => _$LangLinksDataToJson(this);
}