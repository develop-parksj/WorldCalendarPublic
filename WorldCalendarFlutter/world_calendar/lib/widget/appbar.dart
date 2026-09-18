import 'package:flutter/material.dart';
import 'package:world_calendar/style/color_style.dart';
import 'package:world_calendar/style/ink_well_style.dart';
import 'package:world_calendar/style/text_style.dart';

class DefaultActionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const DefaultActionsAppBar({
    super.key,
    required this.title,
    required this.actions
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      centerTitle: false,
      leadingWidth: 0,
      leading: const SizedBox.shrink(),
      title: TextStyleWhite22(
        text: title,
      ),
      backgroundColor: ColorStyle.designIndigo,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final VoidCallback? _onBackPressed;

  const DefaultAppBar({
    super.key,
    required String title,
    VoidCallback? onBackPressed,
  }):
        _title = title,
        _onBackPressed = onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      centerTitle: false,
      leadingWidth: _onBackPressed != null ? preferredSize.height : 0,
      leading: _onBackPressed != null ? InkWellDefaultStyle(
        onTap: () {
          _onBackPressed();
        },
        child: SizedBox(
          width: preferredSize.height,
          height: preferredSize.height,
          child: Icon(
            Icons.arrow_back_ios_new,
            size: preferredSize.height - 20,
            color: ColorStyle.designWhite,
          ),
        ),
      ) : const SizedBox.shrink(),
      title: TextStyleWhite22(
        text: _title,
      ),
      backgroundColor: ColorStyle.designIndigo,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}