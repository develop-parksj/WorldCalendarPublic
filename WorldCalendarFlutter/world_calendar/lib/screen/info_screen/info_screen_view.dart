import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/data/related_app_data.dart';
import 'package:world_calendar/screen/info_screen/info_screen_view_model.dart';
import 'package:world_calendar/style/color_style.dart';
import 'package:world_calendar/style/text_style.dart';
import 'package:world_calendar/widget/appbar.dart';
import 'package:world_calendar/widget/related_app_widget.dart';

class InfoScreenView extends HookConsumerWidget {
  const InfoScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: l10n.drawerInfo,
        onBackPressed: () {
          popScreen(context);
        },
      ),
      body: const InfoScreenViewBody(),
    );
  }
}

class InfoScreenViewBody extends StatelessWidget {
  const InfoScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _relatedAppWidget(),
        ],
      ),
    );
  }

  Widget _relatedAppWidget() {
    final InfoScreenViewModel viewModel = InfoScreenViewModel.instance;
    final List<RelatedAppData> relatedAppDataList = viewModel.relatedAppDataList;

    return relatedAppDataList.isNotEmpty ? Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: ColorStyle.designGrey,
                    ),
                  ),
                ),
                child: TextStyleBlack22w(
                  text: l10n.infoRelatedApp,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Column(
                  children: relatedAppDataList.map((relatedAppData) {
                    return RelatedAppWidget(
                      relatedAppData: relatedAppData,
                      onTap: (url) {
                        viewModel.onRelatedAppTap(url);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    ) : const SizedBox.shrink();
  }
}