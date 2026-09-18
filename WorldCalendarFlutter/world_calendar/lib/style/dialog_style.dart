import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/style/color_style.dart';
import 'package:world_calendar/style/text_style.dart';

class WebViewDialog extends StatelessWidget {
  final WebViewController _controller;

  const WebViewDialog({
    super.key,
    required WebViewController controller,
  }):
      _controller = controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: WebViewWidget(
        controller: _controller,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: TextStyleColor18w(
            text: l10n.commonOk,
            color: ColorStyle.designIndigo,
          ),
        ),
      ],
    );
  }
}

class DefaultDialog extends StatelessWidget {
  final String _title;

  const DefaultDialog({
    super.key,
    required String title,
  }):
        _title = title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextStyleBlack20(
        text: _title,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: TextStyleColor18w(
            text: l10n.commonOk,
            color: ColorStyle.designIndigo,
          ),
        ),
      ],
    );
  }
}