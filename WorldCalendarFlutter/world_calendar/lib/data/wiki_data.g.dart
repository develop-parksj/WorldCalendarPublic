// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiki_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteLinkData _$SiteLinkDataFromJson(Map<String, dynamic> json) => SiteLinkData(
      lang: json['site'] == null
          ? ''
          : SiteLinkData._getLanguageCode(json['site']),
      title: json['title'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$SiteLinkDataToJson(SiteLinkData instance) =>
    <String, dynamic>{
      'site': instance.lang,
      'title': instance.title,
      'url': instance.url,
    };

LangLinksData _$LangLinksDataFromJson(Map<String, dynamic> json) =>
    LangLinksData(
      lang: json['lang'] as String? ?? '',
      url: json['url'] as String? ?? '',
      langName: json['langname'] as String? ?? '',
      autoNym: json['autonym'] as String? ?? '',
      titleName: json['*'] as String? ?? '',
    );

Map<String, dynamic> _$LangLinksDataToJson(LangLinksData instance) =>
    <String, dynamic>{
      'lang': instance.lang,
      'url': instance.url,
      'langname': instance.langName,
      'autonym': instance.autoNym,
      '*': instance.titleName,
    };
