import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/style/color_style.dart';
import 'package:world_calendar/style/text_style.dart';

class SelectCountryDialog extends HookConsumerWidget {
  final Map<String, String> _countryMap = {
    'en_us': l10n.countryUS, //1
    'en_ca': l10n.countryCA, //1
    'fr_fr': l10n.countryFR, //33
    'en_ie': l10n.countryIE, //353
    'en_gb-eng': l10n.countryGBENG, //44
    'en_gb-wls': l10n.countryGBWLS, //44
    'en_gb-sct': l10n.countryGBSCT, //44
    'en_gb-nir': l10n.countryGBNIR, //44
    'de_de': l10n.countryDE, //49
    'en_au': l10n.countryAU, //61
    'ja_jp': l10n.countryJP, //81
    'ko_kr': l10n.countryKR, //82
    'en_hk': l10n.countryHK, //852
    'zh_cn': l10n.countryCN, //86
    'zh_tw': l10n.countryTW, //886
  };

  final ChangeNotifierProvider<CodeChangeNotifier> codeChangeProvider = ChangeNotifierProvider((ref) => CodeChangeNotifier(code: '${languageCode}_$countryCode'));

  SelectCountryDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CodeChangeNotifier codeChangeNotifier = ref.watch(codeChangeProvider);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextStyleBlack20(
            text: l10n.drawerCountry,
          ),
          DropdownButton(
            value: codeChangeNotifier.code,
            itemHeight: 60,
            items: _countryMap.keys.map((code) {
              return DropdownMenuItem(
                value: code,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        getCountryImagePath(code.split('_')[1]),
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 150,
                        child: TextStyleBlack16(
                          text: _countryMap[code] ?? '',
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              if (value is String) {
                codeChangeNotifier.setCode(value);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(codeChangeNotifier.initialCode);
          },
          child: TextStyleColor18w(
            text: l10n.commonCancel,
            color: ColorStyle.designRed,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(codeChangeNotifier.code);
          },
          child: TextStyleColor18w(
            text: l10n.commonDone,
            color: ColorStyle.designIndigo,
          ),
        ),
      ],
    );
  }
}

class CodeChangeNotifier extends ChangeNotifier {
  final String _initialCode;
  String get initialCode => _initialCode;
  String code;

  CodeChangeNotifier({required this.code}): _initialCode = code;

  void setCode(String value) {
    code = value;
    notifyListeners();
  }
}