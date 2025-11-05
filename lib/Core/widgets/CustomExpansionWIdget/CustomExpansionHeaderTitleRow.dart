// header_title_row.dart
import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomExpansionWIdget/CustomExpansionHeaderTitle.dart';
import 'package:sintir/Core/widgets/CustomExpansionWIdget/CustomExpansionHeaderTitleCollapesIcon.dart';

class CustomExpansionHeaderTitleRow extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;
  final String title;
  const CustomExpansionHeaderTitleRow({
    super.key,
    required this.isExpanded,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomExpansionHeaderTitle(
              title: title,
            ),
            CustomExpansionHeaderTitleCollapesIcon(isExpanded: isExpanded),
          ],
        ),
      ),
    );
  }
}
