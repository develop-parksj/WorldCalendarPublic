import 'package:flutter/material.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/style/color_style.dart';
import 'package:world_calendar/style/ink_well_style.dart';
import 'package:world_calendar/style/text_style.dart';

class DrawerMenuHeaderItem extends StatelessWidget {
  const DrawerMenuHeaderItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorStyle.designGrey,
            width: 1,
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Image.asset(
              getAssetsImagePath('app_icon'),
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  final String _title;
  final VoidCallback? _onTap;

  const DrawerMenuItem({
    super.key,
    required String title,
    VoidCallback? onTap,
  }):
        _title = title,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorStyle.designGrey,
            width: 1,
          ),
        ),
      ),
      child: InkWellDefaultStyle(
        onTap: _onTap,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          child: TextStyleBlack20(
            text: _title,
          ),
        ),
      ),
    );
  }
}