import 'package:flutter/material.dart';

class CustomExpansionHeaderTitleCollapesIcon extends StatelessWidget {
  const CustomExpansionHeaderTitleCollapesIcon(
      {super.key, required this.isExpanded});
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? const Icon(Icons.keyboard_arrow_up)
        : const Icon(Icons.keyboard_arrow_down);
  }
}
