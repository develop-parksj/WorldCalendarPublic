// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'related_app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelatedAppData _$RelatedAppDataFromJson(Map<String, dynamic> json) =>
    RelatedAppData(
      title: json['title'] as String,
      titleJa: json['title_ja'] as String,
      titleKo: json['title_ko'] as String,
      detail: json['detail'] as String,
      detailJa: json['detail_ja'] as String,
      detailKo: json['detail_ko'] as String,
      icon: json['icon'] as String,
      package: json['package'] as String,
    );

Map<String, dynamic> _$RelatedAppDataToJson(RelatedAppData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'title_ja': instance.titleJa,
      'title_ko': instance.titleKo,
      'detail': instance.detail,
      'detail_ja': instance.detailJa,
      'detail_ko': instance.detailKo,
      'icon': instance.icon,
      'package': instance.package,
    };
