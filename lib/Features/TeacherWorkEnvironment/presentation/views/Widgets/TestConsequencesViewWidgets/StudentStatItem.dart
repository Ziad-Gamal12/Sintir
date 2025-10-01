import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class StudentStatItem extends StatelessWidget {
  const StudentStatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.backgroundColor,
  });

  final String icon;
  final String value;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(icon),
          ),
        ),
        const SizedBox(height: 10),
        Text(value, style: AppTextStyles(context).semiBold20),
      ],
    );
  }
}
