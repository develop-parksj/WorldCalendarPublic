import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/data/date_display_data.dart';
import 'package:world_calendar/model/mobile_ads_model.dart';
import 'package:world_calendar/model/wikipedia_model.dart';
import 'package:world_calendar/style/color_style.dart';
import 'package:world_calendar/style/ink_well_style.dart';
import 'package:world_calendar/style/text_style.dart';

class DateDisplayDialog extends HookConsumerWidget {
  final DateDisplayData _dateDisplayData;
  final String _dateDetailHtml;
  final String _worldDetailHtml;

  late final ChangeNotifierProvider<TypeChangeNotifier> typeChangeProvider = ChangeNotifierProvider((ref) {
    return TypeChangeNotifier(
      isDateDetail: _dateDetailHtml.isNotEmpty,
      html: _dateDetailHtml.isNotEmpty ? _dateDetailHtml : _worldDetailHtml,
    );
  });

  DateDisplayDialog({
    super.key,
    required DateDisplayData dateDisplayData,
    required String dateDetailHtml,
    required String worldDetailHtml,
  }):
        _dateDisplayData = dateDisplayData,
        _dateDetailHtml = dateDetailHtml,
        _worldDetailHtml = worldDetailHtml;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _titleWidget(),
                _tabBarWidget(),
                _detailWidget(),
              ],
            ),
            _adMobWidget(),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      width: double.infinity,
      color: ColorStyle.designIndigo,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          TextStyleWhite22w(
            text: _dateDisplayData.solarDate,
          ),
          isDisplayLunar ? TextStyleWhite18(
            text: _dateDisplayData.lunarDate,
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _tabBarWidget() {
    return HookConsumer(
      builder: (context, ref, child) {
        final TypeChangeNotifier typeChangeNotifier = ref.watch(typeChangeProvider);

        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorStyle.designIndigo,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWellDefaultStyle(
                  onTap: () {
                    if (!typeChangeNotifier.isDateDetail) {
                      typeChangeNotifier.setData(true, _dateDetailHtml.isNotEmpty ? _dateDetailHtml : WikipediaModel.instance.emptyHtml);
                    }
                  },
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            color: typeChangeNotifier.isDateDetail ? ColorStyle.designWhite : ColorStyle.designIndigo,
                          ),
                          child: TextStyleColor18(
                            text: l10n.worldEvents,
                            color: typeChangeNotifier.isDateDetail ? ColorStyle.designIndigo : ColorStyle.designWhite,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            color: typeChangeNotifier.isDateDetail ? ColorStyle.designIndigo : ColorStyle.designWhite,
                          ),
                          child: TextStyleColor18(
                            text: l10n.countryEvents,
                            color: typeChangeNotifier.isDateDetail ? ColorStyle.designWhite : ColorStyle.designIndigo,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWellDefaultStyle(
                  onTap: () {
                    if (typeChangeNotifier.isDateDetail) {
                      typeChangeNotifier.setData(false, _worldDetailHtml);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: typeChangeNotifier.isDateDetail ? ColorStyle.designWhite : ColorStyle.designIndigo,
                    ),
                    child: TextStyleColor18(
                      text: l10n.worldEvents,
                      color: typeChangeNotifier.isDateDetail ? ColorStyle.designIndigo : ColorStyle.designWhite,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _detailWidget() {
    return HookConsumer(
      builder: (context, ref, child) {
        final TypeChangeNotifier typeChangeNotifier = ref.watch(typeChangeProvider);

        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Html(
                data: typeChangeNotifier.html,
                extensions: [
                  TagExtension(
                    tagsToExtend: {"img"},
                    builder: (context) {
                      final String src = context.attributes['src'] ?? '';
                      final String fixedSrc = src.startsWith('//') ? 'https:$src' : src;
                      return CachedNetworkImage(
                        imageUrl: fixedSrc,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
                onLinkTap: (url, attributes, element) async {
                  if (url?.contains('wikipedia.org') == true) {
                    if (await canLaunchUrlString(url!)) {
                      launchUrlString(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _adMobWidget() {
    return HookConsumer(
      builder: (context, ref, child) {
        final DialogMobileAdsNotifier dialogMobileAdsNotifier = ref.watch(MobileAdsModel.instance.dialogMobileAdsProvider);
        final NativeAd nativeAd = dialogMobileAdsNotifier.dialogNativeAd;

        return Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 7,
          child: dialogMobileAdsNotifier.isAdLoaded ? AdWidget(
            ad: nativeAd,
          ) : const SizedBox.shrink(),
        );
      },
    );
  }
}

class TypeChangeNotifier extends ChangeNotifier {
  bool isDateDetail;
  String html;

  TypeChangeNotifier({
    required this.isDateDetail,
    required this.html,
  });

  void setData(bool isDateDetail, String html) {
    this.isDateDetail = isDateDetail;
    this.html = html;
    notifyListeners();
  }
}