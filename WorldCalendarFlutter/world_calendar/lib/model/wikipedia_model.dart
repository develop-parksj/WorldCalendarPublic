import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/const/enum.dart';
import 'package:world_calendar/const/extension.dart';
import 'package:world_calendar/data/date_search_data.dart';
import 'package:world_calendar/data/wiki_data.dart';
import 'package:world_calendar/model/log_model.dart';

class WikipediaModel {
  static final WikipediaModel _model = WikipediaModel();
  static WikipediaModel get instance => _model;


  String get emptyHtml => _getHtmlString(l10n.emptyEvents);
  late final String _headHtml;

  final Map<String, String> _displayMap = {};

  WikipediaModel();

  Future<void> initialize(BuildContext context) async {
    String headHtml = '';
    try {
      headHtml = await DefaultAssetBundle.of(context).loadString(getAssetsFilePath('wiki_header.html'));
    } catch (_) {
    }
    _headHtml = headHtml;
  }

  Future<String> getDateDetailHtml(List<DateSearchData> searchDataList) async {
    if (searchDataList.isEmpty) {
      return '';
    }

    final String mobileLanguageCode = getMobileLanguageCode();
    String bodyHtml = '';
    for (DateSearchData searchData in searchDataList) {
      final String title = searchData.title;
      if (_displayMap.containsKey(title)) {
        bodyHtml += _displayMap[title] ?? '';
        continue;
      }
      final String search = searchData.search ?? '';
      final String searchLanguageCode = searchData.searchLang ?? languageCode;
      if (searchData.text != null) {
        final String searchUrlString = 'https://$searchLanguageCode.m.wikipedia.org/wiki/$search';
        bodyHtml += '<h2>$title</h2>';
        bodyHtml += '<div>${searchData.text}</div>'.addWikiReference(searchUrlString);
      } else {
        if (search.isEmpty) {
          return '';
        }

        final List<SiteLinkData> siteLinkDataList = await _getSiteLinkDataList(search, searchLanguageCode);

        final SiteLinkData siteLinkData;
        if (siteLinkDataList.any((e) => e.lang == searchLanguageCode)) {
          siteLinkData = siteLinkDataList.firstWhere((e) => e.lang == searchLanguageCode);
        } else if (siteLinkDataList.any((e) => e.lang == mobileLanguageCode)) {
          siteLinkData = siteLinkDataList.firstWhere((e) => e.lang == mobileLanguageCode);
        } else if (siteLinkDataList.any((e) => e.lang == 'en')) {
          siteLinkData = siteLinkDataList.firstWhere((e) => e.lang == 'en');
        } else if (siteLinkDataList.isNotEmpty) {
          siteLinkData = siteLinkDataList.first;
        } else {
          LogModel.instance.print('getDateDetailHtml No language found');
          continue;
        }
        String finalTitle = siteLinkData.title;
        String langToUse = siteLinkData.lang;

        final String content = await _getSectionData(finalTitle, langToUse);
        bodyHtml += '<h2>$title</h2>';
        bodyHtml += '<div>$content</div>'
            .removeLinkData()
            .addWikiReference(siteLinkData.url);
      }
      _displayMap[title] = bodyHtml;
    }
    if (bodyHtml.isEmpty) {
      return '';
    }
    final String resultHtml = _getHtmlString(bodyHtml);
    LogModel.instance.print('getDateDetailHtml resultHtml: $resultHtml');
    return resultHtml;
  }

  Future<String> getWorldDetailHtml(DateTime dateTime) async {
    final String dateKey = dateTime.getDateTimeString(DateTimeType.wiki);
    if (_displayMap.containsKey(dateKey)) {
      return _displayMap[dateKey] ?? '';
    }
    final String mobileLanguageCode = getMobileLanguageCode();

    final String url = 'https://$mobileLanguageCode.m.wikipedia.org/wiki/$dateKey';

    try {
      final String content = await _getSectionData(dateKey, mobileLanguageCode, section: 1);
      dom.Document document = parse(content);
      document.querySelectorAll('div.mw-heading').forEach((element) {
        element.remove();
      });
      document.querySelectorAll('.references').forEach((element) {
        element.remove();
      });
      document.querySelectorAll('.error').forEach((element) {
        element.remove();
      });
      final String innerHtml = (document.body?.innerHtml ?? content)
          .removeLinkData()
          .addWikiReference(url);
      final String resultHtml = _getHtmlString(innerHtml);
      _displayMap[dateKey] = resultHtml;
      LogModel.instance.print('getWorldDetailHtml resultHtml: $resultHtml');
      return resultHtml;
    } catch (e) {
      _displayMap[dateKey] = url;
      return url;
    }
  }

  /// 言語別 interlanguage 確認 (存在する言語リストの取得)
  Future<List<SiteLinkData>> _getSiteLinkDataList(String title, String languageCode) async {
    final Uri pagePropsUri = Uri.parse(
      'https://$languageCode.wikipedia.org/w/api.php?action=query&titles=$title&prop=pageprops&format=json&origin=*',
    );

    final response = await http.get(pagePropsUri);
    if (response.statusCode != 200) {
      throw Exception('Failed to load language links');
    }

    final List<SiteLinkData> siteLinkDataList = [];

    final Map<String, dynamic> pagePropsData = json.decode(response.body);
    final String? wikiBaseItem = pagePropsData['query']['pages']?.values.first['pageprops']['wikibase_item'];
    if (wikiBaseItem != null) {
      final Uri siteLinksUri = Uri.parse(
        'https://www.wikidata.org/wiki/Special:EntityData/$wikiBaseItem.json',
      );

      final response = await http.get(siteLinksUri);
      if (response.statusCode != 200) {
        throw Exception('Failed to load language links');
      }

      final Map<String, dynamic> siteLinksData = json.decode(response.body);
      final Map<String, dynamic>? entity = siteLinksData['entities'][wikiBaseItem];
      if (entity != null) {
        siteLinkDataList.addAll(
          (entity['sitelinks'] as Map<String, dynamic>).values.map((e) {
            return SiteLinkData.fromJson(e);
          }),
        );
      }
    }

    return siteLinkDataList;
  }

  /// 本文内容の取得
  Future<String> _getSectionData(String title, String languageCode, {int section = 0}) async {
    final apiBase = 'https://$languageCode.wikipedia.org/w/api.php';
    final uri = Uri.parse(
      '$apiBase?action=parse&page=$title&format=json&prop=text&section=$section&origin=*',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load extract');
    }

    final Map<String, dynamic> data = json.decode(response.body);
    final Map<String, dynamic> texts = data['parse']['text'];

    return texts.values.first ?? '';
  }

  String _getHtmlString(String bodyHtml) {
    String resultHtml = '<html>';
    resultHtml += _headHtml;
    resultHtml += '<body>';
    resultHtml += bodyHtml;
    resultHtml += '</body>';
    resultHtml += '</html>';
    return resultHtml;
  }
}