import 'package:flutter/material.dart';
import 'package:world_calendar/data/related_app_data.dart';
import 'package:world_calendar/style/ink_well_style.dart';
import 'package:world_calendar/style/text_style.dart';

class RelatedAppWidget extends StatelessWidget {
  final RelatedAppData relatedAppData;
  final Function(String) onTap;
  
  const RelatedAppWidget({
    super.key,
    required this.relatedAppData,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: InkWellDefaultStyle(
        onTap: () {
          onTap(relatedAppData.getStoreUrl());
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: Image.file(
                relatedAppData.iconFile,
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: TextStyleIndigo22w(
                      text: relatedAppData.getTitle(),
                    ),
                  ),
                  TextStyleIndigo18(
                    text: relatedAppData.getDetail(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}