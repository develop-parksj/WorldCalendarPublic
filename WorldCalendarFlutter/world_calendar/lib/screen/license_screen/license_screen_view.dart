import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/screen/license_screen/license_screen_view_model.dart';
import 'package:world_calendar/style/text_style.dart';
import 'package:world_calendar/widget/appbar.dart';

class LicenseScreenView extends HookConsumerWidget {
  const LicenseScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: l10n.drawerLicense,
        onBackPressed: () {
          popScreen(context);
        },
      ),
      body: const LicenseScreenViewBody(),
    );
  }
}

class LicenseScreenViewBody extends HookConsumerWidget {
  const LicenseScreenViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LicenseScreenViewModel licenseScreenViewModel = ref.watch(licenseScreenViewModelProvider);
    final Map<String,List<String>> licenses = licenseScreenViewModel.licenses;

    return ListView.builder(
      itemCount: licenses.length ,
      itemBuilder: (context, index) {
        final List<String> license = licenses.keys.toList();
        final String count = licenses[license[index]]!.length.toString();
        return ListTile(
            title: TextStyleBlack20(
              text: license[index],
            ),
            subtitle: TextStyleBlack16(
              text: sprintf(l10n.licenseCount, [count]),
            ),
            // ライセンス詳細画面遷移
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) {
                      return LicenseDetailScreenView(
                        title: license[index],
                        license: licenses[license[index]] ?? [],
                      );
                    }
                ),
              );
            }
        );
      },
    );
  }
}

class LicenseDetailScreenView extends StatelessWidget {
  final String _title;
  final List<String> _license;

  const LicenseDetailScreenView({
    super.key,
    required String title,
    required List<String> license,
  }):
        _title = title,
        _license = license;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: _title,
        onBackPressed: () {
          popScreen(context);
        },
      ),
      body: ListView.builder(
        itemCount: _license.length,
        itemBuilder: (context, index) {
          return ListTile(
            subtitle: Text(_license[index]),
          );
        },
      ),
    );
  }
}