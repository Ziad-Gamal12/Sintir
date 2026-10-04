import 'package:flutter/material.dart';

class ReportReasonCardSelectedButton extends StatelessWidget {
  const ReportReasonCardSelectedButton({super.key, required this.isSelected});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.primaryColor
            : (isDarkMode ? Color(0xff1E1E1E) : Color(0xffDEE9FC)),
        shape: BoxShape.circle,
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              size: 16,
              color: Colors.white,
            )
          : null,
    );
  }
}
