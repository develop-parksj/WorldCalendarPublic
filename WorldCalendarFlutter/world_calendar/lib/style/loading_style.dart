import 'package:flutter/material.dart';
import 'package:world_calendar/style/color_style.dart';

class LoadingStyleIndicator extends StatelessWidget {
  const LoadingStyleIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 1,
        valueColor: AlwaysStoppedAnimation<Color>(ColorStyle.designGrey),
      ),
    );
  }
}