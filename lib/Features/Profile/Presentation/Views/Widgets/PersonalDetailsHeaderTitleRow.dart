// header_title_row.dart
import 'package:flutter/material.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/PersonalDetailsHeaderExpandCollapseIcon.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/PersonalHeaderTitleText.dart';

class HeaderTitleRow extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;

  const HeaderTitleRow({
    super.key,
    required this.isExpanded,
    required this.onTap,
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
            const PersonalHeaderTitleText(),
            PersonalDetailsHeaderExpandCollapseIcon(isExpanded: isExpanded),
          ],
        ),
      ),
    );
  }
}
