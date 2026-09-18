import 'package:flutter/material.dart';
import 'package:world_calendar/style/ink_well_style.dart';

class ButtonStyleIcon extends StatelessWidget {
  final Icon _icon;
  final GestureTapCallback _onTap;

  const ButtonStyleIcon({
    super.key,
    required Icon icon,
    required GestureTapCallback onTap,
  }):
        _icon = icon,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return InkWellDefaultStyle(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: _icon,
      ),
    );
  }
}