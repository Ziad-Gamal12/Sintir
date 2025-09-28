import 'package:flutter/material.dart';

class PersonalDetailsHeaderExpandCollapseIcon extends StatelessWidget {
  const PersonalDetailsHeaderExpandCollapseIcon(
      {super.key, required this.isExpanded});
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? const Icon(Icons.keyboard_arrow_up)
        : const Icon(Icons.keyboard_arrow_down);
  }
}
