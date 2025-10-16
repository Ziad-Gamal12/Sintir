import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class StudentStatItem extends StatelessWidget {
  const StudentStatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
    required this.backgroundColor,
  });

  final String icon;
  final String value;
  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value, style: AppTextStyles(context).bold20),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(icon),
              ),
            ),
            const SizedBox(width: 5),
            Text(title, style: AppTextStyles(context).semiBold16),
          ],
        ),
      ],
    );
  }
}
